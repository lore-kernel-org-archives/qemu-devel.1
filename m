Received: from eggs.gnu.org ([2001:4830:134:3::10]:42510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cPYPZ-0003Wg-4D
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 12:34:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cPYPY-0007Jj-9w
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 12:34:41 -0500
Message-ID: <1483724069.4199.80.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Fri, 06 Jan 2017 18:34:29 +0100
In-Reply-To: <20170105054618.GA12106@umbus.fritz.box>
References: <20170105054618.GA12106@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Proposal PCI/PCIe device placement on PAPR guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: thuth@redhat.com, lvivier@redhat.com, benh@kernel.crashing.org, marcel@redhat.com, aik@ozlabs.ru, groug@kaod.org, ehabkost@redhat.com, mdroth@linux.vnet.ibm.com, libvir-list@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, laine@redhat.com

[Added Laine to CC, fixed qemu-devel address]

On Thu, 2017-01-05 at 16:46 +1100, David Gibson wrote:
[...]
>=C2=A0=C2=A0=C2=A0* To allow for hotplugged devices, libvirt should also=
 add a number
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0of additional, empty vPHBs (the PAPR spec =
allows for hotplug of
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PHBs, but this is not yet implemented in q=
emu).

"A number" here will have to mean "one", same number of
empty PCIe Root Ports libvirt will add to a newly-defined
q35 guest.

>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0When hotplugging
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0a new device (or PE) libvirt should locate=
 a vPHB which doesn't
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0currently contain anything.

This will need to be a PHB-specific behavior, because at the
moment libvirt will happily pick one of the empty slots in
an existing PHB.

>=C2=A0=C2=A0=C2=A0* libvirt should only (automatically) add PHBs - never=
 root ports or
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0other PCI to PCI bridges
>=C2=A0
> In order to handle migration, the vPHBs will need to be represented in
> the domain XML, which will also allow the user to override this
> topology if they want.

We'll have to decide how to represent them in the XML, but
that's basically your average bikeshedding.


Overall, the plan seems entirely reasonable to me.

It's pretty clear at this point that pseries guest are
different enough in their handling of PCI that none of
the address allocation algorithms currently implemented
in libvirt could be quite adapted to work with it, so
a custom one is in order.

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
