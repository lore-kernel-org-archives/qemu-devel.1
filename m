Received: from eggs.gnu.org ([2001:4830:134:3::10]:38174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fYZBg-0003Xm-8Q
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:50:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fYZBc-0001t2-V0
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:50:24 -0400
Received: from 9.mo68.mail-out.ovh.net ([46.105.78.111]:37840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fYZBc-0001rh-IC
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:50:20 -0400
Received: from player158.ha.ovh.net (unknown [10.109.120.91])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id DA6AAE9B43
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 17:50:18 +0200 (CEST)
References: <cover.1529839203.git.balaton@eik.bme.hu>
	<61b9cf7d09f0f12a86f036b828665c3fc91c3ce9.1529839203.git.balaton@eik.bme.hu>
	<51f8a2ca-0b35-dd1b-33a5-1fca51ef7a9c@kaod.org>
	<alpine.BSF.2.21.1806242200550.67254@zero.eik.bme.hu>
	<5f5a8c59-9466-75ce-f291-ca2841ea5a99@kaod.org>
	<alpine.BSF.2.21.1806281625070.26695@zero.eik.bme.hu>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <57c056a7-3cf5-c9a7-6cc6-e7f074705160@kaod.org>
Date: Thu, 28 Jun 2018 17:50:12 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1806281625070.26695@zero.eik.bme.hu>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v5 1/4] ppc4xx_i2c: Rewrite to
 model hardware more closely
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 06/28/2018 04:34 PM, BALATON Zoltan wrote:
> On Thu, 28 Jun 2018, C=E9dric Le Goater wrote:
>> I have tried an ISO from :
>>
>> =A0=A0=A0=A0http://aros.sourceforge.net/nightly1.php
>>
>> which boots and writes :
>>
>> =A0U-Boot 2010.06.05 (Oct 22 2017 - 17:40:02)
>>
>> =A0CPU:=A0=A0 AMCC PowerPC 460EX Rev. B at 1150 MHz (PLB=3D230 OPB=3D1=
15 EBC=3D115)
>> =A0=A0=A0=A0=A0=A0=A0 No Security/Kasumi support
>> =A0=A0=A0=A0=A0=A0=A0 Bootstrap Option A - Boot ROM Location EBC (8 bi=
ts)
>> =A0=A0=A0=A0=A0=A0=A0 Internal PCI arbiter disabled
>> =A0=A0=A0=A0=A0=A0=A0 32 kB I-Cache 32 kB D-Cache
>> =A0Board: Sam460ex, PCIe 4x + SATA-2
>> =A0I2C:=A0=A0 ready
>> =A0DRAM:=A0 512 MiB (ECC not enabled, 460 MHz, CL0)
>> =A0*** Warning - bad CRC, using default environment
>>
>> =A0PCI:=A0=A0 Bus Dev VenId DevId Class Int
>> =A0=A0=A0=A0=A0=A0=A0=A0 00=A0 06=A0 126f=A0 0501=A0 0380=A0 00
>> =A0PCIE1: successfully set as root-complex
>> =A0Net:=A0=A0 ppc_4xx_eth0
>> =A0FPGA:=A0 Revision 00 (20 0-00-00)
>> =A0SM502: found
>> =A0VGA:=A0=A0 NO CARDS
>=20
> This is the U-Boot firmware that prints this.
>=20
>> and on the graphic window :
>>
>> =A0FLB: no SLB found in any of the designated boot sources, returning =
to u-boot.
>=20
> And also this is from U-Boot saying it could not find bootable image so=
 it did not boot. (One could test i2c from u_boot with date and i2c comma=
nds as well.)
>=20
>> the graphical bool loader menu works but I couldn't exercise much more=
 the
>> system.
>=20
> Have you by chance used the -cdrom shortcut? That tries to connect CDRO=
M to secondary master but the sii3112 this board uses only has 2 SATA por=
ts so this won't work. You need to use the long options like
>=20
> -drive if=3Dnone,id=3Dcd,file=3Daros-sam440-ppc.iso,format=3Draw \
> -device ide-cd,drive=3Dcd,bus=3Dide.0
>=20
> I'm not sure how to fix -cdrom or have it print a meaningful warning or=
 error.

Looks good :

[BATT] i2c=3D011bc904
[BATT] Probing i2c RTC...
[BATT] RTC found. Object=3D011ba234
[BATT] Dump:  35 46 15 04 28 06 18=20

C.=20
