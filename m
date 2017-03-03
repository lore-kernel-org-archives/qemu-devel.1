Received: from eggs.gnu.org ([2001:4830:134:3::10]:46976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cjmeB-0005A8-8r
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:49:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cjme8-00073J-8A
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:49:23 -0500
Received: from 9.mo4.mail-out.ovh.net ([46.105.40.176]:44950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cjme8-00072n-1T
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:49:20 -0500
Received: from player746.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 90944502E3
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 13:49:17 +0100 (CET)
References: <5b2054e1-5867-979b-b476-b3aa8ecc5689@redhat.com>
	<ee977c5e-affd-cf8d-d793-0d153fdf3e7d@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b1143d55-715e-0f20-a11f-068430d412e9@kaod.org>
Date: Fri, 3 Mar 2017 13:49:11 +0100
MIME-Version: 1.0
In-Reply-To: <ee977c5e-affd-cf8d-d793-0d153fdf3e7d@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] qemu-system-ppc64 crashes during "info qtree"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

On 03/03/2017 12:16 PM, C=C3=A9dric Le Goater wrote:
> On 03/03/2017 11:48 AM, Thomas Huth wrote:
>>  Hi C=C3=A9dric, hi David,
>>
>> running "info qtree" at the HMP monitor with the pseries machine
>> currently results in:
>>
>>   [...]
>>       dev: spapr-vty, id "vty@71000000"
>>         reg =3D 1895825408 (0x71000000)
>>         chardev =3D "serial0"
>>         irq =3D 4098 (0x1002)
>>   dev: spapr-rtc, id ""
>>   dev: icp, id ""
>> hw/core/sysbus.c:277:sysbus_dev_print: Object 0x7f83127fc3f0 is not an
>> instance of type sys-bus-device
>> Aborted (core dumped)
>>
>> Since the last device that is printed here is "icp" ... could that be
>> related to the recent ICP/XICS reworks that have been merged a couple =
of
>> days ago?
>=20
> The cleanup did not change the nature of ICP but as we removed=20
> the XICS object, which used to be a SysBusDevice, that might=20
> be a consequence.=20
>=20
> May be we should make the ICP objects SysBus devices now. I will=20
> check.=20

No. The problem came with the reset handlers. Sending a patch.

C.=20
