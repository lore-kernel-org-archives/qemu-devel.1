Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A6EC7619B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 08:29:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E102420725
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 08:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="ytiX/mLg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E102420725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3bmK-0001wq-1J
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 03:29:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1j3bjz-0000Z3-Vk
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:26:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luc.michel@greensocs.com>) id 1j3bjy-0006A2-PW
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:26:55 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:47096)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luc.michel@greensocs.com>)
 id 1j3bjy-00069X-HN
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:26:54 -0500
Received: from [172.16.11.100] (tiramisu.bar.greensocs.com [172.16.11.100])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 387AD96F50;
 Mon, 17 Feb 2020 08:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1581928013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E8CqOeoPbm4ZFPdqCYRgw5qb9eW5R4VZD4IcBlasMJk=;
 b=ytiX/mLga+qhRU4rv9p7Xy1C2LXRw3/Um09co/hAMDhju9TJQdmzVgM6XZQSczi5qwIu52
 KZPGEFALbwbSHup5NZ9E9bJImafJYt/zeEdnH/t+BgkpDQwKzzLs91L9oCPshSdyayv18V
 fKTjByWeXgipdQegRXqFKRSUat6oZ40=
Subject: Re: [PATCH 2/8] tests/acceptance/boot_linux_console: Add raspi
 version=2 parameter
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200215192216.4899-1-f4bug@amsat.org>
 <20200215192216.4899-3-f4bug@amsat.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <e66e65c8-f0f4-52c5-1a45-47dc3fd8714d@greensocs.com>
Date: Mon, 17 Feb 2020 09:26:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200215192216.4899-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-PH
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1581928013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E8CqOeoPbm4ZFPdqCYRgw5qb9eW5R4VZD4IcBlasMJk=;
 b=JOPdp+LHDzeRkZuniXMa0CsWiE5lysJb2pxweAeOMRD1czWRCoJhn3KBEGHkUQzn5J9M2I
 5PcwNyC9NH2eTOrLoY9cZxA7kwmhX/35yKcqhf8XRfPJ2MSre01enHRbVIMB/qZPmb8rzy
 DpmBW8OgkBZSPNalOfTK9a9BLxDNzko=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1581928013; a=rsa-sha256; cv=none;
 b=yrz1cqayrRMzHYLj4vBj4k3zlOg9KM7D2Aax6o7jC5EDIXL50xp0Fnfka0zcCviknpmyTe
 CD/XZ/KOYqIY6wbbi4YXnrzdskNodyVR0VIhpyK+YrgXZyF/4eXY6gq6H7kdHQuR/2AmGE
 TyT9iKrG++RjNcFtJ0s0IFrI75F3Dpk=
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
> We want to tests different Raspberry Pi machines. Refactor to
> take the board version as argument.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  tests/acceptance/boot_linux_console.py | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/=
boot_linux_console.py
> index 8cfc758d42..a1b6e70d3f 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -347,26 +347,34 @@ def test_arm_emcraft_sf2(self):
>          self.vm.launch()
>          self.wait_for_console_pattern('init started: BusyBox')
> =20
> -    def do_test_arm_raspi2(self, uart_model):
> +    def do_test_arm_raspi(self, version, uart_model):
>          """
>          The kernel can be rebuilt using the kernel source referenced
>          and following the instructions on the on:
>          https://www.raspberrypi.org/documentation/linux/kernel/buildin=
g.md
>          """
>          serial_kernel_cmdline =3D {
> -            'pl011': 'earlycon=3Dpl011,0x3f201000 console=3DttyAMA0',
> +            'pl011': {
> +                2: 'earlycon=3Dpl011,0x3f201000 console=3DttyAMA0',
> +            },
> +        }
> +        kernel =3D {
> +            2: '/boot/kernel7.img',
> +        }
> +        dtb =3D {
> +            2: '/boot/bcm2709-rpi-2-b.dtb',
>          }
>          deb_url =3D ('http://archive.raspberrypi.org/debian/'
>                     'pool/main/r/raspberrypi-firmware/'
>                     'raspberrypi-kernel_1.20190215-1_armhf.deb')
>          deb_hash =3D 'cd284220b32128c5084037553db3c482426f3972'
>          deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> -        kernel_path =3D self.extract_from_deb(deb_path, '/boot/kernel7=
.img')
> -        dtb_path =3D self.extract_from_deb(deb_path, '/boot/bcm2709-rp=
i-2-b.dtb')
> +        kernel_path =3D self.extract_from_deb(deb_path, kernel[version=
])
> +        dtb_path =3D self.extract_from_deb(deb_path, dtb[version])
> =20
>          self.vm.set_console()
>          kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> -                               serial_kernel_cmdline[uart_model])
> +                               serial_kernel_cmdline[uart_model][versi=
on])
>          self.vm.add_args('-kernel', kernel_path,
>                           '-dtb', dtb_path,
>                           '-append', kernel_command_line)
> @@ -378,9 +386,10 @@ def test_arm_raspi2_uart0(self):
>          """
>          :avocado: tags=3Darch:arm
>          :avocado: tags=3Dmachine:raspi2
> +        :avocado: tags=3Dcpu:cortex-a7
>          :avocado: tags=3Ddevice:pl011
>          """
> -        self.do_test_arm_raspi2('pl011')
> +        self.do_test_arm_raspi(2, 'pl011')
> =20
>      def test_arm_exynos4210_initrd(self):
>          """
>=20

