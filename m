Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTML_OBFUSCATE_05_10,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,PDS_BTC_ID,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EE8CA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 08:19:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F121208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 08:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrRb1K2X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F121208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP0Ex-0004Jn-Ds
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 04:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51862)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iP0DR-0002H3-3U
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 04:17:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iP0DO-0007MN-Kp
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 04:17:28 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:38333)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iP0DO-0007Lc-E8
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 04:17:26 -0400
Received: by mail-oi1-x234.google.com with SMTP id v186so5337010oie.5
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 01:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=abwCdvUAQRzMDerLj/HwOMWo8w92iTcKxF7NwQ/wImc=;
 b=UrRb1K2X4VYWEPwfzZnq8PoEc7IYWk1mXJBPlpfPiRXzmbWtV6uuUJh1563fVTO1ie
 GOYtKpBywzERiffb6ID5+4jsrm0LXW6EbPviySRfbXhtx3ni1WvdNkSbQ7hRM2diPOIN
 pb8c3QyYinGCqfcmMKIXGSF45XKh5dcj1O/j1uDjKiF+MwLWHD7NXP1QrExY0DfVx2f3
 6LJu8ndXPE7SBpZBYdD1mRsNv4sIxZvFNWB/vb3VGJ+9qeK18YoQm6pWQgtN+02kwWU3
 UNy1NlxaYPpWVYLg4ocLzjKFp4RyKPfKZN0bDKwKOdUWMKqFPhqC/S1cI+oogZYulESP
 xvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=abwCdvUAQRzMDerLj/HwOMWo8w92iTcKxF7NwQ/wImc=;
 b=FUNYKc0wEFVB0DKPW+/XfH/6oyp7YghDMN2rTaGyvl5f+mZrFef6iovxIlJDg55V7V
 MY4xDpzs0dgiFk8Y4Vgb9zrtf5eCdHOH8ZwBshUYmseokq4jhvNp7cIqykomcrh7CoHs
 xJi13qnB+r5Vx88lfD2ZaxY0jHWX4bbz4HPFFf7rn+/5hKvxz8u+U24U7VD9e8yDnFsz
 Qubi4GEpPYOoWKXqMape5Bbiz8OHHrMjd5ty7UedM4LVCt1+eXpFuaSFZ7S7UCPfIdD/
 CZo7gmNMAUbn7bLllbAfkSjAjT2h2mn8oRBFhA7gVq29QnTD11jwo8P8IR4Iw3Qd8J9c
 8SvA==
X-Gm-Message-State: APjAAAVmBFLirVhUL097zpIMDPoiKTGk0EykwrudfetSV3X5CMUYdb7Y
 iuRC/0lpnoK6grxjCRNj9HBkFJq9X+uJFKGYgao=
X-Google-Smtp-Source: APXvYqyB7i43qgOEhohPf4oAiw1uwVc6OB8V23b4wNOXqqa/AfAf5HeHaQVgeEK2zims4iedaoDjyZJb/l4UcY9Gxnc=
X-Received: by 2002:aca:210e:: with SMTP id 14mr12936655oiz.62.1572250645428; 
 Mon, 28 Oct 2019 01:17:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Mon, 28 Oct 2019 01:17:24
 -0700 (PDT)
In-Reply-To: <20191028073441.6448-27-philmd@redhat.com>
References: <20191028073441.6448-1-philmd@redhat.com>
 <20191028073441.6448-27-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 28 Oct 2019 09:17:24 +0100
Message-ID: <CAL1e-=gBPSYmuoU4eH75mdUu_sUMDQNoXMHXU1ThNZFhJUHTwA@mail.gmail.com>
Subject: [PATCH 26/26] tests/boot_linux_console: Run BusyBox on 5KEc 64-bit cpu
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000037fd010595f421fa"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::234
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
Cc: Fam Zheng <fam@euphon.net>, Kamil Rytarowski <kamil@netbsd.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000037fd010595f421fa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Monday, October 28, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
>
wrote:

> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> This tests boots a Linux kernel on a Malta machine up to a
> busybox shell on the serial console. Few commands are executed
> before halting the machine (via reboot).
>
>

A very nice test.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>


> We use the Fedora 24 kernel extracted from the image at:
> https://fedoraproject.org/wiki/Architectures/MIPS
> and the initrd cpio image from the kerneltests project:
> https://kerneltests.org/
>
> If MIPS is a target being built, "make check-acceptance" will
> automatically include this test by the use of the "arch:mips" tags.
>
> Alternatively, this test can be run using:
>
>   $ AVOCADO_ALLOW_UNTRUSTED_CODE=3Dyes \
>     avocado --show=3Dconsole run -t arch:mips64el \
>       tests/acceptance/boot_linux_console.py
>   console: [    0.000000] Linux version 3.19.3.mtoman.20150408
> (mtoman@debian-co3-1) (gcc version 5.0.0 20150316 (Red Hat 5.0.0-0.20)
> (GCC) ) #3 Wed Apr 8 14:32:50 UTC 2015
>   console: [    0.000000] Early serial console at I/O port 0x3f8 (options
> '38400n8')
>   console: [    0.000000] bootconsole [uart0] enabled
>   console: [    0.000000] CPU0 revision is: 00018900 (MIPS 5KE)
>   console: [    0.000000] Checking for the multiply/shift bug... no.
>   console: [    0.000000] Checking for the daddiu bug... no.
>   [...]
>   console: Boot successful.
>   console: cat /proc/cpuinfo
>   console: / # cat /proc/cpuinfo
>   console: system type            : MIPS Malta
>   console: machine                        : Unknown
>   console: processor              : 0
>   console: cpu model              : MIPS 5KE V0.0
>   console: : 1616.89
>   console: wait instruction       : nouname -a
>   console: microsecond timers     : yes
>   console: tlb_entries            : 32
>   console: extra interrupt vector : yes
>   console: hardware watchpoint    : yes, count: 1, address/irw mask:
> [0x0ff8]
>   console: isa                    : mips1 mips2 mips3 mips4 mips5 mips32r=
1
> mips32r2 mips64r1 mips64r2
>   console: ASEs implemented       :
>   console: shadow register sets   : 1
>   console: kscratch registers     : 0
>   console: package                        : 0
>   console: core                   : 0
>   console: VCED exceptions                : not available
>   console: VCEI exceptions                : not available
>   console: / #
>   console: / # uname -a
>   console: Linux buildroot 3.19.3.mtoman.20150408 #3 Wed Apr 8 14:32:50
> UTC 2015 mips64 GNU/Linux
>   console: reboot
>   console: / #
>   console: / # reboot
>   console: / #
>   console: / # reboot: Restarting system
>   PASS (7.04 s)
>   JOB TIME   : 7.20 s
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/acceptance/boot_linux_console.py | 41 ++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/tests/acceptance/boot_linux_console.py
> b/tests/acceptance/boot_linux_console.py
> index 489df4862c..959d4557c9 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -168,6 +168,47 @@ class BootLinuxConsole(MachineTest):
>          exec_command_and_wait_for_pattern(self, 'reboot',
>                                                  'reboot: Restarting
> system')
>
> +    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted
> code')
> +    def test_mips64el_malta_5KEc_cpio(self):
> +        """
> +        :avocado: tags=3Darch:mips64el
> +        :avocado: tags=3Dmachine:malta
> +        :avocado: tags=3Dendian:little
> +        """
> +        kernel_url =3D ('https://github.com/philmd/qemu-testing-blob/'
> +                      'raw/9ad2df38/mips/malta/mips64el/'
> +                      'vmlinux-3.19.3.mtoman.20150408')
> +        kernel_hash =3D '00d1d268fb9f7d8beda1de6bebcc46e884d71754'
> +        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
> +        initrd_url =3D ('https://github.com/groeck/linux-build-test/'
> +                      'raw/8584a59e/rootfs/'
> +                      'mipsel64/rootfs.mipsel64r1.cpio.gz')
> +        initrd_hash =3D '1dbb8a396e916847325284dbe2151167'
> +        initrd_path_gz =3D self.fetch_asset(initrd_url, algorithm=3D'md5=
',
> +                                          asset_hash=3Dinitrd_hash)
> +        initrd_path =3D self.workdir + "rootfs.cpio"
> +        archive.gzip_uncompress(initrd_path_gz, initrd_path)
> +
> +        self.vm.set_machine('malta')
> +        self.vm.set_console()
> +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE
> +                               + 'console=3DttyS0 console=3Dtty '
> +                               + 'rdinit=3D/sbin/init noreboot')
> +        self.vm.add_args('-cpu', '5KEc',
> +                         '-kernel', kernel_path,
> +                         '-initrd', initrd_path,
> +                         '-append', kernel_command_line,
> +                         '-no-reboot')
> +        self.vm.launch()
> +        wait_for_console_pattern(self, 'Boot successful.')
> +
> +        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
> +                                                'MIPS 5KE')
> +        exec_command_and_wait_for_pattern(self, 'uname -a',
> +                                                '3.19.3.mtoman.20150408'=
)
> +        exec_command_and_wait_for_pattern(self, 'reboot',
> +                                                'reboot: Restarting
> system')
> +
>      def do_test_mips_malta32el_nanomips(self, kernel_url, kernel_hash):
>          kernel_path_xz =3D self.fetch_asset(kernel_url,
> asset_hash=3Dkernel_hash)
>          kernel_path =3D self.workdir + "kernel"
> --
> 2.21.0
>
>
>

--00000000000037fd010595f421fa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, October 28, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a hre=
f=3D"mailto:philmd@redhat.com" target=3D"_blank">philmd@redhat.com</a>&gt; =
wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">From: Philippe Mathieu-Daud=C3=A9 =
&lt;<a href=3D"mailto:f4bug@amsat.org" target=3D"_blank">f4bug@amsat.org</a=
>&gt;<br>
<br>
This tests boots a Linux kernel on a Malta machine up to a<br>
busybox shell on the serial console. Few commands are executed<br>
before halting the machine (via reboot).<br>
<br></blockquote><div><br></div><div><br></div><div>A very nice test.</div>=
<div><br></div><div><span style=3D"color:rgb(34,34,34);font-size:14px;line-=
height:22.1200008392334px">Reviewed-by: Aleksandar Markovic &lt;</span><a h=
ref=3D"mailto:amarkovic@wavecomp.com" target=3D"_blank" style=3D"font-size:=
14px;line-height:22.1200008392334px">amarkovic@wavecomp.com</a><span style=
=3D"color:rgb(34,34,34);font-size:14px;line-height:22.1200008392334px">&gt;=
</span></div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
We use the Fedora 24 kernel extracted from the image at:<br>
<a href=3D"https://fedoraproject.org/wiki/Architectures/MIPS" target=3D"_bl=
ank">https://fedoraproject.org/wiki<wbr>/Architectures/MIPS</a><br>
and the initrd cpio image from the kerneltests project:<br>
<a href=3D"https://kerneltests.org/" target=3D"_blank">https://kerneltests.=
org/</a><br>
<br>
If MIPS is a target being built, &quot;make check-acceptance&quot; will<br>
automatically include this test by the use of the &quot;arch:mips&quot; tag=
s.<br>
<br>
Alternatively, this test can be run using:<br>
<br>
=C2=A0 $ AVOCADO_ALLOW_UNTRUSTED_CODE=3Dy<wbr>es \<br>
=C2=A0 =C2=A0 avocado --show=3Dconsole run -t arch:mips64el \<br>
=C2=A0 =C2=A0 =C2=A0 tests/acceptance/boot_linux_co<wbr>nsole.py<br>
=C2=A0 console: [=C2=A0 =C2=A0 0.000000] Linux version 3.19.3.mtoman.201504=
08 (mtoman@debian-co3-1) (gcc version 5.0.0 20150316 (Red Hat 5.0.0-0.20) (=
GCC) ) #3 Wed Apr 8 14:32:50 UTC 2015<br>
=C2=A0 console: [=C2=A0 =C2=A0 0.000000] Early serial console at I/O port 0=
x3f8 (options &#39;38400n8&#39;)<br>
=C2=A0 console: [=C2=A0 =C2=A0 0.000000] bootconsole [uart0] enabled<br>
=C2=A0 console: [=C2=A0 =C2=A0 0.000000] CPU0 revision is: 00018900 (MIPS 5=
KE)<br>
=C2=A0 console: [=C2=A0 =C2=A0 0.000000] Checking for the multiply/shift bu=
g... no.<br>
=C2=A0 console: [=C2=A0 =C2=A0 0.000000] Checking for the daddiu bug... no.=
<br>
=C2=A0 [...]<br>
=C2=A0 console: Boot successful.<br>
=C2=A0 console: cat /proc/cpuinfo<br>
=C2=A0 console: / # cat /proc/cpuinfo<br>
=C2=A0 console: system type=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : MIPS=
 Malta<br>
=C2=A0 console: machine=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : Unknown<br>
=C2=A0 console: processor=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :=
 0<br>
=C2=A0 console: cpu model=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :=
 MIPS 5KE V0.0<br>
=C2=A0 console: : 1616.89<br>
=C2=A0 console: wait instruction=C2=A0 =C2=A0 =C2=A0 =C2=A0: nouname -a<br>
=C2=A0 console: microsecond timers=C2=A0 =C2=A0 =C2=A0: yes<br>
=C2=A0 console: tlb_entries=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 32<b=
r>
=C2=A0 console: extra interrupt vector : yes<br>
=C2=A0 console: hardware watchpoint=C2=A0 =C2=A0 : yes, count: 1, address/i=
rw mask: [0x0ff8]<br>
=C2=A0 console: isa=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 : mips1 mips2 mips3 mips4 mips5 mips32r1 mips32r2 mips64r1 mi=
ps64r2<br>
=C2=A0 console: ASEs implemented=C2=A0 =C2=A0 =C2=A0 =C2=A0:<br>
=C2=A0 console: shadow register sets=C2=A0 =C2=A0: 1<br>
=C2=A0 console: kscratch registers=C2=A0 =C2=A0 =C2=A0: 0<br>
=C2=A0 console: package=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0<br>
=C2=A0 console: core=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0: 0<br>
=C2=A0 console: VCED exceptions=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 : not available<br>
=C2=A0 console: VCEI exceptions=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 : not available<br>
=C2=A0 console: / #<br>
=C2=A0 console: / # uname -a<br>
=C2=A0 console: Linux buildroot 3.19.3.mtoman.20150408 #3 Wed Apr 8 14:32:5=
0 UTC 2015 mips64 GNU/Linux<br>
=C2=A0 console: reboot<br>
=C2=A0 console: / #<br>
=C2=A0 console: / # reboot<br>
=C2=A0 console: / #<br>
=C2=A0 console: / # reboot: Restarting system<br>
=C2=A0 PASS (7.04 s)<br>
=C2=A0 JOB TIME=C2=A0 =C2=A0: 7.20 s<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
---<br>
=C2=A0tests/acceptance/boot_linux_c<wbr>onsole.py | 41 ++++++++++++++++++++=
++++++<br>
=C2=A01 file changed, 41 insertions(+)<br>
<br>
diff --git a/tests/acceptance/boot_linux_<wbr>console.py b/tests/acceptance=
/boot_linux_<wbr>console.py<br>
index 489df4862c..959d4557c9 100644<br>
--- a/tests/acceptance/boot_linux_<wbr>console.py<br>
+++ b/tests/acceptance/boot_linux_<wbr>console.py<br>
@@ -168,6 +168,47 @@ class BootLinuxConsole(MachineTest):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exec_command_and_wait_for_pat<wbr>tern(se=
lf, &#39;reboot&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;reboot: Restarting system&#39;)<br>
<br>
+=C2=A0 =C2=A0 @skipUnless(os.getenv(&#39;AVOCADO<wbr>_ALLOW_UNTRUSTED_CODE=
&#39;), &#39;untrusted code&#39;)<br>
+=C2=A0 =C2=A0 def test_mips64el_malta_5KEc_cpio(<wbr>self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Darch:mips64el<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dmachine:malta<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dendian:little<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_url =3D (&#39;<a href=3D"https://github=
.com/philmd/qemu-testing-blob/" target=3D"_blank">https://github.com/philmd=
/qe<wbr>mu-testing-blob/</a>&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &#39;raw/9ad2df38/mips/malta/mips6<wbr>4el/&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &#39;vmlinux-3.19.3.mtoman.2015040<wbr>8&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_hash =3D &#39;00d1d268fb9f7d8beda1de6be=
bcc4<wbr>6e884d71754&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_path =3D self.fetch_asset(kernel_url, a=
sset_hash=3Dkernel_hash)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 initrd_url =3D (&#39;<a href=3D"https://github=
.com/groeck/linux-build-test/" target=3D"_blank">https://github.com/groeck/=
li<wbr>nux-build-test/</a>&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &#39;raw/8584a59e/rootfs/&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &#39;mipsel64/rootfs.mipsel64r1.cp<wbr>io.gz&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 initrd_hash =3D &#39;1dbb8a396e916847325284dbe=
2151<wbr>167&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 initrd_path_gz =3D self.fetch_asset(initrd_url=
, algorithm=3D&#39;md5&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 a=
sset_hash=3Dinitrd_hash)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 initrd_path =3D self.workdir + &quot;rootfs.cp=
io&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 archive.gzip_uncompress(initrd<wbr>_path_gz, i=
nitrd_path)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.set_machine(&#39;malta&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.set_console()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_command_line =3D (self.KERNEL_COMMON_CO=
MMAND_LI<wbr>NE<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ &#39;console=3DttyS0 console=3Dtty =
&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ &#39;rdinit=3D/sbin/init noreboot&#=
39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.add_args(&#39;-cpu&#39;, &#39;5KEc&#39=
;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-kernel&#39;, kernel_path,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-initrd&#39;, initrd_path,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-append&#39;, kernel_command_line,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-no-reboot&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.launch()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 wait_for_console_pattern(self, &#39;Boot succe=
ssful.&#39;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_patt<wbr>ern(self, &=
#39;cat /proc/cpuinfo&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &#39;MIPS 5KE&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_patt<wbr>ern(self, &=
#39;uname -a&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &#39;3.19.3.mtoman.20150408&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_patt<wbr>ern(self, &=
#39;reboot&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &#39;reboot: Restarting system&#39;)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def do_test_mips_malta32el_nanomip<wbr>s(self, kernel_u=
rl, kernel_hash):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_path_xz =3D self.fetch_asset(kerne=
l_url, asset_hash=3Dkernel_hash)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_path =3D self.workdir + &quot;kern=
el&quot;<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote>

--00000000000037fd010595f421fa--

