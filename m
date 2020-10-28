Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E09C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 01:37:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A0D320829
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 01:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cd6FeQPa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A0D320829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXaP1-0004qX-KB
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 21:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kXaOO-0004K7-6t; Tue, 27 Oct 2020 21:36:48 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:40787)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kXaOM-0004ut-7v; Tue, 27 Oct 2020 21:36:47 -0400
Received: by mail-yb1-xb42.google.com with SMTP id n142so2913565ybf.7;
 Tue, 27 Oct 2020 18:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W5t7X4QSpTNGiing32neLmfeIujtnyLUHKsAu6ZWal8=;
 b=cd6FeQPaL9+sh+Z/DFCQjAP7DO2N5CN0dHNOR6e1BWzBxuhqvMobDl7sVLJ6nobupv
 RRVZrRPKodz6ujKDsrnGLf1CXwv86xVX9HbC0yx3U9rdLoeG2zCTBs8gM4897qV2YDuE
 X564QRJZ8cwsfIDDKAdwfqd6fpTV/UWo4OKsevs0e0UBSQEt/MVYHHO1B9Zi9qb2E7rJ
 u+qpJ8WjyBPc/A4tQTyQivf4qwkoVAx/1D4gnh54MNWJktnJynsJ0GLCHBmk1M1JFutT
 JkYceA7OAkyblYY9WHRDlA0TvERIhIjbnMGOCaswt3oulfkEqYFB9VE4hY6r93Ggmixn
 m+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W5t7X4QSpTNGiing32neLmfeIujtnyLUHKsAu6ZWal8=;
 b=eIypn81/7SffWijA5jsa1JzBmTcqnpKc5G++GZfXV+dvsQz77j9LuIuMHwndK4VLYd
 kFmpTpJbqo6jX1MfXlYKn3rjMEqgLUUyFT2Lmw4DFf0TMH6xK4ep95k0bPycRBhKim5h
 i1oqBMjAJlqmfKQ9dSRWX9Drr3VzLZrocPhWcDXbymLl1APYi9xbPNEE/Il6v1UtHTGz
 nu5MMjlxzv3DrTxGeFO9thKUtNGwaLo8KA77Wg3/JoXGTUxLtApWzvgFgWVrWRY7xU9e
 VV5IHhosnrnN0nYCAaQ4hCOZ0E9QyJTQL1+8QiztX8IcBdUSH6TMmN9Lk1neJAQFXFmp
 4ZXg==
X-Gm-Message-State: AOAM533u/h25dicjR94yBwKe2S2KHSZgm7xugV5SpChHUE/fGPuB8WEI
 pFxX0ZJgDfiQ3tUu2xixFHKkbGDQZZDjMDx1lpY=
X-Google-Smtp-Source: ABdhPJzbSSzGX4h684u8dVO+iuatILkmneBm8XvNWuEFABS5xB1Gos21mFS0g7q3umHlqcwISuN+of1yibDI0thHQMo=
X-Received: by 2002:a25:520a:: with SMTP id g10mr7346727ybb.152.1603849004730; 
 Tue, 27 Oct 2020 18:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <20201024014954.21330-1-bmeng.cn@gmail.com>
 <1e4c44aa-7d2a-e773-fe8e-47b858137896@amsat.org>
 <CAPan3WqM1VGRB_K4AsBynrhzm-+DN9x2G7oOKHujSj-A1yH3Sg@mail.gmail.com>
In-Reply-To: <CAPan3WqM1VGRB_K4AsBynrhzm-+DN9x2G7oOKHujSj-A1yH3Sg@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 28 Oct 2020 09:36:33 +0800
Message-ID: <CAEUhbmV_z1mtK2PCVjrXhQtg48HgeAhuJAxdEoms+wFttLeg6g@mail.gmail.com>
Subject: Re: [PATCH] hw/sd: Zero out function selection fields before being
 populated
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b42;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Niek,

On Wed, Oct 28, 2020 at 3:55 AM Niek Linnenbank
<nieklinnenbank@gmail.com> wrote:
>
> Hello Philippe, Bin,
>
> Thanks for your support on this. I've just tried this patch and unfortunately it doesn't seem to
> resolve the issue, at least on my machine. This is the output that I get when running the avocado test for NetBSD9.0:
>
>  (5/5) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_uboot_netbsd9: |console: U-Boot SPL 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000)
> console: DRAM: 1024 MiB
> console: Failed to set core voltage! Can't set CPU frequency
> console: Trying to boot from MMC1
> console: U-Boot 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000) Allwinner Technology
> console: CPU:   Allwinner H3 (SUN8I 0000)
> ...
> console: [   1.2957642] sdmmc0: SD card status: 4-bit, C0
> console: [   1.3094731] ld0 at sdmmc0: <0xaa:0x5859:QEMU!:0x01:0xdeadbeef:0x062>
> console: [   1.3159383] ld0: 1024 MB, 1040 cyl, 32 head, 63 sec, 512 bytes/sect x 2097152 sectors
> console: [   1.3763222] ld0: 4-bit width, High-Speed/SDR25, 50.000 MHz
> console: [   2.0592109] WARNING: 4 errors while detecting hardware; check system log.
> console: [   2.0693403] boot device: ld0
> console: [   2.0798960] root on ld0a dumps on ld0b
> console: [   2.0994141] vfs_mountroot: can't open root device
> console: [   2.0994141] cannot mount root, error = 6
> <FREEZE>
>
> When starting NetBSD 9.0 manually, it shows clearly that the SD card is recognized with 1GiB size, also from U-Boot:
> $ qemu-system-arm -M orangepi-pc -nographic -nic user -sd ./armv7.img
> WARNING: Image format was not specified for './armv7.img' and probing guessed raw.
>          Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
>          Specify the 'raw' format explicitly to remove the restrictions.
>
> U-Boot SPL 2020.07-00610-g610e1487c8 (Jul 11 2020 - 22:31:58 +0200)
> DRAM: 1024 MiB
> Failed to set core voltage! Can't set CPU frequency
> Trying to boot from MMC1
>
> U-Boot 2020.07-00610-g610e1487c8 (Jul 11 2020 - 22:31:58 +0200) Allwinner Technology
>
> CPU:   Allwinner H3 (SUN8I 0000)
> Model: Xunlong Orange Pi PC
> DRAM:  1 GiB
> MMC:   mmc@1c0f000: 0
> ...
> Hit any key to stop autoboot:  0
> => mmc info
> Device: mmc@1c0f000
> Manufacturer ID: aa
> OEM: 5859
> Name: QEMU!
> Bus Speed: 50000000
> Mode: SD High Speed (50MHz)
> Rd Block Len: 512
> SD version 2.0
> High Capacity: No
> Capacity: 1 GiB
> Bus Width: 4-bit
> Erase Group Size: 512 Bytes
> =>
> => boot
> 8846552 bytes read in 931 ms (9.1 MiB/s)
> ...
> [   1.3447558] sdmmc0: SD card status: 4-bit, C0
> [   1.3546801] ld0 at sdmmc0: <0xaa:0x5859:QEMU!:0x01:0xdeadbeef:0x062>
> [   1.3647790] ld0: 1024 MB, 1040 cyl, 32 head, 63 sec, 512 bytes/sect x 2097152 sectors
> [   1.4150230] ld0: 4-bit width, High-Speed/SDR25, 50.000 MHz
> [   2.0800893] WARNING: 4 errors while detecting hardware; check system log.
> [   2.0800893] boot device: ld0
> [   2.0900792] root on ld0a dumps on ld0b
> [   2.1004160] vfs_mountroot: can't open root device
> [   2.1004160] cannot mount root, error = 6
> [   2.1004160] root device (default ld0a):
> <FREEZE>
>
> Note that the image has been resized to 2GiB with qemu-img:
> $ ls -alh armv7.img
> -rw-rw-r-- 1 user user 2,0G okt 28 22:45 armv7.img
>
> The previous patch proposed by Bin did resolve the error ("hw/sd: Fix 2GiB card CSD register values" ):
>  https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg07318.html

Correct. The patch above has not been applied yet, and only this patch
is now in mainline, so you will still see errors in the NetBSD 9.0
test.

>
> Although I see that this patch is now in master (89c6700fe7eed9195f10055751edbc6d5e7ab940),
> can you please confirm that the issue is still present when testing this on your machine as well?
>

Regards,
Bin

