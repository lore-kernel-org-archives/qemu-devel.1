Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0867CC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 21:22:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA8A12176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 21:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q79xBpfa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA8A12176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihgmF-0005TZ-SS
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 16:22:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49087)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ihgl3-0004dW-IV
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:21:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ihgl1-0000tt-6T
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:21:25 -0500
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b]:32790)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1ihgl0-0000tb-Vh; Wed, 18 Dec 2019 16:21:23 -0500
Received: by mail-il1-x12b.google.com with SMTP id v15so2979358iln.0;
 Wed, 18 Dec 2019 13:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eYOQYD7N468B9qLiuc+fIol2HVdnn3O8hnxJaHLAR74=;
 b=q79xBpfa6sMS3V6cd4FV5Gr3IhTdrdVLHJ9ywxwepUVH3mk7lAwFjgHSA2RiLttoLb
 al87Mf00mz2U0HtNnIZkIYxdGzGXaRUXtti65ohi5muYPWEMgIoKdCHSV0UtR/8QrUQx
 F7SIIlWLmPZBsD/SVSyGxXO16CRvQJzNiOZ30fpW1q1oj0AxXqOwSDbKeDwJVR9Tm7p/
 noasGN4FxAiYa5ptWdfMzQSkHrohaMqB0pvv64R+9dNOmIz7q+arvN8Pcpb+pFUBXYKj
 fsBZvNxTsmgmPwU73FMEJkj32fVtN+X8Y3p5fcNPr/op6wpFEII+zbwwYKcskpjAgLuB
 LpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eYOQYD7N468B9qLiuc+fIol2HVdnn3O8hnxJaHLAR74=;
 b=RKa86a+ol+KVhR/qPSpklfnX6xBf4iIvLkJhdzNI7C30e+gwAP7Be6pA5sdf7mbE+A
 G7h1FT9R9jlI3vjsAVpXbOY/VWAmRi5SQ9zMJesvDP8rJPewJw6BPXxPlLuizds8ra5D
 /PYxyUC86/5qImpS44fNaRrd9D9y1pUNxTMbtB1p4Ju3lj3t4OkfpD8cuuntECvcH8Qz
 hRLrvG/oDXsg8nI4EzME+CzF8M5s+KikoACWnM1ssGb0EnbcXCIERyS5d7GpJAk9W9n4
 2cXrwyG3y5nbi0o++kry0OPqGBfa0+1GtjMNIxBLgarnI9CMB0cgQWzGLTXbzggj3a7D
 CqWA==
X-Gm-Message-State: APjAAAX+h8iDJWBK80GW+D/8q9tO30q2jjNhlbnP3t+HIYy5PXepgWjT
 6ATjCz8L6snlUe0d1lyCBi+u8NBxTol/QKvuZ7U=
X-Google-Smtp-Source: APXvYqzrtrtEHZP/g8KDI3c8WeSDu5eweQ24GxMBopYnuGgnXkdZnv3ACKG/q5U9LqMinHJbVb4yxYg0xxpAEDeO5f4=
X-Received: by 2002:a92:a103:: with SMTP id v3mr3372445ili.265.1576704082031; 
 Wed, 18 Dec 2019 13:21:22 -0800 (PST)
MIME-Version: 1.0
References: <20191217182730.943-1-f4bug@amsat.org>
 <20191217182730.943-3-f4bug@amsat.org>
In-Reply-To: <20191217182730.943-3-f4bug@amsat.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Wed, 18 Dec 2019 22:21:11 +0100
Message-ID: <CAPan3WoYNtHY23yYMWm7ORR8jLcAdCfushGCSfEa6UzJWjzeog@mail.gmail.com>
Subject: Re: [PATCH 2/5] tests/boot_linux_console: Add initrd test for the
 Orange Pi PC board
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000b9bbe2059a010660"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::12b
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
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b9bbe2059a010660
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This one also works fine on my host (Ubuntu 18.04 LTS):

  Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>

On Tue, Dec 17, 2019 at 7:27 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> This test boots a Linux kernel on a OrangePi PC board and verify
> the serial output is working.
>
> The kernel image and DeviceTree blob are built by the Raspbian
> project (based on Debian):
> https://www.raspbian.org/RaspbianImages
>
> The cpio image used comes from the linux-build-test project:
> https://github.com/groeck/linux-build-test
>
> If ARM is a target being built, "make check-acceptance" will
> automatically include this test by the use of the "arch:arm" tags.
>
> Alternatively, this test can be run using:
>
>   $ avocado --show=3Dconsole run -t machine:orangepi-pc
> tests/acceptance/boot_linux_console.py
>   console: Uncompressing Linux... done, booting the kernel.
>   console: Booting Linux on physical CPU 0x0
>   console: Linux version 4.20.7-sunxi (root@armbian.com) (gcc version
> 7.2.1 20171011 (Linaro GCC 7.2-2017.11)) #5.75 SMP Fri Feb 8 09:02:10 CET
> 2019
>   console: CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=3D50c53=
87d
>   console: CPU: div instructions available: patching division code
>   console: CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
> instruction cache
>   console: OF: fdt: Machine model: Xunlong Orange Pi PC
>   [...]
>   console: Trying to unpack rootfs image as initramfs...
>   console: Freeing initrd memory: 3256K
>   console: Freeing unused kernel memory: 1024K
>   console: Run /init as init process
>   console: mount: mounting devtmpfs on /dev failed: Device or resource bu=
sy
>   console: Starting logging: OK
>   console: Initializing random number generator... random: dd:
> uninitialized urandom read (512 bytes read)
>   console: done.
>   console: Starting network: OK
>   console: Found console ttyS0
>   console: Linux version 4.20.7-sunxi (root@armbian.com) (gcc version
> 7.2.1 20171011 (Linaro GCC 7.2-2017.11)) #5.75 SMP Fri Feb 8 09:02:10 CET
> 2019
>   console: Boot successful.
>   console: cat /proc/cpuinfo
>   console: / # cat /proc/cpuinfo
>   console: processor      : 0
>   console: model name     : ARMv7 Processor rev 5 (v7l)
>   console: BogoMIPS       : 125.00
>   console: Features       : half thumb fastmult vfp edsp neon vfpv3 tls
> vfpv4 idiva idivt vfpd32 lpae evtstrm
>   console: CPU implementer        : 0x41
>   console: CPU architecture: 7
>   console: CPU variant    : 0x0
>   console: CPU part       : 0xc07
>   console: CPU revision   : 5
>   [...]
>   console: processor      : 3
>   console: model name     : ARMv7 Processor rev 5 (v7l)
>   console: BogoMIPS       : 125.00
>   console: Features       : half thumb fastmult vfp edsp neon vfpv3 tls
> vfpv4 idiva idivt vfpd32 lpae evtstrm
>   console: CPU implementer        : 0x41
>   console: CPU architecture: 7
>   console: CPU variant    : 0x0
>   console: CPU part       : 0xc07
>   console: CPU revision   : 5
>   console: Hardware       : Allwinner sun8i Family
>   console: Revision       : 0000
>   console: Serial         : 0000000000000000
>   console: cat /proc/iomem
>   console: / # cat /proc/iomem
>   console: 01000000-010fffff : clock@1000000
>   console: 01c00000-01c00fff : system-control@1c00000
>   console: 01c02000-01c02fff : dma-controller@1c02000
>   [...]
>   console: reboot
>   console: / # reboot
>   console: / # Found console ttyS0
>   console: Stopping network: OK
>   console: hrtimer: interrupt took 21852064 ns
>   console: Saving random seed... random: dd: uninitialized urandom read
> (512 bytes read)
>   console: done.
>   console: Stopping logging: OK
>   console: umount: devtmpfs busy - remounted read-only
>   console: umount: can't unmount /: Invalid argument
>   console: The system is going down NOW!
>   console: Sent SIGTERM to all processes
>   console: Sent SIGKILL to all processes
>   console: Requesting system reboot
>   console: reboot: Restarting system
>   PASS (48.32 s)
>   JOB TIME   : 49.16 s
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/acceptance/boot_linux_console.py | 41 ++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/tests/acceptance/boot_linux_console.py
> b/tests/acceptance/boot_linux_console.py
> index 820239e439..daabd47404 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -437,6 +437,47 @@ class BootLinuxConsole(Test):
>          console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
>          self.wait_for_console_pattern(console_pattern)
>
> +    def test_arm_orangepi_initrd(self):
> +        """
> +        :avocado: tags=3Darch:arm
> +        :avocado: tags=3Dmachine:orangepi-pc
> +        """
> +        deb_url =3D ('https://apt.armbian.com/pool/main/l/'
> +
>  'linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.deb')
> +        deb_hash =3D '1334c29c44d984ffa05ed10de8c3361f33d78315'
> +        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> +        kernel_path =3D self.extract_from_deb(deb_path,
> +                                            '/boot/vmlinuz-4.20.7-sunxi'=
)
> +        dtb_path =3D
> '/usr/lib/linux-image-dev-sunxi/sun8i-h3-orangepi-pc.dtb'
> +        dtb_path =3D self.extract_from_deb(deb_path, dtb_path)
> +        initrd_url =3D ('https://github.com/groeck/linux-build-test/raw/=
'
> +                      '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
> +                      'arm/rootfs-armv7a.cpio.gz')
> +        initrd_hash =3D '604b2e45cdf35045846b8bbfbf2129b1891bdc9c'
> +        initrd_path_gz =3D self.fetch_asset(initrd_url,
> asset_hash=3Dinitrd_hash)
> +        initrd_path =3D os.path.join(self.workdir, 'rootfs.cpio')
> +        archive.gzip_uncompress(initrd_path_gz, initrd_path)
> +
> +        self.vm.set_machine('orangepi-pc')
> +        self.vm.set_console()
> +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> +                               'console=3DttyS0,115200 '
> +                               'panic=3D-1 noreboot')
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-dtb', dtb_path,
> +                         '-initrd', initrd_path,
> +                         '-append', kernel_command_line,
> +                         '-no-reboot')
> +        self.vm.launch()
> +        self.wait_for_console_pattern('Boot successful.')
> +
> +        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
> +                                                'Allwinner sun8i Family'=
)
> +        exec_command_and_wait_for_pattern(self, 'cat /proc/iomem',
> +                                                'system-control@1c00000'=
)
> +        exec_command_and_wait_for_pattern(self, 'reboot',
> +                                                'reboot: Restarting
> system')
> +
>      def test_s390x_s390_ccw_virtio(self):
>          """
>          :avocado: tags=3Darch:s390x
> --
> 2.21.0
>
>

--=20
Niek Linnenbank

--000000000000b9bbe2059a010660
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>This one also works fine on my host (Ubuntu 18.04 LTS=
):</div><div><br></div><div>=C2=A0 Tested-by: Niek Linnenbank &lt;<a href=
=3D"mailto:nieklinnenbank@gmail.com">nieklinnenbank@gmail.com</a>&gt;<br></=
div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On=
 Tue, Dec 17, 2019 at 7:27 PM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"ma=
ilto:f4bug@amsat.org">f4bug@amsat.org</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">This test boots a Linux kernel on a Or=
angePi PC board and verify<br>
the serial output is working.<br>
<br>
The kernel image and DeviceTree blob are built by the Raspbian<br>
project (based on Debian):<br>
<a href=3D"https://www.raspbian.org/RaspbianImages" rel=3D"noreferrer" targ=
et=3D"_blank">https://www.raspbian.org/RaspbianImages</a><br>
<br>
The cpio image used comes from the linux-build-test project:<br>
<a href=3D"https://github.com/groeck/linux-build-test" rel=3D"noreferrer" t=
arget=3D"_blank">https://github.com/groeck/linux-build-test</a><br>
<br>
If ARM is a target being built, &quot;make check-acceptance&quot; will<br>
automatically include this test by the use of the &quot;arch:arm&quot; tags=
.<br>
<br>
Alternatively, this test can be run using:<br>
<br>
=C2=A0 $ avocado --show=3Dconsole run -t machine:orangepi-pc tests/acceptan=
ce/boot_linux_console.py<br>
=C2=A0 console: Uncompressing Linux... done, booting the kernel.<br>
=C2=A0 console: Booting Linux on physical CPU 0x0<br>
=C2=A0 console: Linux version 4.20.7-sunxi (<a href=3D"mailto:root@armbian.=
com" target=3D"_blank">root@armbian.com</a>) (gcc version 7.2.1 20171011 (L=
inaro GCC 7.2-2017.11)) #5.75 SMP Fri Feb 8 09:02:10 CET 2019<br>
=C2=A0 console: CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=3D50=
c5387d<br>
=C2=A0 console: CPU: div instructions available: patching division code<br>
=C2=A0 console: CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing inst=
ruction cache<br>
=C2=A0 console: OF: fdt: Machine model: Xunlong Orange Pi PC<br>
=C2=A0 [...]<br>
=C2=A0 console: Trying to unpack rootfs image as initramfs...<br>
=C2=A0 console: Freeing initrd memory: 3256K<br>
=C2=A0 console: Freeing unused kernel memory: 1024K<br>
=C2=A0 console: Run /init as init process<br>
=C2=A0 console: mount: mounting devtmpfs on /dev failed: Device or resource=
 busy<br>
=C2=A0 console: Starting logging: OK<br>
=C2=A0 console: Initializing random number generator... random: dd: uniniti=
alized urandom read (512 bytes read)<br>
=C2=A0 console: done.<br>
=C2=A0 console: Starting network: OK<br>
=C2=A0 console: Found console ttyS0<br>
=C2=A0 console: Linux version 4.20.7-sunxi (<a href=3D"mailto:root@armbian.=
com" target=3D"_blank">root@armbian.com</a>) (gcc version 7.2.1 20171011 (L=
inaro GCC 7.2-2017.11)) #5.75 SMP Fri Feb 8 09:02:10 CET 2019<br>
=C2=A0 console: Boot successful.<br>
=C2=A0 console: cat /proc/cpuinfo<br>
=C2=A0 console: / # cat /proc/cpuinfo<br>
=C2=A0 console: processor=C2=A0 =C2=A0 =C2=A0 : 0<br>
=C2=A0 console: model name=C2=A0 =C2=A0 =C2=A0: ARMv7 Processor rev 5 (v7l)=
<br>
=C2=A0 console: BogoMIPS=C2=A0 =C2=A0 =C2=A0 =C2=A0: 125.00<br>
=C2=A0 console: Features=C2=A0 =C2=A0 =C2=A0 =C2=A0: half thumb fastmult vf=
p edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm<br>
=C2=A0 console: CPU implementer=C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0x41<br>
=C2=A0 console: CPU architecture: 7<br>
=C2=A0 console: CPU variant=C2=A0 =C2=A0 : 0x0<br>
=C2=A0 console: CPU part=C2=A0 =C2=A0 =C2=A0 =C2=A0: 0xc07<br>
=C2=A0 console: CPU revision=C2=A0 =C2=A0: 5<br>
=C2=A0 [...]<br>
=C2=A0 console: processor=C2=A0 =C2=A0 =C2=A0 : 3<br>
=C2=A0 console: model name=C2=A0 =C2=A0 =C2=A0: ARMv7 Processor rev 5 (v7l)=
<br>
=C2=A0 console: BogoMIPS=C2=A0 =C2=A0 =C2=A0 =C2=A0: 125.00<br>
=C2=A0 console: Features=C2=A0 =C2=A0 =C2=A0 =C2=A0: half thumb fastmult vf=
p edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm<br>
=C2=A0 console: CPU implementer=C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0x41<br>
=C2=A0 console: CPU architecture: 7<br>
=C2=A0 console: CPU variant=C2=A0 =C2=A0 : 0x0<br>
=C2=A0 console: CPU part=C2=A0 =C2=A0 =C2=A0 =C2=A0: 0xc07<br>
=C2=A0 console: CPU revision=C2=A0 =C2=A0: 5<br>
=C2=A0 console: Hardware=C2=A0 =C2=A0 =C2=A0 =C2=A0: Allwinner sun8i Family=
<br>
=C2=A0 console: Revision=C2=A0 =C2=A0 =C2=A0 =C2=A0: 0000<br>
=C2=A0 console: Serial=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: 0000000000000000<=
br>
=C2=A0 console: cat /proc/iomem<br>
=C2=A0 console: / # cat /proc/iomem<br>
=C2=A0 console: 01000000-010fffff : clock@1000000<br>
=C2=A0 console: 01c00000-01c00fff : system-control@1c00000<br>
=C2=A0 console: 01c02000-01c02fff : dma-controller@1c02000<br>
=C2=A0 [...]<br>
=C2=A0 console: reboot<br>
=C2=A0 console: / # reboot<br>
=C2=A0 console: / # Found console ttyS0<br>
=C2=A0 console: Stopping network: OK<br>
=C2=A0 console: hrtimer: interrupt took 21852064 ns<br>
=C2=A0 console: Saving random seed... random: dd: uninitialized urandom rea=
d (512 bytes read)<br>
=C2=A0 console: done.<br>
=C2=A0 console: Stopping logging: OK<br>
=C2=A0 console: umount: devtmpfs busy - remounted read-only<br>
=C2=A0 console: umount: can&#39;t unmount /: Invalid argument<br>
=C2=A0 console: The system is going down NOW!<br>
=C2=A0 console: Sent SIGTERM to all processes<br>
=C2=A0 console: Sent SIGKILL to all processes<br>
=C2=A0 console: Requesting system reboot<br>
=C2=A0 console: reboot: Restarting system<br>
=C2=A0 PASS (48.32 s)<br>
=C2=A0 JOB TIME=C2=A0 =C2=A0: 49.16 s<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
---<br>
=C2=A0tests/acceptance/boot_linux_console.py | 41 +++++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 41 insertions(+)<br>
<br>
diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot=
_linux_console.py<br>
index 820239e439..daabd47404 100644<br>
--- a/tests/acceptance/boot_linux_console.py<br>
+++ b/tests/acceptance/boot_linux_console.py<br>
@@ -437,6 +437,47 @@ class BootLinuxConsole(Test):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0console_pattern =3D &#39;Kernel command l=
ine: %s&#39; % kernel_command_line<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.wait_for_console_pattern(console_pat=
tern)<br>
<br>
+=C2=A0 =C2=A0 def test_arm_orangepi_initrd(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Darch:arm<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dmachine:orangepi-pc<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_url =3D (&#39;<a href=3D"https://apt.armbi=
an.com/pool/main/l/" rel=3D"noreferrer" target=3D"_blank">https://apt.armbi=
an.com/pool/main/l/</a>&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;=
linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.deb&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;1334c29c44d984ffa05ed10de8c3=
361f33d78315&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_path =3D self.fetch_asset(deb_url, asset_h=
ash=3Ddeb_hash)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_path =3D self.extract_from_deb(deb_path=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &#39;/boot/vmlinuz-4.20.7-sunxi&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D &#39;/usr/lib/linux-image-dev-sun=
xi/sun8i-h3-orangepi-pc.dtb&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D self.extract_from_deb(deb_path, d=
tb_path)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 initrd_url =3D (&#39;<a href=3D"https://github=
.com/groeck/linux-build-test/raw/" rel=3D"noreferrer" target=3D"_blank">htt=
ps://github.com/groeck/linux-build-test/raw/</a>&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &#39;2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &#39;arm/rootfs-armv7a.cpio.gz&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 initrd_hash =3D &#39;604b2e45cdf35045846b8bbfb=
f2129b1891bdc9c&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 initrd_path_gz =3D self.fetch_asset(initrd_url=
, asset_hash=3Dinitrd_hash)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 initrd_path =3D os.path.join(self.workdir, &#3=
9;rootfs.cpio&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 archive.gzip_uncompress(initrd_path_gz, initrd=
_path)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.set_machine(&#39;orangepi-pc&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.set_console()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_command_line =3D (self.KERNEL_COMMON_CO=
MMAND_LINE +<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;console=3DttyS0,115200 &#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;panic=3D-1 noreboot&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.add_args(&#39;-kernel&#39;, kernel_pat=
h,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-dtb&#39;, dtb_path,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-initrd&#39;, initrd_path,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-append&#39;, kernel_command_line,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-no-reboot&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.launch()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wait_for_console_pattern(&#39;Boot succes=
sful.&#39;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self, &#39;c=
at /proc/cpuinfo&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &#39;Allwinner sun8i Family&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self, &#39;c=
at /proc/iomem&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &#39;system-control@1c00000&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self, &#39;r=
eboot&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &#39;reboot: Restarting system&#39;)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def test_s390x_s390_ccw_virtio(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0:avocado: tags=3Darch:s390x<br>
-- <br>
2.21.0<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000b9bbe2059a010660--

