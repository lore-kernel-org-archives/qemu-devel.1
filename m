Return-Path: <SRS0=QItv=AX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9159EC433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 18:44:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C34A2063A
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 18:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T427+6oo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C34A2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jugxh-0000tR-Je
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 14:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jugx3-0000KQ-Aj; Sun, 12 Jul 2020 14:43:49 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:38762)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jugx1-0008Nv-9N; Sun, 12 Jul 2020 14:43:49 -0400
Received: by mail-il1-x143.google.com with SMTP id s21so9350767ilk.5;
 Sun, 12 Jul 2020 11:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GK7fBLxC3G7c+VyYH5fLxeJReQHEROmPFn39bTi7jxU=;
 b=T427+6ooXtpgY1NIC68pCVhRF4i3i6vzz24w8/v9cI3cp+/vgIztaCl3ZjrTCvOmmS
 iA3/EmnaetqlJaEQSSF1OffQpeiqPrN1p1vhVcUZFCI6JHPIJQ7mLSo9BEovf9SuPftf
 9cIdQZ/4nSe/R6mgUVTA7v2h7rff6QAR69IBfHeufPh4RN5GoQ8E0j8ycjP7EZoLcqrx
 ksLV1ktmfAxpRdvHvtYTZn254qp0IT4ItAQNp/nt7IdXKFZTm3eoGQOly63tHF7VBUD5
 DqGSPqBelIKWqDCbGEZuWicmUX2gpkmiAHCI+yXssi6NtJ79XZh9nyuAsOfXJMkQ1lIk
 PNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GK7fBLxC3G7c+VyYH5fLxeJReQHEROmPFn39bTi7jxU=;
 b=cRjcxTgKZMn1VZat4g5Nn8GxqWKqW1hUQZ6wYNN+Ajz0ytqAVcHJ/SdcHtpufZDi0z
 nweqGt2s3y2ZesdQ0f0K2/29CqUqrvcMBnFaBWGKf+NxjpseqrOUSFYK1BU3PGiE2D8j
 IeKo6L1YdABx50zzeNGktRRWFSPie0Svwf/h6UFozL11qNy14NvmgCHIef2B4beUxAfi
 Q8sM3ndR2s+0AyL+IFWiVGH1co+55AbvJa3a38ZwskIy9NaYoNfMKSMUv47DT4mSP8Ms
 bUjwuZwCsX0Urm0qN0FFMJW1p9J6x1v+FU3me65WCq9Vhod3p1HX2e9cepx9uGC/FybR
 0xvg==
X-Gm-Message-State: AOAM533PqhPBDro7vXoRMGp6g4b+d0xZ5IasJa0g+C8u6GoIfN1i+GvR
 mD3S8sisLWE3DjPHjObWALlwm//kDBdSaf9PGGE=
X-Google-Smtp-Source: ABdhPJwG3ViNDfEEgcypp3zJAafAZ+E6PSYGELpVrBt+lQ0bscj8K3aav05KR5Pst8B9RJmy+OW/z4hyjC65bD1YqyA=
X-Received: by 2002:a92:bb57:: with SMTP id w84mr62002879ili.104.1594579425302; 
 Sun, 12 Jul 2020 11:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200707132116.26207-1-f4bug@amsat.org>
 <20200707132116.26207-2-f4bug@amsat.org>
In-Reply-To: <20200707132116.26207-2-f4bug@amsat.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Sun, 12 Jul 2020 20:43:34 +0200
Message-ID: <CAPan3Wp7PpFaXDGxD+cT=GXLi-upKgPc-eNDa8P4ZGZBbhSg7w@mail.gmail.com>
Subject: Re: [PATCH 1/2] tests/acceptance/boot_linux: Truncate SD card image
 to power of 2
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000361be205aa42f4c1"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000361be205aa42f4c1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2020 at 3:21 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
>
wrote:

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
> diff --git a/tests/acceptance/boot_linux_console.py
> b/tests/acceptance/boot_linux_console.py
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
> +
>  class LinuxKernelTest(Test):
>      KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
>
> @@ -635,6 +647,7 @@ def test_arm_orangepi_sd(self):
>          rootfs_path_xz =3D self.fetch_asset(rootfs_url,
> asset_hash=3Drootfs_hash)
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
>          self.vm.add_args('-drive', 'file=3D' + image_path +
> ',if=3Dsd,format=3Draw',
> @@ -728,6 +742,7 @@ def test_arm_orangepi_uboot_netbsd9(self):
>          image_hash =3D '2babb29d36d8360adcb39c09e31060945259917a'
>          image_path_gz =3D self.fetch_asset(image_url, asset_hash=3Dimage=
_hash)
>          image_path =3D os.path.join(self.workdir, 'armv7.img')
> +        image_pow2ceil_truncate(image_path)
>          image_drive_args =3D 'if=3Dsd,format=3Draw,snapshot=3Don,file=3D=
' +
> image_path
>          archive.gzip_uncompress(image_path_gz, image_path)
>
> --
> 2.21.3
>
>
Hi Philippe,

This patch works OK for the linux part, but the NetBSD didn't work, it
prints this error:

       (5/5)
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_u=
boot_netbsd9:
        ERROR: [Errno 2] No such file or directory:
'/var/tmp/avocado_6hoo815w/avocado_job_40aayif8/

5-tests_acceptance_boot_linux_console.py_BootLinuxConsole.test_arm_orangepi=
_uboot_netbsd9/armv7.img'
(0.18 s)

Basically the truncate should just be moved after the uncompress to fix it.
And the lines that we use before
to extend the image size can be removed now. That was needed to avoid
conflict with the partition size inside image.

So with these small changes, I got it working fine:

diff --git a/tests/acceptance/boot_linux_console.py
b/tests/acceptance/boot_linux_console.py
index f4d4e3635f..69607a5840 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -684,7 +684,7 @@ class BootLinuxConsole(LinuxKernelTest):
         :avocado: tags=3Dmachine:orangepi-pc
         """

-        # This test download a 196MB compressed image and expand it to
932MB...
+        # This test download a 196MB compressed image and expand it to 1G
         image_url =3D ('https://dl.armbian.com/orangepipc/archive/'
                      'Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.7z')
         image_hash =3D '196a8ffb72b0123d92cea4a070894813d305c71e'
@@ -725,7 +725,7 @@ class BootLinuxConsole(LinuxKernelTest):
         :avocado: tags=3Darch:arm
         :avocado: tags=3Dmachine:orangepi-pc
         """
-        # This test download a 304MB compressed image and expand it to
1.3GB...
+        # This test download a 304MB compressed image and expand it to
2GB...
         deb_url =3D ('http://snapshot.debian.org/archive/debian/'
                    '20200108T145233Z/pool/main/u/u-boot/'
                    'u-boot-sunxi_2020.01%2Bdfsg-1_armhf.deb')
@@ -742,9 +742,9 @@ class BootLinuxConsole(LinuxKernelTest):
         image_hash =3D '2babb29d36d8360adcb39c09e31060945259917a'
         image_path_gz =3D self.fetch_asset(image_url, asset_hash=3Dimage_h=
ash)
         image_path =3D os.path.join(self.workdir, 'armv7.img')
-        image_pow2ceil_truncate(image_path)
         image_drive_args =3D 'if=3Dsd,format=3Draw,snapshot=3Don,file=3D' =
+
image_path
         archive.gzip_uncompress(image_path_gz, image_path)
+        image_pow2ceil_truncate(image_path)

         # dd if=3Du-boot-sunxi-with-spl.bin of=3Darmv7.img bs=3D1K seek=3D=
8
conv=3Dnotrunc
         with open(uboot_path, 'rb') as f_in:
@@ -754,9 +754,9 @@ class BootLinuxConsole(LinuxKernelTest):

                 # Extend image, to avoid that NetBSD thinks the partition
                 # inside the image is larger than device size itself
-                f_out.seek(0, 2)
-                f_out.seek(64 * 1024 * 1024, 1)
-                f_out.write(bytearray([0x00]))




--=20
Niek Linnenbank

--000000000000361be205aa42f4c1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 7, 2020 at 3:21 PM Philip=
pe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.or=
g</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>In the next commit we won&#39;t allow SD card images with invalid<br>
size (not aligned to a power of 2). Prepare the tests: add the<br>
pow2ceil() and image_pow2ceil_truncate() methods and truncate<br>
the images of the tests using SD cards.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
---<br>
=C2=A0tests/acceptance/boot_linux_console.py | 15 +++++++++++++++<br>
=C2=A01 file changed, 15 insertions(+)<br>
<br>
diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot=
_linux_console.py<br>
index 3d02519660..f4d4e3635f 100644<br>
--- a/tests/acceptance/boot_linux_console.py<br>
+++ b/tests/acceptance/boot_linux_console.py<br>
@@ -28,6 +28,18 @@<br>
=C2=A0except CmdNotFoundError:<br>
=C2=A0 =C2=A0 =C2=A0P7ZIP_AVAILABLE =3D False<br>
<br>
+# round up to next power of 2<br>
+def pow2ceil(x):<br>
+=C2=A0 =C2=A0 return 1 if x =3D=3D 0 else 2**(x - 1).bit_length()<br>
+<br>
+# truncate file size to next power of 2<br>
+def image_pow2ceil_truncate(path):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D os.path.getsize(path)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_aligned =3D pow2ceil(size)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if size !=3D size_aligned:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(path, &#39;ab+&#39;) a=
s fd:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fd.truncate(size_a=
ligned)<br>
+<br>
=C2=A0class LinuxKernelTest(Test):<br>
=C2=A0 =C2=A0 =C2=A0KERNEL_COMMON_COMMAND_LINE =3D &#39;printk.time=3D0 &#3=
9;<br>
<br>
@@ -635,6 +647,7 @@ def test_arm_orangepi_sd(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rootfs_path_xz =3D self.fetch_asset(rootf=
s_url, asset_hash=3Drootfs_hash)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rootfs_path =3D os.path.join(self.workdir=
, &#39;rootfs.cpio&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0archive.lzma_uncompress(rootfs_path_xz, r=
ootfs_path)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_pow2ceil_truncate(rootfs_path)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.vm.set_console()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_command_line =3D (self.KERNEL_COMM=
ON_COMMAND_LINE +<br>
@@ -679,6 +692,7 @@ def test_arm_orangepi_bionic(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0image_name =3D &#39;Armbian_19.11.3_Orang=
epipc_bionic_current_5.3.9.img&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0image_path =3D os.path.join(self.workdir,=
 image_name)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0process.run(&quot;7z e -o%s %s&quot; % (s=
elf.workdir, image_path_7z))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_pow2ceil_truncate(image_path)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.vm.set_console()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.vm.add_args(&#39;-drive&#39;, &#39;f=
ile=3D&#39; + image_path + &#39;,if=3Dsd,format=3Draw&#39;,<br>
@@ -728,6 +742,7 @@ def test_arm_orangepi_uboot_netbsd9(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0image_hash =3D &#39;2babb29d36d8360adcb39=
c09e31060945259917a&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0image_path_gz =3D self.fetch_asset(image_=
url, asset_hash=3Dimage_hash)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0image_path =3D os.path.join(self.workdir,=
 &#39;armv7.img&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_pow2ceil_truncate(image_path)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0image_drive_args =3D &#39;if=3Dsd,format=
=3Draw,snapshot=3Don,file=3D&#39; + image_path<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0archive.gzip_uncompress(image_path_gz, im=
age_path)<br>
<br>
-- <br>
2.21.3<br>
<br>
</blockquote></div><div><br></div><div>Hi Philippe,</div><div><br></div><di=
v>This patch works OK for the linux part, but the NetBSD didn&#39;t work, i=
t prints this error:<br></div><div><br></div><div>=C2=A0 =C2=A0 =C2=A0=C2=
=A0 (5/5) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_=
orangepi_uboot_netbsd9:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 ERROR: [Errno 2] No =
such file or directory: &#39;/var/tmp/avocado_6hoo815w/avocado_job_40aayif8=
/<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 5-tests_acceptance_boot_linux_console.py_B=
ootLinuxConsole.test_arm_orangepi_uboot_netbsd9/armv7.img&#39; (0.18 s)<br>=
</div><div><br></div><div>Basically the truncate should just be moved after=
 the uncompress to fix it. And the lines that we use before</div><div>to ex=
tend the image size can be removed now. That was needed to avoid conflict w=
ith the partition size inside image.<br></div><br><div>So with these small =
changes, I got it working fine:</div><div><br></div><div>diff --git a/tests=
/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py<=
br>index f4d4e3635f..69607a5840 100644<br>--- a/tests/acceptance/boot_linux=
_console.py<br>+++ b/tests/acceptance/boot_linux_console.py<br>@@ -684,7 +6=
84,7 @@ class BootLinuxConsole(LinuxKernelTest):<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0:avocado: tags=3Dmachine:orangepi-pc<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0&quot;&quot;&quot;<br>=C2=A0<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0#=
 This test download a 196MB compressed image and expand it to 932MB...<br>+=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0# This test download a 196MB compressed image a=
nd expand it to 1G<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0image_url =3D (&#39=
;<a href=3D"https://dl.armbian.com/orangepipc/archive/">https://dl.armbian.=
com/orangepipc/archive/</a>&#39;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;Armbian_19.11.3_Orangepipc_bion=
ic_current_5.3.9.7z&#39;)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0image_hash =
=3D &#39;196a8ffb72b0123d92cea4a070894813d305c71e&#39;<br>@@ -725,7 +725,7 =
@@ class BootLinuxConsole(LinuxKernelTest):<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0:avocado: tags=3Darch:arm<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0:avoca=
do: tags=3Dmachine:orangepi-pc<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&=
quot;&quot;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0# This test download a 304MB co=
mpressed image and expand it to 1.3GB...<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0# =
This test download a 304MB compressed image and expand it to 2GB...<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0deb_url =3D (&#39;<a href=3D"http://snapshot=
.debian.org/archive/debian/">http://snapshot.debian.org/archive/debian/</a>=
&#39;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &#39;20200108T145233Z/pool/main/u/u-boot/&#39;<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;u-boot-sunxi_2020.01%=
2Bdfsg-1_armhf.deb&#39;)<br>@@ -742,9 +742,9 @@ class BootLinuxConsole(Linu=
xKernelTest):<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0image_hash =3D &#39;2bab=
b29d36d8360adcb39c09e31060945259917a&#39;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0image_path_gz =3D self.fetch_asset(image_url, asset_hash=3Dimage_hash=
)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0image_path =3D os.path.join(self.wor=
kdir, &#39;armv7.img&#39;)<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0image_pow2ceil_t=
runcate(image_path)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0image_drive_args =
=3D &#39;if=3Dsd,format=3Draw,snapshot=3Don,file=3D&#39; + image_path<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0archive.gzip_uncompress(image_path_gz, im=
age_path)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0image_pow2ceil_truncate(image_pat=
h)<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# dd if=3Du-boot-sunxi-wi=
th-spl.bin of=3Darmv7.img bs=3D1K seek=3D8 conv=3Dnotrunc<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0with open(uboot_path, &#39;rb&#39;) as f_in:<br>@@ -754=
,9 +754,9 @@ class BootLinuxConsole(LinuxKernelTest):<br>=C2=A0<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Extend image, to a=
void that NetBSD thinks the partition<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0# inside the image is larger than device size i=
tself<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f_out.see=
k(0, 2)<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f_out.s=
eek(64 * 1024 * 1024, 1)<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0f_out.write(bytearray([0x00]))<br></div><div><br></div><div><br><=
/div><div><br></div><br>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><=
div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></div></div>

--000000000000361be205aa42f4c1--

