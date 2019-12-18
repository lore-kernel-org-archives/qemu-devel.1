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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D70C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 21:27:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3A2E2176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 21:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6aQ1bwW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A2E2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihgrD-00025q-TY
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 16:27:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ihgpr-0000fX-Mn
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:26:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ihgpo-0007QS-HX
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:26:23 -0500
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:41592)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1ihgpo-0007Pi-B2; Wed, 18 Dec 2019 16:26:20 -0500
Received: by mail-il1-x142.google.com with SMTP id f10so2954841ils.8;
 Wed, 18 Dec 2019 13:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hjzXs3cozJZpZgcBx2emjmDsMBr6Ew/+q/IvgzsBb8w=;
 b=V6aQ1bwWnawCdghS0qJqu026jJFFdUR3TRnJQvEoIY7rG5QyY+lsNHTYDJWRARCVnw
 r8Q9DdWTBbBsFWGHz+RNZqD89mC5wVQCACHO5CXB51ACjv1S7i8GLM8g0SdAxyJTJIr3
 DqMcfw1gbsb3obBHf2FbeHOMCZ7ptcbBfvVRGTHyspQoaSNVwU7/CsnEdu+xepW7XwW1
 VkLGxQr0DC7FlCqk/K0v9gi33M2+1lwNZ1JfmiHbGLACPB7k5HdlCUl+EHSWKgJbjL2p
 TP6x+8bsqzj4zD3Utfc5sWs0NT4OoBIa7Yh/uGQoA1e9Rrg9LkqlPZJrphma17LJiWpO
 IJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hjzXs3cozJZpZgcBx2emjmDsMBr6Ew/+q/IvgzsBb8w=;
 b=jRA92cD25CRwqxeEoGbtAiHlsq2/viKxc/yHlHjFaH/Hrd2bEQYQiIp7IrC/fy5D6z
 40yZwVWfM99dPEYgH4C7XDX3VgxFqwjWyPdzXrYNSegIkcTzmJry8haIML4Mbntlo+9H
 gdgPUbW0O+kKXnVBeLfPQ41WS4YRXVxuL9CHcR7jO4uUWT2t1ldeguLBj/Gt1P4snpqM
 GA/ilLw6YiafBlde0bg/nG/VmhQP2T8+4moCT0wz1mvlo2TWu2oXyiJ4uCj6myc/taxC
 S2Dv+M9MYKhBc2iIDXEeowat/FiwWOGyNf8jmfd0EhdUGK3ggxqGgQuDOfFFZs4+s9wC
 Hetg==
X-Gm-Message-State: APjAAAWe3CNQ8gZw9tswRNevSde9uUGiGB8xzDgmiRFqtPOZcLto0M+o
 MC2LG9lWcbcAbY27YDlBzZXxx4Bpe/BLcS2rAXg=
X-Google-Smtp-Source: APXvYqwKSEtndlV3DBntk3ds6pQdl1TR7iyuSNThsYyKUi/G5tgzHbmUZWwMei52oy37D8A9rJcHTX3pFuoTG5kwxU0=
X-Received: by 2002:a92:a103:: with SMTP id v3mr3394346ili.265.1576704379474; 
 Wed, 18 Dec 2019 13:26:19 -0800 (PST)
MIME-Version: 1.0
References: <20191217182730.943-1-f4bug@amsat.org>
 <20191217182730.943-6-f4bug@amsat.org>
In-Reply-To: <20191217182730.943-6-f4bug@amsat.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Wed, 18 Dec 2019 22:26:08 +0100
Message-ID: <CAPan3WrgL-ULAMQPTHj7zbNMS_xaTuNprp1W4GzhryQbMcPQOA@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] tests/boot_linux_console: Add a SLOW test booting
 Ubuntu on OrangePi PC
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000745858059a0118b3"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::142
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

--000000000000745858059a0118b3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

This test has some problems on my host (Ubuntu 18.04.3 LTS, avocado 73.0,
python 3.6.9):

 (4/4) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_ora=
ngepi_bionic:
ERROR: Input format not supported by decoder (3.25 s)
RESULTS    : PASS 3 | ERROR 1 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0
| CANCEL 0
JOB TIME   : 46.22 s

I suspect it didn't download the image correctly.

Regards,
Niek

On Tue, Dec 17, 2019 at 7:27 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> This test boots Ubuntu Bionic on a OrangePi PC board.
>
> As it requires 1GB of storage, and is slow, this test is disabled
> on automatic CI testing.
>
> It is useful for workstation testing. Currently Avocado timeouts too
> quickly, so we can't run userland commands.
>
> The kernel image and DeviceTree blob are built by the Raspbian
> project (based on Debian):
> https://www.raspbian.org/RaspbianImages
>
> The Ubuntu image is downloaded from:
> https://dl.armbian.com/orangepipc/Bionic_current
>
> This test can be run using:
>
>   $ AVOCADO_ALLOW_LARGE_STORAGE=3Dyes \
>     avocado --show=3Dapp,console run -t machine:orangepi-pc \
>       tests/acceptance/boot_linux_console.py
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
>   console: sunxi-mmc 1c0f000.mmc: initialized, max. request size: 16384 K=
B
>   console: NET: Registered protocol family 10
>   console: mmc0: host does not support reading read-only switch, assuming
> write-enable
>   console: mmc0: Problem switching card into high-speed mode!
>   console: mmc0: new SD card at address 4567
>   console: mmcblk0: mmc0:4567 QEMU! 932 MiB
>   console: Segment Routing with IPv6
>   console: NET: Registered protocol family 17
>   console: NET: Registered protocol family 15
>   console: bridge: filtering via arp/ip/ip6tables is no longer available
> by default. Update your scripts to load br_netfilter if you need this.
>   console: 8021q: 802.1Q VLAN Support v1.8
>   console: Key type dns_resolver registered
>   console: Registering SWP/SWPB emulation handler
>   console: mmcblk0: p1
>   [...]
>   console: Freeing unused kernel memory: 1024K
>   console: Run /sbin/init as init process
>   console: random: fast init done
>   console: systemd[1]: System time before build time, advancing clock.
>   console: systemd[1]: systemd 237 running in system mode. (+PAM +AUDIT
> +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT
> +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2
> default-hierarchy=3Dhybrid)
>   console: systemd[1]: Detected architecture arm.
>   console: Welcome to Ubuntu 18.04.3 LTS!
>   console: systemd[1]: Set hostname to <orangepipc>.
>   console: random: systemd: uninitialized urandom read (16 bytes read)
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> RFC because this is not the definitive test, but it is helpful so
> for for testing Niek work.
> ---
>  tests/acceptance/boot_linux_console.py | 41 ++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/tests/acceptance/boot_linux_console.py
> b/tests/acceptance/boot_linux_console.py
> index 8179b45910..663290e0c7 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -520,6 +520,47 @@ class BootLinuxConsole(Test):
>          exec_command_and_wait_for_pattern(self, 'reboot',
>                                                  'reboot: Restarting
> system')
>
> +    @skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage
> limited')
> +    def test_arm_orangepi_bionic(self):
> +        """
> +        :avocado: tags=3Darch:arm
> +        :avocado: tags=3Dmachine:orangepi-pc
> +        """
> +        # This test download a 196MB compressed image and expand it to
> 932MB...
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
> +        image_url =3D ('https://dl.armbian.com/orangepipc/archive/'
> +                     'Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.7z=
')
> +        image_hash =3D '196a8ffb72b0123d92cea4a070894813d305c71e'
> +        image_path_xz =3D self.fetch_asset(image_url, asset_hash=3Dimage=
_hash)
> +        image_name =3D 'Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.=
img'
> +        image_path =3D os.path.join(self.workdir, image_name)
> +        archive.lzma_uncompress(image_path_xz, image_path)
> +
> +        self.vm.set_machine('orangepi-pc')
> +        self.vm.set_console()
> +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> +                               'console=3DttyS0,115200 '
> +                               'root=3D/dev/mmcblk0p1 rootwait rw '
> +                               'systemd.mask=3Ddev-ttyS0.device '
> +                               'systemd.mask=3Darmbian-zram-config.servi=
ce '
> +                               'systemd.mask=3Darmbian-ramlog.service')
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-dtb', dtb_path,
> +                         '-drive', 'file=3D' + image_path +
> ',if=3Dsd,format=3Draw',
> +                         '-append', kernel_command_line,
> +                         '-nic', 'user',
> +                         '-no-reboot')
> +        self.vm.launch()
> +        self.wait_for_console_pattern('Welcome to Ubuntu 18.04.3 LTS!')
> +        self.wait_for_console_pattern('Started Armbian filesystem
> resize.')
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

--000000000000745858059a0118b3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Philippe,</div><div><br></div><div>This test has s=
ome problems on my host (Ubuntu 18.04.3 LTS, avocado 73.0, python 3.6.9):<b=
r><pre> (4/4) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_=
arm_orangepi_bionic: ERROR: Input format not supported by decoder (3.25 s)
RESULTS    : PASS 3 | ERROR 1 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CA=
NCEL 0
JOB TIME   : 46.22 s
</pre></div><div>I suspect it didn&#39;t download the image correctly.</div=
><div><br></div><div>Regards,</div><div>Niek<br></div><div><br></div><div c=
lass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec 17, =
2019 at 7:27 PM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@ams=
at.org">f4bug@amsat.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">This test boots Ubuntu Bionic on a OrangePi PC board=
.<br>
<br>
As it requires 1GB of storage, and is slow, this test is disabled<br>
on automatic CI testing.<br>
<br>
It is useful for workstation testing. Currently Avocado timeouts too<br>
quickly, so we can&#39;t run userland commands.<br>
<br>
The kernel image and DeviceTree blob are built by the Raspbian<br>
project (based on Debian):<br>
<a href=3D"https://www.raspbian.org/RaspbianImages" rel=3D"noreferrer" targ=
et=3D"_blank">https://www.raspbian.org/RaspbianImages</a><br>
<br>
The Ubuntu image is downloaded from:<br>
<a href=3D"https://dl.armbian.com/orangepipc/Bionic_current" rel=3D"norefer=
rer" target=3D"_blank">https://dl.armbian.com/orangepipc/Bionic_current</a>=
<br>
<br>
This test can be run using:<br>
<br>
=C2=A0 $ AVOCADO_ALLOW_LARGE_STORAGE=3Dyes \<br>
=C2=A0 =C2=A0 avocado --show=3Dapp,console run -t machine:orangepi-pc \<br>
=C2=A0 =C2=A0 =C2=A0 tests/acceptance/boot_linux_console.py<br>
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
=C2=A0 console: sunxi-mmc 1c0f000.mmc: initialized, max. request size: 1638=
4 KB<br>
=C2=A0 console: NET: Registered protocol family 10<br>
=C2=A0 console: mmc0: host does not support reading read-only switch, assum=
ing write-enable<br>
=C2=A0 console: mmc0: Problem switching card into high-speed mode!<br>
=C2=A0 console: mmc0: new SD card at address 4567<br>
=C2=A0 console: mmcblk0: mmc0:4567 QEMU! 932 MiB<br>
=C2=A0 console: Segment Routing with IPv6<br>
=C2=A0 console: NET: Registered protocol family 17<br>
=C2=A0 console: NET: Registered protocol family 15<br>
=C2=A0 console: bridge: filtering via arp/ip/ip6tables is no longer availab=
le by default. Update your scripts to load br_netfilter if you need this.<b=
r>
=C2=A0 console: 8021q: 802.1Q VLAN Support v1.8<br>
=C2=A0 console: Key type dns_resolver registered<br>
=C2=A0 console: Registering SWP/SWPB emulation handler<br>
=C2=A0 console: mmcblk0: p1<br>
=C2=A0 [...]<br>
=C2=A0 console: Freeing unused kernel memory: 1024K<br>
=C2=A0 console: Run /sbin/init as init process<br>
=C2=A0 console: random: fast init done<br>
=C2=A0 console: systemd[1]: System time before build time, advancing clock.=
<br>
=C2=A0 console: systemd[1]: systemd 237 running in system mode. (+PAM +AUDI=
T +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GN=
UTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 defaul=
t-hierarchy=3Dhybrid)<br>
=C2=A0 console: systemd[1]: Detected architecture arm.<br>
=C2=A0 console: Welcome to Ubuntu 18.04.3 LTS!<br>
=C2=A0 console: systemd[1]: Set hostname to &lt;orangepipc&gt;.<br>
=C2=A0 console: random: systemd: uninitialized urandom read (16 bytes read)=
<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
---<br>
RFC because this is not the definitive test, but it is helpful so<br>
for for testing Niek work.<br>
---<br>
=C2=A0tests/acceptance/boot_linux_console.py | 41 +++++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 41 insertions(+)<br>
<br>
diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot=
_linux_console.py<br>
index 8179b45910..663290e0c7 100644<br>
--- a/tests/acceptance/boot_linux_console.py<br>
+++ b/tests/acceptance/boot_linux_console.py<br>
@@ -520,6 +520,47 @@ class BootLinuxConsole(Test):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exec_command_and_wait_for_pattern(self, &=
#39;reboot&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;reboot: Restarting system&#39;)<br>
<br>
+=C2=A0 =C2=A0 @skipUnless(os.getenv(&#39;AVOCADO_ALLOW_LARGE_STORAGE&#39;)=
, &#39;storage limited&#39;)<br>
+=C2=A0 =C2=A0 def test_arm_orangepi_bionic(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Darch:arm<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dmachine:orangepi-pc<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # This test download a 196MB compressed image =
and expand it to 932MB...<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_url =3D (&#39;<a href=3D"https://dl.armb=
ian.com/orangepipc/archive/" rel=3D"noreferrer" target=3D"_blank">https://d=
l.armbian.com/orangepipc/archive/</a>&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&#39;Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.7z&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_hash =3D &#39;196a8ffb72b0123d92cea4a070=
894813d305c71e&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_path_xz =3D self.fetch_asset(image_url, =
asset_hash=3Dimage_hash)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_name =3D &#39;Armbian_19.11.3_Orangepipc=
_bionic_current_5.3.9.img&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_path =3D os.path.join(self.workdir, imag=
e_name)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 archive.lzma_uncompress(image_path_xz, image_p=
ath)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.set_machine(&#39;orangepi-pc&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.set_console()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_command_line =3D (self.KERNEL_COMMON_CO=
MMAND_LINE +<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;console=3DttyS0,115200 &#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;root=3D/dev/mmcblk0p1 rootwait r=
w &#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;systemd.mask=3Ddev-ttyS0.device =
&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;systemd.mask=3Darmbian-zram-conf=
ig.service &#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;systemd.mask=3Darmbian-ramlog.se=
rvice&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.add_args(&#39;-kernel&#39;, kernel_pat=
h,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-dtb&#39;, dtb_path,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-drive&#39;, &#39;file=3D&#39; + image_path + &#39;,i=
f=3Dsd,format=3Draw&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-append&#39;, kernel_command_line,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-nic&#39;, &#39;user&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-no-reboot&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.launch()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wait_for_console_pattern(&#39;Welcome to =
Ubuntu 18.04.3 LTS!&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wait_for_console_pattern(&#39;Started Arm=
bian filesystem resize.&#39;)<br>
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

--000000000000745858059a0118b3--

