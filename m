Received: from eggs.gnu.org ([2001:4830:134:3::10]:41181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dxVfv-0003rJ-Ge
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 06:04:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dxVfs-0007Qy-9w
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 06:04:11 -0400
Message-ID: <1506593024.25626.33.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 28 Sep 2017 12:03:44 +0200
In-Reply-To: <bb16322a-129d-6aa0-2d84-e06978ac3cae@kaod.org>
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-19-clg@kaod.org> <20170919084406.GX27153@umbus>
	<5d9394e6-0e3f-7824-dd23-04107eb22582@kaod.org>
	<20170921013548.GB4998@umbus.fritz.box>
	<50588b22-8081-c353-9d83-70cf29a4daa4@kaod.org>
	<1506588226.25626.29.camel@kernel.crashing.org>
	<bb16322a-129d-6aa0-2d84-e06978ac3cae@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>

On Thu, 2017-09-28 at 10:51 +0200, C=C3=A9dric Le Goater wrote:
> probably, I just removed the properties under QEMU and could=20
> boot the guest, with disks and network.

As long as you don't use LSIs...
> =20
> > Do you have a DT snapshot from pHyp for me to look at ?
>=20
>=20
> # lsprop /proc/device-tree/interrupt-controller\@200010000/
> compatible       "ibm,power-ivpe"
> device_type      "power-ivpe"
> ibm,xive-eq-sizes
>                  00000007 00000009 0000000c 0000000e
>                  00000010 00000012 00000015 00000016
>                  00000018
> reg              00000002 00010000 00000000 00010000
>                  00000002 00000000 00000000 00010000
> linux,phandle    00dce438 (14476344)
> ibm,xive-lisn-ranges
>                  00094000 00000030
> name             "interrupt-controller"
>=20
>=20
> Cheers,
