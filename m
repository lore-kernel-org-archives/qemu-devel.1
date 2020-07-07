Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37E5C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:05:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B3E12065D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGydGaHH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B3E12065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsq63-0007zc-OD
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsq3r-0005HC-8f; Tue, 07 Jul 2020 12:03:11 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:33424)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsq3p-0005e2-IF; Tue, 07 Jul 2020 12:03:10 -0400
Received: by mail-il1-x142.google.com with SMTP id a11so28210368ilk.0;
 Tue, 07 Jul 2020 09:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=qKMKLn+NM0fVhDR9Wl8Ewv7hJFrzevopLDHtMRtWkyk=;
 b=pGydGaHHFnsOjeBghQEStW3yQxvMukpzrfZCgT2abLG4YBVFqwE0XyzXx1vt/2QZub
 eIKNQWOfCsIb3mOQ70tf0JuKht4U61H7/UbynBEG99ghJd5IO6/YaMp73+rQOGuFBqLy
 TnXElgUWUz6eP+3i7s5uuOUZ46jSfZ6371gU8yETIs1Ty82acGGSPae0AT5pha4ri4Lk
 aG08Mo/hdVRSP63BrvK0wl+eAd+r2pRwHrsJ1Y19vexU2HW8gKSR6NZWuo3TUALSSsAx
 fxVICb0koFNYTle0u+sYDh+EF/l+cszCwbgIqfD17selGM13J+zotjzqgtVtfxGomvw8
 7kNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qKMKLn+NM0fVhDR9Wl8Ewv7hJFrzevopLDHtMRtWkyk=;
 b=PBPUcFpcutJRgMa1InzpM8C2OEpEuilJ7ZuShzV7FJnvjMMfIKBewJ+VO2CYOIsIE5
 AjpL4J/dziimVdD90weuCpNDQOjAJWqr8iLswdcv3iLMMx2ecDH78k5DUWG8lthh5Lan
 XrssGMV5P88a8am6aPsQ60jmYY6vu+F55SkrgB91xpbqvb1wwhHmYyBK9lUVrI0+QIzl
 HP864li/SFFGC+ko/hqLU5K9EVENVagRRJ3CO14N8AngiLSvWkGRE4Oq5EMRX+AtcWg3
 Js5OU8un2JKiDxq6dGcCoq0T3m+2aolO9omy+eXXSjerJ5F5Jen4i9BVCskjdfRpDcOD
 PpbA==
X-Gm-Message-State: AOAM531KosjUL6kPTKZIoKkT1h4s+n2zF4DkUGfw6zjftkpS9aSJbSoC
 bFwXuV5AMUd8b/bwDKNk6cavEeylogjVMM9ndq4=
X-Google-Smtp-Source: ABdhPJzP+gFc+uSmuN1FFbd+cvGcPT7No6n0TF1DNz+lNB855MAmUv6Io8bubqgtXS6UiBYCP4wsxVC6OmXPIVyWQsM=
X-Received: by 2002:a92:5f12:: with SMTP id t18mr37270709ilb.267.1594137784938; 
 Tue, 07 Jul 2020 09:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200707132116.26207-1-f4bug@amsat.org>
 <20200707132116.26207-2-f4bug@amsat.org>
In-Reply-To: <20200707132116.26207-2-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 7 Jul 2020 08:53:16 -0700
Message-ID: <CAKmqyKPSh4e+XVBLni71rHDZoTUV+cYQgZpO+FBYv-riLYW9eQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] tests/acceptance/boot_linux: Truncate SD card image
 to power of 2
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Niek Linnenbank <nieklinnenbank@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

n Tue, Jul 7, 2020 at 6:21 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> In the next commit we won't allow SD card images with invalid
> size (not aligned to a power of 2). Prepare the tests: add the
> pow2ceil() and image_pow2ceil_truncate() methods and truncate
> the images of the tests using SD cards.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/acceptance/boot_linux_console.py | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index 3d02519660..f4d4e3635f 100644
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
> +# truncate file size to next power of 2
> +def image_pow2ceil_truncate(path):
> +        size =3D os.path.getsize(path)
> +        size_aligned =3D pow2ceil(size)
> +        if size !=3D size_aligned:
> +            with open(path, 'ab+') as fd:
> +                fd.truncate(size_aligned)

Why truncate the image, can't we expand it instead?

Alistair

> +
>  class LinuxKernelTest(Test):
>      KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
>
> @@ -635,6 +647,7 @@ def test_arm_orangepi_sd(self):
>          rootfs_path_xz =3D self.fetch_asset(rootfs_url, asset_hash=3Droo=
tfs_hash)
>          rootfs_path =3D os.path.join(self.workdir, 'rootfs.cpio')
>          archive.lzma_uncompress(rootfs_path_xz, rootfs_path)
> +        image_pow2ceil_truncate(rootfs_path)
>
>          self.vm.set_console()
>          kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> @@ -679,6 +692,7 @@ def test_arm_orangepi_bionic(self):
>          image_name =3D 'Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.=
img'
>          image_path =3D os.path.join(self.workdir, image_name)
>          process.run("7z e -o%s %s" % (self.workdir, image_path_7z))
> +        image_pow2ceil_truncate(image_path)
>
>          self.vm.set_console()
>          self.vm.add_args('-drive', 'file=3D' + image_path + ',if=3Dsd,fo=
rmat=3Draw',
> @@ -728,6 +742,7 @@ def test_arm_orangepi_uboot_netbsd9(self):
>          image_hash =3D '2babb29d36d8360adcb39c09e31060945259917a'
>          image_path_gz =3D self.fetch_asset(image_url, asset_hash=3Dimage=
_hash)
>          image_path =3D os.path.join(self.workdir, 'armv7.img')
> +        image_pow2ceil_truncate(image_path)
>          image_drive_args =3D 'if=3Dsd,format=3Draw,snapshot=3Don,file=3D=
' + image_path
>          archive.gzip_uncompress(image_path_gz, image_path)
>
> --
> 2.21.3
>
>

