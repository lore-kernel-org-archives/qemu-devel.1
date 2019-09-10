Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271C3C49ED9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:57:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E84DE2082C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84DE2082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7jSe-0003l6-TC
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 12:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59286)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7jRY-0002l0-Ji
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:56:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7jRU-00030d-ME
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:56:39 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:54679)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7jRU-00030J-DF
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:56:36 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MNss4-1hnr8M2kNU-00OFaU; Tue, 10 Sep 2019 18:56:26 +0200
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20190910163430.11326-1-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <7a6167d6-8fd5-87be-f319-07856c888a70@vivier.eu>
Date: Tue, 10 Sep 2019 18:56:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910163430.11326-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8P1wtumJq8wNAoDLWNsx4xn84dl6wUD2t3jsHV0h5bIWpZMz3kx
 +ffLIFV1hapI7Rt5g0EBrqd+28gHVfLhsGGqUmhSyVyL4OoiioyoB3iVsq426YC0C1onNkk
 wheA0bOsmnX19P19iR/HRG4bVzTANA9vW9RgXm7rDBeeAPh/BzplPJ2huffLigu1bxADr2X
 H0M57ZcUSRy8iXM51Dw+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bdVYdpSxTRo=:1q25fgHamfJj3PMrISp2e5
 Nk6PHtGRduD00bWX3NQX5Z6p0BURZLcXGseP1arBNf8+VIYFz+Y0rPpRiRfTRMX9Q5CuFiPnI
 gtv9O9JHP/8X4L5VT4quyIoAA2ySmx5l7FV/qmIU7LFwMFg7HdgjsOKfBqKH5Nepl8p6Y+1KR
 ZBetewnd3+HzQn3mBPJ0bjwVbmMmMAbkTlA9q/0TXWmQuBF74xURqv6O0gSR3toYuDatiAT6f
 JxbsxvXZOR3vQIbPPLxnI8Cw22WOo5ZyY9cVi0RO63YD8PXRA+Q22VUmbRTLNORB3q/2dKgiK
 XhH/JcyZFgqWqreVQGsw2OlN1nFhB+OV+1MikNKXoPgUwrhtkKU8Wm6bEfGqYkbd0wxU4aodq
 cglSaTjEGZpRcDKpJ4ctAhafvyko4SuGJZj88TaTaPuGk817JAhg3s5XPHWMH+QQNsn82hNyz
 NAQiho5zr+ctxC7zwVOuzkJiIE0q+x9cdlGx15pKe1DLUI+2SbkG5RLopSmoqQvUZtELz/dHP
 u2NmIo/nuY0fl6DKPUK8Jkr8lqPUoRZLwpM7L7aWqXut1MJ7emfaGOjqOlxKomzRWpaW5xfj+
 LqCYtVNONDPv+b4pjDnqJuU3EuYX7ZWHCGJZSmvwgStzzoHfDOoSL5aUS1Ip062oDarUMHM4m
 cshh9mIIcblmcIV9dksLtgtirNKgBYg2jTQdV5e1ncLa2n6uI24XpjTZ+3bybTPnHrIKx2Fwh
 rOsOEox1LsyOYKpyyvrMxvdkem1PLvksaX+JSjc/WOcY53yGgHmAYUUDNMZgbQwOUvg2j4GJZ
 t4YTj1k1bTH+iC/QinPEdCNiiyjFNNcP+I/AS+GwKN56WWP8Q4F87/rGuSd5/gkGQjDIRSthH
 3l4GlqXGOccYM7eHKdqb5ai7ypME7IN+GvVfOZudg=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
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
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 10/09/2019 à 18:34, Philippe Mathieu-Daudé a écrit :
> This test boots a Linux kernel on a Quadra 800 board
> and verify the serial is working.
> 
> Example:
> 
>   $ avocado --show=app,console run -t machine:q800 tests/acceptance/boot_linux_console.py
>   console: ABCFGHIJK
>   console: Linux version 5.2.0-2-m68k (debian-kernel@lists.debian.org) (gcc version 8.3.0 (Debian 8.3.0-21)) #1 Debian 5.2.9-2 (2019-08-21)
>   console: Detected Macintosh model: 35
>   console: Apple Macintosh Quadra 800
>   console: Built 1 zonelists, mobility grouping on.  Total pages: 32448
>   console: Kernel command line: printk.time=0 console=ttyS0 vga=off
>   [...]
>   console: Calibrating delay loop... 1236.99 BogoMIPS (lpj=6184960)
>   [...]
>   console: NuBus: Scanning NuBus slots.
>   console: Slot 9: Board resource not found!
>   console: SCSI subsystem initialized
>   console: clocksource: Switched to clocksource via1
>   [...]
>   console: macfb: framebuffer at 0xf9001000, mapped to 0x(ptrval), size 468k
>   console: macfb: mode is 800x600x8, linelength=800
>   console: Console: switching to colour frame buffer device 100x37
>   console: fb0: DAFB frame buffer device
>   console: pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
>   console: scc.0: ttyS0 at MMIO 0x50f0c022 (irq = 4, base_baud = 230400) is a Z85c30 ESCC - Serial port
>   console: scc.1: ttyS1 at MMIO 0x50f0c020 (irq = 4, base_baud = 230400) is a Z85c30 ESCC - Serial port
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
>   console: rtc-generic rtc-generic: setting system clock to 2019-09-10T16:20:25 UTC (1568132425)
>   console: List of all partitions:
>   console: No filesystem could mount root, tried:
>   JOB TIME   : 2.91 s
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> Based-on: <20190910113323.17324-1-laurent@vivier.eu>
> "hw/m68k: add Apple Machintosh Quadra 800 machine"
> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg01775.html
> ---
>  tests/acceptance/boot_linux_console.py | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index 2504ef0150..8e346bb0f4 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -373,3 +373,27 @@ class BootLinuxConsole(Test):
>          self.vm.launch()
>          console_pattern = 'Kernel command line: %s' % kernel_command_line
>          self.wait_for_console_pattern(console_pattern)
> +
> +    def test_m68k_q800(self):
> +        """
> +        :avocado: tags=arch:m68k
> +        :avocado: tags=machine:q800
> +        """
> +        deb_url = ('http://ftp.ports.debian.org/debian-ports/pool-m68k/main'
> +                   '/l/linux/kernel-image-5.2.0-2-m68k-di_5.2.9-2_m68k.udeb')
> +        deb_hash = '0797e05129595f22f3c0142db5e199769a723bf9'
> +        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
> +        kernel_path = self.extract_from_deb(deb_path,
> +                                            '/boot/vmlinux-5.2.0-2-m68k')
> +
> +        self.vm.set_machine('q800')
> +        self.vm.set_console()
> +        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
> +                               'console=ttyS0 vga=off')
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-append', kernel_command_line)
> +        self.vm.launch()
> +        console_pattern = 'Kernel command line: %s' % kernel_command_line
> +        self.wait_for_console_pattern(console_pattern)
> +        console_pattern = 'No filesystem could mount root'
> +        self.wait_for_console_pattern(console_pattern)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

