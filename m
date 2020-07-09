Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C15C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 13:57:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D205320708
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 13:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YErqQGSE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D205320708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtX3L-000069-1V
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 09:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtX2k-00084B-F0; Thu, 09 Jul 2020 09:56:54 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38680)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtX2i-0006jF-EL; Thu, 09 Jul 2020 09:56:54 -0400
Received: by mail-wm1-x344.google.com with SMTP id f18so1907178wml.3;
 Thu, 09 Jul 2020 06:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=u3aKQ8+cwKjgCr/L+GyujiTh8CUSLj1WqlsO4uLLmIk=;
 b=YErqQGSEhmOrMNwXi6VUclL9pLZPX3ODKkdC0s9GdZ3FaAM0x5L8TzDSMUXR2lF8Uw
 6bFvSZ3NEkF2ZxsIeah6f0RLuHQkwq5XUA2RHnvZayTidu3DAoL0MoZjufX0Z1LsccWz
 pNMEHAUVHbqrwOhDJ972zOSexIumesk7pIFcl1u4kmpHoojntWpJ2UkFFTdUWx0jmop4
 ZmpU88+ig94Wwv+3QhHxQ+fDGMWQcziJbLT5UUN/dJXoYKOG24EB+0TUOm8exji20ZTv
 FjGmWq9exHvl4xf5Wz1w+6y+fdmobo61sEAorePV9UeOXN7oeeqILevZN1AbsenC+kfr
 fLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u3aKQ8+cwKjgCr/L+GyujiTh8CUSLj1WqlsO4uLLmIk=;
 b=G8TdZJ8YTmynMTAk+MzMhXfq4rNEmvnhjU2Uwl+pURtZNxDBdJkRZN6cn+LTF4VHDZ
 x213ukIm5i2rypYAJAAWTrGaoEPzm7wHPLHjQPJutQmQUoTQG/Iby57aqAMEFDYfi+zb
 16w5EDgIdLtAbPZTyfKgxCe3pQCYnwqY/3FmvZ/9bC38aR/thEuQrpD0R9AX8dloPy1U
 pKrdnfpJ75loLMxrfgnt6UObmCb4r+aUnWD/5xu84K8fekNbUPRqGNFZXPtBwThFLECo
 XMr6q53696NSYlAMVBbaPDnckS5IaBDa5JKW4Vk1XA6+K51pQxl73SOGXNc0YqK9jciI
 ceTA==
X-Gm-Message-State: AOAM5332l6EU6GQEnBmapVyRYRctg1KmrUEmJW6jLp89E0DAxlXvNbRr
 xLR16T4UwCZVwiqttgAQJ38=
X-Google-Smtp-Source: ABdhPJwd6PlcKxlzxrxkxwj1QyGyXLXuB/wBx7B9O0qxeYeJ8/oapgJraIuSwUQphUAxjooqxJL5Zg==
X-Received: by 2002:a05:600c:2152:: with SMTP id
 v18mr129053wml.5.1594303010207; 
 Thu, 09 Jul 2020 06:56:50 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id j24sm5893685wrd.43.2020.07.09.06.56.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2020 06:56:49 -0700 (PDT)
Subject: Re: [PATCH 2/2] hw/sd/sdcard: Do not allow invalid SD card sizes
To: Niek Linnenbank <nieklinnenbank@gmail.com>
References: <20200707132116.26207-1-f4bug@amsat.org>
 <20200707132116.26207-3-f4bug@amsat.org>
 <CAKmqyKNY+7tE9tcZm7_Th9qapo1CH0AwNwBf7vaf+7vSqBNtVA@mail.gmail.com>
 <CAFEAcA_ZXgNHMAhBVmjvstyG=PpaHOtcmo=VgvfBQ3Z9VJTk_g@mail.gmail.com>
 <3f1bf3ba-d6c3-a148-9850-076b2caa64d0@amsat.org>
 <CAPan3Wr09ZbbHWO-dhGeK3zhZQv3smrzLpUGMj71NWh0hToZDg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e87550d9-e1cc-cc15-2674-755249e9a965@amsat.org>
Date: Thu, 9 Jul 2020 15:56:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAPan3Wr09ZbbHWO-dhGeK3zhZQv3smrzLpUGMj71NWh0hToZDg@mail.gmail.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Qemu-block <qemu-block@nongnu.org>, Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Alistair Francis <alistair23@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/7/20 10:29 PM, Niek Linnenbank wrote:
> Hi Philippe,
> 
> Just tried out your patch on latest master, and I noticed I couldn't
> apply it without getting this error:
> 
> $ git am ~/Downloads/patches/\[PATCH\ 2_2\]\ hw_sd_sdcard\:\ Do\ not\
> allow\ invalid\ SD\ card\ sizes\ -\ Philippe\ Mathieu-Daudé\
> \<f4bug@amsat.org <mailto:f4bug@amsat.org>\>\ -\ 2020-07-07\ 1521.eml
> Applying: hw/sd/sdcard: Do not allow invalid SD card sizes
> error: patch failed: hw/sd/sd.c:2130
> error: hw/sd/sd.c: patch does not apply
> Patch failed at 0001 hw/sd/sdcard: Do not allow invalid SD card sizes
> Use 'git am --show-current-patch' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> 
> The first patch did go OK. Maybe this one just needs to be rebased, or I
> made a mistake.

Sorry it was not clear on the cover:

  Part 1 is already reviewed:
  https://www.mail-archive.com/qemu-devel@nongnu.org/msg718150.html
  Based-on: <20200630133912.9428-1-f4bug@amsat.org>

This series is based on the "Part 1".

> So I manually copy & pasted the change into hw/sd/sd.c to test it.
> It looks like the check works, but my concern is that with this change,
> we will be getting this error on 'off-the-shelf' images as well.
> For example, the latest Raspbian image size also isn't a power of two:
> 
> $ ./arm-softmmu/qemu-system-arm -M raspi2 -sd
> ~/Downloads/2020-05-27-raspios-buster-lite-armhf.img -nographic
> WARNING: Image format was not specified for
> '/home/me/Downloads/2020-05-27-raspios-buster-lite-armhf.img' and
> probing guessed raw.
>          Automatically detecting the format is dangerous for raw images,
> write operations on block 0 will be restricted.
>          Specify the 'raw' format explicitly to remove the restrictions.
> qemu-system-arm: Invalid SD card size: 1.73 GiB (expecting at least 2 GiB)
> 
> If we do decide that the change is needed, I would like to propose that
> we also give the user some instructions
> on how to fix it, maybe some 'dd' command?

On POSIX we can suggest to use 'truncate -s 2G' from coreutils.
This is not in the default Darwin packages.
On Windows I have no clue.

> In my opinion that should
> also go in some of the documentation file(s),
> possibly also in the one for the OrangePi PC at
> docs/system/arm/orangepi.rst (I can also provide a patch for that if you
> wish).

Good idea, if you can send that patch that would a precious help,
and I'd include it with the other patches :)

Note that this was your orangepi-pc acceptance test that catched
this bug!
See https://travis-ci.org/github/philmd/qemu/jobs/705653532#L5672:

 CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=50c5387d
 OF: fdt: Machine model: Xunlong Orange Pi PC
 Kernel command line: printk.time=0 console=ttyS0,115200
root=/dev/mmcblk0 rootwait rw panic=-1 noreboot
 sunxi-mmc 1c0f000.mmc: Linked as a consumer to regulator.2
 sunxi-mmc 1c0f000.mmc: Got CD GPIO
 sunxi-mmc 1c0f000.mmc: initialized, max. request size: 16384 KB
 mmc0: host does not support reading read-only switch, assuming write-enable
 mmc0: Problem switching card into high-speed mode!
 mmc0: new SD card at address 4567
 mmcblk0: mmc0:4567 QEMU! 60.0 MiB
 EXT4-fs (mmcblk0): mounting ext2 file system using the ext4 subsystem
 EXT4-fs (mmcblk0): mounted filesystem without journal. Opts: (null)
 VFS: Mounted root (ext2 filesystem) on device 179:0.
 EXT4-fs (mmcblk0): re-mounted. Opts: block_validity,barrier,user_xattr,acl
 Populating /dev using udev: udevd[204]: starting version 3.2.7
 udevadm settle failed
 done
 udevd[205]: worker [208]
/devices/platform/soc/1c0f000.mmc/mmc_host/mmc0/mmc0:4567/block/mmcblk0
is taking a long time
Runner error occurred: Timeout reached
Original status: ERROR

(I'll add that in the commit description too).

Thanks for your testing/review!

> Kind regards,
> 
> Niek
> 
> 
> On Tue, Jul 7, 2020 at 6:11 PM Philippe Mathieu-Daudé <f4bug@amsat.org
> <mailto:f4bug@amsat.org>> wrote:
> 
>     On 7/7/20 6:06 PM, Peter Maydell wrote:
>     > On Tue, 7 Jul 2020 at 17:04, Alistair Francis
>     <alistair23@gmail.com <mailto:alistair23@gmail.com>> wrote:
>     >>
>     >> On Tue, Jul 7, 2020 at 6:22 AM Philippe Mathieu-Daudé
>     <f4bug@amsat.org <mailto:f4bug@amsat.org>> wrote:
>     >>>
>     >>> QEMU allows to create SD card with unrealistic sizes. This could
>     work,
>     >>> but some guests (at least Linux) consider sizes that are not a power
>     >>> of 2 as a firmware bug and fix the card size to the next power of 2.
>     >>>
>     >>> Before CVE-2020-13253 fix, this would allow OOB read/write accesses
>     >>> past the image size end.
>     >>>
>     >>> CVE-2020-13253 has been fixed as:
>     >>>
>     >>>     Read command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
>     >>>     occurred and no data transfer is performed.
>     >>>
>     >>>     Write command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
>     >>>     occurred and no data transfer is performed.
>     >>>
>     >>>     WP_VIOLATION errors are not modified: the error bit is set, we
>     >>>     stay in receive-data state, wait for a stop command. All further
>     >>>     data transfer is ignored. See the check on sd->card_status
>     at the
>     >>>     beginning of sd_read_data() and sd_write_data().
>     >>>
>     >>> While this is the correct behavior, in case QEMU create smaller SD
>     >>> cards, guests still try to access past the image size end, and QEMU
>     >>> considers this is an invalid address, thus "all further data
>     transfer
>     >>> is ignored". This is wrong and make the guest looping until
>     >>> eventually timeouts.
>     >>>
>     >>> Fix by not allowing invalid SD card sizes.  Suggesting the expected
>     >>> size as a hint:
>     >>>
>     >>>   $ qemu-system-arm -M orangepi-pc -drive
>     file=rootfs.ext2,if=sd,format=raw
>     >>>   qemu-system-arm: Invalid SD card size: 60 MiB (expecting at
>     least 64 MiB)
>     >>>
>     >>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org
>     <mailto:f4bug@amsat.org>>
>     >>> ---
>     >>>  hw/sd/sd.c | 16 ++++++++++++++++
>     >>>  1 file changed, 16 insertions(+)
>     >>>
>     >>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>     >>> index cb81487e5c..c45106b78e 100644
>     >>> --- a/hw/sd/sd.c
>     >>> +++ b/hw/sd/sd.c
>     >>> @@ -32,6 +32,7 @@
>     >>>
>     >>>  #include "qemu/osdep.h"
>     >>>  #include "qemu/units.h"
>     >>> +#include "qemu/cutils.h"
>     >>>  #include "hw/irq.h"
>     >>>  #include "hw/registerfields.h"
>     >>>  #include "sysemu/block-backend.h"
>     >>> @@ -2130,11 +2131,26 @@ static void sd_realize(DeviceState *dev,
>     Error **errp)
>     >>>      }
>     >>>
>     >>>      if (sd->blk) {
>     >>> +        int64_t blk_size;
>     >>> +
>     >>>          if (blk_is_read_only(sd->blk)) {
>     >>>              error_setg(errp, "Cannot use read-only drive as SD
>     card");
>     >>>              return;
>     >>>          }
>     >>>
>     >>> +        blk_size = blk_getlength(sd->blk);
>     >>> +        if (blk_size > 0 && !is_power_of_2(blk_size)) {
>     >>> +            int64_t blk_size_aligned = pow2ceil(blk_size);
>     >>> +            char *blk_size_str = size_to_str(blk_size);
>     >>> +            char *blk_size_aligned_str =
>     size_to_str(blk_size_aligned);
>     >>> +
>     >>> +            error_setg(errp, "Invalid SD card size: %s
>     (expecting at least %s)",
>     >>> +                       blk_size_str, blk_size_aligned_str);
>     >>
>     >> Should we print that we expect a power of 2? This isn't always
>     obvious
>     >> from the message.
>     >
>     > Mmm, I was thinking that. Perhaps
>     >  "expecting a power of 2, e.g. %s"
>     > ?
> 
>     OK, thanks guys!
> 
>     >
>     > thanks
>     > -- PMM
>     >
> 
> 
> 
> -- 
> Niek Linnenbank
> 

