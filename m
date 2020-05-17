Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE0DC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 10:41:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BBCC20727
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 10:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnTrH2b9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BBCC20727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaGjx-000742-6u
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 06:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jaGj5-0006ZA-Mg
 for qemu-devel@nongnu.org; Sun, 17 May 2020 06:40:59 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39019)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jaGj4-0004h4-Oe
 for qemu-devel@nongnu.org; Sun, 17 May 2020 06:40:59 -0400
Received: by mail-wm1-x343.google.com with SMTP id w64so7097098wmg.4
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 03:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pst2zp0eKOrywVfbdKsYdZOlXMDj3OXEeJAX6wXY/gw=;
 b=GnTrH2b9C2Zq0ff8Yut1VUFFNuR+z8BJ3uKWNmkgRawVbGtjSj7Pt81Ztx9MSN15w+
 JUNyrnsf3S9cEvm/iBg5PI6q1JeJUtSB2MR4LzdWTHD8hLQHHMghtJDEfp68HZkc50m4
 sB6su+e9qOYvuJLPRR5WtnBaQfGh4Yv/xyMU8U0w+jqjYY5QG5dTz0kF8dyAbe97zMUW
 g69GfzxSAJtSOJKG2yxCr7N5i1Atu4A+6rXxTOZPPWyEq/U2DnfL4NH7S6fOGYTR3xQy
 DDxydN5qJLT+lGgLObQ1zeDhxXRd7sMI2+Qt7YAFyG0n4qfaBZLxR98W8A8KmMo2LwB8
 l+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pst2zp0eKOrywVfbdKsYdZOlXMDj3OXEeJAX6wXY/gw=;
 b=TCpvOG+AZ9x92TdW+BxY92V1azBKYFUCMjvN2870/1uYsxeZxHxM4SvqiWukLWhcDF
 N1wfrJxxf7ga5B3dY5YlhRhJFXpvM0cMGGXoRdo4FpUxesh3+HpZDobb+63ZlqHdF8Yb
 5Cy1d3SYW0V/tU/c5xlkM7cKKzFQnH1avKdI01O9QGn8+9GLWC3YsO/deuJe/IZl9qwD
 TRvzdz3XSdL0ZnmVot4dNrPLj2M5b+3EU+PUSsKqunUlU1hLKdhnCy/ZLosStYDclLen
 0rQyQn4zA/yGgirfPymMuZamFcRf4o7EugZippHy/RhvQsYpzhhP0OLfBqSZ65DZEYZV
 HOcQ==
X-Gm-Message-State: AOAM533UQhu01Eb4tCLNIOToxuHMwpWP9hMh+YHPrqDaHyTgK8BuRMr/
 z/i5bUBWmFgzI/E+DjA/VGc=
X-Google-Smtp-Source: ABdhPJzwX87niNmzZ5SXAi+cd2MSc4sacKGiTZU0xCZv5/Q2s1xHewjOsqtNCFe5uD5Mha890zR+Rw==
X-Received: by 2002:a05:600c:2c0c:: with SMTP id
 q12mr13302781wmg.36.1589712057467; 
 Sun, 17 May 2020 03:40:57 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id 5sm11646731wmd.19.2020.05.17.03.40.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2020 03:40:56 -0700 (PDT)
Subject: Re: [PATCH] ati-vga: Do not allow unaligned access via index register
To: BALATON Zoltan <balaton@eik.bme.hu>, Alexander Bulekov <alxndr@bu.edu>
References: <20200516132352.39E9374594E@zero.eik.bme.hu>
 <20200516144706.zz54mgs7k7anq3cj@mozz.bu.edu>
 <alpine.BSF.2.22.395.2005161730460.69993@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <16020f02-5fe3-a7d9-ca30-759a2ba69307@amsat.org>
Date: Sun, 17 May 2020 12:40:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2005161730460.69993@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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

On 5/16/20 5:33 PM, BALATON Zoltan wrote:
> On Sat, 16 May 2020, Alexander Bulekov wrote:
>> On 200516 1513, BALATON Zoltan wrote:
>>> According to docs bits 1 and 0 of MM_INDEX are hard coded to 0 so
>>> unaligned access via this register should not be possible.
>>> This also fixes problems reported in bug #1878134.
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>
>> Hi Zoltan,
>> I applied this patch and confirmed that I cannot reproduce the crash 
>> in #1878134
>> Thanks!
>>
>> Acked-by: Alexander Bulekov <alxndr@bu.edu>
> 
> Thanks, so that should be Tested-by I think but I don't care much about 
> tags so whatever works for me.

'Acked-by' means as a Fuzzer maintainer, Alexander checked your patch 
and is happy that another maintainer (usually Gerd for hw/display/, as 
ati.c doesn't have particular maintainer) takes this patch.

You are right, if Alexander tested your patch, he also should add:
Tested-by: Alexander Bulekov <alxndr@bu.edu>

If a developer review your patch and agree the logic matches the 
description and doesn't introduce new regressions, he might reply with a 
'Reviewed-by' tag.

Note than tags are not trophies for the patch author, but are helpful 
for distributions such Debian/Fedora/NetBSD/... when they backport 
particular patches fixing bugs, before new QEMU (stable) version is 
released.

Also they are useful in history in case a developer/maintainer goes MIA, 
there is still others to contact.

Finally, there is a tag documented for bug fixes:
https://wiki.qemu.org/Contribute/SubmitAPatch#Write_a_meaningful_commit_message

If your patch addresses a bug in a public bug tracker, please add a line 
with "Buglink: <URL-of-the-bug>" there, too.

Buglink: https://bugs.launchpad.net/qemu/+bug/1878134

Now, looking at your device implementation, it seems

1/ The device isn't supposed to have 64-bit accesses

So this might be a more generic fix to Alexander issue:

-- >8 --
@@ -879,6 +879,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
  static const MemoryRegionOps ati_mm_ops = {
      .read = ati_mm_read,
      .write = ati_mm_write,
+    .valid.max_access_size = 4,
      .endianness = DEVICE_LITTLE_ENDIAN,
  };
---

2/ All the registers are 32-bit aligned

So you can simplify the implementation by letting 
access_with_adjusted_size() handle the 8/16-bit accesses by using:

@@ -879,6 +879,8 @@ static void ati_mm_write(void *opaque, hwaddr addr,
  static const MemoryRegionOps ati_mm_ops = {
      .read = ati_mm_read,
      .write = ati_mm_write,
+    .min.min_access_size = 4,
      .endianness = DEVICE_LITTLE_ENDIAN,
  };

Regards,

Phil.

> 
> Regards,
> BALATON Zoltan
> 
>>>  hw/display/ati.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/display/ati.c b/hw/display/ati.c
>>> index f4c4542751..2ee23173b2 100644
>>> --- a/hw/display/ati.c
>>> +++ b/hw/display/ati.c
>>> @@ -531,7 +531,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>>>      }
>>>      switch (addr) {
>>>      case MM_INDEX:
>>> -        s->regs.mm_index = data;
>>> +        s->regs.mm_index = data & ~3;
>>>          break;
>>>      case MM_DATA ... MM_DATA + 3:
>>>          /* indexed access to regs or memory */
>>> -- 
>>> 2.21.3
>>>
>>>
>>
>>
> 


