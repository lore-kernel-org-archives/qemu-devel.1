Received: from eggs.gnu.org ([2001:4830:134:3::10]:45147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cRcfZ-0004Jn-KY
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 05:31:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cRcfW-0002DN-Iw
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 05:31:45 -0500
Message-ID: <1484217095.7948.1.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Thu, 12 Jan 2017 11:31:35 +0100
In-Reply-To: <20170108234621.GB12515@umbus.fritz.box>
References: <20170105054618.GA12106@umbus.fritz.box>
	<1483724069.4199.80.camel@redhat.com>
	<20170108234621.GB12515@umbus.fritz.box>
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

On Mon, 2017-01-09 at 10:46 +1100, David Gibson wrote:
> > >=C2=A0=C2=A0=C2=A0=C2=A0* To allow for hotplugged devices, libvirt s=
hould also add a number
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0of additional, empty vPHBs (the =
PAPR spec allows for hotplug of
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PHBs, but this is not yet implem=
ented in qemu).
> >=C2=A0
> > "A number" here will have to mean "one", same number of
> > empty PCIe Root Ports libvirt will add to a newly-defined
> > q35 guest.
>=C2=A0
> Umm.. why?

Because some applications using libvirt would inevitably
start relying on the fact that such spare PHBs are
available, locking us into providing at least the same
number forever. In other words, increasing the amount at
a later time is always possible, but decreasing it isn't.
We did the same when we started automatically adding PCIe
Root Ports to q35 machines.

The rationale is that having a single spare hotpluggable
slot is extremely convenient for basic usage, eg. a simple
guest created by someone who's not necessarily very
familiar with virtualization; on the other hand, if you
are actually deploying in production you ought to conduct
proper capacity planning and figure out in advance how
many devices you're likely to need to hotplug throughout
the guest's life.

Of course this all will be moot once we can hotplug PHBs :)

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
