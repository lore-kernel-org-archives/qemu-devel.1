Received: from eggs.gnu.org ([2001:4830:134:3::10]:38275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dKhN8-0000YP-46
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 04:40:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dKhN4-0005IZ-Vz
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 04:40:22 -0400
Received: from 7.mo5.mail-out.ovh.net ([178.32.124.100]:41759)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dKhN4-0005IF-QJ
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 04:40:18 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 6AE5C106044
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 10:40:11 +0200 (CEST)
Date: Tue, 13 Jun 2017 10:40:03 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170613104003.233e21d5@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170613080631.GB30171@umbus>
References: <149685579678.12025.9278446121024037161.stgit@bahia.lan>
	<149685584629.12025.14875914798241845062.stgit@bahia.lan>
	<20170608040857.GV13397@umbus.fritz.box>
	<20170608115410.2e7a2511@bahia.ttt.fr.ibm.com>
	<20170612142456.GJ18542@umbus>
	<20170613093359.4567ba94@bahia.ttt.fr.ibm.com>
	<20170613080631.GB30171@umbus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/hre0zq9+U0yVtsqoZx/YLzV";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v3 5/5] spapr: fix migration of ICPState
 objects from/to older QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan
	Gilbert" <dgilbert@redhat.com>

--Sig_/hre0zq9+U0yVtsqoZx/YLzV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Jun 2017 16:06:31 +0800
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Jun 13, 2017 at 09:33:59AM +0200, Greg Kurz wrote:
[...]
> > > > > > +static void pre_2_10_vmstate_register_dummy_icp(sPAPRMachineSt=
ate *spapr, int i)
> > > > > > +{
> > > > > > +    bool *flag =3D &spapr->pre_2_10_ignore_icp[i];
> > > > > > +
> > > > > > +    g_assert(!*flag);     =20
> > > > >=20
> > > > > Apart from this assert(), you never seem to test the values in the
> > > > > pre_2_10_ignore_icp() array, so it seems a bit pointless.
> > > > >    =20
> > > >=20
> > > > There's the opposite check in pre_2_10_vmstate_unregister_dummy_icp=
().
> > > > But I agree it isn't really useful... but more because of paranoia =
:)   =20
> > >=20
> > > I'm all for paranoid assert()s if they can be made using data readily
> > > to hand.  Adding a data structure just for the purpose of making an
> > > assert() later, not so much.
> > >  =20
> >=20
> > It is also passed as opaque argument to vmstate_register(), where it is
> > used as a key when calling vmstate_unregister(). I could possibly pass
> > (void *) i instead, but I'm not a big fan of hijacking pointer arguments
> > to pass numbers. =20
>=20
> Ah, I see your point.  Creating an array, purely to generate arbitrary
> pointers is also kind of ugly, though.  Really the cpu_index / XICS
> server number makes sense to identify the vmstate, but it looks like
> vmstate_unregister() doesn't take that.
>=20

Indeed... what about adding a vmstate_unregister_by_instance_id() then ?

Cc'ing Juan and David.

--
Greg

--Sig_/hre0zq9+U0yVtsqoZx/YLzV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlk/pOQACgkQAvw66wEB28LP6wCdGjXeezSrgPRbtFUFPYK/f2sk
kCkAoKjEh1FHz0ucCfQZB83B85PDk7oP
=rtS/
-----END PGP SIGNATURE-----

--Sig_/hre0zq9+U0yVtsqoZx/YLzV--
