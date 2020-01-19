Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49644C32771
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 00:26:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F047B246A0
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 00:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGl00VmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F047B246A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isyQ8-0007NL-42
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 19:26:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45676)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1isyPG-0006lk-1S
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 19:25:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1isyPD-0005pc-8E
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 19:25:33 -0500
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:45631)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1isyPC-0005p4-V1; Sat, 18 Jan 2020 19:25:31 -0500
Received: by mail-io1-xd44.google.com with SMTP id i11so29906694ioi.12;
 Sat, 18 Jan 2020 16:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Sypx9i14wQVGFjiiFLRvz+7z5FDk3s6nMhuaMnKP6f0=;
 b=hGl00VmEARdYoD3vm62wKdHSQHUPhMrtGMEB2kN8MbR7GlQk+ABQrgkApruwo1qw3G
 3y3d9sUW/oCQFOjXx0t25knwg2qK2FlBCHPcjLskE727JS3oxcwk/KZDI2E78WBM+2Tz
 Twr4geOFOlejVUuhtmusTFWZP1idnGUiwtVSQUP3KoR/zAR9Cx8gQCvP1dk9scMDLAT2
 p5lZmwMB2/7WMTMzMV9SHswwluHKQ+CXiABASVnzDoj+iWjQjavYCRK++TQLD9tul4ny
 v2J6GVoDpCveYR8CrU80X+OTukVwIF2KORSmbsQcPtNFFvy1/GP4E+zmtoywpBHQ8a2q
 amHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Sypx9i14wQVGFjiiFLRvz+7z5FDk3s6nMhuaMnKP6f0=;
 b=acjnqXWsitnuAgE9weQLb9VxqA988y6qQfamPxurxCffeoj3KYa/5kfmC1QP/2GSuy
 UaRbwA5oWWionN8LvkwZJtN0GxNuzIUqAY2jeeEsCfEdfqUGoxXjMG3oDp86uEXXIF1g
 pQOXG99fl9fDJHMlSm19cr+QHaJlreofycKd3RkARsvQNnpfmfZSbk6r0d5J2aTz+cKH
 OMBE8MlHqsmbMc0ESQq8NzlOmmUzKvcdY604s5ab9bc3h8K8The5F+Eab/a7YxtsmgjA
 NinV4r4vpRrs6VYSiooi9Sl1Aj1Kfwdxt/gRVj9s/n4/50FKcvOOCK50Q9vw0tGxhzVP
 62eQ==
X-Gm-Message-State: APjAAAX34hBEHCe33ggpZdtsfCn8UQxAArSr2KAetPBgAKTfHtapupkB
 /HNW9xzR8XHJLmOXCWQtt+N2tfdfnmQebpAzQyQ=
X-Google-Smtp-Source: APXvYqxVtK4baTXF9a3YqPKmaEQ1SWTyy5t6BWzu5e7cZdDOeWjUXcxt1s7OqDevrlns5ht4RezCbB7+8ca9wh9mtSc=
X-Received: by 2002:a6b:d912:: with SMTP id r18mr34958470ioc.306.1579393529593; 
 Sat, 18 Jan 2020 16:25:29 -0800 (PST)
MIME-Version: 1.0
References: <20200118191623.32549-1-f4bug@amsat.org>
 <20200118191623.32549-4-f4bug@amsat.org>
In-Reply-To: <20200118191623.32549-4-f4bug@amsat.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Sun, 19 Jan 2020 01:25:18 +0100
Message-ID: <CAPan3WrS3-7nfAr=YatS18DLR9OOJwO9UH-n0xQxq1ap1wrzoQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] tests/boot_linux_console: Test booting NetBSD via
 U-Boot on OrangePi PC
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="0000000000004ac34b059c733661"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Kamil Rytarowski <kamil@netbsd.org>,
 qemu-arm <qemu-arm@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004ac34b059c733661
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Sat, Jan 18, 2020 at 8:16 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> This test boots U-Boot then NetBSD (stored on a SD card) on
> a OrangePi PC board.
>
> As it requires ~1.3GB of storage, it is disabled by default.
>
> U-Boot is built by the Debian project [1], and the SD card image
> is provided by the NetBSD organization [2].
>

Thanks a lot for sending this patch, it very nicely complements the linux
tests to
prove that the ARM/Allwinner-H3 emulation is working properly!

I also see that you have used a pre-compiled binary from Debian to automate
it.
That works very well indeed.


> Once the compressed SD card image is downloaded (304MB) and
> extracted, this test is fast:
>
>   $ AVOCADO_ALLOW_LARGE_STORAGE=3Dyes \
>     avocado --show=3Dapp,console run -t machine:orangepi-pc \
>       tests/acceptance/boot_linux_console.py
>   console: U-Boot SPL 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000)
>   console: DRAM: 1024 MiB
>   console: U-Boot 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000) Allwinner
> Technology
>   console: CPU:   Allwinner H3 (SUN8I 0000)
>   console: scanning bus usb@1c1b000 for devices... 1 USB Device(s) found
>   console: scanning bus usb@1c1d000 for devices... 1 USB Device(s) found
>   console: scanning usb for storage devices... 0 Storage Device(s) found
>   console: Hit any key to stop autoboot:  0
>   console: =3D> setenv bootargs root=3Dld0a
>   console: =3D> setenv kernel netbsd-GENERIC.ub
>   console: =3D> setenv fdtfile dtb/sun8i-h3-orangepi-pc.dtb
>   console: =3D> boot
>   console: ## Booting kernel from Legacy Image at 42000000 ...
>   console: Image Name:   NetBSD/earmv7hf 9.0_RC1
>   console: Image Type:   ARM Linux Kernel Image (no loading done)
> (uncompressed)
>   console: XIP Kernel Image (no loading done)
>   console: Loading Device Tree to 49ff6000, end 49fffe01 ... OK
>   console: Starting kernel ...
>   console: [   1.0000000] NetBSD/evbarm (fdt) booting ...
>   console: [   1.0000000] NetBSD 9.0_RC1 (GENERIC) #0: Wed Nov 27 16:14:5=
2
> UTC 2019
>   console: [   1.0000000] simplebus0 at armfdt0: Xunlong Orange Pi PC
>   console: [   1.0000000] cpu0 at cpus0: Cortex-A7 r0p5 (Cortex V7A core)
>   console: [   1.0000000] cpu0: DC enabled IC enabled WB enabled LABT
> branch prediction enabled
>   console: [   1.0000000] cpu0: 32KB/64B 2-way L1 VIPT Instruction cache
>   console: [   1.0000000] cpu0: 32KB/64B 2-way write-back-locking-C L1
> PIPT Data cache
>   console: [   1.0000000] cpu0: 2304KB/64B 16-way write-through L2 PIPT
> Unified cache
>   console: [   1.0000000] vfp0 at cpu0: NEON MPE (VFP 3.0+), rounding, Na=
N
> propagation, denormals
>   ...
>   console: [   2.8171937] sdmmc0: SD card status: 4-bit, C0
>   console: [   2.8234040] ld0 at sdmmc0:
> <0xaa:0x5859:QEMU!:0x01:0xdeadbeef:0x062>
>   console: [   2.8743967] ld0: 1290 MB, 655 cyl, 64 head, 63 sec, 512
> bytes/sect x 2642944 sectors
>   console: [   3.1588850] ld0: 4-bit width, High-Speed/SDR25, 50.000 MHz
>   console: [   4.9942260] WARNING: 4 errors while detecting hardware;
> check system log.
>   console: [   5.0142912] boot device: ld0
>   console: [   5.0551260] root on ld0a dumps on ld0b
>   console: [   5.2175484] root file system type: ffs
>   console: [   5.2858559] kern.module.path=3D/stand/evbarm/9.0/modules
>   console: Tue Jan 18 18:15:15 UTC 2050
>   console: Starting root file system check:
>   PASS (35.96 s)
>   RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 =
|
> CANCEL 0
>   JOB TIME   : 36.09 s
>
> Note, this test only took ~65 seconds to run on Travis-CI, see: [3].
>

It is very fast, on my laptop it only took 23 seconds!


>
> This test is based on a description from Niek Linnenbank from [4].
>
> [1]
> https://wiki.debian.org/InstallingDebianOn/Allwinner#Creating_a_bootable_=
SD_Card_with_u-boot
> [2] https://wiki.netbsd.org/ports/evbarm/allwinner/
> [3] https://travis-ci.org/philmd/qemu/jobs/638823612#L3778
> [4] https://www.mail-archive.com/qemu-devel@nongnu.org/msg669347.html
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>

Regards,
Niek


> ---
>  tests/acceptance/boot_linux_console.py | 63 ++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>
> diff --git a/tests/acceptance/boot_linux_console.py
> b/tests/acceptance/boot_linux_console.py
> index 55d0b8b036..56d3d6e9eb 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -16,6 +16,7 @@ import shutil
>  from avocado import skipUnless
>  from avocado_qemu import Test
>  from avocado_qemu import exec_command_and_wait_for_pattern
> +from avocado_qemu import interrupt_interactive_console_until_pattern
>  from avocado_qemu import wait_for_console_pattern
>  from avocado.utils import process
>  from avocado.utils import archive
> @@ -551,6 +552,68 @@ class BootLinuxConsole(Test):
>                                        'to <orangepipc>')
>          self.wait_for_console_pattern('Starting Load Kernel Modules...')
>
> +    @skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage
> limited')
> +    def test_arm_orangepi_uboot_netbsd9(self):
> +        """
> +        :avocado: tags=3Darch:arm
> +        :avocado: tags=3Dmachine:orangepi-pc
> +        """
> +        # This test download a 304MB compressed image and expand it to
> 1.3GB...
> +        deb_url =3D ('http://snapshot.debian.org/archive/debian/'
> +                   '20200108T145233Z/pool/main/u/u-boot/'
> +                   'u-boot-sunxi_2020.01%2Bdfsg-1_armhf.deb')
> +        deb_hash =3D 'f67f404a80753ca3d1258f13e38f2b060e13db99'
> +        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> +        # We use the common OrangePi PC 'plus' build of U-Boot for our
> secondary
> +        # program loader (SPL). We will then set the path to the more
> specific
> +        # OrangePi "PC" device tree blob with 'setenv fdtfile' in U-Boot
> prompt,
> +        # before to boot NetBSD.
> +        uboot_path =3D
> '/usr/lib/u-boot/orangepi_plus/u-boot-sunxi-with-spl.bin'
> +        uboot_path =3D self.extract_from_deb(deb_path, uboot_path)
> +        image_url =3D ('https://cdn.netbsd.org/pub/NetBSD/NetBSD-9.0_RC1=
/'
> +                     'evbarm-earmv7hf/binary/gzimg/armv7.img.gz')
> +        image_hash =3D '7f58d5c36600430a8bcebe7e999a8945a2be4d1f'
> +        image_path_gz =3D self.fetch_asset(image_url, asset_hash=3Dimage=
_hash)
> +        image_path =3D os.path.join(self.workdir, 'armv7.img')
> +        image_drive_args =3D 'if=3Dsd,format=3Draw,snapshot=3Don,file=3D=
' +
> image_path
> +        archive.gzip_uncompress(image_path_gz, image_path)
> +
> +        # dd if=3Du-boot-sunxi-with-spl.bin of=3Darmv7.img bs=3D1K seek=
=3D8
> conv=3Dnotrunc
> +        with open(uboot_path, 'rb') as f_in:
> +            with open(image_path, 'r+b') as f_out:
> +                f_out.seek(8 * 1024)
> +                shutil.copyfileobj(f_in, f_out)
> +
> +        self.vm.set_console()
> +        self.vm.add_args('-nic', 'user',
> +                         '-drive', image_drive_args,
> +                         '-no-reboot')
> +        self.vm.launch()
> +        wait_for_console_pattern(self, 'U-Boot 2020.01+dfsg-1')
> +        interrupt_interactive_console_until_pattern(self,
> +                                       'Hit any key to stop autoboot:',
> +                                       'switch to partitions #0, OK')
> +
> +        exec_command_and_wait_for_pattern(self, '', '=3D>')
> +        cmd =3D 'setenv bootargs root=3Dld0a'
> +        exec_command_and_wait_for_pattern(self, cmd, '=3D>')
> +        cmd =3D 'setenv kernel netbsd-GENERIC.ub'
> +        exec_command_and_wait_for_pattern(self, cmd, '=3D>')
> +        cmd =3D 'setenv fdtfile dtb/sun8i-h3-orangepi-pc.dtb'
> +        exec_command_and_wait_for_pattern(self, cmd, '=3D>')
> +        cmd =3D ("setenv bootcmd 'fatload mmc 0:1 ${kernel_addr_r}
> ${kernel}; "
> +               "fatload mmc 0:1 ${fdt_addr_r} ${fdtfile}; "
> +               "fdt addr ${fdt_addr_r}; "
> +               "bootm ${kernel_addr_r} - ${fdt_addr_r}'")
> +        exec_command_and_wait_for_pattern(self, cmd, '=3D>')
> +
> +        exec_command_and_wait_for_pattern(self, 'boot',
> +                                          'Booting kernel from Legacy
> Image')
> +        wait_for_console_pattern(self, 'Starting kernel ...')
> +        wait_for_console_pattern(self, 'NetBSD 9.0_RC1 (GENERIC)')
> +        # Wait for user-space
> +        wait_for_console_pattern(self, 'Starting root file system check'=
)
> +
>      def test_s390x_s390_ccw_virtio(self):
>          """
>          :avocado: tags=3Darch:s390x
> --
> 2.21.1
>
>

--=20
Niek Linnenbank

--0000000000004ac34b059c733661
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Philippe,<br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Jan 18, 2020 at 8:16 PM Phili=
ppe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.o=
rg</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">This test boots U-Boot then NetBSD (stored on a SD card) on<br>
a OrangePi PC board.<br>
<br>
As it requires ~1.3GB of storage, it is disabled by default.<br>
<br>
U-Boot is built by the Debian project [1], and the SD card image<br>
is provided by the NetBSD organization [2].<br></blockquote><div><br></div>=
<div>Thanks a lot for sending this patch, it very nicely complements the li=
nux tests to</div><div>prove that the ARM/Allwinner-H3 emulation is working=
 properly!</div><div><br></div><div>I also see that you have used a pre-com=
piled binary from Debian to automate it.</div><div>That works very well ind=
eed.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Once the compressed SD card image is downloaded (304MB) and<br>
extracted, this test is fast:<br>
<br>
=C2=A0 $ AVOCADO_ALLOW_LARGE_STORAGE=3Dyes \<br>
=C2=A0 =C2=A0 avocado --show=3Dapp,console run -t machine:orangepi-pc \<br>
=C2=A0 =C2=A0 =C2=A0 tests/acceptance/boot_linux_console.py<br>
=C2=A0 console: U-Boot SPL 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000)<br=
>
=C2=A0 console: DRAM: 1024 MiB<br>
=C2=A0 console: U-Boot 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000) Allwin=
ner Technology<br>
=C2=A0 console: CPU:=C2=A0 =C2=A0Allwinner H3 (SUN8I 0000)<br>
=C2=A0 console: scanning bus usb@1c1b000 for devices... 1 USB Device(s) fou=
nd<br>
=C2=A0 console: scanning bus usb@1c1d000 for devices... 1 USB Device(s) fou=
nd<br>
=C2=A0 console: scanning usb for storage devices... 0 Storage Device(s) fou=
nd<br>
=C2=A0 console: Hit any key to stop autoboot:=C2=A0 0<br>
=C2=A0 console: =3D&gt; setenv bootargs root=3Dld0a<br>
=C2=A0 console: =3D&gt; setenv kernel netbsd-GENERIC.ub<br>
=C2=A0 console: =3D&gt; setenv fdtfile dtb/sun8i-h3-orangepi-pc.dtb<br>
=C2=A0 console: =3D&gt; boot<br>
=C2=A0 console: ## Booting kernel from Legacy Image at 42000000 ...<br>
=C2=A0 console: Image Name:=C2=A0 =C2=A0NetBSD/earmv7hf 9.0_RC1<br>
=C2=A0 console: Image Type:=C2=A0 =C2=A0ARM Linux Kernel Image (no loading =
done) (uncompressed)<br>
=C2=A0 console: XIP Kernel Image (no loading done)<br>
=C2=A0 console: Loading Device Tree to 49ff6000, end 49fffe01 ... OK<br>
=C2=A0 console: Starting kernel ...<br>
=C2=A0 console: [=C2=A0 =C2=A01.0000000] NetBSD/evbarm (fdt) booting ...<br=
>
=C2=A0 console: [=C2=A0 =C2=A01.0000000] NetBSD 9.0_RC1 (GENERIC) #0: Wed N=
ov 27 16:14:52 UTC 2019<br>
=C2=A0 console: [=C2=A0 =C2=A01.0000000] simplebus0 at armfdt0: Xunlong Ora=
nge Pi PC<br>
=C2=A0 console: [=C2=A0 =C2=A01.0000000] cpu0 at cpus0: Cortex-A7 r0p5 (Cor=
tex V7A core)<br>
=C2=A0 console: [=C2=A0 =C2=A01.0000000] cpu0: DC enabled IC enabled WB ena=
bled LABT branch prediction enabled<br>
=C2=A0 console: [=C2=A0 =C2=A01.0000000] cpu0: 32KB/64B 2-way L1 VIPT Instr=
uction cache<br>
=C2=A0 console: [=C2=A0 =C2=A01.0000000] cpu0: 32KB/64B 2-way write-back-lo=
cking-C L1 PIPT Data cache<br>
=C2=A0 console: [=C2=A0 =C2=A01.0000000] cpu0: 2304KB/64B 16-way write-thro=
ugh L2 PIPT Unified cache<br>
=C2=A0 console: [=C2=A0 =C2=A01.0000000] vfp0 at cpu0: NEON MPE (VFP 3.0+),=
 rounding, NaN propagation, denormals<br>
=C2=A0 ...<br>
=C2=A0 console: [=C2=A0 =C2=A02.8171937] sdmmc0: SD card status: 4-bit, C0<=
br>
=C2=A0 console: [=C2=A0 =C2=A02.8234040] ld0 at sdmmc0: &lt;0xaa:0x5859:QEM=
U!:0x01:0xdeadbeef:0x062&gt;<br>
=C2=A0 console: [=C2=A0 =C2=A02.8743967] ld0: 1290 MB, 655 cyl, 64 head, 63=
 sec, 512 bytes/sect x 2642944 sectors<br>
=C2=A0 console: [=C2=A0 =C2=A03.1588850] ld0: 4-bit width, High-Speed/SDR25=
, 50.000 MHz<br>
=C2=A0 console: [=C2=A0 =C2=A04.9942260] WARNING: 4 errors while detecting =
hardware; check system log.<br>
=C2=A0 console: [=C2=A0 =C2=A05.0142912] boot device: ld0<br>
=C2=A0 console: [=C2=A0 =C2=A05.0551260] root on ld0a dumps on ld0b<br>
=C2=A0 console: [=C2=A0 =C2=A05.2175484] root file system type: ffs<br>
=C2=A0 console: [=C2=A0 =C2=A05.2858559] kern.module.path=3D/stand/evbarm/9=
.0/modules<br>
=C2=A0 console: Tue Jan 18 18:15:15 UTC 2050<br>
=C2=A0 console: Starting root file system check:<br>
=C2=A0 PASS (35.96 s)<br>
=C2=A0 RESULTS=C2=A0 =C2=A0 : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 |=
 INTERRUPT 0 | CANCEL 0<br>
=C2=A0 JOB TIME=C2=A0 =C2=A0: 36.09 s<br>
<br>
Note, this test only took ~65 seconds to run on Travis-CI, see: [3].<br></b=
lockquote><div><br></div><div>It is very fast, on my laptop it only took 23=
 seconds!<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
This test is based on a description from Niek Linnenbank from [4].<br>
<br>
[1] <a href=3D"https://wiki.debian.org/InstallingDebianOn/Allwinner#Creatin=
g_a_bootable_SD_Card_with_u-boot" rel=3D"noreferrer" target=3D"_blank">http=
s://wiki.debian.org/InstallingDebianOn/Allwinner#Creating_a_bootable_SD_Car=
d_with_u-boot</a><br>
[2] <a href=3D"https://wiki.netbsd.org/ports/evbarm/allwinner/" rel=3D"nore=
ferrer" target=3D"_blank">https://wiki.netbsd.org/ports/evbarm/allwinner/</=
a><br>
[3] <a href=3D"https://travis-ci.org/philmd/qemu/jobs/638823612#L3778" rel=
=3D"noreferrer" target=3D"_blank">https://travis-ci.org/philmd/qemu/jobs/63=
8823612#L3778</a><br>
[4] <a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg669347=
.html" rel=3D"noreferrer" target=3D"_blank">https://www.mail-archive.com/qe=
mu-devel@nongnu.org/msg669347.html</a><br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br></blockquote><div>Teste=
d-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com">niekl=
innenbank@gmail.com</a>&gt;</div><div><br></div><div>Regards,</div><div>Nie=
k<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
---<br>
=C2=A0tests/acceptance/boot_linux_console.py | 63 +++++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 63 insertions(+)<br>
<br>
diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot=
_linux_console.py<br>
index 55d0b8b036..56d3d6e9eb 100644<br>
--- a/tests/acceptance/boot_linux_console.py<br>
+++ b/tests/acceptance/boot_linux_console.py<br>
@@ -16,6 +16,7 @@ import shutil<br>
=C2=A0from avocado import skipUnless<br>
=C2=A0from avocado_qemu import Test<br>
=C2=A0from avocado_qemu import exec_command_and_wait_for_pattern<br>
+from avocado_qemu import interrupt_interactive_console_until_pattern<br>
=C2=A0from avocado_qemu import wait_for_console_pattern<br>
=C2=A0from avocado.utils import process<br>
=C2=A0from avocado.utils import archive<br>
@@ -551,6 +552,68 @@ class BootLinuxConsole(Test):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;to &=
lt;orangepipc&gt;&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.wait_for_console_pattern(&#39;Starti=
ng Load Kernel Modules...&#39;)<br>
<br>
+=C2=A0 =C2=A0 @skipUnless(os.getenv(&#39;AVOCADO_ALLOW_LARGE_STORAGE&#39;)=
, &#39;storage limited&#39;)<br>
+=C2=A0 =C2=A0 def test_arm_orangepi_uboot_netbsd9(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Darch:arm<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dmachine:orangepi-pc<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # This test download a 304MB compressed image =
and expand it to 1.3GB...<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_url =3D (&#39;<a href=3D"http://snapshot.d=
ebian.org/archive/debian/" rel=3D"noreferrer" target=3D"_blank">http://snap=
shot.debian.org/archive/debian/</a>&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;=
20200108T145233Z/pool/main/u/u-boot/&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;=
u-boot-sunxi_2020.01%2Bdfsg-1_armhf.deb&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;f67f404a80753ca3d1258f13e38f=
2b060e13db99&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_path =3D self.fetch_asset(deb_url, asset_h=
ash=3Ddeb_hash)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # We use the common OrangePi PC &#39;plus&#39;=
 build of U-Boot for our secondary<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # program loader (SPL). We will then set the p=
ath to the more specific<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # OrangePi &quot;PC&quot; device tree blob wit=
h &#39;setenv fdtfile&#39; in U-Boot prompt,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # before to boot NetBSD.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uboot_path =3D &#39;/usr/lib/u-boot/orangepi_p=
lus/u-boot-sunxi-with-spl.bin&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uboot_path =3D self.extract_from_deb(deb_path,=
 uboot_path)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_url =3D (&#39;<a href=3D"https://cdn.net=
bsd.org/pub/NetBSD/NetBSD-9.0_RC1/" rel=3D"noreferrer" target=3D"_blank">ht=
tps://cdn.netbsd.org/pub/NetBSD/NetBSD-9.0_RC1/</a>&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&#39;evbarm-earmv7hf/binary/gzimg/armv7.img.gz&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_hash =3D &#39;7f58d5c36600430a8bcebe7e99=
9a8945a2be4d1f&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_path_gz =3D self.fetch_asset(image_url, =
asset_hash=3Dimage_hash)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_path =3D os.path.join(self.workdir, &#39=
;armv7.img&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_drive_args =3D &#39;if=3Dsd,format=3Draw=
,snapshot=3Don,file=3D&#39; + image_path<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 archive.gzip_uncompress(image_path_gz, image_p=
ath)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # dd if=3Du-boot-sunxi-with-spl.bin of=3Darmv7=
.img bs=3D1K seek=3D8 conv=3Dnotrunc<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(uboot_path, &#39;rb&#39;) as f_in:<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(image_path, &#39;r+b&#=
39;) as f_out:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f_out.seek(8 * 102=
4)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 shutil.copyfileobj=
(f_in, f_out)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.set_console()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.add_args(&#39;-nic&#39;, &#39;user&#39=
;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-drive&#39;, image_drive_args,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-no-reboot&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.launch()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 wait_for_console_pattern(self, &#39;U-Boot 202=
0.01+dfsg-1&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt_interactive_console_until_pattern(se=
lf,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;Hit =
any key to stop autoboot:&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;swit=
ch to partitions #0, OK&#39;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self, &#39;&=
#39;, &#39;=3D&gt;&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D &#39;setenv bootargs root=3Dld0a&#39;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self, cmd, &=
#39;=3D&gt;&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D &#39;setenv kernel netbsd-GENERIC.ub&#=
39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self, cmd, &=
#39;=3D&gt;&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D &#39;setenv fdtfile dtb/sun8i-h3-orang=
epi-pc.dtb&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self, cmd, &=
#39;=3D&gt;&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D (&quot;setenv bootcmd &#39;fatload mmc=
 0:1 ${kernel_addr_r} ${kernel}; &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;fatload mmc 0=
:1 ${fdt_addr_r} ${fdtfile}; &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;fdt addr ${fd=
t_addr_r}; &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;bootm ${kerne=
l_addr_r} - ${fdt_addr_r}&#39;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self, cmd, &=
#39;=3D&gt;&#39;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self, &#39;b=
oot&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
#39;Booting kernel from Legacy Image&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 wait_for_console_pattern(self, &#39;Starting k=
ernel ...&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 wait_for_console_pattern(self, &#39;NetBSD 9.0=
_RC1 (GENERIC)&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Wait for user-space<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 wait_for_console_pattern(self, &#39;Starting r=
oot file system check&#39;)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def test_s390x_s390_ccw_virtio(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0:avocado: tags=3Darch:s390x<br>
-- <br>
2.21.1<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--0000000000004ac34b059c733661--

