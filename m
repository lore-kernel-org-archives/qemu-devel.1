Received: from eggs.gnu.org ([2001:4830:134:3::10]:44508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cS4jN-0000p0-1n
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 11:29:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cS4jI-0004Aw-5E
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 11:29:33 -0500
Received: from 11.mo1.mail-out.ovh.net ([188.165.48.29]:57346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cS4jH-00049B-Vd
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 11:29:28 -0500
Received: from player726.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 00E5238602
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 17:29:16 +0100 (CET)
Date: Fri, 13 Jan 2017 17:29:00 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170113172900.2575cc19@bahia.lan>
In-Reply-To: <20170112225736.GB13656@umbus.fritz.box>
References: <20170105054618.GA12106@umbus.fritz.box>
	<1483724069.4199.80.camel@redhat.com>
	<20170108234621.GB12515@umbus.fritz.box>
	<1484217095.7948.1.camel@redhat.com>
	<20170112225736.GB13656@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/EjNoJOXp.8/gnjCm3uHpd3p";
	protocol="application/pgp-signature"
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
Cc: Andrea Bolognani <abologna@redhat.com>, thuth@redhat.com, lvivier@redhat.com, benh@kernel.crashing.org, marcel@redhat.com, aik@ozlabs.ru, ehabkost@redhat.com, mdroth@linux.vnet.ibm.com, libvir-list@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, laine@redhat.com

--Sig_/EjNoJOXp.8/gnjCm3uHpd3p
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Jan 2017 09:57:36 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Jan 12, 2017 at 11:31:35AM +0100, Andrea Bolognani wrote:
> > On Mon, 2017-01-09 at 10:46 +1100, David Gibson wrote: =20
> > > > >=C2=A0=C2=A0=C2=A0=C2=A0* To allow for hotplugged devices, libvirt=
 should also add a number
> > > > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0of additional, empty vPHBs (th=
e PAPR spec allows for hotplug of
> > > > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PHBs, but this is not yet impl=
emented in qemu). =20
> > > >=C2=A0
> > > > "A number" here will have to mean "one", same number of
> > > > empty PCIe Root Ports libvirt will add to a newly-defined
> > > > q35 guest. =20
> > >=C2=A0
> > > Umm.. why? =20
> >=20
> > Because some applications using libvirt would inevitably
> > start relying on the fact that such spare PHBs are
> > available, locking us into providing at least the same
> > number forever. In other words, increasing the amount at
> > a later time is always possible, but decreasing it isn't.
> > We did the same when we started automatically adding PCIe
> > Root Ports to q35 machines.
> >=20
> > The rationale is that having a single spare hotpluggable
> > slot is extremely convenient for basic usage, eg. a simple
> > guest created by someone who's not necessarily very
> > familiar with virtualization; on the other hand, if you
> > are actually deploying in production you ought to conduct
> > proper capacity planning and figure out in advance how
> > many devices you're likely to need to hotplug throughout
> > the guest's life. =20
>=20
> Hm, ok.  Well I guess the limitation is the same as on x86, so it
> shouldn't surprise people.
>=20
> > Of course this all will be moot once we can hotplug PHBs :) =20
>=20
> Yes.  Unfortunately, nobody's actually working on that at present.
>=20

Well, there might be someone now :)

Michael Roth had posted a RFC patchset back in 2015:

https://lists.gnu.org/archive/html/qemu-ppc/2015-04/msg00275.html

I'll start from here.

Cheers.

--
Greg

--Sig_/EjNoJOXp.8/gnjCm3uHpd3p
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlh5AEwACgkQAvw66wEB28IY4gCaA/LcdhBMkUABmcUuzFtF+jdh
6fQAoI3ndmPEKOnxHe5z6zSaaZa5RHWX
=W+73
-----END PGP SIGNATURE-----

--Sig_/EjNoJOXp.8/gnjCm3uHpd3p--
