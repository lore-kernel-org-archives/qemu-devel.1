Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B5FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:41:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F41692064C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hs/bg7dx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F41692064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsqeh-0000Ta-8O
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsqCC-0004ys-ES; Tue, 07 Jul 2020 12:11:48 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37359)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsqCA-0007xL-NO; Tue, 07 Jul 2020 12:11:48 -0400
Received: by mail-wm1-x344.google.com with SMTP id o2so47128804wmh.2;
 Tue, 07 Jul 2020 09:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=plQfzATZctkt4/3FhyTNhnWjJdVmJGp5zhAhmOExzz0=;
 b=hs/bg7dx/ccCKRhthXiPEUC46kQl+AZ3yd9MN5mxrj2itwNDh1qu7+4NKEhOi7UN8g
 c+SRFRVomPSga+1b1ZmiZ+O4eonKOv62Y5LIBmKj9i+QIl0m+8UDU3st1yfG4htXZHRt
 TKN91dOQ23V0l0Q1ZjNmrEpYQHZhRoUEtJR/ZpUfCHcX/ZCMrvpVVs6vuxMtrqFRPVRo
 qAUoMxq2HschtOPGxw+jprIigxhhq3t3tOkA5DUvELU1/DdQhPf5W4mjSpSIFqxPda4j
 8KZwMoknb5AxvTvxaVNBjIPc9YJgExiMch+nkQCokU1cuRZWUUrEUM3NUcTvIWoNEXiW
 p/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=plQfzATZctkt4/3FhyTNhnWjJdVmJGp5zhAhmOExzz0=;
 b=VRcb6EWehojuxkWndcBCmPG807j5mJLXx28mYwunpsNgyYqneSTMmJN1s4/Tl9Z2DQ
 RdGmikGRmqLBRRBj8eC93/RQ/xtReiV3lyntIQfV2q9fsgegmH0AC/ZQvTmEQNGLvQfT
 PnOR1kgFZqyo2p8M3iBtyYKaYmFnIM7GU8Gq9qvBtjDaDO7sQnVpBHp9mtD/P6GQws1v
 Hwk+4mwY/fstn4ajGw9yO7v9asKDITyq4Ff0eoCCfrhZfPhW9+7m+cw25I/tLA8cYGRz
 imBWMw+xYzg8845iC4A8IgafQ86NAXauW0D9idKA5U4p9VtV73xV/v5JGUn7GSAIn97j
 z24w==
X-Gm-Message-State: AOAM533B/ZK8uKlSt3p1lVXvNIlO8qZm2mYZ55l0TIiH7qLpjhaAFYkf
 1mcrptsrLGe/8bVve4UdDCw=
X-Google-Smtp-Source: ABdhPJw0b62fR8p/n27AHDo5/FhZQuh8tP0DJjMUuH00m4Hdykw3rgIs9yft4Yc8XZ1h+wjdAoiUKg==
X-Received: by 2002:a1c:3dc3:: with SMTP id k186mr5191931wma.66.1594138304657; 
 Tue, 07 Jul 2020 09:11:44 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id k126sm1778457wmf.3.2020.07.07.09.11.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2020 09:11:43 -0700 (PDT)
Subject: Re: [PATCH 2/2] hw/sd/sdcard: Do not allow invalid SD card sizes
To: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair23@gmail.com>
References: <20200707132116.26207-1-f4bug@amsat.org>
 <20200707132116.26207-3-f4bug@amsat.org>
 <CAKmqyKNY+7tE9tcZm7_Th9qapo1CH0AwNwBf7vaf+7vSqBNtVA@mail.gmail.com>
 <CAFEAcA_ZXgNHMAhBVmjvstyG=PpaHOtcmo=VgvfBQ3Z9VJTk_g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3f1bf3ba-d6c3-a148-9850-076b2caa64d0@amsat.org>
Date: Tue, 7 Jul 2020 18:11:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_ZXgNHMAhBVmjvstyG=PpaHOtcmo=VgvfBQ3Z9VJTk_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Qemu-block <qemu-block@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/7/20 6:06 PM, Peter Maydell wrote:
> On Tue, 7 Jul 2020 at 17:04, Alistair Francis <alistair23@gmail.com> wrote:
>>
>> On Tue, Jul 7, 2020 at 6:22 AM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>
>>> QEMU allows to create SD card with unrealistic sizes. This could work,
>>> but some guests (at least Linux) consider sizes that are not a power
>>> of 2 as a firmware bug and fix the card size to the next power of 2.
>>>
>>> Before CVE-2020-13253 fix, this would allow OOB read/write accesses
>>> past the image size end.
>>>
>>> CVE-2020-13253 has been fixed as:
>>>
>>>     Read command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
>>>     occurred and no data transfer is performed.
>>>
>>>     Write command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
>>>     occurred and no data transfer is performed.
>>>
>>>     WP_VIOLATION errors are not modified: the error bit is set, we
>>>     stay in receive-data state, wait for a stop command. All further
>>>     data transfer is ignored. See the check on sd->card_status at the
>>>     beginning of sd_read_data() and sd_write_data().
>>>
>>> While this is the correct behavior, in case QEMU create smaller SD
>>> cards, guests still try to access past the image size end, and QEMU
>>> considers this is an invalid address, thus "all further data transfer
>>> is ignored". This is wrong and make the guest looping until
>>> eventually timeouts.
>>>
>>> Fix by not allowing invalid SD card sizes.  Suggesting the expected
>>> size as a hint:
>>>
>>>   $ qemu-system-arm -M orangepi-pc -drive file=rootfs.ext2,if=sd,format=raw
>>>   qemu-system-arm: Invalid SD card size: 60 MiB (expecting at least 64 MiB)
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>>  hw/sd/sd.c | 16 ++++++++++++++++
>>>  1 file changed, 16 insertions(+)
>>>
>>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>>> index cb81487e5c..c45106b78e 100644
>>> --- a/hw/sd/sd.c
>>> +++ b/hw/sd/sd.c
>>> @@ -32,6 +32,7 @@
>>>
>>>  #include "qemu/osdep.h"
>>>  #include "qemu/units.h"
>>> +#include "qemu/cutils.h"
>>>  #include "hw/irq.h"
>>>  #include "hw/registerfields.h"
>>>  #include "sysemu/block-backend.h"
>>> @@ -2130,11 +2131,26 @@ static void sd_realize(DeviceState *dev, Error **errp)
>>>      }
>>>
>>>      if (sd->blk) {
>>> +        int64_t blk_size;
>>> +
>>>          if (blk_is_read_only(sd->blk)) {
>>>              error_setg(errp, "Cannot use read-only drive as SD card");
>>>              return;
>>>          }
>>>
>>> +        blk_size = blk_getlength(sd->blk);
>>> +        if (blk_size > 0 && !is_power_of_2(blk_size)) {
>>> +            int64_t blk_size_aligned = pow2ceil(blk_size);
>>> +            char *blk_size_str = size_to_str(blk_size);
>>> +            char *blk_size_aligned_str = size_to_str(blk_size_aligned);
>>> +
>>> +            error_setg(errp, "Invalid SD card size: %s (expecting at least %s)",
>>> +                       blk_size_str, blk_size_aligned_str);
>>
>> Should we print that we expect a power of 2? This isn't always obvious
>> from the message.
> 
> Mmm, I was thinking that. Perhaps
>  "expecting a power of 2, e.g. %s"
> ?

OK, thanks guys!

> 
> thanks
> -- PMM
> 

