Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF28C7619D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 08:40:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97AC42064C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 08:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="GIHesJGD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97AC42064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3bwj-0007KL-Ly
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 03:40:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45037)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1j3blv-000282-Ud
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:28:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luc.michel@greensocs.com>) id 1j3blu-0007G5-L3
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:28:55 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:47252)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luc.michel@greensocs.com>)
 id 1j3blu-0007Fb-Cp
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:28:54 -0500
Received: from [172.16.11.100] (tiramisu.bar.greensocs.com [172.16.11.100])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 53A7E96F51;
 Mon, 17 Feb 2020 08:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1581928133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k8SBPmb8gvdV3IllyECufJ3GkY5fKGxx3UU+XmTXzDk=;
 b=GIHesJGDbkAsTRzKn2WMQc5eis8TkpfvQ2JF8oOo+epHmtYIdZryunxQd8a2fy53CQHLJw
 BhvZbpdI0f7cmpHbH6SC4ZeESlTsjBZoizYoUDrjbwTdPWaH2xAH6eq5jdbKohjcqSkQHo
 eHF4w3xmqjVCcBrPHgWtknc9W3PzxJY=
Subject: Re: [PATCH 7/8] tests/boot_linux_console: Test booting U-Boot on the
 Raspberry Pi 3
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200215192216.4899-1-f4bug@amsat.org>
 <20200215192216.4899-8-f4bug@amsat.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <59852f0e-5462-5371-2e1b-e34dc02e867d@greensocs.com>
Date: Mon, 17 Feb 2020 09:28:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200215192216.4899-8-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-PH
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1581928133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k8SBPmb8gvdV3IllyECufJ3GkY5fKGxx3UU+XmTXzDk=;
 b=UPmWnpasFToxsv9igD+W041V82VTy0TD8mS6aaMFTtC6r6AVhxWjdnakiHBoSZu4SDV+aD
 9KNsnXzNR7U2035YQWIKbzoO59PehykHOzAYqettKQRQHUza/G2QIfxL+WqYdeiAoHncEk
 KFCEwrYENqU7kYYTpXIkFjjmJBi7C0s=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1581928133; a=rsa-sha256; cv=none;
 b=tocNiEGSgGS/f6QXO2sgXfbsv52okMcSIhJZN/9mKNYJDy9vC2fNRYlmldR7iwB2uwJ1ci
 dHix9tYA2QebQoAxemVKYOv5ctJPjwrAxAl9i9Uy6cSjmR4XfBcwMtbXchossaXicypFvJ
 uY/BapqZeV9+SYqoUs98iW4PoiCPDHU=
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
> This test runs U-Boot on the Raspberry Pi 3.
> It is very simple and fast:
>=20
>   $ avocado --show=3Dapp,console run -t raspi3 -t u-boot tests/acceptan=
ce/
>   JOB LOG    : avocado/job-results/job-2020-01-20T23.40-2424777/job.log
>    (1/1) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_a=
arch64_raspi3_uboot:
>   console: MMC:   mmc@7e202000: 0, sdhci@7e300000: 1
>   console: Loading Environment from FAT... WARNING at drivers/mmc/bcm28=
35_sdhost.c:410/bcm2835_send_command()!
>   console: WARNING at drivers/mmc/bcm2835_sdhost.c:410/bcm2835_send_com=
mand()!
>   console: Card did not respond to voltage select!
>   console: In:    serial
>   console: Out:   vidconsole
>   console: Err:   vidconsole
>   console: Net:   No ethernet found.
>   console: starting USB...
>   console: Bus usb@7e980000: Port not available.
>   console: Hit any key to stop autoboot:  0
>   console: U-Boot>
>   console: U-Boot>
>   console: U-Boot> bdinfo
>   console: arch_number =3D 0x0000000000000000
>   console: boot_params =3D 0x0000000000000100
>   console: DRAM bank   =3D 0x0000000000000000
>   console: -> start    =3D 0x0000000000000000
>   console: -> size     =3D 0x000000003c000000
>   console: baudrate    =3D 115200 bps
>   console: TLB addr    =3D 0x000000003bff0000
>   console: relocaddr   =3D 0x000000003bf57000
>   console: reloc off   =3D 0x000000003bed7000
>   console: irq_sp      =3D 0x000000003bb52dd0
>   console: sp start    =3D 0x000000003bb52dd0
>   console: FB base     =3D 0x0000000000000000
>   console: Early malloc usage: 7b0 / 2000
>   console: fdt_blob    =3D 0x000000003bfbf200
>   console: U-Boot> version
>   console: U-Boot 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000)
>   console: gcc (Debian 9.2.1-22) 9.2.1 20200104
>   console: GNU ld (GNU Binutils for Debian) 2.33.1
>   console: U-Boot> reset
>   console: resetting ...
>   PASS (1.79 s)
>=20
> U-Boot is built by the Debian project, see:
> https://wiki.debian.org/InstallingDebianOn/Allwinner#Creating_a_bootabl=
e_SD_Card_with_u-boot
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  tests/acceptance/boot_linux_console.py | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/=
boot_linux_console.py
> index 3b1952b2df..989db7d461 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -603,6 +603,31 @@ def test_arm_raspi2_uboot(self):
>          exec_command_and_wait_for_pattern(self, 'version', 'U-Boot')
>          exec_command_and_wait_for_pattern(self, 'reset', 'resetting ..=
.')
> =20
> +    def test_aarch64_raspi3_uboot(self):
> +        """
> +        :avocado: tags=3Darch:aarch64
> +        :avocado: tags=3Dmachine:raspi3
> +        :avocado: tags=3Du-boot
> +        """
> +        deb_url =3D ('https://snapshot.debian.org/archive/debian/'
> +                   '20200108T145233Z/pool/main/u/u-boot/'
> +                   'u-boot-rpi_2020.01%2Bdfsg-1_arm64.deb')
> +        deb_hash =3D 'f394386e02469d52f2eb3c07a2325b1c95aeb00b'
> +        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> +        uboot_path =3D '/usr/lib/u-boot/rpi_3/u-boot.bin'
> +        uboot_path =3D self.extract_from_deb(deb_path, uboot_path)
> +
> +        self.vm.set_console(console_index=3D1)
> +        self.vm.add_args('-kernel', uboot_path,
> +                         '-no-reboot')
> +        self.vm.launch()
> +        interrupt_interactive_console_until_pattern(self,
> +                                       'Hit any key to stop autoboot:'=
,
> +                                       'Config file not found')
> +        exec_command_and_wait_for_pattern(self, 'bdinfo', 'U-Boot')
> +        exec_command_and_wait_for_pattern(self, 'version', 'U-Boot')
> +        exec_command_and_wait_for_pattern(self, 'reset', 'resetting ..=
.')
> +
>      def test_s390x_s390_ccw_virtio(self):
>          """
>          :avocado: tags=3Darch:s390x
>=20

