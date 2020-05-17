Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DC6C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 13:12:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7284A2075F
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 13:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEQqywEM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7284A2075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaJ64-0003IR-GS
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 09:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jaJ5J-0002fQ-Ju
 for qemu-devel@nongnu.org; Sun, 17 May 2020 09:12:05 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40205)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jaJ5I-00070H-Nk
 for qemu-devel@nongnu.org; Sun, 17 May 2020 09:12:05 -0400
Received: by mail-wm1-x341.google.com with SMTP id n18so3073787wmj.5
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 06:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vcqajkkMJ6mJA98vJSYu8/e9fc24Aa8EQPD5F1bxVGU=;
 b=hEQqywEMkqNR4ZKuCutN0+9yKAFHcMrjB0ezShS5A59g3c4UXYiTe1uP+8DJGRvUSV
 odl8w0Ww4t/GX2h3sYaVhvw2E3ej87Z+eDBoBh+40VGnAAYG9KBmy4O2IAOq+GpX7utV
 JozUgZEJfCoDLnLNMWYmDuWBGIx7MVijS7fxuR5ATAkxo+jG3upUqFMA9sKrzJcNZhL8
 BOC+W3O/681aMkDT2F9EYic/PqUELx+CsNP5JH87aIpyN+cE7RnIjR4V/eFRXWlZW0Tw
 916CBoAzwX4vA8WJv1X/Ox1rxTZCPW6C8l6M6/6I8E8SeHgfE7qZcGD67tFi3RIxpCkW
 rqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vcqajkkMJ6mJA98vJSYu8/e9fc24Aa8EQPD5F1bxVGU=;
 b=dGZLWZ9C9ZuHRpmdSpm/Gl0E7qL6g4QLVomGbB+PcT0ThWak2i6+ZGtyALdthweruy
 0pOF7R0zIP26NMlfbjiMjiVQ7qT5byS4Bu2/Te3URXa4pwzcx85nuWRL2y7iudPcqNvl
 8PCOq1H+sN6+c9kzZZxiGyLqvPGrjCmvRzCvT9prJKsodtw2vSWhrhTDvIawAoynuFOd
 IvoiuQesiZHkRQt7F9EqIZUgORahajZUvk5ktinbT0qT8dCYNDFZo8LlVl7s45jTCatH
 i/2REHZ7cgUR+TtiLiur14ucuHSvFD4Nse81xTe5S/XOY8VpaqBXyjkHwc1seEsWCeGb
 7KKA==
X-Gm-Message-State: AOAM532EhEZxUCT9+cvhHqOvPeB2cL7Yw7uxRDzCXp/SNvw240W+xnyi
 Sv+32VFGKV7GUBVflXc5XB0=
X-Google-Smtp-Source: ABdhPJxcwQ+jeg8kRWImU2X9Ti+/t/0+vf31cSgtAYm8/gVrQnNXxjphblCnllzg3fuc7ymFQUBUyA==
X-Received: by 2002:a05:600c:228f:: with SMTP id
 15mr13858429wmf.26.1589721123017; 
 Sun, 17 May 2020 06:12:03 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id f5sm12310920wro.18.2020.05.17.06.12.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2020 06:12:02 -0700 (PDT)
Subject: Re: [PATCH] ati-vga: Do not allow unaligned access via index register
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: BALATON Zoltan <balaton@eik.bme.hu>, Alexander Bulekov <alxndr@bu.edu>
References: <20200516132352.39E9374594E@zero.eik.bme.hu>
 <20200516144706.zz54mgs7k7anq3cj@mozz.bu.edu>
 <alpine.BSF.2.22.395.2005161730460.69993@zero.eik.bme.hu>
 <16020f02-5fe3-a7d9-ca30-759a2ba69307@amsat.org>
Message-ID: <2aa3e473-4de3-253b-37b6-f61b13969329@amsat.org>
Date: Sun, 17 May 2020 15:12:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <16020f02-5fe3-a7d9-ca30-759a2ba69307@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/17/20 12:40 PM, Philippe Mathieu-Daudé wrote:
> On 5/16/20 5:33 PM, BALATON Zoltan wrote:
>> On Sat, 16 May 2020, Alexander Bulekov wrote:
>>> On 200516 1513, BALATON Zoltan wrote:
>>>> According to docs bits 1 and 0 of MM_INDEX are hard coded to 0 so
>>>> unaligned access via this register should not be possible.
>>>> This also fixes problems reported in bug #1878134.
>>>>
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> ---
>>>
>>> Hi Zoltan,
>>> I applied this patch and confirmed that I cannot reproduce the crash 
>>> in #1878134
>>> Thanks!
>>>
>>> Acked-by: Alexander Bulekov <alxndr@bu.edu>
>>
>> Thanks, so that should be Tested-by I think but I don't care much 
>> about tags so whatever works for me.
> 
> 'Acked-by' means as a Fuzzer maintainer, Alexander checked your patch 
> and is happy that another maintainer (usually Gerd for hw/display/, as 
> ati.c doesn't have particular maintainer) takes this patch.
> 
> You are right, if Alexander tested your patch, he also should add:
> Tested-by: Alexander Bulekov <alxndr@bu.edu>
> 
> If a developer review your patch and agree the logic matches the 
> description and doesn't introduce new regressions, he might reply with a 
> 'Reviewed-by' tag.
> 
> Note than tags are not trophies for the patch author, but are helpful 
> for distributions such Debian/Fedora/NetBSD/... when they backport 
> particular patches fixing bugs, before new QEMU (stable) version is 
> released.
> 
> Also they are useful in history in case a developer/maintainer goes MIA, 
> there is still others to contact.
> 
> Finally, there is a tag documented for bug fixes:
> https://wiki.qemu.org/Contribute/SubmitAPatch#Write_a_meaningful_commit_message 
> 
> 
> If your patch addresses a bug in a public bug tracker, please add a line 
> with "Buglink: <URL-of-the-bug>" there, too.
> 
> Buglink: https://bugs.launchpad.net/qemu/+bug/1878134
> 
> Now, looking at your device implementation, it seems
> 
> 1/ The device isn't supposed to have 64-bit accesses
> 
> So this might be a more generic fix to Alexander issue:
> 
> -- >8 --
> @@ -879,6 +879,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>   static const MemoryRegionOps ati_mm_ops = {
>       .read = ati_mm_read,
>       .write = ati_mm_write,
> +    .valid.max_access_size = 4,
>       .endianness = DEVICE_LITTLE_ENDIAN,
>   };
> ---
> 
> 2/ All the registers are 32-bit aligned
> 
> So you can simplify the implementation by letting 
> access_with_adjusted_size() handle the 8/16-bit accesses by using:
> 
> @@ -879,6 +879,8 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>   static const MemoryRegionOps ati_mm_ops = {
>       .read = ati_mm_read,
>       .write = ati_mm_write,
> +    .min.min_access_size = 4,

I meant '.impl.min_access_size'.

>       .endianness = DEVICE_LITTLE_ENDIAN,
>   };
> 
> Regards,
> 
> Phil.
> 
>>
>> Regards,
>> BALATON Zoltan
>>
>>>>  hw/display/ati.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/display/ati.c b/hw/display/ati.c
>>>> index f4c4542751..2ee23173b2 100644
>>>> --- a/hw/display/ati.c
>>>> +++ b/hw/display/ati.c
>>>> @@ -531,7 +531,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>>>>      }
>>>>      switch (addr) {
>>>>      case MM_INDEX:
>>>> -        s->regs.mm_index = data;
>>>> +        s->regs.mm_index = data & ~3;
>>>>          break;
>>>>      case MM_DATA ... MM_DATA + 3:
>>>>          /* indexed access to regs or memory */
>>>> -- 
>>>> 2.21.3
>>>>
>>>>
>>>
>>>
>>
> 
> 

