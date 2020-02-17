Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8137DC7619D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 08:32:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D93220725
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 08:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="Iv/VThhu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D93220725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3bpM-0004Wj-CP
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 03:32:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1j3bkg-00018z-5S
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:27:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luc.michel@greensocs.com>) id 1j3bkf-0006YK-4H
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:27:38 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:47152)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luc.michel@greensocs.com>)
 id 1j3bke-0006Xd-SD
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:27:37 -0500
Received: from [172.16.11.100] (tiramisu.bar.greensocs.com [172.16.11.100])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 8BF0096F50;
 Mon, 17 Feb 2020 08:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1581928055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O7/bbZ07FBoxsEoa/kvJLE/w06DIo9ZBLBnJd7CLw9A=;
 b=Iv/VThhuYp9ccMT/y+jycfEUhKokxBnwFlPuPSgQNVi1NM/JZav9VhUt66QnFF6WBVAgNT
 EEOPyGGu41R0j0lK9GmB7auR5vxJDVcM3g8QG/j+sfLe2Qt/dg9fIHyfz8ZegUJKYBfZr1
 8pkEpkzjpJDkb0s/90d5E1jVyuRhy7I=
Subject: Re: [PATCH 4/8] tests/acceptance/boot_linux_console: Test the raspi0
 console
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200215192216.4899-1-f4bug@amsat.org>
 <20200215192216.4899-5-f4bug@amsat.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <51a6a0c1-d2d6-66db-df03-2e72739dd160@greensocs.com>
Date: Mon, 17 Feb 2020 09:27:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200215192216.4899-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-PH
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1581928056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O7/bbZ07FBoxsEoa/kvJLE/w06DIo9ZBLBnJd7CLw9A=;
 b=2TINswzfjhbyKwH7TZXEHdEmKqpDwOJCUiJslJJsN4wCEvRzDgjaBz0c7kHU7xZSgUHv+K
 vPyyh7TbGV+wi1pQCPS1Tm5/ou2TcW1YO5oRsy/CgmVBh+LnAAy28gbmFIEdQzkofdVicH
 u9rHrK9YvYsAaLk2g2v+0wyFiNNUeSk=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1581928056; a=rsa-sha256; cv=none;
 b=dCZflIpJrSg0vi29As0WHTIUnwJ0prlUvryBHoBDY6LvQj9DW1FTH09fa1rxyxSyUbR3o8
 DL6Dm8l793H00FseyX1g568qsHH5Xloudzt/mNmLRPFGUEnv7oojxshQLEJa4cpNy651p0
 5ZM+OTI+6qQrThvUuJmj9VUCrdP1rE8=
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
>   $ avocado --show=3Dapp,console run -t machine:raspi0 tests/acceptance=
/
>   JOB ID     : af8e017486290758bff39c986934134199af3556
>   JOB LOG    : avocado/job-results/job-2020-02-05T23.53-af8e017/job.log
>    (1/1) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_a=
rm_raspi0_uart0:
>   console: [    0.000000] Booting Linux on physical CPU 0x0
>   console: [    0.000000] Linux version 4.14.98+ (dom@dom-XPS-13-9370) =
(gcc version 4.9.3 (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1200 =
Tue Feb 12 20:11:02 GMT 2019
>   console: [    0.000000] CPU: ARMv6-compatible processor [410fb767] re=
vision 7 (ARMv7), cr=3D00c5387d
>   console: [    0.000000] CPU: VIPT aliasing data cache, unknown instru=
ction cache
>   console: [    0.000000] OF: fdt: Machine model: Raspberry Pi Zero W
>   console: [    0.000000] earlycon: pl11 at MMIO 0x20201000 (options ''=
)
>   console: [    0.000000] bootconsole [pl11] enabled
>   console: [    0.000000] Memory policy: Data cache writeback
>   console: [    0.000000] cma: Reserved 8 MiB at 0x1b800000
>   console: [    0.000000] Built 1 zonelists, mobility grouping on.  Tot=
al pages: 113680
>   console: [    0.000000] Kernel command line: printk.time=3D0 earlycon=
=3Dpl011,0x20201000 console=3DttyAMA0
>   PASS (12.59 s)
>   RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT =
0 | CANCEL 0
>   JOB TIME   : 12.88 s
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  tests/acceptance/boot_linux_console.py | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/=
boot_linux_console.py
> index c8eabae695..bd3f0fc852 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -355,15 +355,18 @@ def do_test_arm_raspi(self, version, uart_model):
>          """
>          serial_kernel_cmdline =3D {
>              'pl011': {
> +                0: 'earlycon=3Dpl011,0x20201000 console=3DttyAMA0',
>                  1: 'earlycon=3Dpl011,0x20201000 console=3DttyAMA0',
>                  2: 'earlycon=3Dpl011,0x3f201000 console=3DttyAMA0',
>              },
>          }
>          kernel =3D {
> +            0: '/boot/kernel.img',
>              1: '/boot/kernel.img',
>              2: '/boot/kernel7.img',
>          }
>          dtb =3D {
> +            0: '/boot/bcm2708-rpi-0-w.dtb',
>              1: '/boot/bcm2708-rpi-b.dtb',
>              2: '/boot/bcm2709-rpi-2-b.dtb',
>          }
> @@ -385,6 +388,15 @@ def do_test_arm_raspi(self, version, uart_model):
>          console_pattern =3D 'Kernel command line: %s' % kernel_command=
_line
>          self.wait_for_console_pattern(console_pattern)
> =20
> +    def test_arm_raspi0_uart0(self):
> +        """
> +        :avocado: tags=3Darch:arm
> +        :avocado: tags=3Dmachine:raspi0
> +        :avocado: tags=3Dcpu:arm1176
> +        :avocado: tags=3Ddevice:pl011
> +        """
> +        self.do_test_arm_raspi(0, 'pl011')
> +
>      def test_arm_raspi1_uart0(self):
>          """
>          :avocado: tags=3Darch:arm
>=20

