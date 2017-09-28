Received: from eggs.gnu.org ([2001:4830:134:3::10]:54149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dxUXy-0001ir-Gs
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 04:51:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dxUXu-0001mf-F8
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 04:51:54 -0400
Received: from 6.mo177.mail-out.ovh.net ([46.105.51.249]:55043)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dxUXu-0001kq-7t
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 04:51:50 -0400
Received: from player779.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 2D24B81703
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 10:51:44 +0200 (CEST)
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-19-clg@kaod.org> <20170919084406.GX27153@umbus>
	<5d9394e6-0e3f-7824-dd23-04107eb22582@kaod.org>
	<20170921013548.GB4998@umbus.fritz.box>
	<50588b22-8081-c353-9d83-70cf29a4daa4@kaod.org>
	<1506588226.25626.29.camel@kernel.crashing.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <bb16322a-129d-6aa0-2d84-e06978ac3cae@kaod.org>
Date: Thu, 28 Sep 2017 10:51:32 +0200
MIME-Version: 1.0
In-Reply-To: <1506588226.25626.29.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 18/21] ppc/xive: add device tree
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>

On 09/28/2017 10:43 AM, Benjamin Herrenschmidt wrote:
> On Thu, 2017-09-21 at 13:21 +0200, C=C3=A9dric Le Goater wrote:
>> Let me be more precise. I am saying that the interrupt-controller=20
>> and #interrupt-cells properties are not needed under the main interrup=
t=20
>> controller node. They can be removed from the tree and the Linux guest=
=20
>> kernel will boot perfectly well.
>=20
> No they are needed. They are the parents of PCI interrupts for example.
> There's something fishy here.

probably, I just removed the properties under QEMU and could=20
boot the guest, with disks and network.

=20
> Do you have a DT snapshot from pHyp for me to look at ?


# lsprop /proc/device-tree/interrupt-controller\@200010000/
compatible       "ibm,power-ivpe"
device_type      "power-ivpe"
ibm,xive-eq-sizes
		 00000007 00000009 0000000c 0000000e
		 00000010 00000012 00000015 00000016
		 00000018
reg              00000002 00010000 00000000 00010000
		 00000002 00000000 00000000 00010000
linux,phandle    00dce438 (14476344)
ibm,xive-lisn-ranges
		 00094000 00000030
name             "interrupt-controller"


Cheers,

C.=20

>=20
>> These properties still are needed under the sub nodes like :
>>
>> /proc/device-tree/vdevice/interrupt-controller
>> /proc/device-tree/event-sources/interrupt-controller
