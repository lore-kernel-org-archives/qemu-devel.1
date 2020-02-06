Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23647C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:33:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D151220658
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p789zCto"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D151220658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izomL-0007cF-UA
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 16:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1izoaq-0001ID-W9
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:21:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1izoao-00075v-RR
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:21:48 -0500
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:43258)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1izoao-00071f-Jj; Thu, 06 Feb 2020 16:21:46 -0500
Received: by mail-il1-x143.google.com with SMTP id o13so6469351ilg.10;
 Thu, 06 Feb 2020 13:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ctjbc4Tr+ubp6tCXycl2H3Xae/BsxQ1mkV9e0ggGVeQ=;
 b=p789zCtokiNOy4jm91nagQ5A77PYKANjdsAq6y5iMrFMs4DeZV0VLwhAD2uF1fNw7B
 J43pG6p5TUciKEE+DoEe8k//1Zl86d+Sz/e4HdRu++dNnlij/I019RoNPVakJuTxkvAq
 FiwVffYjYC/nuS+PY6razj9DOYQPbc5RLmkbM/4Y5+nX/NR/d9LX9yXFsfPw00dp4Jq+
 U9ouUsKb1Zdio4g87we4HpfNcRLcL7XoRKnGdPRaN/W3nZcnCbvjCBHQxdBm/3znX3GX
 5n5eqnf7wJ+Mk6cnmuuQUbdWVPWKE5upE5zT2SvIBT6On1/gHRlLjksfrLmtp3uLcsUs
 mDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ctjbc4Tr+ubp6tCXycl2H3Xae/BsxQ1mkV9e0ggGVeQ=;
 b=nBlKzMcgkGGfnkOyDElWnk8ATCu9/5RdbIR+gIuaLcnUMds249ji7865DORAWl4vCA
 0DbQsa5dxgTUCjISpQqaXB9LLR+kQGzfnjYSlIjIyhnGvE2XwRQBI4CPFTukbA2DbUun
 +Mshg0Kf3SIXLNjTHxFRmpCCiT25NHOynGMzgPu1TigCLc5WBwyanAIsGf1oHQASRAgB
 67+PtEsRmtru4zzpGxXIzW5v0pgP0dAbi9BRJDLs3eyvPhvfGKoT6/mU+ve/sQHMUoKH
 BLaS8+gdUSoGpY4e9pTf7cR+EgcpwtSSWhlC2iktZwxQ9oVVJERwl62dBDuC0hdAscJz
 GaHg==
X-Gm-Message-State: APjAAAVszv3b/9bE7iBBe6aHz7YCuSg1Uy8ZPFyFXdXOlPHw3y6bKYfF
 5HbKYsR0sn9QEXCdhvusJqvXOQWBCNUYXL0VbXw=
X-Google-Smtp-Source: APXvYqxFYv83jyeJ22beUn/1Q0wBtVbCNI1VVO8oxY0Hp1iVPAePCzxFiFoUyCGSNE2nPx/R+61GBe4kIB0ue1xitH0=
X-Received: by 2002:a92:5f45:: with SMTP id t66mr6112555ilb.28.1581024105854; 
 Thu, 06 Feb 2020 13:21:45 -0800 (PST)
MIME-Version: 1.0
References: <20200119005102.3847-1-nieklinnenbank@gmail.com>
 <20200119005102.3847-17-nieklinnenbank@gmail.com>
 <6dd1ab52-3a75-c439-f26b-fa04d797059c@amsat.org>
In-Reply-To: <6dd1ab52-3a75-c439-f26b-fa04d797059c@amsat.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Thu, 6 Feb 2020 22:21:34 +0100
Message-ID: <CAPan3Wq8eftDpzxzGoeY5Qhpvcw8oA0vFebXwmSbT+78UaDRcg@mail.gmail.com>
Subject: Re: [PATCH v4 16/20] tests/boot_linux_console: Add a SLOW test
 booting Ubuntu on OrangePi PC
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="00000000000036006e059deedc89"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::143
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
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, jasowang@redhat.com,
 QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Cleber Rosa <crosa@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000036006e059deedc89
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Sun, Jan 19, 2020 at 11:30 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg>
wrote:

> On 1/19/20 1:50 AM, Niek Linnenbank wrote:
> > From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >
> > This test boots Ubuntu Bionic on a OrangePi PC board.
> >
> > As it requires 1GB of storage, and is slow, this test is disabled
> > on automatic CI testing.
> >
> > It is useful for workstation testing. Currently Avocado timeouts too
> > quickly, so we can't run userland commands.
> >
> > The kernel image and DeviceTree blob are built by the Armbian
> > project (based on Debian):
> > https://www.armbian.com/orange-pi-pc/
> >
> > The Ubuntu image is downloaded from:
> > https://dl.armbian.com/orangepipc/Bionic_current
>
> I forgot the image is compressed is compressed with 7z, which is not
> provided by avocado.utils.archive. This patch requires more checks, see
> inlined...
>
> >
> > This test can be run using:
> >
> >   $ AVOCADO_ALLOW_LARGE_STORAGE=3Dyes \
> >     avocado --show=3Dapp,console run -t machine:orangepi-pc \
> >       tests/acceptance/boot_linux_console.py
> >   console: U-Boot SPL 2019.04-armbian (Nov 18 2019 - 23:08:35 +0100)
> >   console: DRAM: 1024 MiB
> >   console: Failed to set core voltage! Can't set CPU frequency
> >   console: Trying to boot from MMC1
> >   console: U-Boot 2019.04-armbian (Nov 18 2019 - 23:08:35 +0100)
> Allwinner Technology
> >   console: CPU:   Allwinner H3 (SUN8I 0000)
> >   console: Model: Xunlong Orange Pi PC
> >   console: DRAM:  1 GiB
> >   console: MMC:   mmc@1c0f000: 0
> >   [...]
> >   console: Uncompressing Linux... done, booting the kernel.
> >   console: Booting Linux on physical CPU 0x0
> >   console: Linux version 5.3.9-sunxi (root@builder) (gcc version 8.3.0
> (GNU Toolchain for the A-profile Architecture 8.3-2019.03 (arm-rel-8.36))=
)
> #19.11.3 SMP Mon Nov 18 18:49:43 CET 2019
> >   console: CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7),
> cr=3D50c5387d
> >   console: CPU: div instructions available: patching division code
> >   console: CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
> instruction cache
> >   console: OF: fdt: Machine model: Xunlong Orange Pi PC
> >   [...]
> >   console: EXT4-fs (mmcblk0p1): mounted filesystem with writeback data
> mode. Opts: (null)
> >   console: done.
> >   console: Begin: Running /scripts/local-bottom ... done.
> >   console: Begin: Running /scripts/init-bottom ... done.
> >   console: systemd[1]: systemd 237 running in system mode. (...)
> >   console: systemd[1]: Detected architecture arm.
> >   console: Welcome to Ubuntu 18.04.3 LTS!
> >   console: systemd[1]: Set hostname to <orangepipc>.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > [NL: rename in commit message Raspbian to Armbian, remove
> vm.set_machine()]
> > [NL: changed test to boot from SD card via BootROM]
> > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> > ---
> >  tests/acceptance/boot_linux_console.py | 41 ++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >
> > diff --git a/tests/acceptance/boot_linux_console.py
> b/tests/acceptance/boot_linux_console.py
> > index 50294e1675..399d5062db 100644
> > --- a/tests/acceptance/boot_linux_console.py
> > +++ b/tests/acceptance/boot_linux_console.py
>
> This patch needs:
>
>   from avocado.utils.path import find_command
>
>   P7ZIP_AVAILABLE =3D True
>   try:
>       find_command('7z')
>   except CmdNotFoundError:
>       P7ZIP_AVAILABLE =3D False
>
> > @@ -591,6 +591,47 @@ class BootLinuxConsole(Test):
> >          exec_command_and_wait_for_pattern(self, 'reboot',
> >                                                  'reboot: Restarting
> system')
> >
> > +    @skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage
> limited')
>
>        @skipUnless(P7ZIP_AVAILABLE, '7z not installed')
>

Ah indeed, that makes sense. I'll add this check for v5.
Now that we come accross this, I'm thinking that functionality like
decompression
might not be specific to the linux tests and perhaps should eventually come
in a utility/helper .py file.

Regards,
Niek


>
> > +    def test_arm_orangepi_bionic(self):
> > +        """
> > +        :avocado: tags=3Darch:arm
> > +        :avocado: tags=3Dmachine:orangepi-pc
> > +        """
> > +
> > +        # This test download a 196MB compressed image and expand it to
> 932MB...
> > +        image_url =3D ('https://dl.armbian.com/orangepipc/archive/'
> > +
>  'Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.7z')
> > +        image_hash =3D '196a8ffb72b0123d92cea4a070894813d305c71e'
> > +        image_path_7z =3D self.fetch_asset(image_url,
> asset_hash=3Dimage_hash)
> > +        image_name =3D
> 'Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.img'
> > +        image_path =3D os.path.join(self.workdir, image_name)
> > +        process.run("7z e -o%s %s" % (self.workdir, image_path_7z))
>
> Because here 7z is called ^
>
> > +
> > +        self.vm.set_console()
> > +        self.vm.add_args('-drive', 'file=3D' + image_path +
> ',if=3Dsd,format=3Draw',
> > +                         '-nic', 'user',
> > +                         '-no-reboot')
> > +        self.vm.launch()
> > +
> > +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> > +                               'console=3DttyS0,115200 '
> > +                               'loglevel=3D7 '
> > +                               'nosmp '
> > +                               'systemd.default_timeout_start_sec=3D90=
00 '
> > +
>  'systemd.mask=3Darmbian-zram-config.service '
> > +                               'systemd.mask=3Darmbian-ramlog.service'=
)
> > +
> > +        self.wait_for_console_pattern('U-Boot SPL')
> > +        self.wait_for_console_pattern('Autoboot in ')
> > +        exec_command_and_wait_for_pattern(self, ' ', '=3D>')
> > +        exec_command_and_wait_for_pattern(self, "setenv extraargs '" +
> > +                                                kernel_command_line +
> "'", '=3D>')
> > +        exec_command_and_wait_for_pattern(self, 'boot', 'Starting
> kernel ...');
> > +
> > +        self.wait_for_console_pattern('systemd[1]: Set hostname ' +
> > +                                      'to <orangepipc>')
> > +        self.wait_for_console_pattern('Starting Load Kernel Modules...=
')
> > +
> >      def test_s390x_s390_ccw_virtio(self):
> >          """
> >          :avocado: tags=3Darch:s390x
> >
>


--=20
Niek Linnenbank

--00000000000036006e059deedc89
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Philippe,<br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Jan 19, 2020 at 11:30 PM Phil=
ippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.=
org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">On 1/19/20 1:50 AM, Niek Linnenbank wrote:<br>
&gt; From: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.or=
g" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
&gt; <br>
&gt; This test boots Ubuntu Bionic on a OrangePi PC board.<br>
&gt; <br>
&gt; As it requires 1GB of storage, and is slow, this test is disabled<br>
&gt; on automatic CI testing.<br>
&gt; <br>
&gt; It is useful for workstation testing. Currently Avocado timeouts too<b=
r>
&gt; quickly, so we can&#39;t run userland commands.<br>
&gt; <br>
&gt; The kernel image and DeviceTree blob are built by the Armbian<br>
&gt; project (based on Debian):<br>
&gt; <a href=3D"https://www.armbian.com/orange-pi-pc/" rel=3D"noreferrer" t=
arget=3D"_blank">https://www.armbian.com/orange-pi-pc/</a><br>
&gt; <br>
&gt; The Ubuntu image is downloaded from:<br>
&gt; <a href=3D"https://dl.armbian.com/orangepipc/Bionic_current" rel=3D"no=
referrer" target=3D"_blank">https://dl.armbian.com/orangepipc/Bionic_curren=
t</a><br>
<br>
I forgot the image is compressed is compressed with 7z, which is not<br>
provided by avocado.utils.archive. This patch requires more checks, see<br>
inlined...<br>
<br>
&gt; <br>
&gt; This test can be run using:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0$ AVOCADO_ALLOW_LARGE_STORAGE=3Dyes \<br>
&gt;=C2=A0 =C2=A0 =C2=A0avocado --show=3Dapp,console run -t machine:orangep=
i-pc \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tests/acceptance/boot_linux_console.py<br>
&gt;=C2=A0 =C2=A0console: U-Boot SPL 2019.04-armbian (Nov 18 2019 - 23:08:3=
5 +0100)<br>
&gt;=C2=A0 =C2=A0console: DRAM: 1024 MiB<br>
&gt;=C2=A0 =C2=A0console: Failed to set core voltage! Can&#39;t set CPU fre=
quency<br>
&gt;=C2=A0 =C2=A0console: Trying to boot from MMC1<br>
&gt;=C2=A0 =C2=A0console: U-Boot 2019.04-armbian (Nov 18 2019 - 23:08:35 +0=
100) Allwinner Technology<br>
&gt;=C2=A0 =C2=A0console: CPU:=C2=A0 =C2=A0Allwinner H3 (SUN8I 0000)<br>
&gt;=C2=A0 =C2=A0console: Model: Xunlong Orange Pi PC<br>
&gt;=C2=A0 =C2=A0console: DRAM:=C2=A0 1 GiB<br>
&gt;=C2=A0 =C2=A0console: MMC:=C2=A0 =C2=A0mmc@1c0f000: 0<br>
&gt;=C2=A0 =C2=A0[...]<br>
&gt;=C2=A0 =C2=A0console: Uncompressing Linux... done, booting the kernel.<=
br>
&gt;=C2=A0 =C2=A0console: Booting Linux on physical CPU 0x0<br>
&gt;=C2=A0 =C2=A0console: Linux version 5.3.9-sunxi (root@builder) (gcc ver=
sion 8.3.0 (GNU Toolchain for the A-profile Architecture 8.3-2019.03 (arm-r=
el-8.36))) #19.11.3 SMP Mon Nov 18 18:49:43 CET 2019<br>
&gt;=C2=A0 =C2=A0console: CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7=
), cr=3D50c5387d<br>
&gt;=C2=A0 =C2=A0console: CPU: div instructions available: patching divisio=
n code<br>
&gt;=C2=A0 =C2=A0console: CPU: PIPT / VIPT nonaliasing data cache, VIPT ali=
asing instruction cache<br>
&gt;=C2=A0 =C2=A0console: OF: fdt: Machine model: Xunlong Orange Pi PC<br>
&gt;=C2=A0 =C2=A0[...]<br>
&gt;=C2=A0 =C2=A0console: EXT4-fs (mmcblk0p1): mounted filesystem with writ=
eback data mode. Opts: (null)<br>
&gt;=C2=A0 =C2=A0console: done.<br>
&gt;=C2=A0 =C2=A0console: Begin: Running /scripts/local-bottom ... done.<br=
>
&gt;=C2=A0 =C2=A0console: Begin: Running /scripts/init-bottom ... done.<br>
&gt;=C2=A0 =C2=A0console: systemd[1]: systemd 237 running in system mode. (=
...)<br>
&gt;=C2=A0 =C2=A0console: systemd[1]: Detected architecture arm.<br>
&gt;=C2=A0 =C2=A0console: Welcome to Ubuntu 18.04.3 LTS!<br>
&gt;=C2=A0 =C2=A0console: systemd[1]: Set hostname to &lt;orangepipc&gt;.<b=
r>
&gt; <br>
&gt; Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug=
@amsat.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
&gt; [NL: rename in commit message Raspbian to Armbian, remove vm.set_machi=
ne()]<br>
&gt; [NL: changed test to boot from SD card via BootROM]<br>
&gt; Signed-off-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gm=
ail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 tests/acceptance/boot_linux_console.py | 41 ++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 1 file changed, 41 insertions(+)<br>
&gt; <br>
&gt; diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance=
/boot_linux_console.py<br>
&gt; index 50294e1675..399d5062db 100644<br>
&gt; --- a/tests/acceptance/boot_linux_console.py<br>
&gt; +++ b/tests/acceptance/boot_linux_console.py<br>
<br>
This patch needs:<br>
<br>
=C2=A0 from avocado.utils.path import find_command<br>
<br>
=C2=A0 P7ZIP_AVAILABLE =3D True<br>
=C2=A0 try:<br>
=C2=A0 =C2=A0 =C2=A0 find_command(&#39;7z&#39;)<br>
=C2=A0 except CmdNotFoundError:<br>
=C2=A0 =C2=A0 =C2=A0 P7ZIP_AVAILABLE =3D False<br>
<br>
&gt; @@ -591,6 +591,47 @@ class BootLinuxConsole(Test):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(se=
lf, &#39;reboot&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;reboot: Restarting system&#39;)<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 @skipUnless(os.getenv(&#39;AVOCADO_ALLOW_LARGE_STORAGE&=
#39;), &#39;storage limited&#39;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0@skipUnless(P7ZIP_AVAILABLE, &#39;7z not install=
ed&#39;)<br></blockquote><div><br></div><div>Ah indeed, that makes sense. I=
&#39;ll add this check for v5.</div><div>Now that we come accross this, I&#=
39;m thinking that functionality like decompression</div><div>might not be =
specific to the linux tests and perhaps should eventually come in a utility=
/helper .py file.<br></div><div><br></div><div>Regards,</div><div>Niek<br><=
/div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 def test_arm_orangepi_bionic(self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Darch:arm<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dmachine:orangepi-pc<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # This test download a 196MB compressed i=
mage and expand it to 932MB...<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_url =3D (&#39;<a href=3D"https://dl=
.armbian.com/orangepipc/archive/" rel=3D"noreferrer" target=3D"_blank">http=
s://dl.armbian.com/orangepipc/archive/</a>&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&#39;Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.7z&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_hash =3D &#39;196a8ffb72b0123d92cea=
4a070894813d305c71e&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_path_7z =3D self.fetch_asset(image_=
url, asset_hash=3Dimage_hash)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_name =3D &#39;Armbian_19.11.3_Orang=
epipc_bionic_current_5.3.9.img&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_path =3D os.path.join(self.workdir,=
 image_name)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 process.run(&quot;7z e -o%s %s&quot; % (s=
elf.workdir, image_path_7z))<br>
<br>
Because here 7z is called ^<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.set_console()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.add_args(&#39;-drive&#39;, &#39;f=
ile=3D&#39; + image_path + &#39;,if=3Dsd,format=3Draw&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0&#39;-nic&#39;, &#39;user&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0&#39;-no-reboot&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.launch()<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_command_line =3D (self.KERNEL_COMM=
ON_COMMAND_LINE +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;console=3DttyS0,115200 &#39;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;loglevel=3D7 &#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;nosmp &#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;systemd.default_timeout_star=
t_sec=3D9000 &#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;systemd.mask=3Darmbian-zram-=
config.service &#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;systemd.mask=3Darmbian-ramlo=
g.service&#39;)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wait_for_console_pattern(&#39;U-Boot=
 SPL&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wait_for_console_pattern(&#39;Autobo=
ot in &#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self, &=
#39; &#39;, &#39;=3D&gt;&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self, &=
quot;setenv extraargs &#39;&quot; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 kernel_command_line + &quot;&#39;&quot;, &#39;=3D&=
gt;&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self, &=
#39;boot&#39;, &#39;Starting kernel ...&#39;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wait_for_console_pattern(&#39;system=
d[1]: Set hostname &#39; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;to &lt=
;orangepipc&gt;&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wait_for_console_pattern(&#39;Starti=
ng Load Kernel Modules...&#39;)<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def test_s390x_s390_ccw_virtio(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Darch:s390x<br>
&gt; <br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--00000000000036006e059deedc89--

