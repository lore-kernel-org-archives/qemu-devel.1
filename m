Return-Path: <SRS0=AG+E=EA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D56C388F7
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 17:06:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C2CC208A9
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 17:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0uGkzJd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C2CC208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWjTT-0008S6-De
	for qemu-devel@archiver.kernel.org; Sun, 25 Oct 2020 13:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1kWjSO-0007cx-Ix; Sun, 25 Oct 2020 13:05:24 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:45069)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1kWjSM-0006Iu-5I; Sun, 25 Oct 2020 13:05:24 -0400
Received: by mail-io1-xd41.google.com with SMTP id n6so7452654ioc.12;
 Sun, 25 Oct 2020 10:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iZmJ8Of7tzxdwMZ0uGoa+0QXeYoF0mVgLGMdWR4j4Ao=;
 b=c0uGkzJd9OqsX1Gk6CEEs8KTun/x0qe85geKH/ds40P7Hlxbq69PYa/y7qnyZz7B3s
 l+n/pn7//iRPnOguA/WJrDB/0ozkV9Aa2XCEZrwDD546vCsyJSlDBgd4EZIDeoZXaiJU
 JAJciI3uN2QWV2VOo1O6CXz4Nxj8qu6g9hGrHRc+eN28qxZcdCtOEdNn/f6rgzbmN1WN
 dOlGJg6q2P3wpVdfCGtcFlfMYuhHfuTSZBPqRKrPh541otQov2EbvTzWLAfv2pA6o7HH
 7PARJEwAXxtLLc9DBzXRhRR4PyO74UWNNh2HMstjg3uTlRxuH6UNI1Z5Ut5JLF1pYs7D
 7SpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iZmJ8Of7tzxdwMZ0uGoa+0QXeYoF0mVgLGMdWR4j4Ao=;
 b=pX4YL2fp8llCRiKjwwK6dQz9s3k/yoF+001h6xP6nCEydnoXrY0vDcZTqaroopq4oT
 Nb5CCaFSjZS3e02JTbX3Trj8wiAGtXqZxk+BxzfXDWedeRip0/GWrP9I04Osx8WMfSh3
 adW6KGUBZWOTsPIb6MmlWn8aWrSWHFkRiRtq2fVfRFeGH8PlNOUH1grKMUPEG87OLUBh
 2X2vdLzV18K5Vnhs5FYku7vrJfLMXvKrWz5ev98H/zz66ZStQ/LIH84pEajwJP0W8Dlx
 /CX7BmsxNAeeiIP/a1bFgtVDab8Y4nzY/2JH88mfwj0bnjSKng5nbtPA6+GlJgVASRWZ
 r1vg==
X-Gm-Message-State: AOAM530mMNGrAWguFUAsqGuQowYBMkbLrZ2WB5iezsb7tRtCGPc3WfFu
 AN2G/HOww3XUQP2Np7oJOqvc5dsBuJamGxvbAdA=
X-Google-Smtp-Source: ABdhPJxp97I8RT0QXKxetzqAGVjlQoQu/7BZSY51RWd50uNyHF040Rn/5wRxKccPP8AFn0mn7S2ihDhs1gzpcXNKI9o=
X-Received: by 2002:a05:6638:2494:: with SMTP id
 x20mr8361260jat.83.1603645520394; 
 Sun, 25 Oct 2020 10:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20201025152357.11865-1-bmeng.cn@gmail.com>
In-Reply-To: <20201025152357.11865-1-bmeng.cn@gmail.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Mon, 26 Oct 2020 01:29:30 +0100
Message-ID: <CAPan3Wr0944ij1Wvz9cucwcp5Kg+HhJNFZOQK+pHgy_HTUaJfg@mail.gmail.com>
Subject: Re: [PATCH] hw/sd: Fix 2 GiB card CSD register values
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000096bed905b281d102"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000096bed905b281d102
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Bin,

On Sun, Oct 25, 2020 at 4:25 PM Bin Meng <bmeng.cn@gmail.com> wrote:

> From: Bin Meng <bin.meng@windriver.com>
>
> Per the SD spec, to indicate a 2 GiB card, BLOCK_LEN shall be 1024
> bytes, hence the READ_BL_LEN field in the CSD register shall be 10
> instead of 9.
>
> This fixes the acceptance test error for the NetBSD 9.0 test of the
> Orange Pi PC that has an expanded SD card image of 2 GiB size.
>

Thanks for your quick response on this. I re-ran all the avocado tests
again with this patch added to philips series
and now all tests are passing:

 (4/6)
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_b=
ionic_19_11:
-console: U-Boot SPL 2019.04-armbian (Nov 18 2019 - 23:08:35 +0100)
console: DRAM: 1024 MiB
console: Failed to set core voltage! Can't set CPU frequency
console: Trying to boot from MMC1
console: U-Boot 2019.04-armbian (Nov 18 2019 - 23:08:35 +0100) Allwinner
Technology
console: CPU:   Allwinner H3 (SUN8I 0000)
...
console: [  OK  ] Listening on Journal Socket.
console: systemd[1]: Starting Create list of required static device nodes
for the current kernel...
console: Starting Create list of required st=E2=80=A6ce nodes for the curre=
nt
kernel...
console: systemd[1]: Starting Load Kernel Modules...
PASS (51.09 s)
 (5/6)
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_b=
ionic_20_08:
\console: U-Boot SPL 2020.04-armbian (Sep 02 2020 - 10:16:13 +0200)
|console: DRAM: 1024 MiB
console: Failed to set core voltage! Can't set CPU frequency
console: Trying to boot from MMC1
console: U-Boot 2020.04-armbian (Sep 02 2020 - 10:16:13 +0200) Allwinner
Technology
...
console: [  OK  ] Listening on /dev/initctl Compatibility Named Pipe.
console: [  OK  ] Listening on Journal Audit Socket.
console: Starting Load Kernel Modules...
PASS (61.05 s)
 (6/6)
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_u=
boot_netbsd9:
\console: U-Boot SPL 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000)
console: DRAM: 1024 MiB
console: Failed to set core voltage! Can't set CPU frequency
console: Trying to boot from MMC1
console: U-Boot 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000) Allwinner
Technology
...
console: [   3.6296962] root on ld0a dumps on ld0b
console: [   3.7250834] root file system type: ffs
console: [   3.7878476] kern.module.path=3D/stand/evbarm/9.0/modules
-console: Sun Oct 25 23:08:43 UTC 2020
|console: Starting root file system check:
PASS (21.12 s)
RESULTS    : PASS 6 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 |
CANCEL 0
JOB TIME   : 183.41 s

I've also booted the Armbian 20.08 image manually and it starts up fine
till the login/setup prompt:

$ qemu-system-arm -M orangepi-pc -nographic -nic user -sd
Armbian_20.08.1_Orangepipc_bionic_current_5.8.5.img
...
WARNING: Image format was not specified for
'Armbian_20.08.1_Orangepipc_bionic_current_5.8.5.img' and probing guessed
raw.
         Automatically detecting the format is dangerous for raw images,
write operations on block 0 will be restricted.
         Specify the 'raw' format explicitly to remove the restrictions.

U-Boot SPL 2020.04-armbian (Sep 02 2020 - 10:16:13 +0200)
DRAM: 1024 MiB
Failed to set core voltage! Can't set CPU frequency
Trying to boot from MMC1

U-Boot 2020.04-armbian (Sep 02 2020 - 10:16:13 +0200) Allwinner Technology

CPU:   Allwinner H3 (SUN8I 0000)
Model: Xunlong Orange Pi PC
...
Autoboot in 1 seconds, press <Space> to stop
=3D> setenv extraargs 'console=3DttyS0,115200'
=3D> boot
...
Uncompressing Linux... done, booting the kernel.
Loading, please wait...
starting version 237
Begin: Loading essential drivers ... done.
Begin: Running /scripts/init-premount ... done.
Begin: Mounting root file system ... Begin: Running /scripts/local-top ...
done.
Begin: Running /scripts/local-premount ... Scanning for Btrfs filesystems
done.
Begin: Will now check root file system ... fsck from util-linux 2.31.1
[/sbin/fsck.ext4 (1) -- /dev/mmcblk0p1] fsck.ext4 -a -C0 /dev/mmcblk0p1
/dev/mmcblk0p1: recovering journal
/dev/mmcblk0p1: clean, 38118/117504 files, 230861/497048 blocks
done.
done.
Begin: Running /scripts/local-bottom ... done.
Begin: Running /scripts/init-bottom ... done.

Welcome to Armbian 20.08.1 Bionic!
...
[  OK  ] Created slice system-getty.slice.
[  OK  ] Started Getty on tty1.
[  OK  ] Reached target Login Prompts.
[  OK  ] Started Network Manager Script Dispatcher Service.

Armbian 20.08.1 Bionic ttyS0

orangepipc login:

From these tests it looks to me that the change is working as expected. I'm
not an expert on SD internals
so perhaps Philippe would like to give more detailed review comments on the
code itself.

So for the Orange Pi PC machine & acceptance tests:

Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>

Regards,
Niek


>
> Fixes: 6d2d4069c47e ("hw/sd: Correct the maximum size of a Standard
> Capacity SD Memory Card")
> Reported-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> ---
>
>  hw/sd/sd.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index bd10ec8fc4..732fcb5ff0 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -386,10 +386,17 @@ static const uint8_t sd_csd_rw_mask[16] =3D {
>
>  static void sd_set_csd(SDState *sd, uint64_t size)
>  {
> -    uint32_t csize =3D (size >> (CMULT_SHIFT + HWBLOCK_SHIFT)) - 1;
> +    int hwblock_shift =3D HWBLOCK_SHIFT;
> +    uint32_t csize;
>      uint32_t sectsize =3D (1 << (SECTOR_SHIFT + 1)) - 1;
>      uint32_t wpsize =3D (1 << (WPGROUP_SHIFT + 1)) - 1;
>
> +    /* To indicate 2 GiB card, BLOCK_LEN shall be 1024 bytes */
> +    if (size =3D=3D SDSC_MAX_CAPACITY) {
> +        hwblock_shift +=3D 1;
> +    }
> +    csize =3D (size >> (CMULT_SHIFT + hwblock_shift)) - 1;
> +
>      if (size <=3D SDSC_MAX_CAPACITY) { /* Standard Capacity SD */
>          sd->csd[0] =3D 0x00;     /* CSD structure */
>          sd->csd[1] =3D 0x26;     /* Data read access-time-1 */
> @@ -397,7 +404,7 @@ static void sd_set_csd(SDState *sd, uint64_t size)
>          sd->csd[3] =3D 0x32;      /* Max. data transfer rate: 25 MHz */
>          sd->csd[4] =3D 0x5f;     /* Card Command Classes */
>          sd->csd[5] =3D 0x50 |    /* Max. read data block length */
> -            HWBLOCK_SHIFT;
> +            hwblock_shift;
>          sd->csd[6] =3D 0xe0 |    /* Partial block for read allowed */
>              ((csize >> 10) & 0x03);
>          sd->csd[7] =3D 0x00 |    /* Device size */
> @@ -411,9 +418,9 @@ static void sd_set_csd(SDState *sd, uint64_t size)
>          sd->csd[11] =3D 0x00 |   /* Write protect group size */
>              ((sectsize << 7) & 0x80) | wpsize;
>          sd->csd[12] =3D 0x90 |   /* Write speed factor */
> -            (HWBLOCK_SHIFT >> 2);
> +            (hwblock_shift >> 2);
>          sd->csd[13] =3D 0x20 |   /* Max. write data block length */
> -            ((HWBLOCK_SHIFT << 6) & 0xc0);
> +            ((hwblock_shift << 6) & 0xc0);
>          sd->csd[14] =3D 0x00;    /* File format group */
>      } else {                   /* SDHC */
>          size /=3D 512 * KiB;
> --
> 2.25.1
>
>

--=20
Niek Linnenbank

--00000000000096bed905b281d102
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hello Bin,</div><div><br></div></div=
><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, O=
ct 25, 2020 at 4:25 PM Bin Meng &lt;<a href=3D"mailto:bmeng.cn@gmail.com">b=
meng.cn@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">From: Bin Meng &lt;<a href=3D"mailto:bin.meng@windriver.co=
m" target=3D"_blank">bin.meng@windriver.com</a>&gt;<br>
<br>
Per the SD spec, to indicate a 2 GiB card, BLOCK_LEN shall be 1024<br>
bytes, hence the READ_BL_LEN field in the CSD register shall be 10<br>
instead of 9.<br>
<br>
This fixes the acceptance test error for the NetBSD 9.0 test of the<br>
Orange Pi PC that has an expanded SD card image of 2 GiB size.<br></blockqu=
ote><div><br></div><div>Thanks for your quick response on this. I re-ran al=
l the avocado tests again with this patch added to philips series</div><div=
>and now all tests are passing:<br></div><div><br></div><div>=C2=A0(4/6) te=
sts/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_bio=
nic_19_11: -console: U-Boot SPL 2019.04-armbian (Nov 18 2019 - 23:08:35 +01=
00)<br>console: DRAM: 1024 MiB<br>console: Failed to set core voltage! Can&=
#39;t set CPU frequency<br>console: Trying to boot from MMC1<br>console: U-=
Boot 2019.04-armbian (Nov 18 2019 - 23:08:35 +0100) Allwinner Technology<br=
>console: CPU: =C2=A0 Allwinner H3 (SUN8I 0000)</div><div>...</div><div>con=
sole: [ =C2=A0OK =C2=A0] Listening on Journal Socket.<br>console: systemd[1=
]: Starting Create list of required static device nodes for the current ker=
nel...<br>console: Starting Create list of required st=E2=80=A6ce nodes for=
 the current kernel...<br>console: systemd[1]: Starting Load Kernel Modules=
...<br>PASS (51.09 s)<br>=C2=A0(5/6) tests/acceptance/boot_linux_console.py=
:BootLinuxConsole.test_arm_orangepi_bionic_20_08: \console: U-Boot SPL 2020=
.04-armbian (Sep 02 2020 - 10:16:13 +0200)<br>|console: DRAM: 1024 MiB<br>c=
onsole: Failed to set core voltage! Can&#39;t set CPU frequency<br>console:=
 Trying to boot from MMC1<br>console: U-Boot 2020.04-armbian (Sep 02 2020 -=
 10:16:13 +0200) Allwinner Technology</div><div>...</div><div>console: [ =
=C2=A0OK =C2=A0] Listening on /dev/initctl Compatibility Named Pipe.<br>con=
sole: [ =C2=A0OK =C2=A0] Listening on Journal Audit Socket.<br>console: Sta=
rting Load Kernel Modules...<br>PASS (61.05 s)<br>=C2=A0(6/6) tests/accepta=
nce/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_uboot_netbsd9:=
 \console: U-Boot SPL 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000)<br>cons=
ole: DRAM: 1024 MiB<br>console: Failed to set core voltage! Can&#39;t set C=
PU frequency<br>console: Trying to boot from MMC1<br>console: U-Boot 2020.0=
1+dfsg-1 (Jan 08 2020 - 08:19:44 +0000) Allwinner Technology<br>...</div><d=
iv>console: [ =C2=A0 3.6296962] root on ld0a dumps on ld0b<br>console: [ =
=C2=A0 3.7250834] root file system type: ffs<br>console: [ =C2=A0 3.7878476=
] kern.module.path=3D/stand/evbarm/9.0/modules<br>-console: Sun Oct 25 23:0=
8:43 UTC 2020<br>|console: Starting root file system check:<br>PASS (21.12 =
s)<br>RESULTS =C2=A0 =C2=A0: PASS 6 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | =
INTERRUPT 0 | CANCEL 0<br>JOB TIME =C2=A0 : 183.41 s<br></div><div><br></di=
v><div>I&#39;ve also booted the Armbian 20.08 image manually and it starts =
up fine till the login/setup prompt:</div><div><br></div><div>$ qemu-system=
-arm -M orangepi-pc -nographic -nic user -sd Armbian_20.08.1_Orangepipc_bio=
nic_current_5.8.5.img</div><div>...</div><div>WARNING: Image format was not=
 specified for &#39;Armbian_20.08.1_Orangepipc_bionic_current_5.8.5.img&#39=
; and probing guessed raw.<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Automatical=
ly detecting the format is dangerous for raw images, write operations on bl=
ock 0 will be restricted.<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Specify the =
&#39;raw&#39; format explicitly to remove the restrictions.<br><br>U-Boot S=
PL 2020.04-armbian (Sep 02 2020 - 10:16:13 +0200)<br>DRAM: 1024 MiB<br>Fail=
ed to set core voltage! Can&#39;t set CPU frequency<br>Trying to boot from =
MMC1<br><br>U-Boot 2020.04-armbian (Sep 02 2020 - 10:16:13 +0200) Allwinner=
 Technology<br><br>CPU: =C2=A0 Allwinner H3 (SUN8I 0000)<br>Model: Xunlong =
Orange Pi PC</div><div>...<br>Autoboot in 1 seconds, press &lt;Space&gt; to=
 stop<br>=3D&gt; setenv extraargs &#39;console=3DttyS0,115200&#39;<br>=3D&g=
t; boot</div><div>...<br></div><div>Uncompressing Linux... done, booting th=
e kernel.<br>Loading, please wait...<br>starting version 237<br>Begin: Load=
ing essential drivers ... done.<br>Begin: Running /scripts/init-premount ..=
. done.<br>Begin: Mounting root file system ... Begin: Running /scripts/loc=
al-top ... done.<br>Begin: Running /scripts/local-premount ... Scanning for=
 Btrfs filesystems<br>done.<br>Begin: Will now check root file system ... f=
sck from util-linux 2.31.1<br>[/sbin/fsck.ext4 (1) -- /dev/mmcblk0p1] fsck.=
ext4 -a -C0 /dev/mmcblk0p1 <br>/dev/mmcblk0p1: recovering journal<br>/dev/m=
mcblk0p1: clean, 38118/117504 files, 230861/497048 blocks<br>done.<br>done.=
<br>Begin: Running /scripts/local-bottom ... done.<br>Begin: Running /scrip=
ts/init-bottom ... done.<br><br>Welcome to Armbian 20.08.1 Bionic!</div><di=
v>...<br></div><div>[ =C2=A0OK =C2=A0] Created slice system-getty.slice.<br=
>[ =C2=A0OK =C2=A0] Started Getty on tty1.<br>[ =C2=A0OK =C2=A0] Reached ta=
rget Login Prompts.<br>[ =C2=A0OK =C2=A0] Started Network Manager Script Di=
spatcher Service.<br><br>Armbian 20.08.1 Bionic ttyS0 <br><br>orangepipc lo=
gin:</div><div><br></div><div>From these tests it looks to me that the chan=
ge is working as expected. I&#39;m not an expert on SD internals</div><div>=
so perhaps Philippe would like to give more detailed review comments on the=
 code itself.</div><div><br></div><div>So for the Orange Pi PC machine &amp=
; acceptance tests:</div><div><br></div><div>Tested-by: Niek Linnenbank &lt=
;<a href=3D"mailto:nieklinnenbank@gmail.com">nieklinnenbank@gmail.com</a>&g=
t;<br></div><div><br></div><div>Regards,</div><div>Niek<br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Fixes: 6d2d4069c47e (&quot;hw/sd: Correct the maximum size of a Standard Ca=
pacity SD Memory Card&quot;)<br>
Reported-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com=
" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
Signed-off-by: Bin Meng &lt;<a href=3D"mailto:bin.meng@windriver.com" targe=
t=3D"_blank">bin.meng@windriver.com</a>&gt;<br>
---<br>
<br>
=C2=A0hw/sd/sd.c | 15 +++++++++++----<br>
=C2=A01 file changed, 11 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/hw/sd/sd.c b/hw/sd/sd.c<br>
index bd10ec8fc4..732fcb5ff0 100644<br>
--- a/hw/sd/sd.c<br>
+++ b/hw/sd/sd.c<br>
@@ -386,10 +386,17 @@ static const uint8_t sd_csd_rw_mask[16] =3D {<br>
<br>
=C2=A0static void sd_set_csd(SDState *sd, uint64_t size)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 uint32_t csize =3D (size &gt;&gt; (CMULT_SHIFT + HWBLOCK_SHI=
FT)) - 1;<br>
+=C2=A0 =C2=A0 int hwblock_shift =3D HWBLOCK_SHIFT;<br>
+=C2=A0 =C2=A0 uint32_t csize;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t sectsize =3D (1 &lt;&lt; (SECTOR_SHIFT + 1)) -=
 1;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t wpsize =3D (1 &lt;&lt; (WPGROUP_SHIFT + 1)) - =
1;<br>
<br>
+=C2=A0 =C2=A0 /* To indicate 2 GiB card, BLOCK_LEN shall be 1024 bytes */<=
br>
+=C2=A0 =C2=A0 if (size =3D=3D SDSC_MAX_CAPACITY) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hwblock_shift +=3D 1;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 csize =3D (size &gt;&gt; (CMULT_SHIFT + hwblock_shift)) - 1;=
<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (size &lt;=3D SDSC_MAX_CAPACITY) { /* Standard Capac=
ity SD */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sd-&gt;csd[0] =3D 0x00;=C2=A0 =C2=A0 =C2=
=A0/* CSD structure */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sd-&gt;csd[1] =3D 0x26;=C2=A0 =C2=A0 =C2=
=A0/* Data read access-time-1 */<br>
@@ -397,7 +404,7 @@ static void sd_set_csd(SDState *sd, uint64_t size)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sd-&gt;csd[3] =3D 0x32;=C2=A0 =C2=A0 =C2=
=A0 /* Max. data transfer rate: 25 MHz */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sd-&gt;csd[4] =3D 0x5f;=C2=A0 =C2=A0 =C2=
=A0/* Card Command Classes */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sd-&gt;csd[5] =3D 0x50 |=C2=A0 =C2=A0 /* =
Max. read data block length */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 HWBLOCK_SHIFT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hwblock_shift;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sd-&gt;csd[6] =3D 0xe0 |=C2=A0 =C2=A0 /* =
Partial block for read allowed */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((csize &gt;&gt; 10) &amp; =
0x03);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sd-&gt;csd[7] =3D 0x00 |=C2=A0 =C2=A0 /* =
Device size */<br>
@@ -411,9 +418,9 @@ static void sd_set_csd(SDState *sd, uint64_t size)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sd-&gt;csd[11] =3D 0x00 |=C2=A0 =C2=A0/* =
Write protect group size */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((sectsize &lt;&lt; 7) &amp=
; 0x80) | wpsize;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sd-&gt;csd[12] =3D 0x90 |=C2=A0 =C2=A0/* =
Write speed factor */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (HWBLOCK_SHIFT &gt;&gt; 2);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (hwblock_shift &gt;&gt; 2);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sd-&gt;csd[13] =3D 0x20 |=C2=A0 =C2=A0/* =
Max. write data block length */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((HWBLOCK_SHIFT &lt;&lt; 6) &amp=
; 0xc0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((hwblock_shift &lt;&lt; 6) &amp=
; 0xc0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sd-&gt;csd[14] =3D 0x00;=C2=A0 =C2=A0 /* =
File format group */<br>
=C2=A0 =C2=A0 =C2=A0} else {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0/* SDHC */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size /=3D 512 * KiB;<br>
-- <br>
2.25.1<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--00000000000096bed905b281d102--

