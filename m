Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53C5C7619B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 08:31:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90C44206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 08:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="hErKRL/r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C44206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3bo7-0003uG-Jc
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 03:31:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45024)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1j3blk-0001we-Gc
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:28:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luc.michel@greensocs.com>) id 1j3blj-00079b-8A
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:28:44 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:47228)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luc.michel@greensocs.com>)
 id 1j3blj-000797-02
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:28:43 -0500
Received: from [172.16.11.100] (tiramisu.bar.greensocs.com [172.16.11.100])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 82DF296F50;
 Mon, 17 Feb 2020 08:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1581928121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UCjp1xR35FlrZa287Kwik/TLNVHebZmQG69LGZLeWvo=;
 b=hErKRL/r6dR/+OJG/dTjmculoA1TgULVLYixFyh2mHMEkjOKvRDi4psGebDXkanSMNQwVW
 cpuNVGtmWHnMqFnkMHQWdKTIYhfxC7cbdgySzdu0+/zU8XVfCPV9p1PxDg5fnXO6EuVA2n
 8xWE9itZYg+AHzHiQnLo9BB1hOlLLZE=
Subject: Re: [PATCH 6/8] tests/boot_linux_console: Test booting U-Boot on the
 Raspberry Pi 2
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200215192216.4899-1-f4bug@amsat.org>
 <20200215192216.4899-7-f4bug@amsat.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <bd12d11d-6e23-9628-24c8-cd8f28440de3@greensocs.com>
Date: Mon, 17 Feb 2020 09:28:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200215192216.4899-7-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-PH
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1581928122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UCjp1xR35FlrZa287Kwik/TLNVHebZmQG69LGZLeWvo=;
 b=B9fBZsvZsJxQ+ODjyhKqcoGvH95ikbFm/FSb6tm61bHDjmLfs9IseLfRk9HvsduCb2KI5r
 RtI6u/pZqIEJmRtyJCQR+tnPLayYbzveHdwMeg15hcEtiZrLrxfcRsXoDbB1UAkrRL2gzs
 XLW+qNEvDMpPezSMCYGeSmE5u2UV704=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1581928122; a=rsa-sha256; cv=none;
 b=VWE1TTy5zTPRTZ7SgnGbzkHQuitkt9e/UYl9bi6q62nM2N0mpFWQI6M6N7lj0Aa7EaAwu3
 sS7LHGNN7gCQtDJrRr/aLvZUkg7mUEgxj8Ztm8h8QTVvFg4ZdBJT4r7qAfRXCz8D/up5px
 xC59Q8+4KIuV41rvaS2Qsfu2+AnI6Kw=
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
> This test runs U-Boot on the Raspberry Pi 2.
> It is very simple and fast:
>=20
>   $ avocado --show=3Dapp,console run -t raspi2 -t u-boot tests/acceptan=
ce/
>   JOB LOG    : avocado/job-results/job-2020-01-20T23.40-2424777/job.log
>    (1/1) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_a=
rm_raspi2_uboot:
>   console: MMC:   sdhci@7e300000: 0
>   console: Loading Environment from FAT... Card did not respond to volt=
age select!
>   console: In:    serial
>   console: Out:   vidconsole
>   console: Err:   vidconsole
>   console: Net:   No ethernet found.
>   console: starting USB...
>   console: USB0:   Port not available.
>   console: Hit any key to stop autoboot:  0
>   console: U-Boot>
>   console: U-Boot> bdinfo
>   console: arch_number =3D 0x00000000
>   console: boot_params =3D 0x00000100
>   console: DRAM bank   =3D 0x00000000
>   console: -> start    =3D 0x00000000
>   console: -> size     =3D 0x3c000000
>   console: baudrate    =3D 115200 bps
>   console: TLB addr    =3D 0x3bff0000
>   console: relocaddr   =3D 0x3bf64000
>   console: reloc off   =3D 0x3bf5c000
>   console: irq_sp      =3D 0x3bb5fec0
>   console: sp start    =3D 0x3bb5feb0
>   console: Early malloc usage: 2a4 / 400
>   console: fdt_blob    =3D 0x3bfbdfb0
>   console: U-Boot> version
>   console: U-Boot 2019.01+dfsg-7 (May 14 2019 - 02:07:44 +0000)
>   console: gcc (Debian 8.3.0-7) 8.3.0
>   console: GNU ld (GNU Binutils for Debian) 2.31.1
>   console: U-Boot> reset
>   console: resetting ...
>   PASS (0.46 s)
>=20
> U-Boot is built by the Debian project, see:
> https://wiki.debian.org/InstallingDebianOn/Allwinner#Creating_a_bootabl=
e_SD_Card_with_u-boot
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  tests/acceptance/boot_linux_console.py | 28 ++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/=
boot_linux_console.py
> index 3d442b6cd1..3b1952b2df 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -16,6 +16,7 @@
>  from avocado import skipUnless
>  from avocado_qemu import Test
>  from avocado_qemu import exec_command_and_wait_for_pattern
> +from avocado_qemu import interrupt_interactive_console_until_pattern
>  from avocado_qemu import wait_for_console_pattern
>  from avocado.utils import process
>  from avocado.utils import archive
> @@ -575,6 +576,33 @@ def test_arm_cubieboard_sata(self):
>          exec_command_and_wait_for_pattern(self, 'reboot',
>                                                  'reboot: Restarting sy=
stem')
> =20
> +    def test_arm_raspi2_uboot(self):
> +        """
> +        :avocado: tags=3Darch:arm
> +        :avocado: tags=3Dmachine:raspi2
> +        :avocado: tags=3Du-boot
> +        """
> +        deb_url =3D ('https://snapshot.debian.org/archive/debian/'
> +                   '20190514T084354Z/pool/main/u/u-boot/'
> +                   'u-boot-rpi_2019.01%2Bdfsg-7_armhf.deb')
> +        deb_hash =3D 'ad858cf3afe623b6c3fa2e20dcdd1768fcb9ae83'
> +        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> +        uboot_path =3D '/usr/lib/u-boot/rpi_2/uboot.elf'
> +        uboot_path =3D self.extract_from_deb(deb_path, uboot_path)
> +
> +        self.vm.set_console()
> +        self.vm.add_args('-kernel', uboot_path,
> +                         # VideoCore starts CPU with only 1 core enabl=
ed
> +                         '-global', 'bcm2836.enabled-cpus=3D1',
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

