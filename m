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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C778C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 21:21:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 132CD2146E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 21:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2TmBwhJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 132CD2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihgkx-0004QV-7M
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 16:21:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ihgkC-0003on-Ik
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:20:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ihgk6-0008IS-3R
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:20:29 -0500
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:32812)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1ihgk4-0008FG-8t; Wed, 18 Dec 2019 16:20:24 -0500
Received: by mail-io1-xd43.google.com with SMTP id z8so3544132ioh.0;
 Wed, 18 Dec 2019 13:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wiaxJVCuSNQJMhOQMKQIbuNI/IgcNMi1SSwkGVjCgKE=;
 b=A2TmBwhJbdSS7XeABnir6EeXy+cEKIX/OERrZokc2j1UINXvRkqj9JBF7V+Ol17KPt
 QT8HBBTiq+UJrBdmxW5YUyIlJpw9/loh/sduyHwclcQ6VbkeD6UlTqXRyY9gJ8VkVztD
 9XgYaw3jiyntgKK3RZpl8kzD2XWJveJuDLDk6fWpE8jGAdQkih2wGC6cndbJL6gcv7Ev
 QPLCCgJcV6W4fIkKBtXs6/XZlbCpPqopz9e+l0JJdwi/0LwAQT0wRo7ItzIA2t+bUIDE
 mwN4hUQa7A9to1TMfaJ2wTQhN09/Sj7KXXilDn5WA0WkiCCTdie/kz3pm9BSGlNShyEZ
 kIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wiaxJVCuSNQJMhOQMKQIbuNI/IgcNMi1SSwkGVjCgKE=;
 b=NEiZ6ElNGu1u5/SKzyFgfECKxO4ufB7Ld4lwx/pViTiV84ItB3w7CCyM2QEABuNIdI
 zkruwngE+ZuGgtpXwETUzVM3AV5trvY+45Y4br8zzkmvEy0NBKtL3jYAVnkKqOZZRLve
 H8sEeCRWsSeoMXeyfA4ldFhbFow54smEd8Vmd9KMA1EHjpaLmWs4djkTxCeXZuK6+lqO
 aZUymWEpTwNP7qlMt5vC6zP7x2/owrm19PieciRIqebki0w6/+f5EqosYQmFfooZZLP3
 Ql3qfq0rOOuJvVCGY+6hETrkwkrW7NEl0eAQHMv6ypuiicLjohuVjaPXEWZmhM4Yivyr
 0yLw==
X-Gm-Message-State: APjAAAXt008a7aRfuIGRAk7Scpk7EYi9mReyYVljdN6JiGpNXR4WJf7S
 ATkCuJlS8LG6gnzJhwtfRNigXW8r8EENI1lqmXc=
X-Google-Smtp-Source: APXvYqyNzw0K/A6R8YcBkWDBWHGY8ZYQtiho3Ae4SHcNyav8OUVBuySIcxTLqHJD8BHPOlBEX1WiF6YS36eGnDqBlWA=
X-Received: by 2002:a6b:6f01:: with SMTP id k1mr3371292ioc.28.1576704021596;
 Wed, 18 Dec 2019 13:20:21 -0800 (PST)
MIME-Version: 1.0
References: <20191217182730.943-1-f4bug@amsat.org>
 <20191217182730.943-2-f4bug@amsat.org>
In-Reply-To: <20191217182730.943-2-f4bug@amsat.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Wed, 18 Dec 2019 22:20:10 +0100
Message-ID: <CAPan3WpCX5RU03+-7QPZ4evTUzaU4BDEsTU4n4M3f+0eTEAhwQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] tests/boot_linux_console: Add a quick test for the
 OrangePi PC board
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="0000000000001f929d059a010365"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
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

--0000000000001f929d059a010365
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Philippe,

Super!! Fantastic, now we can automatically test the H3 based boards
and use that to verify they keep working as expected when changing the code=
.

Great, I'm going to use these tests also from now on (previously I had some
small
bash scripts).

This quick test is working fine for me, so:

Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>

Regards,
Niek



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
> If ARM is a target being built, "make check-acceptance" will
> automatically include this test by the use of the "arch:arm" tags.
>
> Alternatively, this test can be run using:
>
>   $ make check-venv
>   $ ./tests/venv/bin/avocado --show=3Dconsole,app run -t machine:orangepi=
-pc
> tests/acceptance/boot_linux_console.py
>   JOB ID     : 2e4d15eceb13c33672af406f08171e6e9de1414a
>   JOB LOG    : ~/job-results/job-2019-12-17T05.46-2e4d15e/job.log
>   (1/1)
> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi=
:
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
>   console: Memory policy: Data cache writealloc
>   console: OF: reserved mem: failed to allocate memory for node
> 'cma@4a000000'
>   console: cma: Failed to reserve 128 MiB
>   console: psci: probing for conduit method from DT.
>   console: psci: PSCIv0.2 detected in firmware.
>   console: psci: Using standard PSCI v0.2 function IDs
>   console: psci: Trusted OS migration not required
>   console: random: get_random_bytes called from start_kernel+0x8d/0x3c2
> with crng_init=3D0
>   console: percpu: Embedded 18 pages/cpu @(ptrval) s41228 r8192 d24308
> u73728
>   console: Built 1 zonelists, mobility grouping on.  Total pages: 32480
>   console: Kernel command line: printk.time=3D0 console=3DttyS0,115200
>   PASS (8.59 s)
>   JOB TIME   : 8.81 s
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/acceptance/boot_linux_console.py | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/tests/acceptance/boot_linux_console.py
> b/tests/acceptance/boot_linux_console.py
> index 7e41cebd47..820239e439 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -411,6 +411,32 @@ class BootLinuxConsole(Test):
>          self.wait_for_console_pattern('Boot successful.')
>          # TODO user command, for now the uart is stuck
>
> +    def test_arm_orangepi(self):
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
> +
> +        self.vm.set_machine('orangepi-pc')
> +        self.vm.set_console()
> +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> +                               'console=3DttyS0,115200n8 '
> +                               'earlycon=3Duart,mmio32,0x1c28000')
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-dtb', dtb_path,
> +                         '-append', kernel_command_line)
> +        self.vm.launch()
> +        console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
> +        self.wait_for_console_pattern(console_pattern)
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

--0000000000001f929d059a010365
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hey Philippe,</div><div><br></div><div>Super!! Fantas=
tic, now we can automatically test the H3 based boards<br></div><div>and us=
e that to verify they keep working as expected when changing the code.</div=
><div><br></div><div>Great, I&#39;m going to use these tests also from now =
on (previously I had some small</div><div>bash scripts).<br></div><div><br>=
</div><div>This quick test is working fine for me, so:</div><div><br></div>=
<div>Tested-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.=
com">nieklinnenbank@gmail.com</a>&gt;<br></div><div><br></div><div>Regards,=
</div><div>Niek<br></div><div><br></div><div><br></div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec 17, 2019=
 at 7:27 PM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.o=
rg">f4bug@amsat.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">This test boots a Linux kernel on a OrangePi PC board an=
d verify<br>
the serial output is working.<br>
<br>
The kernel image and DeviceTree blob are built by the Raspbian<br>
project (based on Debian):<br>
<a href=3D"https://www.raspbian.org/RaspbianImages" rel=3D"noreferrer" targ=
et=3D"_blank">https://www.raspbian.org/RaspbianImages</a><br>
<br>
If ARM is a target being built, &quot;make check-acceptance&quot; will<br>
automatically include this test by the use of the &quot;arch:arm&quot; tags=
.<br>
<br>
Alternatively, this test can be run using:<br>
<br>
=C2=A0 $ make check-venv<br>
=C2=A0 $ ./tests/venv/bin/avocado --show=3Dconsole,app run -t machine:orang=
epi-pc tests/acceptance/boot_linux_console.py<br>
=C2=A0 JOB ID=C2=A0 =C2=A0 =C2=A0: 2e4d15eceb13c33672af406f08171e6e9de1414a=
<br>
=C2=A0 JOB LOG=C2=A0 =C2=A0 : ~/job-results/job-2019-12-17T05.46-2e4d15e/jo=
b.log<br>
=C2=A0 (1/1) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_a=
rm_orangepi:<br>
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
=C2=A0 console: Memory policy: Data cache writealloc<br>
=C2=A0 console: OF: reserved mem: failed to allocate memory for node &#39;c=
ma@4a000000&#39;<br>
=C2=A0 console: cma: Failed to reserve 128 MiB<br>
=C2=A0 console: psci: probing for conduit method from DT.<br>
=C2=A0 console: psci: PSCIv0.2 detected in firmware.<br>
=C2=A0 console: psci: Using standard PSCI v0.2 function IDs<br>
=C2=A0 console: psci: Trusted OS migration not required<br>
=C2=A0 console: random: get_random_bytes called from start_kernel+0x8d/0x3c=
2 with crng_init=3D0<br>
=C2=A0 console: percpu: Embedded 18 pages/cpu @(ptrval) s41228 r8192 d24308=
 u73728<br>
=C2=A0 console: Built 1 zonelists, mobility grouping on.=C2=A0 Total pages:=
 32480<br>
=C2=A0 console: Kernel command line: printk.time=3D0 console=3DttyS0,115200=
<br>
=C2=A0 PASS (8.59 s)<br>
=C2=A0 JOB TIME=C2=A0 =C2=A0: 8.81 s<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
---<br>
=C2=A0tests/acceptance/boot_linux_console.py | 26 +++++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 26 insertions(+)<br>
<br>
diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot=
_linux_console.py<br>
index 7e41cebd47..820239e439 100644<br>
--- a/tests/acceptance/boot_linux_console.py<br>
+++ b/tests/acceptance/boot_linux_console.py<br>
@@ -411,6 +411,32 @@ class BootLinuxConsole(Test):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.wait_for_console_pattern(&#39;Boot s=
uccessful.&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# TODO user command, for now the uart is =
stuck<br>
<br>
+=C2=A0 =C2=A0 def test_arm_orangepi(self):<br>
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
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.set_machine(&#39;orangepi-pc&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.set_console()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_command_line =3D (self.KERNEL_COMMON_CO=
MMAND_LINE +<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;console=3DttyS0,115200n8 &#39;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;earlycon=3Duart,mmio32,0x1c28000=
&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.add_args(&#39;-kernel&#39;, kernel_pat=
h,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-dtb&#39;, dtb_path,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-append&#39;, kernel_command_line)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.launch()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 console_pattern =3D &#39;Kernel command line: =
%s&#39; % kernel_command_line<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wait_for_console_pattern(console_pattern)=
<br>
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

--0000000000001f929d059a010365--

