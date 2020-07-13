Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2032C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:40:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 589A72068F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c91HipQQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589A72068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv4JW-00014k-GG
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 15:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jv4H4-0006EI-D1; Mon, 13 Jul 2020 15:38:03 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:35740)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jv4H2-00012v-84; Mon, 13 Jul 2020 15:38:02 -0400
Received: by mail-io1-xd42.google.com with SMTP id v8so14800139iox.2;
 Mon, 13 Jul 2020 12:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=gzQcjiv60UsA9qKNwzOFGizSUzrsu2B8LsEUhyYdmDo=;
 b=c91HipQQXclFzB7zw+exL8+YlakUuOusLorX5v6YszriRdoRyBM1kfjJ2BGW371P56
 ysJ9bCCm1O1T3IQdoq4eY2kKUXK6m6EGah3NMVTWKPyCQGR8r3U32o7x9+zsg6kQS3I5
 ybvNCQybq6B55l5pgv7s9YGu+sHS9S735BYSrFB9XrrZmx1Rwvaq9cErE2F64aKNnlQu
 9F+wQafw365U81lRY0Mfm26MDoPQAPbB425/Ke1x606NtgbJesSs4QGJH1m4e5OI8YN1
 12E7uU0j5r3s98DaRnKRdMT+vk0n2NRzjdn5EvcYL5KacdSRj20vGAtekQPYrZYIPn9n
 tliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=gzQcjiv60UsA9qKNwzOFGizSUzrsu2B8LsEUhyYdmDo=;
 b=FammgHfdWvIMhZokq91EEQ6xA+Vr0nt2hvr+vvtpOrWjBZIOfSoJZB70VpsbT+MUpZ
 pJa/wb2MXuvdNAu0Q3565VNlsND+E52szSLhaB5TxYfNQGPmS836HjvRPLBMqDRCd9Sc
 MvRuCWV//PYFYeGuMeAmMTJtf/PA9Smv7PRmrtxTqOeD42G9avvwczuDWAod54ctgns/
 NRPUAKXQehd4iflWjb1u4o3GB0paCNPg+XwjM+1b5Axc3L/chFqoBwLBc0AHyquCoFnQ
 Y0yO9Pw8w5/Pjzok+MgDPRkAyFmLaIpcQlG9XZ//A1I+tkbeNHMb93qU4FEQ2GSB2pbo
 hn7A==
X-Gm-Message-State: AOAM532T/C4/Ljav5COthMxbgujf1u3aIxZQRHmHwep93N6QzBlut1Lb
 dvvIekYznhztJyjbw6toH4jzN9ypuT/a8Xaop8I=
X-Google-Smtp-Source: ABdhPJwy+aVwxxROgG0V4KSNV9l4UhEE7fIBZtAMj59NqiNqUJmwaN/cflkvvNPTiFzWtUSBBbdc1t9e5eXk1eBPqgo=
X-Received: by 2002:a5d:9ed0:: with SMTP id a16mr1350078ioe.176.1594669078333; 
 Mon, 13 Jul 2020 12:37:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200713183209.26308-1-f4bug@amsat.org>
 <20200713183209.26308-5-f4bug@amsat.org>
In-Reply-To: <20200713183209.26308-5-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 Jul 2020 12:28:00 -0700
Message-ID: <CAKmqyKPH1_Ne6BNvLsMCQ5RpaVz+vb1zgqqhv0hD5CUGV-XOog@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] tests/acceptance/boot_linux: Expand SD card image
 to power of 2
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 Prasad J Pandit <pjp@fedoraproject.org>, Qemu-block <qemu-block@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Niek Linnenbank <nieklinnenbank@gmail.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 13, 2020 at 11:34 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> In few commits we won't allow SD card images with invalid size
> (not aligned to a power of 2). Prepare the tests: add the
> pow2ceil() and image_pow2ceil_expand() methods and resize the
> images (expanding) of the tests using SD cards.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> Since v1: Addressed review comments
> - truncate -> expand reword (Alistair Francis)
> - expand after uncompress (Niek Linnenbank)
> ---
>  tests/acceptance/boot_linux_console.py | 27 +++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index b7e8858c2d..8f2a6aa8a4 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -28,6 +28,18 @@
>  except CmdNotFoundError:
>      P7ZIP_AVAILABLE =3D False
>
> +# round up to next power of 2
> +def pow2ceil(x):
> +    return 1 if x =3D=3D 0 else 2**(x - 1).bit_length()
> +
> +# expand file size to next power of 2
> +def image_pow2ceil_expand(path):
> +        size =3D os.path.getsize(path)
> +        size_aligned =3D pow2ceil(size)
> +        if size !=3D size_aligned:
> +            with open(path, 'ab+') as fd:
> +                fd.truncate(size_aligned)
> +
>  class LinuxKernelTest(Test):
>      KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
>
> @@ -636,6 +648,7 @@ def test_arm_orangepi_sd(self):
>          rootfs_path_xz =3D self.fetch_asset(rootfs_url, asset_hash=3Droo=
tfs_hash)
>          rootfs_path =3D os.path.join(self.workdir, 'rootfs.cpio')
>          archive.lzma_uncompress(rootfs_path_xz, rootfs_path)
> +        image_pow2ceil_expand(rootfs_path)
>
>          self.vm.set_console()
>          kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> @@ -673,7 +686,7 @@ def test_arm_orangepi_bionic(self):
>          :avocado: tags=3Ddevice:sd
>          """
>
> -        # This test download a 196MB compressed image and expand it to 9=
32MB...
> +        # This test download a 196MB compressed image and expand it to 1=
GB
>          image_url =3D ('https://dl.armbian.com/orangepipc/archive/'
>                       'Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.7z=
')
>          image_hash =3D '196a8ffb72b0123d92cea4a070894813d305c71e'
> @@ -681,6 +694,7 @@ def test_arm_orangepi_bionic(self):
>          image_name =3D 'Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.=
img'
>          image_path =3D os.path.join(self.workdir, image_name)
>          process.run("7z e -o%s %s" % (self.workdir, image_path_7z))
> +        image_pow2ceil_expand(image_path)
>
>          self.vm.set_console()
>          self.vm.add_args('-drive', 'file=3D' + image_path + ',if=3Dsd,fo=
rmat=3Draw',
> @@ -714,7 +728,7 @@ def test_arm_orangepi_uboot_netbsd9(self):
>          :avocado: tags=3Dmachine:orangepi-pc
>          :avocado: tags=3Ddevice:sd
>          """
> -        # This test download a 304MB compressed image and expand it to 1=
.3GB...
> +        # This test download a 304MB compressed image and expand it to 2=
GB
>          deb_url =3D ('http://snapshot.debian.org/archive/debian/'
>                     '20200108T145233Z/pool/main/u/u-boot/'
>                     'u-boot-sunxi_2020.01%2Bdfsg-1_armhf.deb')
> @@ -731,8 +745,9 @@ def test_arm_orangepi_uboot_netbsd9(self):
>          image_hash =3D '2babb29d36d8360adcb39c09e31060945259917a'
>          image_path_gz =3D self.fetch_asset(image_url, asset_hash=3Dimage=
_hash)
>          image_path =3D os.path.join(self.workdir, 'armv7.img')
> -        image_drive_args =3D 'if=3Dsd,format=3Draw,snapshot=3Don,file=3D=
' + image_path
>          archive.gzip_uncompress(image_path_gz, image_path)
> +        image_pow2ceil_expand(image_path)
> +        image_drive_args =3D 'if=3Dsd,format=3Draw,snapshot=3Don,file=3D=
' + image_path
>
>          # dd if=3Du-boot-sunxi-with-spl.bin of=3Darmv7.img bs=3D1K seek=
=3D8 conv=3Dnotrunc
>          with open(uboot_path, 'rb') as f_in:
> @@ -740,12 +755,6 @@ def test_arm_orangepi_uboot_netbsd9(self):
>                  f_out.seek(8 * 1024)
>                  shutil.copyfileobj(f_in, f_out)
>
> -                # Extend image, to avoid that NetBSD thinks the partitio=
n
> -                # inside the image is larger than device size itself
> -                f_out.seek(0, 2)
> -                f_out.seek(64 * 1024 * 1024, 1)
> -                f_out.write(bytearray([0x00]))
> -
>          self.vm.set_console()
>          self.vm.add_args('-nic', 'user',
>                           '-drive', image_drive_args,
> --
> 2.21.3
>
>

