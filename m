Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA71C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 17:08:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32874216F4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 17:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32874216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7jd9-00080z-69
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 13:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60986)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1i7jcQ-0007Wc-5S
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 13:07:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1i7jcM-0000IJ-Cu
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 13:07:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48172)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1i7jcM-0000Hz-5E
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 13:07:50 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DD7AA3082138;
 Tue, 10 Sep 2019 17:07:48 +0000 (UTC)
Received: from localhost.localdomain (ovpn-121-171.rdu2.redhat.com
 [10.10.121.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A2E9019C4F;
 Tue, 10 Sep 2019 17:07:47 +0000 (UTC)
Date: Tue, 10 Sep 2019 13:07:45 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Message-ID: <20190910170745.GA26663@localhost.localdomain>
References: <20190910163430.11326-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190910163430.11326-1-f4bug@amsat.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 10 Sep 2019 17:07:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] BootLinuxConsoleTest: Test the Quadra 800
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
Cc: Thomas Huth <huth@tuxfamily.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 10, 2019 at 06:34:30PM +0200, Philippe Mathieu-Daud=E9 wrote:
> This test boots a Linux kernel on a Quadra 800 board
> and verify the serial is working.
>=20
> Example:
>=20
>   $ avocado --show=3Dapp,console run -t machine:q800 tests/acceptance/b=
oot_linux_console.py
>   console: ABCFGHIJK
>   console: Linux version 5.2.0-2-m68k (debian-kernel@lists.debian.org) =
(gcc version 8.3.0 (Debian 8.3.0-21)) #1 Debian 5.2.9-2 (2019-08-21)
>   console: Detected Macintosh model: 35
>   console: Apple Macintosh Quadra 800
>   console: Built 1 zonelists, mobility grouping on.  Total pages: 32448
>   console: Kernel command line: printk.time=3D0 console=3DttyS0 vga=3Do=
ff
>   [...]
>   console: Calibrating delay loop... 1236.99 BogoMIPS (lpj=3D6184960)
>   [...]
>   console: NuBus: Scanning NuBus slots.
>   console: Slot 9: Board resource not found!
>   console: SCSI subsystem initialized
>   console: clocksource: Switched to clocksource via1
>   [...]
>   console: macfb: framebuffer at 0xf9001000, mapped to 0x(ptrval), size=
 468k
>   console: macfb: mode is 800x600x8, linelength=3D800
>   console: Console: switching to colour frame buffer device 100x37
>   console: fb0: DAFB frame buffer device
>   console: pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashin=
g.org>)
>   console: scc.0: ttyS0 at MMIO 0x50f0c022 (irq =3D 4, base_baud =3D 23=
0400) is a Z85c30 ESCC - Serial port
>   console: scc.1: ttyS1 at MMIO 0x50f0c020 (irq =3D 4, base_baud =3D 23=
0400) is a Z85c30 ESCC - Serial port
>   console: Non-volatile memory driver v1.3
>   console: adb: Mac II ADB Driver v1.0 for Unified ADB
>   console: mousedev: PS/2 mouse device common for all mice
>   console: random: fast init done
>   console: Detected ADB keyboard, type <unknown>.
>   console: input: ADB keyboard as /devices/virtual/input/input0
>   console: input: ADB mouse as /devices/virtual/input/input1
>   console: rtc-generic rtc-generic: registered as rtc0
>   console: ledtrig-cpu: registered to indicate activity on CPUs
>   [...]
>   console: rtc-generic rtc-generic: setting system clock to 2019-09-10T=
16:20:25 UTC (1568132425)
>   console: List of all partitions:
>   console: No filesystem could mount root, tried:
>   JOB TIME   : 2.91 s
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
> Based-on: <20190910113323.17324-1-laurent@vivier.eu>
> "hw/m68k: add Apple Machintosh Quadra 800 machine"
> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg01775.html
> ---
>  tests/acceptance/boot_linux_console.py | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/=
boot_linux_console.py
> index 2504ef0150..8e346bb0f4 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -373,3 +373,27 @@ class BootLinuxConsole(Test):
>          self.vm.launch()
>          console_pattern =3D 'Kernel command line: %s' % kernel_command=
_line
>          self.wait_for_console_pattern(console_pattern)
> +
> +    def test_m68k_q800(self):
> +        """
> +        :avocado: tags=3Darch:m68k
> +        :avocado: tags=3Dmachine:q800
> +        """
> +        deb_url =3D ('http://ftp.ports.debian.org/debian-ports/pool-m6=
8k/main'
> +                   '/l/linux/kernel-image-5.2.0-2-m68k-di_5.2.9-2_m68k=
.udeb')
> +        deb_hash =3D '0797e05129595f22f3c0142db5e199769a723bf9'
> +        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> +        kernel_path =3D self.extract_from_deb(deb_path,
> +                                            '/boot/vmlinux-5.2.0-2-m68=
k')
> +
> +        self.vm.set_machine('q800')
> +        self.vm.set_console()
> +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> +                               'console=3DttyS0 vga=3Doff')
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-append', kernel_command_line)
> +        self.vm.launch()
> +        console_pattern =3D 'Kernel command line: %s' % kernel_command=
_line
> +        self.wait_for_console_pattern(console_pattern)
> +        console_pattern =3D 'No filesystem could mount root'
> +        self.wait_for_console_pattern(console_pattern)
> --=20
> 2.20.1
>

LGTM.

Of course it needs to wait for the series adding the machine type.
If there's a new version of the series, shouldn't this be included
there?  Either way:

Tested-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>

