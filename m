Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF8BC7619B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 08:28:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F23920725
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 08:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="2j4StSMH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F23920725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3blN-0001Ej-VC
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 03:28:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44726)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1j3bj1-0000Cs-TM
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:25:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luc.michel@greensocs.com>) id 1j3bj0-0005NG-Dy
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:25:55 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:47050)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luc.michel@greensocs.com>)
 id 1j3biz-0005LO-UJ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:25:54 -0500
Received: from [172.16.11.100] (tiramisu.bar.greensocs.com [172.16.11.100])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 0388896EF0;
 Mon, 17 Feb 2020 08:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1581927950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7HC8dwf3ppu94pFZ2PRdsiNuNc9G+P1bw0BzaasnNRg=;
 b=2j4StSMHYVBO5LJYgf6/Et8vH7j3uJKz1YgMHwzEyJCxjDQUBGK6Gl0iacPXqk38ZBGRjf
 nwrVjvEzR27zlu8RtMKbL/vcNqtXZWt+x0iwtA20wE/S+G4kRcUc+7HnyZkcIgt0+KazjW
 yn6/rsZjLdDdcO4CypdmVPR4SDS6orE=
Subject: Re: [PATCH 1/8] tests/acceptance/boot_linux_console: Use raspi
 console model as key
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200215192216.4899-1-f4bug@amsat.org>
 <20200215192216.4899-2-f4bug@amsat.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <a64c0b9e-ecc4-7437-4470-af3d24efd899@greensocs.com>
Date: Mon, 17 Feb 2020 09:25:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200215192216.4899-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-PH
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1581927950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7HC8dwf3ppu94pFZ2PRdsiNuNc9G+P1bw0BzaasnNRg=;
 b=1Xge0CxI9LUY4lKePeSTnR8BgKYKQr4URICa07L7CeUM6SuyqSjRkVJDKxhCEYYzrZDcs/
 zWHh/IvgecR6ghPJG8bvvsVJLWAvcajLllokfS/e4i+s7owdJ3flGWDTpMPdnSSDHNeO7/
 +nRl8PqFGKWGV0yWfqO7tmP66jtyuGA=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1581927950; a=rsa-sha256; cv=none;
 b=r4L2gGlw/4EFLB4kDKKlqpoe0M0F2lUAGGuD07D7fz1w2aFAaFrzU9VpnRgQlnDD+p5LVa
 NHP16kTV59QT4nUNH439QAGcik91wE5pHwh3EU4yAyAzJPLuxDaZVaNUzR2IFfO1Q+xgJW
 v7cY1lRUfKlAvJck1VaukfZ49xTFEnE=
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
> Python dictionary are not that expensive. Use a key makes the
> code easier to review.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  tests/acceptance/boot_linux_console.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/=
boot_linux_console.py
> index 34d37eba3b..8cfc758d42 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -347,14 +347,14 @@ def test_arm_emcraft_sf2(self):
>          self.vm.launch()
>          self.wait_for_console_pattern('init started: BusyBox')
> =20
> -    def do_test_arm_raspi2(self, uart_id):
> +    def do_test_arm_raspi2(self, uart_model):
>          """
>          The kernel can be rebuilt using the kernel source referenced
>          and following the instructions on the on:
>          https://www.raspberrypi.org/documentation/linux/kernel/buildin=
g.md
>          """
>          serial_kernel_cmdline =3D {
> -            0: 'earlycon=3Dpl011,0x3f201000 console=3DttyAMA0',
> +            'pl011': 'earlycon=3Dpl011,0x3f201000 console=3DttyAMA0',
>          }
>          deb_url =3D ('http://archive.raspberrypi.org/debian/'
>                     'pool/main/r/raspberrypi-firmware/'
> @@ -366,7 +366,7 @@ def do_test_arm_raspi2(self, uart_id):
> =20
>          self.vm.set_console()
>          kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> -                               serial_kernel_cmdline[uart_id])
> +                               serial_kernel_cmdline[uart_model])
>          self.vm.add_args('-kernel', kernel_path,
>                           '-dtb', dtb_path,
>                           '-append', kernel_command_line)
> @@ -380,7 +380,7 @@ def test_arm_raspi2_uart0(self):
>          :avocado: tags=3Dmachine:raspi2
>          :avocado: tags=3Ddevice:pl011
>          """
> -        self.do_test_arm_raspi2(0)
> +        self.do_test_arm_raspi2('pl011')
> =20
>      def test_arm_exynos4210_initrd(self):
>          """
>=20

