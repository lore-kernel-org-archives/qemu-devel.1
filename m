Received: from eggs.gnu.org ([2001:4830:134:3::10]:43986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dxTyJ-0005Cy-Ly
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 04:15:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dxTyF-0006AU-Mo
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 04:15:03 -0400
Message-ID: <1506586475.25626.12.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 28 Sep 2017 10:14:35 +0200
In-Reply-To: <d3a85114-ab64-5086-31b0-27124c4a5fbb@kaod.org>
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-14-clg@kaod.org> <20170919075300.GQ27153@umbus>
	<d3a85114-ab64-5086-31b0-27124c4a5fbb@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 13/21] ppc/xive: handle interrupt
 acknowledgment by the O/S
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

On Wed, 2017-09-20 at 11:40 +0200, C=C3=A9dric Le Goater wrote:
> > Plus, this doesn't seem right.  Shouldn't this
> > recheck the CPPR against the PIPR, in case a higher priority irq has
> > been delivered since the one the cpu is acking.
>=20
> If a higher priority is delivered, it means that the CPPR was more=20
> privileged and that we have now two bits set in the IPB by the time=20
> the interrupt is acked. The high priority PIPR will become the new=20
> CPPR and the IBP will be modified keeping only the lower priority.=20
>=20
> if the CPPR is modified to the lower priority level, then the=20
> first interrupt will be delivered again.=20
>=20
> I think this is fine.

Also remember the HW PIPR behaviour, its a bit odd, it will be clamped
by the CPPR. So if CPPR is 0 PIPR will be 0.

If CPPR is 7, PIPR will be <=3D 7, etc...

Cheers,
Ben.
