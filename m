Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4338C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 17:55:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CBCF20758
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 17:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsgzJDGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CBCF20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaNVa-0002dc-Pi
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 13:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jaNUI-0001kH-4D
 for qemu-devel@nongnu.org; Sun, 17 May 2020 13:54:11 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34079)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jaNUH-0004ih-9q
 for qemu-devel@nongnu.org; Sun, 17 May 2020 13:54:09 -0400
Received: by mail-wr1-x442.google.com with SMTP id y3so9199318wrt.1
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 10:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6T/qb4rnrH5RfKSGyJ1i0NaxjPfIQSW88gXzcJmCVEw=;
 b=XsgzJDGRgPoJYm+WjwgMyFrafvymL9Nv/gJWeG6TmSi8A7wljc/CQ2wjkGV+fZuiTB
 WXFxX0ysW1nrLCrY0VDiYtKwcPuBxEoiQQUT+noO5i6nSBNSIgwgBquJ4NltDLtaEeVJ
 gkWIxl5t9F1pEjrdWL3Hw+7UVr/ajnpEvP/WVpEFHekpxzN0eTLPeqK8Fl+QOYaofudv
 +CekuXcDUYc/y07tgsVBXyd8uYqvy1t+5unUQJkJbkmf5hRfctjBK1dFvdMqW34Uo1f9
 g4njyztv1KDazteuTVyC3lXpO86DKLrCVLc0F5nFXOp6LcsqCz+ZXU0PhVVs4SpXmyn3
 CoiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6T/qb4rnrH5RfKSGyJ1i0NaxjPfIQSW88gXzcJmCVEw=;
 b=LgAmpMRJvgsFfHKqENwZ3ukNdDgnvIozwjDwNrbFOzjUh/ONgXLQdfCpIfPMIajf38
 dNMJUitJfOc8uuiks4T0Ygra68f1oiE581IlzgGq+eLxA1UQUnyHASd0V48cpJPn7JwF
 dmvbNSPPWtwE6OTQLadY8YzJDxhD+0w5n5mabXUL8phn+WzY194N8stsXhXdJExp4T/k
 U8Y+Lt5qcshpRtgtahan/ZkDIIlVH7WfrpSD9nVH3Jdhg6if6jNZVH+rKy6MT3jwxii+
 GgBg7Gu7R/cBCbggxt9/QKHmAzrPKMhiSkh+i53SRMNg9hqvjhucyR3+64bPWvzRWwrm
 xDig==
X-Gm-Message-State: AOAM530HrfWuhNi+m2ok5WW9lW4WJq7tH/SgbOVNk9TRlz7OsoZzNIRt
 fgN/iE3OZDFpWkSjDOGHS1I=
X-Google-Smtp-Source: ABdhPJzRbhQkSwOKVeY1gqfhYYTRiCOYgjbM/xCkruH3jsM+JpSIgfmh03BZ2pLO902Pqd0Ohhc3og==
X-Received: by 2002:adf:e9d2:: with SMTP id l18mr15376728wrn.34.1589738047820; 
 Sun, 17 May 2020 10:54:07 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id q5sm13828341wra.36.2020.05.17.10.54.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2020 10:54:06 -0700 (PDT)
Subject: Re: [PATCH] ati-vga: Do not allow unaligned access via index register
To: BALATON Zoltan <balaton@eik.bme.hu>
References: <20200516132352.39E9374594E@zero.eik.bme.hu>
 <20200516144706.zz54mgs7k7anq3cj@mozz.bu.edu>
 <alpine.BSF.2.22.395.2005161730460.69993@zero.eik.bme.hu>
 <16020f02-5fe3-a7d9-ca30-759a2ba69307@amsat.org>
 <2aa3e473-4de3-253b-37b6-f61b13969329@amsat.org>
 <alpine.BSF.2.22.395.2005171613510.1650@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <620e0537-6a38-21b8-4ec1-9c12eb010399@amsat.org>
Date: Sun, 17 May 2020 19:54:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2005171613510.1650@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/17/20 4:30 PM, BALATON Zoltan wrote:
> On Sun, 17 May 2020, Philippe Mathieu-Daudé wrote:
>> On 5/17/20 12:40 PM, Philippe Mathieu-Daudé wrote:
>>> On 5/16/20 5:33 PM, BALATON Zoltan wrote:
>>>> On Sat, 16 May 2020, Alexander Bulekov wrote:
>>>>> On 200516 1513, BALATON Zoltan wrote:
>>> Finally, there is a tag documented for bug fixes:
>>> https://wiki.qemu.org/Contribute/SubmitAPatch#Write_a_meaningful_commit_message 
>>>
>>> If your patch addresses a bug in a public bug tracker, please add a 
>>> line with "Buglink: <URL-of-the-bug>" there, too.
>>>
>>> Buglink: https://bugs.launchpad.net/qemu/+bug/1878134
> 
> Does this reply add that tag already or do I need to submit a v2 with it 
> (or the maintainer could add it when merging)?

If he doesn't have time he can reply to your patch :)

> 
>>> Now, looking at your device implementation, it seems
>>>
>>> 1/ The device isn't supposed to have 64-bit accesses
>>>
>>> So this might be a more generic fix to Alexander issue:
>>>
>>> -- >8 --
>>> @@ -879,6 +879,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>>>   static const MemoryRegionOps ati_mm_ops = {
>>>       .read = ati_mm_read,
>>>       .write = ati_mm_write,
>>> +    .valid.max_access_size = 4,
>>>       .endianness = DEVICE_LITTLE_ENDIAN,
>>>   };
>>> ---
> 
> I've tried that first but it does not work. The reason is that 
> ati_mm_read is recursively called for indexed access via MM_DATA which 
> causes the problem that happens when MM_INDEX is set to a non-aligned 
> value. No 64 bit access, just 32 bit with offset of 2 bytes as can be 
> seen from the stach trace I've attached to the bug. Fortunately indexed 
> access is documented to only support aligned access by not allowing 
> setting low bits of MM_INDEX so unless we find a client needing it my 
> patch should do it.

OK, so this is another device affected by the memory.c lacking of 
unaligned access (Gerd saw another one with USB).

> 
>>> 2/ All the registers are 32-bit aligned
>>>
>>> So you can simplify the implementation by letting 
>>> access_with_adjusted_size() handle the 8/16-bit accesses by using:
>>>
>>> @@ -879,6 +879,8 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>>>   static const MemoryRegionOps ati_mm_ops = {
>>>       .read = ati_mm_read,
>>>       .write = ati_mm_write,
>>> +    .min.min_access_size = 4,
>>
>> I meant '.impl.min_access_size'.
> 
> I think this would not work either because not all registers are the 
> same, some only can be read all 32 bits, some also 16 or 8 bits and 
> clients do access these with less than 32 bits and accessing parts of 
> the reg may trigger actions so the current way is probably better and 
> necessary to correctly support different valid and invalid unaligned 
> accessses.

.valid.xxx_access_size is what the guest are allowed to use,
.impl.xxx_access_size is what the developer had in mind when writing the 
model.

.impl.min_access_size = 4 doesn't forbid 8/16-bit guest accesses.

Moreover, it overloads you the burden of handling short accesses.

Anyway this was just a suggested simplification.

> 
> Regards,
> BALATON Zoltan

