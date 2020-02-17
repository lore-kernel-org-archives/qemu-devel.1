Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4A7C7619D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 08:36:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6617B2064C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 08:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="SGz7dyqY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6617B2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3bt8-000633-Gt
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 03:36:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45001)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1j3blW-0001mU-GP
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:28:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luc.michel@greensocs.com>) id 1j3blV-00071Z-2r
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:28:30 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:47214)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luc.michel@greensocs.com>)
 id 1j3blU-000715-Qr
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:28:29 -0500
Received: from [172.16.11.100] (tiramisu.bar.greensocs.com [172.16.11.100])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 6785996F50;
 Mon, 17 Feb 2020 08:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1581928107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AUxrKeu1MTKzV3kvwZDVnnGXzjhz+606AfAtMOONICY=;
 b=SGz7dyqYqE0TUSLqLv5o6fyOlImJAWiJVoy7B3seIl9XcMpxGmyBLZc8rQCA+UK8AAIdrI
 yjTaK29n2VRBPjg9L3dInY8PKgqQtg0aiIm1a3VmbIzhjfyFCJs5CycSWljhNl8cpecsuv
 LJsJwhAkGRBMSqRC26fCjTX46CGJoOo=
Subject: Re: [PATCH 5/8] tests/acceptance/boot_linux_console: Test the raspi1
 AUX console
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200215192216.4899-1-f4bug@amsat.org>
 <20200215192216.4899-6-f4bug@amsat.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <8e25bd63-85dc-343b-c4bb-8cf99feed90c@greensocs.com>
Date: Mon, 17 Feb 2020 09:28:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200215192216.4899-6-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-PH
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1581928107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AUxrKeu1MTKzV3kvwZDVnnGXzjhz+606AfAtMOONICY=;
 b=HuizAoRzvZvyQhNV+VwaRDh3cKvyqilMyYMewRsgeBxg1wu7RZKuKY/crOgG9HIdVVUwEX
 8OLjJH+BU1M8uJ8tzy8qBw9kmeYIiUNF5CLnnWeydFUUAS069W/5zPrVUmArKlJOhhdRmV
 51UCwYy+afc3ClTFrSxueLE2/qadVM0=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1581928107; a=rsa-sha256; cv=none;
 b=rwHT06DHbX98uw/m4V43e/TaEkGwvMMObaH0XNy+9SZl16rjPKIt9pjZ6gxaxGmWBrAYYM
 eZFzruk/sNGr9RkYwqv2bvLN1XaJPIUFR8V7JTI1krp97VfQ8l+3/+O1nn83W8fYrewE4Y
 iLOtRdifiCpt3iKsVOV1VpnxxRVnpaY=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=luc smtp.mailfrom=luc.michel@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
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
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/15/20 8:22 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>   $ avocado --show=3Dapp,console run -t device:bcm2835_aux tests/accept=
ance/
>   JOB ID     : a8846d69d52da701681b1d17f80ef299009fd078
>   JOB LOG    : avocado/job-results/job-2020-02-05T23.44-a8846d6/job.log
>    (1/3) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_a=
rm_raspi0_uart1:
>   console: [    0.000000] Booting Linux on physical CPU 0x0
>   console: [    0.000000] Linux version 4.14.98+ (dom@dom-XPS-13-9370) =
(gcc version 4.9.3 (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1200 =
Tue Feb 12 20:11:02 GMT 2019
>   console: [    0.000000] CPU: ARMv6-compatible processor [410fb767] re=
vision 7 (ARMv7), cr=3D00c5387d
>   console: [    0.000000] CPU: VIPT aliasing data cache, unknown instru=
ction cache
>   console: [    0.000000] OF: fdt: Machine model: Raspberry Pi Zero W
>   console: [    0.000000] earlycon: uart8250 at MMIO32 0x20215040 (opti=
ons '')
>   console: [    0.000000] bootconsole [uart8250] enabled
>   console: [    0.000000] Memory policy: Data cache writeback
>   console: [    0.000000] cma: Reserved 8 MiB at 0x1b800000
>   console: [    0.000000] Built 1 zonelists, mobility grouping on.  Tot=
al pages: 113680
>   console: [    0.000000] Kernel command line: printk.time=3D0 earlycon=
=3Duart8250,mmio32,0x20215040 console=3DttyS1,115200
>   PASS (13.31 s)
>    (2/3) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_a=
rm_raspi1_uart1:
>   console: [    0.000000] Booting Linux on physical CPU 0x0
>   console: [    0.000000] Linux version 4.14.98+ (dom@dom-XPS-13-9370) =
(gcc version 4.9.3 (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1200 =
Tue Feb 12 20:11:02 GMT 2019
>   console: [    0.000000] CPU: ARMv6-compatible processor [410fb767] re=
vision 7 (ARMv7), cr=3D00c5387d
>   console: [    0.000000] CPU: VIPT aliasing data cache, unknown instru=
ction cache
>   console: [    0.000000] OF: fdt: Machine model: Raspberry Pi Model B
>   console: [    0.000000] earlycon: uart8250 at MMIO32 0x20215040 (opti=
ons '')
>   console: [    0.000000] bootconsole [uart8250] enabled
>   console: [    0.000000] Memory policy: Data cache writeback
>   console: [    0.000000] cma: Reserved 8 MiB at 0x1b800000
>   console: [    0.000000] Built 1 zonelists, mobility grouping on.  Tot=
al pages: 113680
>   console: [    0.000000] Kernel command line: printk.time=3D0 earlycon=
=3Duart8250,mmio32,0x20215040 console=3DttyS1,115200
>   PASS (13.39 s)
>    (3/3) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_a=
rm_raspi2_uart1:
>   console: [    0.000000] Booting Linux on physical CPU 0xf00
>   console: [    0.000000] Linux version 4.14.98-v7+ (dom@dom-XPS-13-937=
0) (gcc version 4.9.3 (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #12=
00 SMP Tue Feb 12 20:27:48 GMT 2019
>   console: [    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (A=
RMv7), cr=3D10c5387d
>   console: [    0.000000] CPU: div instructions available: patching div=
ision code
>   console: [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT=
 aliasing instruction cache
>   console: [    0.000000] OF: fdt: Machine model: Raspberry Pi 2 Model =
B
>   console: [    0.000000] earlycon: uart8250 at MMIO32 0x3f215040 (opti=
ons '')
>   console: [    0.000000] bootconsole [uart8250] enabled
>   console: [    0.000000] Memory policy: Data cache writealloc
>   console: [    0.000000] cma: Reserved 8 MiB at 0x3b800000
>   console: [    0.000000] percpu: Embedded 17 pages/cpu @baf2e000 s3872=
0 r8192 d22720 u69632
>   console: [    0.000000] Built 1 zonelists, mobility grouping on.  Tot=
al pages: 243600
>   console: [    0.000000] Kernel command line: printk.time=3D0 earlycon=
=3Duart8250,mmio32,0x3f215040 console=3DttyS1,115200
>   PASS (12.46 s)
>   RESULTS    : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT =
0 | CANCEL 0
>   JOB TIME   : 39.60 s
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  tests/acceptance/boot_linux_console.py | 37 +++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/=
boot_linux_console.py
> index bd3f0fc852..3d442b6cd1 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -359,6 +359,14 @@ def do_test_arm_raspi(self, version, uart_model):
>                  1: 'earlycon=3Dpl011,0x20201000 console=3DttyAMA0',
>                  2: 'earlycon=3Dpl011,0x3f201000 console=3DttyAMA0',
>              },
> +            'bcm2835_aux': {
> +                0: 'earlycon=3Duart8250,mmio32,0x20215040 console=3Dtt=
yS1,115200',
> +                1: 'earlycon=3Duart8250,mmio32,0x20215040 console=3Dtt=
yS1,115200',
> +                2: 'earlycon=3Duart8250,mmio32,0x3f215040 console=3Dtt=
yS1,115200',
> +            },
> +        }
> +        uart_id =3D {
> +            'pl011': 0, 'bcm2835_aux': 1,
>          }
>          kernel =3D {
>              0: '/boot/kernel.img',
> @@ -378,7 +386,7 @@ def do_test_arm_raspi(self, version, uart_model):
>          kernel_path =3D self.extract_from_deb(deb_path, kernel[version=
])
>          dtb_path =3D self.extract_from_deb(deb_path, dtb[version])
> =20
> -        self.vm.set_console()
> +        self.vm.set_console(console_index=3Duart_id[uart_model])
>          kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
>                                 serial_kernel_cmdline[uart_model][versi=
on])
>          self.vm.add_args('-kernel', kernel_path,
> @@ -397,6 +405,15 @@ def test_arm_raspi0_uart0(self):
>          """
>          self.do_test_arm_raspi(0, 'pl011')
> =20
> +    def test_arm_raspi0_uart1(self):
> +        """
> +        :avocado: tags=3Darch:arm
> +        :avocado: tags=3Dmachine:raspi0
> +        :avocado: tags=3Dcpu:arm1176
> +        :avocado: tags=3Ddevice:bcm2835_aux
> +        """
> +        self.do_test_arm_raspi(0, 'bcm2835_aux')
> +
>      def test_arm_raspi1_uart0(self):
>          """
>          :avocado: tags=3Darch:arm
> @@ -406,6 +423,15 @@ def test_arm_raspi1_uart0(self):
>          """
>          self.do_test_arm_raspi(1, 'pl011')
> =20
> +    def test_arm_raspi1_uart1(self):
> +        """
> +        :avocado: tags=3Darch:arm
> +        :avocado: tags=3Dmachine:raspi1
> +        :avocado: tags=3Dcpu:arm1176
> +        :avocado: tags=3Ddevice:bcm2835_aux
> +        """
> +        self.do_test_arm_raspi(1, 'bcm2835_aux')
> +
>      def test_arm_raspi2_uart0(self):
>          """
>          :avocado: tags=3Darch:arm
> @@ -415,6 +441,15 @@ def test_arm_raspi2_uart0(self):
>          """
>          self.do_test_arm_raspi(2, 'pl011')
> =20
> +    def test_arm_raspi2_uart1(self):
> +        """
> +        :avocado: tags=3Darch:arm
> +        :avocado: tags=3Dmachine:raspi2
> +        :avocado: tags=3Dcpu:cortex-a7
> +        :avocado: tags=3Ddevice:bcm2835_aux
> +        """
> +        self.do_test_arm_raspi(2, 'bcm2835_aux')
> +
>      def test_arm_exynos4210_initrd(self):
>          """
>          :avocado: tags=3Darch:arm
>=20

