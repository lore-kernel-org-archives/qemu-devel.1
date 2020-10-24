Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBDAC55178
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 21:03:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8954D21D41
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 21:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nH4KxszU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8954D21D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWQhL-0008JX-LL
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 17:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1kWQev-0006nL-Hv; Sat, 24 Oct 2020 17:01:05 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:42545)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1kWQes-0007Wm-Cz; Sat, 24 Oct 2020 17:01:05 -0400
Received: by mail-io1-xd43.google.com with SMTP id k21so6001903ioa.9;
 Sat, 24 Oct 2020 14:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qoc3JBFAAslpB2r/tFXzmj3e+z1i5/seanHTOJCzebU=;
 b=nH4KxszUoTXmWjQJUYZK6XPj2brygnloRsznFBlnUxKwH/AN6wFLINLutwh8BsnBhG
 XLN3iilF54u1qUgiQiDZSuC6YboByvkh3CXsOK8KF/6q1AcxzyWso73NlncfZ7meNSSV
 ErfRacsBXPAqAy/guJWu9clgIlEXVCMqYfiDtrU10q+pEZ/wLuNeIFYyRKrcHsTmC7zs
 tsDhORLpEcw0qh0AUPpOhOV6MODQ4USIaBsAyty1g+900i08XddgL+v17BjrNLcvv9It
 S5owICLeNSiW4v8F6X/bqaM2QlqVynFdCKWP8wsRmPOIzChkgOIR8vv0bNW4wJlUJXt9
 34Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qoc3JBFAAslpB2r/tFXzmj3e+z1i5/seanHTOJCzebU=;
 b=rqrImgf82BzPbpIV9Mm2+cXIBBm+w7++oIu9IxB6gAupk0RSS9Z9qfD6WEI0JWvWHM
 SIjyFxf9qpsTcTJ89Z31FmtqVyUtl85+iB5XIjA6QReWzzBtqa9gbOwqIAF1fGOF4uMl
 TzRPD1tThKvBTx2sGvfMpRGhrUffTYw/g3qVWhxU8MeDV/uX+2M2RWrxbXrwrhVqWhgY
 9ZF3qSPYLmiSWYbkZyIE6eITXwPOg3pAI4ql6RqeWbuu0ntHj1b2Mu2890J2qMoik5hw
 5bZTjPvxfTCYLzH4JggDzerU7a7ukVHUuHlTXfe2wDLo9Tcom98wpqrqu7RRAdHjHwQy
 mJWg==
X-Gm-Message-State: AOAM533h0todpBhgC4DyLI00JuZd8dfgXriCaSi0BN+W77Q6VRDKm2YM
 4z9XJ8hdFGYxuXl+37SjMCn/KHoRK1bSDyNLjKE=
X-Google-Smtp-Source: ABdhPJy0mUb9A1Fk5ieUTQGCAllt8G+eaXm15+EwRcTAPSWfoRIY5/x/wfJrYQu4hJGzgKNuM2riMaVNs+ZYZodVzFw=
X-Received: by 2002:a5d:8487:: with SMTP id t7mr5979387iom.35.1603573260312;
 Sat, 24 Oct 2020 14:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201023131808.3198005-1-f4bug@amsat.org>
 <20201023131808.3198005-5-f4bug@amsat.org>
In-Reply-To: <20201023131808.3198005-5-f4bug@amsat.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Sat, 24 Oct 2020 23:00:49 +0200
Message-ID: <CAPan3Wp3CEh0Q1pJ41+rqBqAucFULAfAj=sR4Ba10hcW+1Tc7w@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] tests/acceptance: Test U-Boot/Linux from Armbian
 20.08 on Orange Pi PC
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="0000000000008d646c05b270fe77"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Qemu-block <qemu-block@nongnu.org>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Bin Meng <bin.meng@windriver.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008d646c05b270fe77
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

I have ran this series with the new Armbian 20.08 test and noticed this
failure:

-console: /dev/mmcblk0p1: The filesystem size (according to the
superrandom: fast init done
console: block) is 264192 blocks
console: The physical size of the device is 261120 blocks
console: Either the superblock or the partition table is likely to be
corrupt!
console: /dev/mmcblk0p1: UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY.
console: (i.e., without -a or -p options)
console: fsck exited with status code 4
console: done.
console: Failure: File system check of the root filesystem failed
console: The root filesystem on /dev/mmcblk0p1 requires a manual fsck
|console: BusyBox v1.27.2 (Ubuntu 1:1.27.2-2ubuntu3.2) built-in shell (ash)
console: Enter 'help' for a list of built-in commands.
INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred: Timeout
reached\nOriginal status: ERROR\n{'name':
'5-tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangep=
i_bionic_20_08',
'logdir': '/home/fox/avocado/job-results/job-2020-10-24T22.25-39... (90.47
s)

When I run the image manually I get the same error, but only if I resize
the 20.08 image to 2G. If resized to 4G, the
20.08 image boots fine.

Additionally, I noticed that the NetBSD 9.0 test has the same problem, even
in current master (4c5b97bfd0dd54dc27717ae8d1cd10e14eef1430):

   (5/5)
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_u=
boot_netbsd9:
|console: U-Boot SPL 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000)
console: DRAM: 1024 MiB
console: Failed to set core voltage! Can't set CPU frequency
/console: Trying to boot from MMC1
console: U-Boot 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000) Allwinner
Technology
...
console: Starting kernel ...
console: [   1.0000000] NetBSD/evbarm (fdt) booting ...
...
console: [   1.3300167] sdmmc0: SD card status: 4-bit, C0
console: [   1.3300167] ld0 at sdmmc0:
<0xaa:0x5859:QEMU!:0x01:0xdeadbeef:0x062>
console: [   1.3430678] ld0: 1024 MB, 1040 cyl, 32 head, 63 sec, 512
bytes/sect x 2097152 sectors
console: [   1.4102580] ld0: 4-bit width, High-Speed/SDR25, 50.000 MHz
console: [   2.0674392] WARNING: 4 errors while detecting hardware; check
system log.
console: [   2.0674392] boot device: ld0
console: [   2.0775401] root on ld0a dumps on ld0b
console: [   2.0977679] vfs_mountroot: can't open root device
console: [   2.0977679] cannot mount root, error =3D 6
INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred: Timeout
reached\nOriginal status: ERROR\n{'name':
'5-tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangep=
i_uboot_netbsd9',
'l>

To resolve this error, I made a small patch that expands the SD image in
both tests to the next power-of-two multiplied by 2:

diff --git a/tests/acceptance/boot_linux_console.py
b/tests/acceptance/boot_linux_console.py
index b604cfe7da..40835904bb 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -35,11 +35,11 @@ def pow2ceil(x):
     return 1 if x =3D=3D 0 else 2**(x - 1).bit_length()

 """
-Expand file size to next power of 2
+Expand file size to next power of 2 or higher
 """
-def image_pow2ceil_expand(path):
+def image_pow2ceil_expand(path, multiply_factor =3D 1):
         size =3D os.path.getsize(path)
-        size_aligned =3D pow2ceil(size)
+        size_aligned =3D pow2ceil(size) * multiply_factor
         if size !=3D size_aligned:
             with open(path, 'ab+') as fd:
                 fd.truncate(size_aligned)
@@ -850,7 +850,7 @@ class BootLinuxConsole(LinuxKernelTest):
         image_path_xz =3D self.fetch_asset(image_url, asset_hash=3Dimage_h=
ash,
                                          algorithm=3D'sha256')
         image_path =3D archive.extract(image_path_xz, self.workdir)
-        image_pow2ceil_expand(image_path)
+        image_pow2ceil_expand(image_path, 2)

         self.do_test_arm_orangepi_uboot_armbian(image_path)

@@ -879,7 +879,7 @@ class BootLinuxConsole(LinuxKernelTest):
         image_path_gz =3D self.fetch_asset(image_url, asset_hash=3Dimage_h=
ash)
         image_path =3D os.path.join(self.workdir, 'armv7.img')
         archive.gzip_uncompress(image_path_gz, image_path)
-        image_pow2ceil_expand(image_path)
+        image_pow2ceil_expand(image_path, 2)
         image_drive_args =3D 'if=3Dsd,format=3Draw,snapshot=3Don,file=3D' =
+
image_path

         # dd if=3Du-boot-sunxi-with-spl.bin of=3Darmv7.img bs=3D1K seek=3D=
8
conv=3Dnotrunc

After applying that change, all Orange Pi tests run successfully:

$ AVOCADO_ALLOW_LARGE_STORAGE=3Dyes ARMBIAN_ARTIFACTS_CACHED=3Dyes avocado
--show=3Dapp,console run -t machine:orangepi-pc
tests/acceptance/boot_linux_console.py
...
RESULTS    : PASS 6 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 |
CANCEL 0
JOB TIME   : 161.69 s

I will send this as a separate patch to the list shortly, so you can
consider adding it to the series (feel free to modify it where needed).

Regards,
Niek


On Fri, Oct 23, 2020 at 3:18 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> Test U-Boot and Linux on the recent Armbian release 20.08.
>
> Suggested-by: Cleber Rosa <crosa@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/acceptance/boot_linux_console.py | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/tests/acceptance/boot_linux_console.py
> b/tests/acceptance/boot_linux_console.py
> index 803b4512a26..b604cfe7dab 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -829,6 +829,31 @@ def test_arm_orangepi_bionic_19_11(self):
>
>          self.do_test_arm_orangepi_uboot_armbian(image_path)
>
> +    @skipUnless(os.getenv('ARMBIAN_ARTIFACTS_CACHED'),
> +                'Test artifacts fetched from unreliable apt.armbian.com'=
)
> +    @skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage
> limited')
> +    def test_arm_orangepi_bionic_20_08(self):
> +        """
> +        :avocado: tags=3Darch:arm
> +        :avocado: tags=3Dmachine:orangepi-pc
> +        :avocado: tags=3Ddevice:sd
> +        """
> +
> +        # This test download a 275 MiB compressed image and expand it
> +        # to 1036 MiB, but the underlying filesystem is 1552 MiB...
> +        # As we expand it to 2 GiB we are safe.
> +
> +        image_url =3D ('https://dl.armbian.com/orangepipc/archive/'
> +
>  'Armbian_20.08.1_Orangepipc_bionic_current_5.8.5.img.xz')
> +        image_hash =3D ('b4d6775f5673486329e45a0586bf06b6'
> +                      'dbe792199fd182ac6b9c7bb6c7d3e6dd')
> +        image_path_xz =3D self.fetch_asset(image_url, asset_hash=3Dimage=
_hash,
> +                                         algorithm=3D'sha256')
> +        image_path =3D archive.extract(image_path_xz, self.workdir)
> +        image_pow2ceil_expand(image_path)
> +
> +        self.do_test_arm_orangepi_uboot_armbian(image_path)
> +
>      @skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage
> limited')
>      def test_arm_orangepi_uboot_netbsd9(self):
>          """
> --
> 2.26.2
>
>

--=20
Niek Linnenbank

--0000000000008d646c05b270fe77
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Philippe,</div><div><br></div><div>I have ran this=
 series with the new Armbian 20.08 test and noticed this failure:</div><div=
><br></div><div>-console: /dev/mmcblk0p1: The filesystem size (according to=
 the superrandom: fast init done<br>console: block) is 264192 blocks<br>con=
sole: The physical size of the device is 261120 blocks<br>console: Either t=
he superblock or the partition table is likely to be corrupt!<br>console: /=
dev/mmcblk0p1: UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY.<br>console: (i.=
e., without -a or -p options)<br>console: fsck exited with status code 4<br=
>console: done.<br>console: Failure: File system check of the root filesyst=
em failed<br>console: The root filesystem on /dev/mmcblk0p1 requires a manu=
al fsck<br>|console: BusyBox v1.27.2 (Ubuntu 1:1.27.2-2ubuntu3.2) built-in =
shell (ash)<br>console: Enter &#39;help&#39; for a list of built-in command=
s.<br>INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred: Time=
out reached\nOriginal status: ERROR\n{&#39;name&#39;: &#39;5-tests/acceptan=
ce/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_bionic_20_08&#3=
9;, &#39;logdir&#39;: &#39;/home/fox/avocado/job-results/job-2020-10-24T22.=
25-39... (90.47 s)</div><div><br></div><div>When I run the image manually I=
 get the same error, but only if I resize the 20.08 image to 2G. If resized=
 to 4G, the</div><div>20.08 image boots fine.<br></div><div><br></div><div>=
Additionally, I noticed that the NetBSD 9.0 test has the same problem, even=
 in current master (4c5b97bfd0dd54dc27717ae8d1cd10e14eef1430):</div><div><b=
r></div><div>=C2=A0=C2=A0 (5/5) tests/acceptance/boot_linux_console.py:Boot=
LinuxConsole.test_arm_orangepi_uboot_netbsd9: |console: U-Boot SPL 2020.01+=
dfsg-1 (Jan 08 2020 - 08:19:44 +0000)<br>console: DRAM: 1024 MiB<br>console=
: Failed to set core voltage! Can&#39;t set CPU frequency<br>/console: Tryi=
ng to boot from MMC1<br>console: U-Boot 2020.01+dfsg-1 (Jan 08 2020 - 08:19=
:44 +0000) Allwinner Technology<br>...<br>console: Starting kernel ...<br>c=
onsole: [ =C2=A0 1.0000000] NetBSD/evbarm (fdt) booting ...<br>...<br>conso=
le: [ =C2=A0 1.3300167] sdmmc0: SD card status: 4-bit, C0<br>console: [ =C2=
=A0 1.3300167] ld0 at sdmmc0: &lt;0xaa:0x5859:QEMU!:0x01:0xdeadbeef:0x062&g=
t;<br>console: [ =C2=A0 1.3430678] ld0: 1024 MB, 1040 cyl, 32 head, 63 sec,=
 512 bytes/sect x 2097152 sectors<br>console: [ =C2=A0 1.4102580] ld0: 4-bi=
t width, High-Speed/SDR25, 50.000 MHz<br>console: [ =C2=A0 2.0674392] WARNI=
NG: 4 errors while detecting hardware; check system log.<br>console: [ =C2=
=A0 2.0674392] boot device: ld0<br>console: [ =C2=A0 2.0775401] root on ld0=
a dumps on ld0b<br>console: [ =C2=A0 2.0977679] vfs_mountroot: can&#39;t op=
en root device<br>console: [ =C2=A0 2.0977679] cannot mount root, error =3D=
 6<br>INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred: Time=
out reached\nOriginal status: ERROR\n{&#39;name&#39;: &#39;5-tests/acceptan=
ce/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_uboot_netbsd9&#=
39;, &#39;l&gt;<br><br></div><div>To resolve this error, I made a small pat=
ch that expands the SD image in both tests to the next power-of-two multipl=
ied by 2:</div><div><br></div><div>diff --git a/tests/acceptance/boot_linux=
_console.py b/tests/acceptance/boot_linux_console.py<br>index b604cfe7da..4=
0835904bb 100644<br>--- a/tests/acceptance/boot_linux_console.py<br>+++ b/t=
ests/acceptance/boot_linux_console.py<br>@@ -35,11 +35,11 @@ def pow2ceil(x=
):<br>=C2=A0 =C2=A0 =C2=A0return 1 if x =3D=3D 0 else 2**(x - 1).bit_length=
()<br>=C2=A0<br>=C2=A0&quot;&quot;&quot;<br>-Expand file size to next power=
 of 2<br>+Expand file size to next power of 2 or higher<br>=C2=A0&quot;&quo=
t;&quot;<br>-def image_pow2ceil_expand(path):<br>+def image_pow2ceil_expand=
(path, multiply_factor =3D 1):<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size =
=3D os.path.getsize(path)<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0size_aligned =3D =
pow2ceil(size)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0size_aligned =3D pow2ceil(si=
ze) * multiply_factor<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if size !=3D siz=
e_aligned:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0with open(pat=
h, &#39;ab+&#39;) as fd:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0fd.truncate(size_aligned)<br>@@ -850,7 +850,7 @@ class Boo=
tLinuxConsole(LinuxKernelTest):<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0image_=
path_xz =3D self.fetch_asset(image_url, asset_hash=3Dimage_hash,<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 algorith=
m=3D&#39;sha256&#39;)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0image_path =3D a=
rchive.extract(image_path_xz, self.workdir)<br>- =C2=A0 =C2=A0 =C2=A0 =C2=
=A0image_pow2ceil_expand(image_path)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0image_=
pow2ceil_expand(image_path, 2)<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0self.do_test_arm_orangepi_uboot_armbian(image_path)<br>=C2=A0<br>@@ -879=
,7 +879,7 @@ class BootLinuxConsole(LinuxKernelTest):<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0image_path_gz =3D self.fetch_asset(image_url, asset_hash=
=3Dimage_hash)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0image_path =3D os.path.=
join(self.workdir, &#39;armv7.img&#39;)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0archive.gzip_uncompress(image_path_gz, image_path)<br>- =C2=A0 =C2=A0 =
=C2=A0 =C2=A0image_pow2ceil_expand(image_path)<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0image_pow2ceil_expand(image_path, 2)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0image_drive_args =3D &#39;if=3Dsd,format=3Draw,snapshot=3Don,file=3D&=
#39; + image_path<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# dd if=3D=
u-boot-sunxi-with-spl.bin of=3Darmv7.img bs=3D1K seek=3D8 conv=3Dnotrunc<br=
></div><div><br></div><div>After applying that change, all Orange Pi tests =
run successfully:</div><div><br></div><div>$ AVOCADO_ALLOW_LARGE_STORAGE=3D=
yes ARMBIAN_ARTIFACTS_CACHED=3Dyes avocado --show=3Dapp,console run -t mach=
ine:orangepi-pc tests/acceptance/boot_linux_console.py<br>...<br>RESULTS =
=C2=A0 =C2=A0: PASS 6 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | =
CANCEL 0<br>JOB TIME =C2=A0 : 161.69 s</div><div><br></div><div>I will send=
 this as a separate patch to the list shortly, so you can consider adding i=
t to the series (feel free to modify it where needed).<br></div><div><br></=
div><div>Regards,</div><div>Niek<br></div><div><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 23, 20=
20 at 3:18 PM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat=
.org">f4bug@amsat.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">Test U-Boot and Linux on the recent Armbian release 20=
.08.<br>
<br>
Suggested-by: Cleber Rosa &lt;<a href=3D"mailto:crosa@redhat.com" target=3D=
"_blank">crosa@redhat.com</a>&gt;<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
---<br>
=C2=A0tests/acceptance/boot_linux_console.py | 25 +++++++++++++++++++++++++=
<br>
=C2=A01 file changed, 25 insertions(+)<br>
<br>
diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot=
_linux_console.py<br>
index 803b4512a26..b604cfe7dab 100644<br>
--- a/tests/acceptance/boot_linux_console.py<br>
+++ b/tests/acceptance/boot_linux_console.py<br>
@@ -829,6 +829,31 @@ def test_arm_orangepi_bionic_19_11(self):<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.do_test_arm_orangepi_uboot_armbian(i=
mage_path)<br>
<br>
+=C2=A0 =C2=A0 @skipUnless(os.getenv(&#39;ARMBIAN_ARTIFACTS_CACHED&#39;),<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;Test artifact=
s fetched from unreliable <a href=3D"http://apt.armbian.com" rel=3D"norefer=
rer" target=3D"_blank">apt.armbian.com</a>&#39;)<br>
+=C2=A0 =C2=A0 @skipUnless(os.getenv(&#39;AVOCADO_ALLOW_LARGE_STORAGE&#39;)=
, &#39;storage limited&#39;)<br>
+=C2=A0 =C2=A0 def test_arm_orangepi_bionic_20_08(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Darch:arm<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dmachine:orangepi-pc<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Ddevice:sd<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # This test download a 275 MiB compressed imag=
e and expand it<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # to 1036 MiB, but the underlying filesystem i=
s 1552 MiB...<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # As we expand it to 2 GiB we are safe.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_url =3D (&#39;<a href=3D"https://dl.armb=
ian.com/orangepipc/archive/" rel=3D"noreferrer" target=3D"_blank">https://d=
l.armbian.com/orangepipc/archive/</a>&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&#39;Armbian_20.08.1_Orangepipc_bionic_current_5.8.5.img.xz&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_hash =3D (&#39;b4d6775f5673486329e45a058=
6bf06b6&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &#39;dbe792199fd182ac6b9c7bb6c7d3e6dd&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_path_xz =3D self.fetch_asset(image_url, =
asset_hash=3Dimage_hash,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0al=
gorithm=3D&#39;sha256&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_path =3D archive.extract(image_path_xz, =
self.workdir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_pow2ceil_expand(image_path)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.do_test_arm_orangepi_uboot_armbian(image_=
path)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0@skipUnless(os.getenv(&#39;AVOCADO_ALLOW_LARGE_STORAGE&=
#39;), &#39;storage limited&#39;)<br>
=C2=A0 =C2=A0 =C2=A0def test_arm_orangepi_uboot_netbsd9(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
-- <br>
2.26.2<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div>

--0000000000008d646c05b270fe77--

