Received: from eggs.gnu.org ([2001:4830:134:3::10]:34756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRp0I-0008FY-Jk
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 18:42:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRp0E-0001xz-My
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 18:41:58 -0500
Date: Fri, 13 Jan 2017 09:56:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170112225630.GA13656@umbus.fritz.box>
References: <20170105054618.GA12106@umbus.fritz.box>
	<1483724069.4199.80.camel@redhat.com>
	<20170108234621.GB12515@umbus.fritz.box>
	<1484217095.7948.1.camel@redhat.com>
	<bdc8e732-f2e9-ff08-9a0b-30ac16cbd9c2@redhat.com>
	<148423893781.24341.140388976706291486@loki>
	<75e2809a-dab3-15f8-d125-3d2def5ebeeb@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <75e2809a-dab3-15f8-d125-3d2def5ebeeb@redhat.com>
Subject: Re: [Qemu-devel] Proposal PCI/PCIe device placement on PAPR guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laine Stump <laine@redhat.com>
Cc: libvir-list@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>, Andrea Bolognani <abologna@redhat.com>, thuth@redhat.com, lvivier@redhat.com, benh@kernel.crashing.org, marcel@redhat.com, aik@ozlabs.ru, groug@kaod.org, ehabkost@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alex Williamson <Alex.Williamson@redhat.com>


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 12, 2017 at 12:53:28PM -0500, Laine Stump wrote:
> On 01/12/2017 11:35 AM, Michael Roth wrote:
> > Quoting Laine Stump (2017-01-12 08:52:10)
> > > On 01/12/2017 05:31 AM, Andrea Bolognani wrote:
> > > > On Mon, 2017-01-09 at 10:46 +1100, David Gibson wrote:
> > > > > > >     * To allow for hotplugged devices, libvirt should also ad=
d a number
> > > > > > >       of additional, empty vPHBs (the PAPR spec allows for ho=
tplug of
> > > > > > >       PHBs, but this is not yet implemented in qemu).
> > > > > >=20
> > > > > > "A number" here will have to mean "one", same number of
> > > > > > empty PCIe Root Ports libvirt will add to a newly-defined
> > > > > > q35 guest.
> > > > >=20
> > > > > Umm.. why?
> > > >=20
> > > > Because some applications using libvirt would inevitably
> > > > start relying on the fact that such spare PHBs are
> > > > available, locking us into providing at least the same
> > > > number forever. In other words, increasing the amount at
> > > > a later time is always possible, but decreasing it isn't.
> > > > We did the same when we started automatically adding PCIe
> > > > Root Ports to q35 machines.
> > > >=20
> > > > The rationale is that having a single spare hotpluggable
> > > > slot is extremely convenient for basic usage, eg. a simple
> > > > guest created by someone who's not necessarily very
> > > > familiar with virtualization; on the other hand, if you
> > > > are actually deploying in production you ought to conduct
> > > > proper capacity planning and figure out in advance how
> > > > many devices you're likely to need to hotplug throughout
> > > > the guest's life.
> > >=20
> > > And of course the reason we don't want to add "too many" extra
> > > controllers by default is so that we don't end up with *all* guests
> > > burdened with extra hardware they don't need or want. The libguestfs
> > > appliance is one example of a libvirt consumer that definitely doesn't
> > > want extra baggage in its guests - guest startup time is very importa=
nt
> > > to libguestfs, so any addition to the hardware list is looked upon wi=
th
> > > disappointment.
> > >=20
> > > >=20
> > > > Of course this all will be moot once we can hotplug PHBs :)
> > >=20
> > > Will the guest OSes handle that properly? I remember being told that
> >=20
> > I believe on pseries we *do* scan for devices on the PHB as part of
> > bringing the PHB online in the hotplug path. But I'm not sure that
> > matters (see below).
> >=20
> > > Linux, for example, doesn't scan the new bus for devices when a new
> > > controller is added, making it pointless to hotplug a PCI controller =
(as
> > > usual, it could be that I'm remembering incorrectly...)
> > >=20
> >=20
> > Wouldn't that only be an issue if we hotplugged a PHB that already had
> > PCI devices on the bus?
>=20
>=20
> Yeah you're right, I'm probably remembering the wrong problem and wrong
> reason for the problem. I just remember there was *some* issue about
> hotplugging new PCI controllers. Possibly the internal representation of =
the
> bus hierarchy wasn't updated unless you forced a rescan of all the devices
> or something? My memory of it is vague, I just remember being told it was=
n't
> just a case of the controller itself being initialized.
>=20
> Alex or Marcel - since whatever it was I likely heard it from one of you =
(or
> imagined it in a dream), can you straighten me out?

Regardless, I'm pretty sure it won't be relevant for Power guests.
PHB hotplug has its own protocol in PAPR, and is used routinely for
Linux guests under PowerVM.

>=20
> > That only seems possible if we had a way to
> > signal phb hotplug *after* we've hotplugged some PCI devices on the bus,
> > which means we'd need some interface to trigger hotplug  beyond the
> > standard 'device_add' calls, e.g.:
> >=20
> >   device_add spapr-pci-host-bridge,hotplug-deferred=3Dtrue,id=3Dphb2,in=
dex=3D2
> >   device_add virtio-net-pci,bus=3Dphb2.0,...,hotplug-deferred=3Dtrue
> >   device_signal_hotplug phb2
> >=20
> > That's actually akin to how it's normally done on pHyp (not only for PHB
> > hotplug, but for PCI hotplug in general, which is why this could be
> > reasonably expected to work on pseries guests), but it seems quite a bit
> > different from how we'd normally handle this on kvm, which I think would
> > be something more like:
> >=20
> >   device_add spapr-pci-host-bridge,id=3Dphb2,index=3D2
> >   <wait for hotplug completion event>
> >   device_add virtio-net-pci,bus=3Dphb2.0,...
> >=20
> > In which case it doesn't really matter if the guest scans the bus at
> > hotplug time or not. Is there some other scenario where this might
> > arise?
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYeAmbAAoJEGw4ysog2bOSkUUP/R32aJc6Dk1CVQX8jh4ya1z+
9L0kiSl6AO5E/RXGQkpxsupy9k4Mats29SJsGxJ0aGxHe7x/BP7lJkMtkKf7FLsW
YakJyZo8fFZjSzbhOm+FHWZuAGvjhRMSJ04sgBDSW6GpN1O7QG5bOfHB/j+G1gKQ
9bqzoSP4cVFTTEe+IfpAVWk9A+YY/krTojrRQndizAVgDvBhrmXZxgyP2/kWMDA1
OIt2sbpGLRGXHzUq1sAQ2jkoGFgiWDSMwdbZyA7rqqMenZlGnZJTMyXcRemLLjrc
oWY35gcuWb2tz1lN49UiKxY81HyS9/i8Wl4y0Im0W6akZKEPMKXrw+O4tzaruh6W
mLGKWjUvaosQQE4/rZYFDZ57WSNooEdCkvyBbs9wjuCjfluG5jJV33sD7brBbKIK
0UDeYy6D9hdIZt2NSCrtHVl/MprJ99+tL3pI2ssU2z4XyAt2K4S1zw0jjBYk0rTX
rxjO+STJ5moB2ajAp1DiY6cpdvFrFI4HW+yRywgwvcwA16qT5ImY7K7/GNb0+t+t
tpFa3nIzIJmd3PL3X8B5PCU8Ru4NYWz0Pm10pivhDN7QGxtXebxEr8N0ZHqAVU+Q
BsclEKRjQIZnTrORgDaS4VufieyE5X/bg1m8nv7sQpUoxc5V7ReMWdUEFChc9hhT
YHHFEiukTtKC2W8sm24S
=dYOb
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
