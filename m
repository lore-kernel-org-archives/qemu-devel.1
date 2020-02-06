Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47DEC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:22:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8322B206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8322B206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izgBE-0002ld-La
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 07:22:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1izgAV-0002H0-Fw
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:22:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1izgAT-0001If-Va
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:22:03 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:31986)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1izgAN-0000JH-VX; Thu, 06 Feb 2020 07:21:57 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 29DAA747DCF;
 Thu,  6 Feb 2020 13:21:45 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E9E2974637F; Thu,  6 Feb 2020 13:21:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E89A074637D;
 Thu,  6 Feb 2020 13:21:44 +0100 (CET)
Date: Thu, 6 Feb 2020 13:21:44 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH v2 01/30] hw/arm/raspi: Use BCM2708 machine type with
 pre Device Tree kernels
In-Reply-To: <20200206011756.2413-2-f4bug@amsat.org>
Message-ID: <alpine.BSF.2.22.395.2002061320310.71431@zero.eik.bme.hu>
References: <20200206011756.2413-1-f4bug@amsat.org>
 <20200206011756.2413-2-f4bug@amsat.org>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1696612204-1580991704=:71431"
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1696612204-1580991704=:71431
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Feb 2020, Philippe Mathieu-Daud=C3=A9 wrote:
> When booting without device tree, the Linux kernels uses the $R1
> register to determine the machine type. The list of values is
> registered at [1].
>
> There are two entries for the Raspberry Pi:
>
> - https://www.arm.linux.org.uk/developer/machines/list.php?mid=3D3138
>  name: MACH_TYPE_BCM2708
>  value: 0xc42 (3138)
>  status: Active, not mainlined
>  date: 15 Oct 2010
>
> - https://www.arm.linux.org.uk/developer/machines/list.php?mid=3D4828
>  name: MACH_TYPE_BCM2835
>  value: 4828
>  status: Active, mainlined
>  date: 6 Dec 2013
>
> QEMU always used the non-mainlined type MACH_TYPE_BCM2708.
> The value 0xc43 is registered to 'MX51_GGC' (processor i.MX51), and
> 0xc44 to 'Western Digital Sharespace NAS' (processor Marvell 88F5182).
>
> The Raspberry Pi foundation bootloader only sets the BCM2708 machine
> type, see [2] or [3]:
>
> 133 9:
> 134     mov r0, #0
> 135     ldr r1, =3D3138       @ BCM2708 machine id
> 136     ldr r2, atags       @ ATAGS
> 137     bx  r4
>
> U-Boot only uses MACH_TYPE_BCM2708 (see [4]):
>
> 25 /*
> 26  * 2835 is a SKU in a series for which the 2708 is the first or prim=
ary SoC,
> 27  * so 2708 has historically been used rather than a dedicated 2835 I=
D.
> 28  *
> 29  * We don't define a machine type for bcm2709/bcm2836 since the RPi =
Foundation
> 30  * chose to use someone else's previously registered machine ID (313=
9, MX51_GGC)
> 31  * rather than obtaining a valid ID:-/
> 32  *
> 33  * For the bcm2837, hopefully a machine type is not needed, since ev=
erything
> 34  * is DT.
> 35  */
>
> While the definition MACH_BCM2709 with value 0xc43 was introduced in
> a commit described "Add 2709 platform for Raspberry Pi 2" out of the
> mainline Linux kernel, it does not seem used, and the platform is
> introduced with Device Tree support anyway (see [5] and [6]).
>
> Remove the unused values (0xc43 introduced in commit 1df7d1f9303aef
> "raspi: add raspberry pi 2 machine" and 0xc44 in commit bade58166f4
> "raspi: Raspberry Pi 3 support"), keeping only MACH_TYPE_BCM2708.
>
> [1] https://www.arm.linux.org.uk/developer/machines/
> [2] https://github.com/raspberrypi/tools/blob/920c7ed2e/armstubs/armstu=
b7.S#L135
> [3] https://github.com/raspberrypi/tools/blob/49719d554/armstubs/armstu=
b7.S#L64
> [4] https://gitlab.denx.de/u-boot/u-boot/blob/v2015.04/include/configs/=
rpi-common.h#L18
> [5] https://github.com/raspberrypi/linux/commit/d9fac63adac#diff-672203=
7d79570df5b392a49e0e006573R526
> [6] http://lists.infradead.org/pipermail/linux-rpi-kernel/2015-February=
/001268.html
>
> Cc: Zolt=C3=A1n Baldaszti <bztemail@gmail.com>
> Cc: Pekka Enberg <penberg@iki.fi>
> Cc: Stephen Warren <swarren@nvidia.com>
> Cc: Kshitij Soni <kshitij.soni@broadcom.com>
> Cc: Michael Chan <michael.chan@broadcom.com>
> Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> hw/arm/raspi.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 3996f6c63a..ef76a27f33 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -29,8 +29,7 @@
> #define FIRMWARE_ADDR_3 0x80000 /* Pi 3 loads kernel.img here by defaul=
t */
> #define SPINTABLE_ADDR  0xd8 /* Pi 3 bootloader spintable */
>
> -/* Table of Linux board IDs for different Pi versions */
> -static const int raspi_boardid[] =3D {[1] =3D 0xc42, [2] =3D 0xc43, [3=
] =3D 0xc44};

Maybe worth a comment about why using this number (short, one line versio=
n=20
of commit message).

Regards,
BALATON Zoltan

> +#define MACH_TYPE_BCM2708   3138 /* Linux board IDs */
>
> typedef struct RasPiState {
>     BCM283XState soc;
> @@ -116,7 +115,7 @@ static void setup_boot(MachineState *machine, int v=
ersion, size_t ram_size)
>     static struct arm_boot_info binfo;
>     int r;
>
> -    binfo.board_id =3D raspi_boardid[version];
> +    binfo.board_id =3D MACH_TYPE_BCM2708;
>     binfo.ram_size =3D ram_size;
>     binfo.nb_cpus =3D machine->smp.cpus;
>
>
--3866299591-1696612204-1580991704=:71431--

