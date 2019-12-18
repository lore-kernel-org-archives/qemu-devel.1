Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A99C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 21:23:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23F1F2176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 21:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8/vEC7X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F1F2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihgn9-0006rm-B5
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 16:23:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50841)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ihglq-0005OD-SY
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:22:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ihglo-00025S-PU
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:22:14 -0500
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:42930)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1ihglo-00024F-Hb; Wed, 18 Dec 2019 16:22:12 -0500
Received: by mail-io1-xd42.google.com with SMTP id n11so1994101iom.9;
 Wed, 18 Dec 2019 13:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YnmFDxFVtARO0HY7CapVcOOi+YIONeWeB7RC8ILYGCQ=;
 b=d8/vEC7X5f3vFQCrQCnYAq+CI0HWEthyo9JmYtqemqIAgw5cx7an/j7Ct8u/RsAV+9
 rC+TTLkNaKDww1tFZTNKJpDKfLkdfSMM0SsgAV8vtUAHV4OOV1orcrxHzHJJx3ka4tuh
 0+8e2t82QNUwAkgYTVEBifHMSQ+xu6AK8slddWmgmAPJabflDL9rXJQjXPzbAxRJEIdL
 C9NQifkxXN9ktdNbyyDjtcWGMsNYOnCRF05DojAsVJxCxvLMSZDOpSKUKzlozCn+LqL+
 7FVUozMkGHM+DdDMUvtA/WVVai2iRkB1jIcHmguVB7HJk91WVNFRUZTMAps7F5zBSS4V
 pYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YnmFDxFVtARO0HY7CapVcOOi+YIONeWeB7RC8ILYGCQ=;
 b=amYe/4DbZXg7qMNEEIs3KL+tlappRH3jfINYZv6kuDJBLhlnRy74JmLX6QI3GOtO9w
 MHGls3/oQpuATcsCaut7UIaC3onf0WCwawzVkO6mAegYejVnVsrh7lArE25BaZeh3u+O
 CgSzzRTpXe7nMu4DGyXqQyUR4BcocKL0XnGX9QSg+RDXbnklDg4s+rehkrru75fMOs9k
 eVQM0qBT+rJSwzSvkhJdTfQAtBqyBR1XWlIOHWS3Qw22GEndGjqSsG/8tYLTgkbjl061
 T/7XXB0NXHB1Al4YceAo4DIIp+XV9btj/Y/SGGubhI9pHq5IdLlh9EiyZ0tDcj6fLoG2
 Mo6w==
X-Gm-Message-State: APjAAAVCATnLODx29kQlZYXh7BSAoyFBJPdVO8lTJKMteatbT3AiPODz
 bJdviz4zbvuXsyi2KY++3G5geVMSE+PCGpihqq4=
X-Google-Smtp-Source: APXvYqy1acOSEA2Tj0Loes/Z9CTkDJotrgtVMiaZUfTU7ECXojJmFZXVei7wioE7VdXse9GILax2k1k74UfPzPmYqOo=
X-Received: by 2002:a6b:d912:: with SMTP id r18mr3231835ioc.306.1576704131649; 
 Wed, 18 Dec 2019 13:22:11 -0800 (PST)
MIME-Version: 1.0
References: <20191217182730.943-1-f4bug@amsat.org>
 <20191217182730.943-4-f4bug@amsat.org>
In-Reply-To: <20191217182730.943-4-f4bug@amsat.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Wed, 18 Dec 2019 22:22:00 +0100
Message-ID: <CAPan3Wqf0RYnDb7Op5NmOsfoX7-J5OqP6niB0SawNEpZf5Pndw@mail.gmail.com>
Subject: Re: [PATCH 3/5] tests/boot_linux_console: Add a SD card test for the
 OrangePi PC board
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000aee4c7059a01095f"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Guenter Roeck <linux@roeck-us.net>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000aee4c7059a01095f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Same, this one also runs fine for me:

  Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>

On Tue, Dec 17, 2019 at 7:27 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> The kernel image and DeviceTree blob are built by the Raspbian
> project (based on Debian):
> https://www.raspbian.org/RaspbianImages
>
> The SD image is from the kernelci.org project:
> https://kernelci.org/faq/#the-code
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
>   [...]
>   console: sunxi-wdt 1c20ca0.watchdog: Watchdog enabled (timeout=3D16 sec=
,
> nowayout=3D0)
>   console: sunxi-mmc 1c0f000.mmc: Linked as a consumer to regulator.2
>   console: sunxi-mmc 1c0f000.mmc: Got CD GPIO
>   console: ledtrig-cpu: registered to indicate activity on CPUs
>   console: hidraw: raw HID events driver (C) Jiri Kosina
>   console: usbcore: registered new interface driver usbhid
>   console: usbhid: USB HID core driver
>   console: Initializing XFRM netlink socket
>   console: sunxi-mmc 1c0f000.mmc: initialized, max. request size: 16384 K=
B
>   console: NET: Registered protocol family 10
>   console: mmc0: host does not support reading read-only switch, assuming
> write-enable
>   console: mmc0: Problem switching card into high-speed mode!
>   console: mmc0: new SD card at address 4567
>   console: mmcblk0: mmc0:4567 QEMU! 60.0 MiB
>   [...]
>   console: EXT4-fs (mmcblk0): mounting ext2 file system using the ext4
> subsystem
>   console: EXT4-fs (mmcblk0): mounted filesystem without journal. Opts:
> (null)
>   console: VFS: Mounted root (ext2 filesystem) on device 179:0.
>   console: Run /sbin/init as init process
>   console: EXT4-fs (mmcblk0): re-mounted. Opts:
> block_validity,barrier,user_xattr,acl
>   console: Starting syslogd: OK
>   console: Starting klogd: OK
>   console: Populating /dev using udev: udevd[203]: starting version 3.2.7
>   console: /bin/sh: can't access tty; job control turned off
>   console: cat /proc/partitions
>   console: / # cat /proc/partitions
>   console: major minor  #blocks  name
>   console: 1        0       4096 ram0
>   console: 1        1       4096 ram1
>   console: 1        2       4096 ram2
>   console: 1        3       4096 ram3
>   console: 179        0      61440 mmcblk0
>   console: reboot
>   console: / # reboot
>   console: umount: devtmpfs busy - remounted read-only
>   console: EXT4-fs (mmcblk0): re-mounted. Opts: (null)
>   console: The system is going down NOW!
>   console: Sent SIGTERM to all processes
>   console: Sent SIGKILL to all processes
>   console: Requesting system reboot
>   console: reboot: Restarting system
>   JOB TIME   : 68.64 s
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/acceptance/boot_linux_console.py | 42 ++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/tests/acceptance/boot_linux_console.py
> b/tests/acceptance/boot_linux_console.py
> index daabd47404..8179b45910 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -478,6 +478,48 @@ class BootLinuxConsole(Test):
>          exec_command_and_wait_for_pattern(self, 'reboot',
>                                                  'reboot: Restarting
> system')
>
> +    def test_arm_orangepi_sd(self):
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
> +        rootfs_url =3D ('
> http://storage.kernelci.org/images/rootfs/buildroot/'
> +                      'kci-2019.02/armel/base/rootfs.ext2.xz')
> +        rootfs_hash =3D '692510cb625efda31640d1de0a8d60e26040f061'
> +        rootfs_path_xz =3D self.fetch_asset(rootfs_url,
> asset_hash=3Drootfs_hash)
> +        rootfs_path =3D os.path.join(self.workdir, 'rootfs.cpio')
> +        archive.lzma_uncompress(rootfs_path_xz, rootfs_path)
> +
> +        self.vm.set_machine('orangepi-pc')
> +        self.vm.set_console()
> +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> +                               'console=3DttyS0,115200 '
> +                               'root=3D/dev/mmcblk0 rootwait rw '
> +                               'panic=3D-1 noreboot')
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-dtb', dtb_path,
> +                         '-drive', 'file=3D' + rootfs_path +
> ',if=3Dsd,format=3Draw',
> +                         '-append', kernel_command_line,
> +                         '-no-reboot')
> +        self.vm.launch()
> +        shell_ready =3D "/bin/sh: can't access tty; job control turned o=
ff"
> +        self.wait_for_console_pattern(shell_ready)
> +
> +        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
> +                                                'Allwinner sun8i Family'=
)
> +        exec_command_and_wait_for_pattern(self, 'cat /proc/partitions',
> +                                                'mmcblk0')
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

--000000000000aee4c7059a01095f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Same, this one also runs fine for me:</div><div><br><=
/div><div>=C2=A0 Tested-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinne=
nbank@gmail.com">nieklinnenbank@gmail.com</a>&gt;<br></div></div><br><div c=
lass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec 17, =
2019 at 7:27 PM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@ams=
at.org">f4bug@amsat.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">The kernel image and DeviceTree blob are built by th=
e Raspbian<br>
project (based on Debian):<br>
<a href=3D"https://www.raspbian.org/RaspbianImages" rel=3D"noreferrer" targ=
et=3D"_blank">https://www.raspbian.org/RaspbianImages</a><br>
<br>
The SD image is from the <a href=3D"http://kernelci.org" rel=3D"noreferrer"=
 target=3D"_blank">kernelci.org</a> project:<br>
<a href=3D"https://kernelci.org/faq/#the-code" rel=3D"noreferrer" target=3D=
"_blank">https://kernelci.org/faq/#the-code</a><br>
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
=C2=A0 [...]<br>
=C2=A0 console: sunxi-wdt 1c20ca0.watchdog: Watchdog enabled (timeout=3D16 =
sec, nowayout=3D0)<br>
=C2=A0 console: sunxi-mmc 1c0f000.mmc: Linked as a consumer to regulator.2<=
br>
=C2=A0 console: sunxi-mmc 1c0f000.mmc: Got CD GPIO<br>
=C2=A0 console: ledtrig-cpu: registered to indicate activity on CPUs<br>
=C2=A0 console: hidraw: raw HID events driver (C) Jiri Kosina<br>
=C2=A0 console: usbcore: registered new interface driver usbhid<br>
=C2=A0 console: usbhid: USB HID core driver<br>
=C2=A0 console: Initializing XFRM netlink socket<br>
=C2=A0 console: sunxi-mmc 1c0f000.mmc: initialized, max. request size: 1638=
4 KB<br>
=C2=A0 console: NET: Registered protocol family 10<br>
=C2=A0 console: mmc0: host does not support reading read-only switch, assum=
ing write-enable<br>
=C2=A0 console: mmc0: Problem switching card into high-speed mode!<br>
=C2=A0 console: mmc0: new SD card at address 4567<br>
=C2=A0 console: mmcblk0: mmc0:4567 QEMU! 60.0 MiB<br>
=C2=A0 [...]<br>
=C2=A0 console: EXT4-fs (mmcblk0): mounting ext2 file system using the ext4=
 subsystem<br>
=C2=A0 console: EXT4-fs (mmcblk0): mounted filesystem without journal. Opts=
: (null)<br>
=C2=A0 console: VFS: Mounted root (ext2 filesystem) on device 179:0.<br>
=C2=A0 console: Run /sbin/init as init process<br>
=C2=A0 console: EXT4-fs (mmcblk0): re-mounted. Opts: block_validity,barrier=
,user_xattr,acl<br>
=C2=A0 console: Starting syslogd: OK<br>
=C2=A0 console: Starting klogd: OK<br>
=C2=A0 console: Populating /dev using udev: udevd[203]: starting version 3.=
2.7<br>
=C2=A0 console: /bin/sh: can&#39;t access tty; job control turned off<br>
=C2=A0 console: cat /proc/partitions<br>
=C2=A0 console: / # cat /proc/partitions<br>
=C2=A0 console: major minor=C2=A0 #blocks=C2=A0 name<br>
=C2=A0 console: 1=C2=A0 =C2=A0 =C2=A0 =C2=A0 0=C2=A0 =C2=A0 =C2=A0 =C2=A040=
96 ram0<br>
=C2=A0 console: 1=C2=A0 =C2=A0 =C2=A0 =C2=A0 1=C2=A0 =C2=A0 =C2=A0 =C2=A040=
96 ram1<br>
=C2=A0 console: 1=C2=A0 =C2=A0 =C2=A0 =C2=A0 2=C2=A0 =C2=A0 =C2=A0 =C2=A040=
96 ram2<br>
=C2=A0 console: 1=C2=A0 =C2=A0 =C2=A0 =C2=A0 3=C2=A0 =C2=A0 =C2=A0 =C2=A040=
96 ram3<br>
=C2=A0 console: 179=C2=A0 =C2=A0 =C2=A0 =C2=A0 0=C2=A0 =C2=A0 =C2=A0 61440 =
mmcblk0<br>
=C2=A0 console: reboot<br>
=C2=A0 console: / # reboot<br>
=C2=A0 console: umount: devtmpfs busy - remounted read-only<br>
=C2=A0 console: EXT4-fs (mmcblk0): re-mounted. Opts: (null)<br>
=C2=A0 console: The system is going down NOW!<br>
=C2=A0 console: Sent SIGTERM to all processes<br>
=C2=A0 console: Sent SIGKILL to all processes<br>
=C2=A0 console: Requesting system reboot<br>
=C2=A0 console: reboot: Restarting system<br>
=C2=A0 JOB TIME=C2=A0 =C2=A0: 68.64 s<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
---<br>
=C2=A0tests/acceptance/boot_linux_console.py | 42 +++++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 42 insertions(+)<br>
<br>
diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot=
_linux_console.py<br>
index daabd47404..8179b45910 100644<br>
--- a/tests/acceptance/boot_linux_console.py<br>
+++ b/tests/acceptance/boot_linux_console.py<br>
@@ -478,6 +478,48 @@ class BootLinuxConsole(Test):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exec_command_and_wait_for_pattern(self, &=
#39;reboot&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;reboot: Restarting system&#39;)<br>
<br>
+=C2=A0 =C2=A0 def test_arm_orangepi_sd(self):<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rootfs_url =3D (&#39;<a href=3D"http://storage=
.kernelci.org/images/rootfs/buildroot/" rel=3D"noreferrer" target=3D"_blank=
">http://storage.kernelci.org/images/rootfs/buildroot/</a>&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &#39;kci-2019.02/armel/base/rootfs.ext2.xz&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rootfs_hash =3D &#39;692510cb625efda31640d1de0=
a8d60e26040f061&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rootfs_path_xz =3D self.fetch_asset(rootfs_url=
, asset_hash=3Drootfs_hash)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rootfs_path =3D os.path.join(self.workdir, &#3=
9;rootfs.cpio&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 archive.lzma_uncompress(rootfs_path_xz, rootfs=
_path)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.set_machine(&#39;orangepi-pc&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.set_console()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_command_line =3D (self.KERNEL_COMMON_CO=
MMAND_LINE +<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;console=3DttyS0,115200 &#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;root=3D/dev/mmcblk0 rootwait rw =
&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;panic=3D-1 noreboot&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.add_args(&#39;-kernel&#39;, kernel_pat=
h,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-dtb&#39;, dtb_path,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-drive&#39;, &#39;file=3D&#39; + rootfs_path + &#39;,=
if=3Dsd,format=3Draw&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-append&#39;, kernel_command_line,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-no-reboot&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.launch()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 shell_ready =3D &quot;/bin/sh: can&#39;t acces=
s tty; job control turned off&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wait_for_console_pattern(shell_ready)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self, &#39;c=
at /proc/cpuinfo&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &#39;Allwinner sun8i Family&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self, &#39;c=
at /proc/partitions&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &#39;mmcblk0&#39;)<br>
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
div>

--000000000000aee4c7059a01095f--

