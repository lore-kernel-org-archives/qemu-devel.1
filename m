Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA688C32771
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 23:05:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8000B24656
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 23:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNJdoK8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8000B24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isx9U-0001nH-Lo
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 18:05:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1isx8h-0001GB-BX
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 18:04:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1isx8f-0007Xw-BG
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 18:04:23 -0500
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:46314)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1isx8e-0007Wx-Oe; Sat, 18 Jan 2020 18:04:21 -0500
Received: by mail-il1-x141.google.com with SMTP id t17so24331032ilm.13;
 Sat, 18 Jan 2020 15:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bAuxKRd+MEfvHonNVyrC8gyyQ28KNWr8dj+5bsmwGjE=;
 b=nNJdoK8z1wb2bgulAUn4wyU8CcyL5xj34pqR0l+bWXea9g2OGaZKluvnQGCrAPozXs
 yq2H+IBXGlqeqKC/Zh1fgwTVKhzvZa4Z9grugxn8yh5mAQ3eRKr489R0rN4OhuoNHCoX
 2AduMN+3D9J6L/QR950H3MkMuS8uVhlr9g3LfDDy1deihXLTpcrs6NCkYSeOEYBgxJKg
 Vlyj9i2ODj5qNDfIGidDwKncw4AhKioy//Z0HKcdSZURwuGJPUzYTAJUico49hCqLASh
 1cQWZABByFPVzrAv4ZyGUtkHkoKpra7IpV2ERVt6JPrgIJ8wIr2csQRlhS1bz3utHrf2
 Ep/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bAuxKRd+MEfvHonNVyrC8gyyQ28KNWr8dj+5bsmwGjE=;
 b=rEnersgmvWxUjQi9WchZ6HClwZSBkKOuikbwwFZ5EKE9r0itb194toknJoKZ2haMnD
 Mxd122obmHTaRA3YU33J+0vDn21Qh83FuUFqx8S7bU3vifx4cdbH/v+dfTFf/smg5Gbp
 MgWvSShN/U/1dTVwfSvVqh+FCqZcxDAc5R+LNW6OWFxPSF4dKsVebfOEKXjBHD1NfChj
 X3FnXO7EhHPwSVjAUu1GXLBXD12NHTUrzE61e6NcaYf7I7ROJ9W4ZXmAFaNvM0axshpt
 7hc+oWH1dfQNSsriRFRBz/7add+dAGuY9NtIFjIwLGjr5MSCFm0lN1h+wvRciYFzKqML
 oDTQ==
X-Gm-Message-State: APjAAAUepgTl1S1oAbJeDq7BFEwxiSXSLB+T4epfcS8B0ytCfd0GnDBw
 1VH8dOrOgIAr7HkoYSELB7238M946AK9PNyNoGk=
X-Google-Smtp-Source: APXvYqxcHloFxyHqy8w71qjoss+NuWPOT91xRIpBXDAqcGo1/fFXbtHGSN0wagCa5oHhdrs9mposQr+uvCN6fwg+Sds=
X-Received: by 2002:a92:c647:: with SMTP id 7mr4819374ill.28.1579388659289;
 Sat, 18 Jan 2020 15:04:19 -0800 (PST)
MIME-Version: 1.0
References: <20200108200020.4745-1-nieklinnenbank@gmail.com>
 <20200108200020.4745-14-nieklinnenbank@gmail.com>
 <5b20d022-f3f8-4913-b157-73f42808a4c0@redhat.com>
In-Reply-To: <5b20d022-f3f8-4913-b157-73f42808a4c0@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Sun, 19 Jan 2020 00:04:08 +0100
Message-ID: <CAPan3Wq854B3K7S4Cdk4A9smpmQdtf+dybs4Z-RxzXHAFAU7Vw@mail.gmail.com>
Subject: Re: [PATCH v3 13/17] tests/boot_linux_console: Add a quick test for
 the OrangePi PC board
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ffd7d0059c721374"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::141
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
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ffd7d0059c721374
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 18, 2020 at 12:22 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com>
wrote:

> On 1/8/20 9:00 PM, Niek Linnenbank wrote:
> > From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >
> > This test boots a Linux kernel on a OrangePi PC board and verify
> > the serial output is working.
> >
> > The kernel image and DeviceTree blob are built by the Armbian
> > project (based on Debian):
> > https://www.armbian.com/orange-pi-pc/
> >
> > If ARM is a target being built, "make check-acceptance" will
> > automatically include this test by the use of the "arch:arm" tags.
> >
> > Alternatively, this test can be run using:
> >
> >    $ make check-venv
> >    $ ./tests/venv/bin/avocado --show=3Dconsole,app run -t
> machine:orangepi-pc tests/acceptance/boot_linux_console.py
> >    JOB ID     : 2e4d15eceb13c33672af406f08171e6e9de1414a
> >    JOB LOG    : ~/job-results/job-2019-12-17T05.46-2e4d15e/job.log
> >    (1/1)
> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi=
:
> >    console: Uncompressing Linux... done, booting the kernel.
> >    console: Booting Linux on physical CPU 0x0
> >    console: Linux version 4.20.7-sunxi (root@armbian.com) (gcc version
> 7.2.1 20171011 (Linaro GCC 7.2-2017.11)) #5.75 SMP Fri Feb 8 09:02:10 CET
> 2019
> >    console: CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7),
> cr=3D50c5387d
> >    console: CPU: div instructions available: patching division code
> >    console: CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
> instruction cache
> >    console: OF: fdt: Machine model: Xunlong Orange Pi PC
> >    console: Memory policy: Data cache writealloc
> >    console: OF: reserved mem: failed to allocate memory for node
> 'cma@4a000000'
> >    console: cma: Failed to reserve 128 MiB
> >    console: psci: probing for conduit method from DT.
> >    console: psci: PSCIv0.2 detected in firmware.
> >    console: psci: Using standard PSCI v0.2 function IDs
> >    console: psci: Trusted OS migration not required
> >    console: random: get_random_bytes called from start_kernel+0x8d/0x3c=
2
> with crng_init=3D0
> >    console: percpu: Embedded 18 pages/cpu @(ptrval) s41228 r8192 d24308
> u73728
> >    console: Built 1 zonelists, mobility grouping on.  Total pages: 3248=
0
> >    console: Kernel command line: printk.time=3D0 console=3DttyS0,115200
> >    PASS (8.59 s)
> >    JOB TIME   : 8.81 s
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > [NL: rename in commit message Raspbian to Armbian]
> > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> > ---
> >   tests/acceptance/boot_linux_console.py | 26 +++++++++++++++++++++++++=
+
> >   1 file changed, 26 insertions(+)
> >
> > diff --git a/tests/acceptance/boot_linux_console.py
> b/tests/acceptance/boot_linux_console.py
> > index 9c6aa2040a..b58308d724 100644
> > --- a/tests/acceptance/boot_linux_console.py
> > +++ b/tests/acceptance/boot_linux_console.py
> > @@ -400,6 +400,32 @@ class BootLinuxConsole(Test):
> >           self.wait_for_console_pattern('Boot successful.')
> >           # TODO user command, for now the uart is stuck
> >
> > +    def test_arm_orangepi(self):
> > +        """
> > +        :avocado: tags=3Darch:arm
> > +        :avocado: tags=3Dmachine:orangepi-pc
> > +        """
> > +        deb_url =3D ('https://apt.armbian.com/pool/main/l/'
> > +
>  'linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.deb')
> > +        deb_hash =3D '1334c29c44d984ffa05ed10de8c3361f33d78315'
> > +        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> > +        kernel_path =3D self.extract_from_deb(deb_path,
> > +
> '/boot/vmlinuz-4.20.7-sunxi')
> > +        dtb_path =3D
> '/usr/lib/linux-image-dev-sunxi/sun8i-h3-orangepi-pc.dtb'
> > +        dtb_path =3D self.extract_from_deb(deb_path, dtb_path)
> > +
> > +        self.vm.set_machine('orangepi-pc')
>
> Please remove the vm.set_machine() calls.
>

OK, I'll also remove them vm.set_machine() calls in the other 3 patches.


>
> > +        self.vm.set_console()
> > +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> > +                               'console=3DttyS0,115200n8 '
> > +                               'earlycon=3Duart,mmio32,0x1c28000')
> > +        self.vm.add_args('-kernel', kernel_path,
> > +                         '-dtb', dtb_path,
> > +                         '-append', kernel_command_line)
> > +        self.vm.launch()
> > +        console_pattern =3D 'Kernel command line: %s' %
> kernel_command_line
> > +        self.wait_for_console_pattern(console_pattern)
> > +
> >       def test_s390x_s390_ccw_virtio(self):
> >           """
> >           :avocado: tags=3Darch:s390x
> >
>
>

--=20
Niek Linnenbank

--000000000000ffd7d0059c721374
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Jan 18, 2020 at 12:22 PM Phil=
ippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">On 1/8/20 9:00 PM, Niek Linnenbank wrote:<br>
&gt; From: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.or=
g" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
&gt; <br>
&gt; This test boots a Linux kernel on a OrangePi PC board and verify<br>
&gt; the serial output is working.<br>
&gt; <br>
&gt; The kernel image and DeviceTree blob are built by the Armbian<br>
&gt; project (based on Debian):<br>
&gt; <a href=3D"https://www.armbian.com/orange-pi-pc/" rel=3D"noreferrer" t=
arget=3D"_blank">https://www.armbian.com/orange-pi-pc/</a><br>
&gt; <br>
&gt; If ARM is a target being built, &quot;make check-acceptance&quot; will=
<br>
&gt; automatically include this test by the use of the &quot;arch:arm&quot;=
 tags.<br>
&gt; <br>
&gt; Alternatively, this test can be run using:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 $ make check-venv<br>
&gt;=C2=A0 =C2=A0 $ ./tests/venv/bin/avocado --show=3Dconsole,app run -t ma=
chine:orangepi-pc tests/acceptance/boot_linux_console.py<br>
&gt;=C2=A0 =C2=A0 JOB ID=C2=A0 =C2=A0 =C2=A0: 2e4d15eceb13c33672af406f08171=
e6e9de1414a<br>
&gt;=C2=A0 =C2=A0 JOB LOG=C2=A0 =C2=A0 : ~/job-results/job-2019-12-17T05.46=
-2e4d15e/job.log<br>
&gt;=C2=A0 =C2=A0 (1/1) tests/acceptance/boot_linux_console.py:BootLinuxCon=
sole.test_arm_orangepi:<br>
&gt;=C2=A0 =C2=A0 console: Uncompressing Linux... done, booting the kernel.=
<br>
&gt;=C2=A0 =C2=A0 console: Booting Linux on physical CPU 0x0<br>
&gt;=C2=A0 =C2=A0 console: Linux version 4.20.7-sunxi (<a href=3D"mailto:ro=
ot@armbian.com" target=3D"_blank">root@armbian.com</a>) (gcc version 7.2.1 =
20171011 (Linaro GCC 7.2-2017.11)) #5.75 SMP Fri Feb 8 09:02:10 CET 2019<br=
>
&gt;=C2=A0 =C2=A0 console: CPU: ARMv7 Processor [410fc075] revision 5 (ARMv=
7), cr=3D50c5387d<br>
&gt;=C2=A0 =C2=A0 console: CPU: div instructions available: patching divisi=
on code<br>
&gt;=C2=A0 =C2=A0 console: CPU: PIPT / VIPT nonaliasing data cache, VIPT al=
iasing instruction cache<br>
&gt;=C2=A0 =C2=A0 console: OF: fdt: Machine model: Xunlong Orange Pi PC<br>
&gt;=C2=A0 =C2=A0 console: Memory policy: Data cache writealloc<br>
&gt;=C2=A0 =C2=A0 console: OF: reserved mem: failed to allocate memory for =
node &#39;cma@4a000000&#39;<br>
&gt;=C2=A0 =C2=A0 console: cma: Failed to reserve 128 MiB<br>
&gt;=C2=A0 =C2=A0 console: psci: probing for conduit method from DT.<br>
&gt;=C2=A0 =C2=A0 console: psci: PSCIv0.2 detected in firmware.<br>
&gt;=C2=A0 =C2=A0 console: psci: Using standard PSCI v0.2 function IDs<br>
&gt;=C2=A0 =C2=A0 console: psci: Trusted OS migration not required<br>
&gt;=C2=A0 =C2=A0 console: random: get_random_bytes called from start_kerne=
l+0x8d/0x3c2 with crng_init=3D0<br>
&gt;=C2=A0 =C2=A0 console: percpu: Embedded 18 pages/cpu @(ptrval) s41228 r=
8192 d24308 u73728<br>
&gt;=C2=A0 =C2=A0 console: Built 1 zonelists, mobility grouping on.=C2=A0 T=
otal pages: 32480<br>
&gt;=C2=A0 =C2=A0 console: Kernel command line: printk.time=3D0 console=3Dt=
tyS0,115200<br>
&gt;=C2=A0 =C2=A0 PASS (8.59 s)<br>
&gt;=C2=A0 =C2=A0 JOB TIME=C2=A0 =C2=A0: 8.81 s<br>
&gt; <br>
&gt; Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug=
@amsat.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
&gt; [NL: rename in commit message Raspbian to Armbian]<br>
&gt; Signed-off-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gm=
ail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0tests/acceptance/boot_linux_console.py | 26 ++++++++++++++=
++++++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 26 insertions(+)<br>
&gt; <br>
&gt; diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance=
/boot_linux_console.py<br>
&gt; index 9c6aa2040a..b58308d724 100644<br>
&gt; --- a/tests/acceptance/boot_linux_console.py<br>
&gt; +++ b/tests/acceptance/boot_linux_console.py<br>
&gt; @@ -400,6 +400,32 @@ class BootLinuxConsole(Test):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.wait_for_console_pattern(=
&#39;Boot successful.&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# TODO user command, for now t=
he uart is stuck<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 def test_arm_orangepi(self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Darch:arm<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dmachine:orangepi-pc<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_url =3D (&#39;<a href=3D"https://apt.=
armbian.com/pool/main/l/" rel=3D"noreferrer" target=3D"_blank">https://apt.=
armbian.com/pool/main/l/</a>&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&#39;linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.deb&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;1334c29c44d984ffa05ed10=
de8c3361f33d78315&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_path =3D self.fetch_asset(deb_url, as=
set_hash=3Ddeb_hash)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_path =3D self.extract_from_deb(deb=
_path,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;/boot/vmlinuz-4.20.7-sunxi&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D &#39;/usr/lib/linux-image-de=
v-sunxi/sun8i-h3-orangepi-pc.dtb&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D self.extract_from_deb(deb_pa=
th, dtb_path)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.set_machine(&#39;orangepi-pc&#39;=
)<br>
<br>
Please remove the vm.set_machine() calls.<br></blockquote><div><br></div><d=
iv>OK, I&#39;ll also remove them vm.set_machine() calls in the other 3 patc=
hes.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.set_console()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_command_line =3D (self.KERNEL_COMM=
ON_COMMAND_LINE +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;console=3DttyS0,115200n8 &#3=
9;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;earlycon=3Duart,mmio32,0x1c2=
8000&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.add_args(&#39;-kernel&#39;, kerne=
l_path,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0&#39;-dtb&#39;, dtb_path,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0&#39;-append&#39;, kernel_command_line)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.launch()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 console_pattern =3D &#39;Kernel command l=
ine: %s&#39; % kernel_command_line<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wait_for_console_pattern(console_pat=
tern)<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0def test_s390x_s390_ccw_virtio(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0:avocado: tags=3Darch:s390x<br=
>
&gt; <br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000ffd7d0059c721374--

