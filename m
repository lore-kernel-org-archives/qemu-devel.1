Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78943C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 22:21:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F19220720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 22:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F19220720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0C0E-0001L5-G6
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 17:21:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j0Byl-0000de-4e
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 17:20:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j0Byj-0007Bq-Jo
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 17:20:03 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:63742)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1j0Byd-0005q8-Al; Fri, 07 Feb 2020 17:19:56 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 8B7327461AE;
 Fri,  7 Feb 2020 23:19:45 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id F21FE745953; Fri,  7 Feb 2020 23:19:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id F094374569F;
 Fri,  7 Feb 2020 23:19:44 +0100 (CET)
Date: Fri, 7 Feb 2020 23:19:44 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 01/30] hw/arm/raspi: Use BCM2708 machine type with
 pre Device Tree kernels
In-Reply-To: <27d1f0e2-941c-11ca-d736-f25af055d9da@redhat.com>
Message-ID: <alpine.BSF.2.22.395.2002072308310.88696@zero.eik.bme.hu>
References: <20200206011756.2413-1-f4bug@amsat.org>
 <20200206011756.2413-2-f4bug@amsat.org>
 <alpine.BSF.2.22.395.2002061320310.71431@zero.eik.bme.hu>
 <27d1f0e2-941c-11ca-d736-f25af055d9da@redhat.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-1581770763-1581113487=:88696"
Content-ID: <alpine.BSF.2.22.395.2002072311370.88696@zero.eik.bme.hu>
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
Cc: qemu-arm@nongnu.org,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1581770763-1581113487=:88696
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-ID: <alpine.BSF.2.22.395.2002072311371.88696@zero.eik.bme.hu>
Content-Transfer-Encoding: quoted-printable

On Fri, 7 Feb 2020, Philippe Mathieu-Daud=E9 wrote:
> On 2/6/20 1:21 PM, BALATON Zoltan wrote:
>> On Thu, 6 Feb 2020, Philippe Mathieu-Daud=E9 wrote:
>>> When booting without device tree, the Linux kernels uses the $R1
>>> register to determine the machine type. The list of values is
>>> registered at [1].
>>>=20
>>> There are two entries for the Raspberry Pi:
>>>=20
>>> - https://www.arm.linux.org.uk/developer/machines/list.php?mid=3D3138
>>> =A0name: MACH_TYPE_BCM2708
>>> =A0value: 0xc42 (3138)
>>> =A0status: Active, not mainlined
>>> =A0date: 15 Oct 2010
>>>=20
>>> - https://www.arm.linux.org.uk/developer/machines/list.php?mid=3D4828
>>> =A0name: MACH_TYPE_BCM2835
>>> =A0value: 4828
>>> =A0status: Active, mainlined
>>> =A0date: 6 Dec 2013
>>>=20
>>> QEMU always used the non-mainlined type MACH_TYPE_BCM2708.
>>> The value 0xc43 is registered to 'MX51_GGC' (processor i.MX51), and
>>> 0xc44 to 'Western Digital Sharespace NAS' (processor Marvell 88F5182)=
.
>>>=20
>>> The Raspberry Pi foundation bootloader only sets the BCM2708 machine
>>> type, see [2] or [3]:
>>>=20
>>> 133 9:
>>> 134=A0=A0=A0=A0 mov r0, #0
>>> 135=A0=A0=A0=A0 ldr r1, =3D3138=A0=A0=A0=A0=A0=A0 @ BCM2708 machine i=
d
>>> 136=A0=A0=A0=A0 ldr r2, atags=A0=A0=A0=A0=A0=A0 @ ATAGS
>>> 137=A0=A0=A0=A0 bx=A0 r4
>>>=20
>>> U-Boot only uses MACH_TYPE_BCM2708 (see [4]):
>>>=20
>>> 25 /*
>>> 26=A0 * 2835 is a SKU in a series for which the 2708 is the first or =
primary=20
>>> SoC,
>>> 27=A0 * so 2708 has historically been used rather than a dedicated 28=
35 ID.
>>> 28=A0 *
>>> 29=A0 * We don't define a machine type for bcm2709/bcm2836 since the =
RPi=20
>>> Foundation
>>> 30=A0 * chose to use someone else's previously registered machine ID =
(3139,=20
>>> MX51_GGC)
>>> 31=A0 * rather than obtaining a valid ID:-/
>>> 32=A0 *
>>> 33=A0 * For the bcm2837, hopefully a machine type is not needed, sinc=
e=20
>>> everything
>>> 34=A0 * is DT.
>>> 35=A0 */
>>>=20
>>> While the definition MACH_BCM2709 with value 0xc43 was introduced in
>>> a commit described "Add 2709 platform for Raspberry Pi 2" out of the
>>> mainline Linux kernel, it does not seem used, and the platform is
>>> introduced with Device Tree support anyway (see [5] and [6]).
>>>=20
>>> Remove the unused values (0xc43 introduced in commit 1df7d1f9303aef
>>> "raspi: add raspberry pi 2 machine" and 0xc44 in commit bade58166f4
>>> "raspi: Raspberry Pi 3 support"), keeping only MACH_TYPE_BCM2708.
>>>=20
>>> [1] https://www.arm.linux.org.uk/developer/machines/
>>> [2]=20
>>> https://github.com/raspberrypi/tools/blob/920c7ed2e/armstubs/armstub7=
.S#L135=20
>>> [3]=20
>>> https://github.com/raspberrypi/tools/blob/49719d554/armstubs/armstub7=
.S#L64=20
>>> [4]=20
>>> https://gitlab.denx.de/u-boot/u-boot/blob/v2015.04/include/configs/rp=
i-common.h#L18=20
>>> [5]=20
>>> https://github.com/raspberrypi/linux/commit/d9fac63adac#diff-6722037d=
79570df5b392a49e0e006573R526=20
>>> [6]=20
>>> http://lists.infradead.org/pipermail/linux-rpi-kernel/2015-February/0=
01268.html=20
>>>=20
>>> Cc: Zolt=E1n Baldaszti <bztemail@gmail.com>
>>> Cc: Pekka Enberg <penberg@iki.fi>
>>> Cc: Stephen Warren <swarren@nvidia.com>
>>> Cc: Kshitij Soni <kshitij.soni@broadcom.com>
>>> Cc: Michael Chan <michael.chan@broadcom.com>
>>> Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>
>>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>>> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>>> ---
>>> hw/arm/raspi.c | 5 ++---
>>> 1 file changed, 2 insertions(+), 3 deletions(-)
>>>=20
>>> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
>>> index 3996f6c63a..ef76a27f33 100644
>>> --- a/hw/arm/raspi.c
>>> +++ b/hw/arm/raspi.c
>>> @@ -29,8 +29,7 @@
>>> #define FIRMWARE_ADDR_3 0x80000 /* Pi 3 loads kernel.img here by defa=
ult=20
>>> */
>>> #define SPINTABLE_ADDR=A0 0xd8 /* Pi 3 bootloader spintable */
>>>=20
>>> -/* Table of Linux board IDs for different Pi versions */
>>> -static const int raspi_boardid[] =3D {[1] =3D 0xc42, [2] =3D 0xc43, =
[3] =3D=20
>>> 0xc44};
>>=20
>> Maybe worth a comment about why using this number (short, one line ver=
sion=20
>> of commit message).
>
> You mean something like:
>
> /* Registered machine type:
> * https://www.arm.linux.org.uk/developer/machines/list.php?mid=3D3138
> */

I think a link in a comment is not very convenient (and may break if the=20
website is ever moved) so maybe just a line to say why this particular=20
number was chosen would be better, such as

/* This matches RPi Foundation bootloader and U-Boot */

>> +#define MACH_TYPE_BCM2708=A0=A0 3138 /* Linux board IDs */

The rest of the detailed explanation could be looked up in the commit=20
message. Just suggested the comment to warn readers that this is not a=20
mistake but a pecularity of the platform.

Regards,
BALATON Zoltan
--3866299591-1581770763-1581113487=:88696--

