Return-Path: <SRS0=AG+E=EA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A57DC2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 02:19:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FCAA20773
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 02:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OS6ExgQB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FCAA20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWVcr-0002vh-CS
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 22:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kWVbX-0002Ok-Ag; Sat, 24 Oct 2020 22:17:55 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:46940)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kWVbV-0005i8-1S; Sat, 24 Oct 2020 22:17:55 -0400
Received: by mail-yb1-xb42.google.com with SMTP id a4so4631145ybq.13;
 Sat, 24 Oct 2020 19:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ZieWmSZ3WXhOZ0Fd8PNhZ+ucEjpUQIoZ4qULDz6WR+8=;
 b=OS6ExgQByVYbE99L2WnPlX0wQWXzji/G3XSH90RP06+tW8+tnvaulTOep5mQpTGw61
 lYSRoo/UoIs/FQW36eTDhA0SIEmXmb5BdCQhvdK+crTchH45ddwShXdbkQVJx0Xpdk5E
 tTILFvM0LzO8vuqUt9Fk/6Bfrpv19DWWEY3SMCq0L1bgkKtmXnVVEOt5oDgojoR1a025
 lkj+u7d4U4BVZbOxkuazVrqeP3TPoXO+Lj6fRnW8IHzuuec5bS5R8RCb2yy8yyGgZWkM
 BvrZbyf/fysROf3AG3bUJsT1IzT0UCoDavsqM2FY5nlXYz9nxLKfyfX5jQ8K2TIiNl8z
 EDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZieWmSZ3WXhOZ0Fd8PNhZ+ucEjpUQIoZ4qULDz6WR+8=;
 b=SMw/Im7bdNFw3v9zoj6771R1HIx20tGtP1KBzYvXJzOgT3aPSXXAwLemzjXCG3cLtf
 17qq2b3jUHcr1tpwWqq3Axff3GnSBWHuXTFUBFBXoWkFYj08Aiui6mjbUl1bQVR32T+8
 ClxWmtR/PVgJfT9XK3VAN87mqZZdeYy0ZRWrWMkA5Q9P5az+NUKiV0CBViFG+i05iZav
 2sAYx9vMfofaTyTnoz/eUS+BP/fhEL54OUbd2K/hYplW5MCQLY4POYxbvA7t0yB4ujux
 dfUGAvoXGRqxvMAuhfrCgcklWDbrTi1LgO0md4YeA37nqTiJ51AL0GgqaZxjZNCnbxNP
 Uo6Q==
X-Gm-Message-State: AOAM531KqMf0w0Thdjsr2hlCL8uWyXwcKwi7TkgsLG+fne7Ywlr8gezu
 aJj0rsx5YnJgRQDHmhphxLzBbexuPtQR1ZkoAc0=
X-Google-Smtp-Source: ABdhPJwYsEaVy1oDNr5NwEXXyZNIxPV3iGsK043xyZNVrpg7JVuVA/4iBMzMyyOTJlKgyb7C9T3NmoC/TU4EIQN8jPo=
X-Received: by 2002:a25:4113:: with SMTP id o19mr12596205yba.314.1603592270552; 
 Sat, 24 Oct 2020 19:17:50 -0700 (PDT)
MIME-Version: 1.0
References: <20201023131808.3198005-1-f4bug@amsat.org>
 <20201023131808.3198005-5-f4bug@amsat.org>
 <CAPan3Wp3CEh0Q1pJ41+rqBqAucFULAfAj=sR4Ba10hcW+1Tc7w@mail.gmail.com>
In-Reply-To: <CAPan3Wp3CEh0Q1pJ41+rqBqAucFULAfAj=sR4Ba10hcW+1Tc7w@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 25 Oct 2020 10:17:39 +0800
Message-ID: <CAEUhbmX8MWBL_7LgLZ5-xNJJ4iddtgQKV9q4qydhektok+zxNA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] tests/acceptance: Test U-Boot/Linux from Armbian
 20.08 on Orange Pi PC
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Bin Meng <bin.meng@windriver.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Niek,

On Sun, Oct 25, 2020 at 5:01 AM Niek Linnenbank
<nieklinnenbank@gmail.com> wrote:
>
> Hi Philippe,
>
> I have ran this series with the new Armbian 20.08 test and noticed this f=
ailure:
>
> -console: /dev/mmcblk0p1: The filesystem size (according to the superrand=
om: fast init done
> console: block) is 264192 blocks
> console: The physical size of the device is 261120 blocks
> console: Either the superblock or the partition table is likely to be cor=
rupt!
> console: /dev/mmcblk0p1: UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY.
> console: (i.e., without -a or -p options)
> console: fsck exited with status code 4
> console: done.
> console: Failure: File system check of the root filesystem failed
> console: The root filesystem on /dev/mmcblk0p1 requires a manual fsck
> |console: BusyBox v1.27.2 (Ubuntu 1:1.27.2-2ubuntu3.2) built-in shell (as=
h)
> console: Enter 'help' for a list of built-in commands.
> INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred: Timeout =
reached\nOriginal status: ERROR\n{'name': '5-tests/acceptance/boot_linux_co=
nsole.py:BootLinuxConsole.test_arm_orangepi_bionic_20_08', 'logdir': '/home=
/fox/avocado/job-results/job-2020-10-24T22.25-39... (90.47 s)
>
> When I run the image manually I get the same error, but only if I resize =
the 20.08 image to 2G. If resized to 4G, the
> 20.08 image boots fine.
>
> Additionally, I noticed that the NetBSD 9.0 test has the same problem, ev=
en in current master (4c5b97bfd0dd54dc27717ae8d1cd10e14eef1430):
>
>    (5/5) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm=
_orangepi_uboot_netbsd9: |console: U-Boot SPL 2020.01+dfsg-1 (Jan 08 2020 -=
 08:19:44 +0000)
> console: DRAM: 1024 MiB
> console: Failed to set core voltage! Can't set CPU frequency
> /console: Trying to boot from MMC1
> console: U-Boot 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000) Allwinner T=
echnology
> ...
> console: Starting kernel ...
> console: [   1.0000000] NetBSD/evbarm (fdt) booting ...
> ...
> console: [   1.3300167] sdmmc0: SD card status: 4-bit, C0
> console: [   1.3300167] ld0 at sdmmc0: <0xaa:0x5859:QEMU!:0x01:0xdeadbeef=
:0x062>
> console: [   1.3430678] ld0: 1024 MB, 1040 cyl, 32 head, 63 sec, 512 byte=
s/sect x 2097152 sectors
> console: [   1.4102580] ld0: 4-bit width, High-Speed/SDR25, 50.000 MHz
> console: [   2.0674392] WARNING: 4 errors while detecting hardware; check=
 system log.
> console: [   2.0674392] boot device: ld0
> console: [   2.0775401] root on ld0a dumps on ld0b
> console: [   2.0977679] vfs_mountroot: can't open root device
> console: [   2.0977679] cannot mount root, error =3D 6
> INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred: Timeout =
reached\nOriginal status: ERROR\n{'name': '5-tests/acceptance/boot_linux_co=
nsole.py:BootLinuxConsole.test_arm_orangepi_uboot_netbsd9', 'l>
>
> To resolve this error, I made a small patch that expands the SD image in =
both tests to the next power-of-two multiplied by 2:
>
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index b604cfe7da..40835904bb 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -35,11 +35,11 @@ def pow2ceil(x):
>      return 1 if x =3D=3D 0 else 2**(x - 1).bit_length()
>
>  """
> -Expand file size to next power of 2
> +Expand file size to next power of 2 or higher
>  """
> -def image_pow2ceil_expand(path):
> +def image_pow2ceil_expand(path, multiply_factor =3D 1):
>          size =3D os.path.getsize(path)
> -        size_aligned =3D pow2ceil(size)
> +        size_aligned =3D pow2ceil(size) * multiply_factor
>          if size !=3D size_aligned:
>              with open(path, 'ab+') as fd:
>                  fd.truncate(size_aligned)
> @@ -850,7 +850,7 @@ class BootLinuxConsole(LinuxKernelTest):
>          image_path_xz =3D self.fetch_asset(image_url, asset_hash=3Dimage=
_hash,
>                                           algorithm=3D'sha256')
>          image_path =3D archive.extract(image_path_xz, self.workdir)
> -        image_pow2ceil_expand(image_path)
> +        image_pow2ceil_expand(image_path, 2)
>
>          self.do_test_arm_orangepi_uboot_armbian(image_path)
>
> @@ -879,7 +879,7 @@ class BootLinuxConsole(LinuxKernelTest):
>          image_path_gz =3D self.fetch_asset(image_url, asset_hash=3Dimage=
_hash)
>          image_path =3D os.path.join(self.workdir, 'armv7.img')
>          archive.gzip_uncompress(image_path_gz, image_path)
> -        image_pow2ceil_expand(image_path)
> +        image_pow2ceil_expand(image_path, 2)
>          image_drive_args =3D 'if=3Dsd,format=3Draw,snapshot=3Don,file=3D=
' + image_path
>
>          # dd if=3Du-boot-sunxi-with-spl.bin of=3Darmv7.img bs=3D1K seek=
=3D8 conv=3Dnotrunc
>
> After applying that change, all Orange Pi tests run successfully:
>
> $ AVOCADO_ALLOW_LARGE_STORAGE=3Dyes ARMBIAN_ARTIFACTS_CACHED=3Dyes avocad=
o --show=3Dapp,console run -t machine:orangepi-pc tests/acceptance/boot_lin=
ux_console.py

This command does not work for me.

Traceback (most recent call last):
  File "/usr/local/bin/avocado", line 5, in <module>
    from avocado.core.main import main
  File "/usr/local/lib/python3.8/dist-packages/avocado/core/main.py",
line 22, in <module>
    from avocado.core import data_dir
  File "/usr/local/lib/python3.8/dist-packages/avocado/core/data_dir.py",
line 39, in <module>
    from .output import LOG_JOB, LOG_UI
  File "/usr/local/lib/python3.8/dist-packages/avocado/core/output.py",
line 27, in <module>
    from .settings import settings
  File "/usr/local/lib/python3.8/dist-packages/avocado/core/settings.py",
line 625, in <module>
    settings =3D Settings()  # pylint: disable-msg=3Dinvalid-name
  File "/usr/local/lib/python3.8/dist-packages/avocado/core/settings.py",
line 274, in __init__
    self._prepare_base_dirs()
  File "/usr/local/lib/python3.8/dist-packages/avocado/core/settings.py",
line 315, in _prepare_base_dirs
    self._config_path_pkg =3D resource_filename('avocado', config_pkg_base)
  File "/usr/lib/python3/dist-packages/pkg_resources/__init__.py",
line 1145, in resource_filename
    return get_provider(package_or_requirement).get_resource_filename(
  File "/usr/lib/python3/dist-packages/pkg_resources/__init__.py",
line 365, in get_provider
    return _find_adapter(_provider_factories, loader)(module)
  File "/usr/lib/python3/dist-packages/pkg_resources/__init__.py",
line 1393, in __init__
    self.module_path =3D os.path.dirname(getattr(module, '__file__', ''))
  File "/usr/lib/python3.8/posixpath.py", line 152, in dirname
    p =3D os.fspath(p)
TypeError: expected str, bytes or os.PathLike object, not NoneType

I haven't got a command to work on testing only a single target. Any
hint? Thanks!

> ...
> RESULTS    : PASS 6 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | =
CANCEL 0
> JOB TIME   : 161.69 s
>
> I will send this as a separate patch to the list shortly, so you can cons=
ider adding it to the series (feel free to modify it where needed).
>

Regards,
Bin

