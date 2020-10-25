Return-Path: <SRS0=AG+E=EA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A346BC388F7
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 16:12:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCC2520853
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 16:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ht190pI0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC2520853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWidM-00023Z-O0
	for qemu-devel@archiver.kernel.org; Sun, 25 Oct 2020 12:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1kWicB-0001MP-7i; Sun, 25 Oct 2020 12:11:27 -0400
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133]:33348)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1kWic8-0008Dh-GW; Sun, 25 Oct 2020 12:11:26 -0400
Received: by mail-il1-x133.google.com with SMTP id j8so5971155ilk.0;
 Sun, 25 Oct 2020 09:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=H7mnGD8NxJ/DbWEZIc4/aEaxxEE7M6vyUjgZOwOqzJM=;
 b=ht190pI0FFOFzIERoERK1kBJSVUYqc38H93dPotVGxmFGUvyJIUzU9mhZOlFNApL+X
 o/1W0fRodysma36SkGcqN9AIMKXKRcqmmrPc5jAoi5EVGW74MBznTnqTzFsEZBvEVrwb
 WOq61t6751k+nTgwZXkkbanYdPL/YjVIIlAYgpV3xBGUaheXAvZL4Gxx5tOgyArVuY9O
 hPA1IKTCfvEaJ9tlaL/t/cmJ4fpRcIHFVanPnrAbwsRiZuy2AbO7F5F97gocWnYiqq5Q
 ruMh1yWbjxk0nvsX1ppIRxdbMC8C0TvISeXA3djhCBe2WesSi12KNt/IC1bbADpc2HhY
 SRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=H7mnGD8NxJ/DbWEZIc4/aEaxxEE7M6vyUjgZOwOqzJM=;
 b=qO9UidQBGkvbd7HWlKRoSypTqzdfokp2V1GuUlLqQj9hP2lqLYSUxF3W3LIa/y0wjf
 c2xBzTnJvgiZuJsDFfaHsciJraDa9Bl16VfOTuL6GSE37CkdAcuq/0lF/8DcYe5mBrju
 iTd4T3cAt2WzAV1pWc0ieKn5qfemsHMxZE4/maL8aEWNOrtRFfUrtrNnviprJuWkA43c
 N3mwsfPcCsPgYpMiwgay+X9bJXxy3gD5NrzEqa4sKtJ/rWI96/fOcVmGas1WGOw+b9BR
 AfkAraU/3ZCTzEy/qzV4e/HvBTtIGje6FX85R6sTDv0z1Du1rWtSVKC+4Gk9GXqvCJzi
 K8uQ==
X-Gm-Message-State: AOAM533NflNt8lG73wH5U0kCtpNabkawSwZLUg9DlsLCxMANUG0AJhOW
 4814TpJRn7QF0aRGTyoh48TQhpwmC72GFDW9daY=
X-Google-Smtp-Source: ABdhPJwvt1kjugYgSlusINuq2WtAXUWOdltBSgxhqyJd1elauadh4F4ue1FG0ww6pLMWSTYMZ6Dxwb1ZhazZDyYvTrA=
X-Received: by 2002:a92:85d5:: with SMTP id f204mr6949050ilh.45.1603642282938; 
 Sun, 25 Oct 2020 09:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20201023131808.3198005-1-f4bug@amsat.org>
 <20201023131808.3198005-5-f4bug@amsat.org>
 <CAPan3Wp3CEh0Q1pJ41+rqBqAucFULAfAj=sR4Ba10hcW+1Tc7w@mail.gmail.com>
 <CAEUhbmX8MWBL_7LgLZ5-xNJJ4iddtgQKV9q4qydhektok+zxNA@mail.gmail.com>
In-Reply-To: <CAEUhbmX8MWBL_7LgLZ5-xNJJ4iddtgQKV9q4qydhektok+zxNA@mail.gmail.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Mon, 26 Oct 2020 00:35:33 +0100
Message-ID: <CAPan3Wo-nydxbQ=Orfi_nzgAr-uMaiGn67tF_fxfW+7OkaZ5VA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] tests/acceptance: Test U-Boot/Linux from Armbian
 20.08 on Orange Pi PC
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000009f14a005b28110cd"
Received-SPF: pass client-ip=2607:f8b0:4864:20::133;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-il1-x133.google.com
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
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Bin Meng <bin.meng@windriver.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009f14a005b28110cd
Content-Type: text/plain; charset="UTF-8"

Hi Bin,

On Sun, Oct 25, 2020 at 3:17 AM Bin Meng <bmeng.cn@gmail.com> wrote:

> Hi Niek,
>
> On Sun, Oct 25, 2020 at 5:01 AM Niek Linnenbank
> <nieklinnenbank@gmail.com> wrote:
> >
> > Hi Philippe,
> >
> > I have ran this series with the new Armbian 20.08 test and noticed this
> failure:
> >
> > -console: /dev/mmcblk0p1: The filesystem size (according to the
> superrandom: fast init done
> > console: block) is 264192 blocks
> > console: The physical size of the device is 261120 blocks
> > console: Either the superblock or the partition table is likely to be
> corrupt!
> > console: /dev/mmcblk0p1: UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY.
> > console: (i.e., without -a or -p options)
> > console: fsck exited with status code 4
> > console: done.
> > console: Failure: File system check of the root filesystem failed
> > console: The root filesystem on /dev/mmcblk0p1 requires a manual fsck
> > |console: BusyBox v1.27.2 (Ubuntu 1:1.27.2-2ubuntu3.2) built-in shell
> (ash)
> > console: Enter 'help' for a list of built-in commands.
> > INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred: Timeout
> reached\nOriginal status: ERROR\n{'name':
> '5-tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_bionic_20_08',
> 'logdir': '/home/fox/avocado/job-results/job-2020-10-24T22.25-39... (90.47
> s)
> >
> > When I run the image manually I get the same error, but only if I resize
> the 20.08 image to 2G. If resized to 4G, the
> > 20.08 image boots fine.
> >
> > Additionally, I noticed that the NetBSD 9.0 test has the same problem,
> even in current master (4c5b97bfd0dd54dc27717ae8d1cd10e14eef1430):
> >
> >    (5/5)
> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_uboot_netbsd9:
> |console: U-Boot SPL 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000)
> > console: DRAM: 1024 MiB
> > console: Failed to set core voltage! Can't set CPU frequency
> > /console: Trying to boot from MMC1
> > console: U-Boot 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000) Allwinner
> Technology
> > ...
> > console: Starting kernel ...
> > console: [   1.0000000] NetBSD/evbarm (fdt) booting ...
> > ...
> > console: [   1.3300167] sdmmc0: SD card status: 4-bit, C0
> > console: [   1.3300167] ld0 at sdmmc0:
> <0xaa:0x5859:QEMU!:0x01:0xdeadbeef:0x062>
> > console: [   1.3430678] ld0: 1024 MB, 1040 cyl, 32 head, 63 sec, 512
> bytes/sect x 2097152 sectors
> > console: [   1.4102580] ld0: 4-bit width, High-Speed/SDR25, 50.000 MHz
> > console: [   2.0674392] WARNING: 4 errors while detecting hardware;
> check system log.
> > console: [   2.0674392] boot device: ld0
> > console: [   2.0775401] root on ld0a dumps on ld0b
> > console: [   2.0977679] vfs_mountroot: can't open root device
> > console: [   2.0977679] cannot mount root, error = 6
> > INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred: Timeout
> reached\nOriginal status: ERROR\n{'name':
> '5-tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_uboot_netbsd9',
> 'l>
> >
> > To resolve this error, I made a small patch that expands the SD image in
> both tests to the next power-of-two multiplied by 2:
> >
> > diff --git a/tests/acceptance/boot_linux_console.py
> b/tests/acceptance/boot_linux_console.py
> > index b604cfe7da..40835904bb 100644
> > --- a/tests/acceptance/boot_linux_console.py
> > +++ b/tests/acceptance/boot_linux_console.py
> > @@ -35,11 +35,11 @@ def pow2ceil(x):
> >      return 1 if x == 0 else 2**(x - 1).bit_length()
> >
> >  """
> > -Expand file size to next power of 2
> > +Expand file size to next power of 2 or higher
> >  """
> > -def image_pow2ceil_expand(path):
> > +def image_pow2ceil_expand(path, multiply_factor = 1):
> >          size = os.path.getsize(path)
> > -        size_aligned = pow2ceil(size)
> > +        size_aligned = pow2ceil(size) * multiply_factor
> >          if size != size_aligned:
> >              with open(path, 'ab+') as fd:
> >                  fd.truncate(size_aligned)
> > @@ -850,7 +850,7 @@ class BootLinuxConsole(LinuxKernelTest):
> >          image_path_xz = self.fetch_asset(image_url,
> asset_hash=image_hash,
> >                                           algorithm='sha256')
> >          image_path = archive.extract(image_path_xz, self.workdir)
> > -        image_pow2ceil_expand(image_path)
> > +        image_pow2ceil_expand(image_path, 2)
> >
> >          self.do_test_arm_orangepi_uboot_armbian(image_path)
> >
> > @@ -879,7 +879,7 @@ class BootLinuxConsole(LinuxKernelTest):
> >          image_path_gz = self.fetch_asset(image_url,
> asset_hash=image_hash)
> >          image_path = os.path.join(self.workdir, 'armv7.img')
> >          archive.gzip_uncompress(image_path_gz, image_path)
> > -        image_pow2ceil_expand(image_path)
> > +        image_pow2ceil_expand(image_path, 2)
> >          image_drive_args = 'if=sd,format=raw,snapshot=on,file=' +
> image_path
> >
> >          # dd if=u-boot-sunxi-with-spl.bin of=armv7.img bs=1K seek=8
> conv=notrunc
> >
> > After applying that change, all Orange Pi tests run successfully:
> >
> > $ AVOCADO_ALLOW_LARGE_STORAGE=yes ARMBIAN_ARTIFACTS_CACHED=yes avocado
> --show=app,console run -t machine:orangepi-pc
> tests/acceptance/boot_linux_console.py
>
> This command does not work for me.
>
> Traceback (most recent call last):
>   File "/usr/local/bin/avocado", line 5, in <module>
>     from avocado.core.main import main
>   File "/usr/local/lib/python3.8/dist-packages/avocado/core/main.py",
> line 22, in <module>
>     from avocado.core import data_dir
>   File "/usr/local/lib/python3.8/dist-packages/avocado/core/data_dir.py",
> line 39, in <module>
>     from .output import LOG_JOB, LOG_UI
>   File "/usr/local/lib/python3.8/dist-packages/avocado/core/output.py",
> line 27, in <module>
>     from .settings import settings
>   File "/usr/local/lib/python3.8/dist-packages/avocado/core/settings.py",
> line 625, in <module>
>     settings = Settings()  # pylint: disable-msg=invalid-name
>   File "/usr/local/lib/python3.8/dist-packages/avocado/core/settings.py",
> line 274, in __init__
>     self._prepare_base_dirs()
>   File "/usr/local/lib/python3.8/dist-packages/avocado/core/settings.py",
> line 315, in _prepare_base_dirs
>     self._config_path_pkg = resource_filename('avocado', config_pkg_base)
>   File "/usr/lib/python3/dist-packages/pkg_resources/__init__.py",
> line 1145, in resource_filename
>     return get_provider(package_or_requirement).get_resource_filename(
>   File "/usr/lib/python3/dist-packages/pkg_resources/__init__.py",
> line 365, in get_provider
>     return _find_adapter(_provider_factories, loader)(module)
>   File "/usr/lib/python3/dist-packages/pkg_resources/__init__.py",
> line 1393, in __init__
>     self.module_path = os.path.dirname(getattr(module, '__file__', ''))
>   File "/usr/lib/python3.8/posixpath.py", line 152, in dirname
>     p = os.fspath(p)
> TypeError: expected str, bytes or os.PathLike object, not NoneType
>
> I haven't got a command to work on testing only a single target. Any
> hint? Thanks!
>

That error is new to me, I have not seen it before. From the stacktrace, it
looks like that avocado is trying to read its own configuration / settings
file (from settings.py).
Later on there is a type conversion error for NoneType. Perhaps the avocado
files for your user have somehow got corrupted?
You could try to remove them from your home directory and/or re-install
avocado as well and start out fresh.
I assume that at least 'avocado --help'  should work without generating
this error.

Also it may be useful to know that it looks like you need to run avocado
from within the new 'build' directory that the new meson build system now
creates.
If not running from the 'build' directory, I'm getting this printed on my
machine:
  CANCEL: No QEMU binary defined or found in the build tree

So once your avocado is working without the type error you could try this:

1) cd build
2) AVOCADO_ALLOW_LARGE_STORAGE=yes ARMBIAN_ARTIFACTS_CACHED=yes avocado
--show=app,console run -t machine:orangepi-pc
tests/acceptance/boot_linux_console.py

Alternatively, if you can't get avocado to run anything, you could also
just run the Armbian image (or any other image) directly via
qemu-system-arm:

  $ build/arm-softmmu/qemu-system-arm -M orangepi-pc -nographic -nic user
-sd Armbian_20.08.1_Orangepipc_bionic_current_5.8.5.img
  U-Boot SPL 2020.04-armbian (Sep 02 2020 - 10:16:13 +0200)
  DRAM: 1024 MiB
  ...
  Autoboot in 1 seconds, press <Space> to stop
  => setenv extraargs 'console=ttyS0,115200'
  => boot
  ...
  Uncompressing Linux... done, booting the kernel.
  Loading, please wait...
  starting version 237

Also see the file docs/system/arm/orangepi.rst with some additional
information and documentation.

Hope this helps & regards,

Niek


>
> > ...
> > RESULTS    : PASS 6 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 |
> CANCEL 0
> > JOB TIME   : 161.69 s
> >
> > I will send this as a separate patch to the list shortly, so you can
> consider adding it to the series (feel free to modify it where needed).
> >
>
> Regards,
> Bin
>


-- 
Niek Linnenbank

--0000000000009f14a005b28110cd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Bin,<br></div><br><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">On Sun, Oct 25, 2020 at 3:17 AM Bin Meng &=
lt;<a href=3D"mailto:bmeng.cn@gmail.com">bmeng.cn@gmail.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Niek,<br>
<br>
On Sun, Oct 25, 2020 at 5:01 AM Niek Linnenbank<br>
&lt;<a href=3D"mailto:nieklinnenbank@gmail.com" target=3D"_blank">nieklinne=
nbank@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi Philippe,<br>
&gt;<br>
&gt; I have ran this series with the new Armbian 20.08 test and noticed thi=
s failure:<br>
&gt;<br>
&gt; -console: /dev/mmcblk0p1: The filesystem size (according to the superr=
andom: fast init done<br>
&gt; console: block) is 264192 blocks<br>
&gt; console: The physical size of the device is 261120 blocks<br>
&gt; console: Either the superblock or the partition table is likely to be =
corrupt!<br>
&gt; console: /dev/mmcblk0p1: UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY.<=
br>
&gt; console: (i.e., without -a or -p options)<br>
&gt; console: fsck exited with status code 4<br>
&gt; console: done.<br>
&gt; console: Failure: File system check of the root filesystem failed<br>
&gt; console: The root filesystem on /dev/mmcblk0p1 requires a manual fsck<=
br>
&gt; |console: BusyBox v1.27.2 (Ubuntu 1:1.27.2-2ubuntu3.2) built-in shell =
(ash)<br>
&gt; console: Enter &#39;help&#39; for a list of built-in commands.<br>
&gt; INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred: Timeo=
ut reached\nOriginal status: ERROR\n{&#39;name&#39;: &#39;5-tests/acceptanc=
e/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_bionic_20_08&#39=
;, &#39;logdir&#39;: &#39;/home/fox/avocado/job-results/job-2020-10-24T22.2=
5-39... (90.47 s)<br>
&gt;<br>
&gt; When I run the image manually I get the same error, but only if I resi=
ze the 20.08 image to 2G. If resized to 4G, the<br>
&gt; 20.08 image boots fine.<br>
&gt;<br>
&gt; Additionally, I noticed that the NetBSD 9.0 test has the same problem,=
 even in current master (4c5b97bfd0dd54dc27717ae8d1cd10e14eef1430):<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 (5/5) tests/acceptance/boot_linux_console.py:BootLinuxCon=
sole.test_arm_orangepi_uboot_netbsd9: |console: U-Boot SPL 2020.01+dfsg-1 (=
Jan 08 2020 - 08:19:44 +0000)<br>
&gt; console: DRAM: 1024 MiB<br>
&gt; console: Failed to set core voltage! Can&#39;t set CPU frequency<br>
&gt; /console: Trying to boot from MMC1<br>
&gt; console: U-Boot 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000) Allwinne=
r Technology<br>
&gt; ...<br>
&gt; console: Starting kernel ...<br>
&gt; console: [=C2=A0 =C2=A01.0000000] NetBSD/evbarm (fdt) booting ...<br>
&gt; ...<br>
&gt; console: [=C2=A0 =C2=A01.3300167] sdmmc0: SD card status: 4-bit, C0<br=
>
&gt; console: [=C2=A0 =C2=A01.3300167] ld0 at sdmmc0: &lt;0xaa:0x5859:QEMU!=
:0x01:0xdeadbeef:0x062&gt;<br>
&gt; console: [=C2=A0 =C2=A01.3430678] ld0: 1024 MB, 1040 cyl, 32 head, 63 =
sec, 512 bytes/sect x 2097152 sectors<br>
&gt; console: [=C2=A0 =C2=A01.4102580] ld0: 4-bit width, High-Speed/SDR25, =
50.000 MHz<br>
&gt; console: [=C2=A0 =C2=A02.0674392] WARNING: 4 errors while detecting ha=
rdware; check system log.<br>
&gt; console: [=C2=A0 =C2=A02.0674392] boot device: ld0<br>
&gt; console: [=C2=A0 =C2=A02.0775401] root on ld0a dumps on ld0b<br>
&gt; console: [=C2=A0 =C2=A02.0977679] vfs_mountroot: can&#39;t open root d=
evice<br>
&gt; console: [=C2=A0 =C2=A02.0977679] cannot mount root, error =3D 6<br>
&gt; INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred: Timeo=
ut reached\nOriginal status: ERROR\n{&#39;name&#39;: &#39;5-tests/acceptanc=
e/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_uboot_netbsd9&#3=
9;, &#39;l&gt;<br>
&gt;<br>
&gt; To resolve this error, I made a small patch that expands the SD image =
in both tests to the next power-of-two multiplied by 2:<br>
&gt;<br>
&gt; diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance=
/boot_linux_console.py<br>
&gt; index b604cfe7da..40835904bb 100644<br>
&gt; --- a/tests/acceptance/boot_linux_console.py<br>
&gt; +++ b/tests/acceptance/boot_linux_console.py<br>
&gt; @@ -35,11 +35,11 @@ def pow2ceil(x):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return 1 if x =3D=3D 0 else 2**(x - 1).bit_length(=
)<br>
&gt;<br>
&gt;=C2=A0 &quot;&quot;&quot;<br>
&gt; -Expand file size to next power of 2<br>
&gt; +Expand file size to next power of 2 or higher<br>
&gt;=C2=A0 &quot;&quot;&quot;<br>
&gt; -def image_pow2ceil_expand(path):<br>
&gt; +def image_pow2ceil_expand(path, multiply_factor =3D 1):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D os.path.getsize(path)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_aligned =3D pow2ceil(size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_aligned =3D pow2ceil(size) * multipl=
y_factor<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if size !=3D size_aligned:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(path, &#39;a=
b+&#39;) as fd:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fd.trunc=
ate(size_aligned)<br>
&gt; @@ -850,7 +850,7 @@ class BootLinuxConsole(LinuxKernelTest):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 image_path_xz =3D self.fetch_asset(i=
mage_url, asset_hash=3Dimage_hash,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0algorithm=3D&#39;sha256&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 image_path =3D archive.extract(image=
_path_xz, self.workdir)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_pow2ceil_expand(image_path)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_pow2ceil_expand(image_path, 2)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.do_test_arm_orangepi_uboot_armb=
ian(image_path)<br>
&gt;<br>
&gt; @@ -879,7 +879,7 @@ class BootLinuxConsole(LinuxKernelTest):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 image_path_gz =3D self.fetch_asset(i=
mage_url, asset_hash=3Dimage_hash)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 image_path =3D os.path.join(self.wor=
kdir, &#39;armv7.img&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 archive.gzip_uncompress(image_path_g=
z, image_path)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_pow2ceil_expand(image_path)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_pow2ceil_expand(image_path, 2)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 image_drive_args =3D &#39;if=3Dsd,fo=
rmat=3Draw,snapshot=3Don,file=3D&#39; + image_path<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # dd if=3Du-boot-sunxi-with-spl.bin =
of=3Darmv7.img bs=3D1K seek=3D8 conv=3Dnotrunc<br>
&gt;<br>
&gt; After applying that change, all Orange Pi tests run successfully:<br>
&gt;<br>
&gt; $ AVOCADO_ALLOW_LARGE_STORAGE=3Dyes ARMBIAN_ARTIFACTS_CACHED=3Dyes avo=
cado --show=3Dapp,console run -t machine:orangepi-pc tests/acceptance/boot_=
linux_console.py<br>
<br>
This command does not work for me.<br>
<br>
Traceback (most recent call last):<br>
=C2=A0 File &quot;/usr/local/bin/avocado&quot;, line 5, in &lt;module&gt;<b=
r>
=C2=A0 =C2=A0 from avocado.core.main import main<br>
=C2=A0 File &quot;/usr/local/lib/python3.8/dist-packages/avocado/core/main.=
py&quot;,<br>
line 22, in &lt;module&gt;<br>
=C2=A0 =C2=A0 from avocado.core import data_dir<br>
=C2=A0 File &quot;/usr/local/lib/python3.8/dist-packages/avocado/core/data_=
dir.py&quot;,<br>
line 39, in &lt;module&gt;<br>
=C2=A0 =C2=A0 from .output import LOG_JOB, LOG_UI<br>
=C2=A0 File &quot;/usr/local/lib/python3.8/dist-packages/avocado/core/outpu=
t.py&quot;,<br>
line 27, in &lt;module&gt;<br>
=C2=A0 =C2=A0 from .settings import settings<br>
=C2=A0 File &quot;/usr/local/lib/python3.8/dist-packages/avocado/core/setti=
ngs.py&quot;,<br>
line 625, in &lt;module&gt;<br>
=C2=A0 =C2=A0 settings =3D Settings()=C2=A0 # pylint: disable-msg=3Dinvalid=
-name<br>
=C2=A0 File &quot;/usr/local/lib/python3.8/dist-packages/avocado/core/setti=
ngs.py&quot;,<br>
line 274, in __init__<br>
=C2=A0 =C2=A0 self._prepare_base_dirs()<br>
=C2=A0 File &quot;/usr/local/lib/python3.8/dist-packages/avocado/core/setti=
ngs.py&quot;,<br>
line 315, in _prepare_base_dirs<br>
=C2=A0 =C2=A0 self._config_path_pkg =3D resource_filename(&#39;avocado&#39;=
, config_pkg_base)<br>
=C2=A0 File &quot;/usr/lib/python3/dist-packages/pkg_resources/__init__.py&=
quot;,<br>
line 1145, in resource_filename<br>
=C2=A0 =C2=A0 return get_provider(package_or_requirement).get_resource_file=
name(<br>
=C2=A0 File &quot;/usr/lib/python3/dist-packages/pkg_resources/__init__.py&=
quot;,<br>
line 365, in get_provider<br>
=C2=A0 =C2=A0 return _find_adapter(_provider_factories, loader)(module)<br>
=C2=A0 File &quot;/usr/lib/python3/dist-packages/pkg_resources/__init__.py&=
quot;,<br>
line 1393, in __init__<br>
=C2=A0 =C2=A0 self.module_path =3D os.path.dirname(getattr(module, &#39;__f=
ile__&#39;, &#39;&#39;))<br>
=C2=A0 File &quot;/usr/lib/python3.8/posixpath.py&quot;, line 152, in dirna=
me<br>
=C2=A0 =C2=A0 p =3D os.fspath(p)<br>
TypeError: expected str, bytes or os.PathLike object, not NoneType<br>
<br>
I haven&#39;t got a command to work on testing only a single target. Any<br=
>
hint? Thanks!<br></blockquote><div><br></div><div>That error is new to me, =
I have not seen it before. From the stacktrace, it looks like that avocado =
is trying to read its own configuration / settings file (from settings.py).=
</div><div>Later on there is a type conversion error for NoneType. Perhaps =
the avocado files for your user have somehow got corrupted?</div><div>You c=
ould try to remove them from your home directory and/or re-install avocado =
as well and start out fresh.</div><div>I assume that at least &#39;avocado =
--help&#39;=C2=A0 should work without generating this error.<br></div><div>=
<br></div><div>Also it may be useful to know that it looks like you need to=
 run avocado from within the new &#39;build&#39; directory that the new mes=
on build system now creates.</div><div>If not running from the &#39;build&#=
39; directory, I&#39;m getting this printed on my machine:</div><div>=C2=A0=
 CANCEL: No QEMU binary defined or found in the build tree</div><div><br></=
div><div>So once your avocado is working without the type error you could t=
ry this:<br></div><div><br></div><div>1) cd build</div><div>2) AVOCADO_ALLO=
W_LARGE_STORAGE=3Dyes ARMBIAN_ARTIFACTS_CACHED=3Dyes avocado --show=3Dapp,c=
onsole run -t machine:orangepi-pc tests/acceptance/boot_linux_console.py</d=
iv><div><br></div><div>Alternatively, if you can&#39;t get avocado to run a=
nything, you could also just run the Armbian image (or any other image) dir=
ectly via qemu-system-arm:</div><div><br></div><div>=C2=A0 $ build/arm-soft=
mmu/qemu-system-arm -M orangepi-pc -nographic -nic user -sd Armbian_20.08.1=
_Orangepipc_bionic_current_5.8.5.img</div><div>=C2=A0 U-Boot SPL 2020.04-ar=
mbian (Sep 02 2020 - 10:16:13 +0200)<br>=C2=A0 DRAM: 1024 MiB<br></div><div=
>=C2=A0 ...</div><div>=C2=A0 Autoboot in 1 seconds, press &lt;Space&gt; to =
stop<br>=C2=A0 =3D&gt; setenv extraargs &#39;console=3DttyS0,115200&#39;<br=
>=C2=A0 =3D&gt; boot</div><div>=C2=A0 ...</div><div>=C2=A0 Uncompressing Li=
nux... done, booting the kernel.<br>=C2=A0 Loading, please wait...<br>=C2=
=A0 starting version 237</div><div><br></div><div>Also see the file docs/sy=
stem/arm/orangepi.rst with some additional information and documentation.</=
div><div><br></div><div>Hope this helps &amp; regards,<br></div><div><br></=
div><div>Niek<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
<br>
&gt; ...<br>
&gt; RESULTS=C2=A0 =C2=A0 : PASS 6 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | I=
NTERRUPT 0 | CANCEL 0<br>
&gt; JOB TIME=C2=A0 =C2=A0: 161.69 s<br>
&gt;<br>
&gt; I will send this as a separate patch to the list shortly, so you can c=
onsider adding it to the series (feel free to modify it where needed).<br>
&gt;<br>
<br>
Regards,<br>
Bin<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--0000000000009f14a005b28110cd--

