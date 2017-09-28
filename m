Received: from eggs.gnu.org ([2001:4830:134:3::10]:52266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dxUQk-0005Hv-Vj
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 04:44:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dxUQg-0005bs-3O
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 04:44:27 -0400
Message-ID: <1506588226.25626.29.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 28 Sep 2017 10:43:46 +0200
In-Reply-To: <50588b22-8081-c353-9d83-70cf29a4daa4@kaod.org>
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-19-clg@kaod.org> <20170919084406.GX27153@umbus>
	<5d9394e6-0e3f-7824-dd23-04107eb22582@kaod.org>
	<20170921013548.GB4998@umbus.fritz.box>
	<50588b22-8081-c353-9d83-70cf29a4daa4@kaod.org>
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

On Thu, 2017-09-21 at 13:21 +0200, C=C3=A9dric Le Goater wrote:
> Let me be more precise. I am saying that the interrupt-controller=20
> and #interrupt-cells properties are not needed under the main interrupt=
=20
> controller node. They can be removed from the tree and the Linux guest=20
> kernel will boot perfectly well.

No they are needed. They are the parents of PCI interrupts for example.
There's something fishy here.

Do you have a DT snapshot from pHyp for me to look at ?

> These properties still are needed under the sub nodes like :
>=20
> /proc/device-tree/vdevice/interrupt-controller
> /proc/device-tree/event-sources/interrupt-controller
