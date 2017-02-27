Received: from eggs.gnu.org ([2001:4830:134:3::10]:33834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciTYM-0001ZW-KH
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:14:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciTYH-0004uI-DG
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:13:58 -0500
Received: from 15.mo6.mail-out.ovh.net ([188.165.39.161]:48629)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ciTYH-0004tm-1b
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:13:53 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 11436AFDCC
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 23:13:51 +0100 (CET)
Date: Mon, 27 Feb 2017 23:13:46 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170227231346.624b8e7c@bahia.lan>
In-Reply-To: <20170227010953.GN17615@umbus.fritz.box>
References: <20170224045531.7026-1-aik@ozlabs.ru>
	<20170224101350.043b97a6@bahia.lan>
	<20170227010953.GN17615@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/2sr8i+.Zcwu0JIxWir40fzj";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH qemu] sysemu: support up to 1024
 vCPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

--Sig_/2sr8i+.Zcwu0JIxWir40fzj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Feb 2017 12:09:53 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Feb 24, 2017 at 10:13:50AM +0100, Greg Kurz wrote:
> > On Fri, 24 Feb 2017 15:55:31 +1100
> > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >  =20
> > > From: Greg Kurz <gkurz@linux.vnet.ibm.com>
> > >=20
> > > Some systems can already provide more than 255 hardware threads.
> > >=20
> > > Bumping the QEMU limit to 1024 seems reasonable:
> > > - it has no visible overhead in top;
> > > - the limit itself has no effect on hot paths.
> > >=20
> > > Cc: Greg Kurz <gkurz@linux.vnet.ibm.com>
> > > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > > ---
> > >=20
> > > With ulimit -u/-n bumped (nproc and nofile), I was able to boot a gue=
st
> > > with 1024 CPUs, both with threads=3D1 and threads=3D8.
> > >=20
> > > It takes time though - 3:15 to get to the guest shell but it is proba=
bly
> > > expected on 160-threads machine. =20
>=20
> Yes, I'd expect so, that's a lot of overcommit.  Plus, switching from
> one vcpu to another on the same host thread will, IIRC, require two
> full partition switches, which are pretty slow on Power.
>=20
> > I remember something similiar at the time... also I had to give more
> > RAM to the guest to be able to run 1024 CPUs (sth like 6 gigs versus
> > 512 megs for 1 CPU). With the same amount of guest RAM, each extra CPU
> > would cause the memory used by QEMU to grow about 8 megs. =20
>=20
> Hm... that seems like rather a lot.  Any idea why?
>=20

No but I'll try again with the current code and I'll have a closer look.

> >  =20
> > > ---
> > >  hw/ppc/spapr.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index e465d7ac98..46b81a625d 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -2712,7 +2712,7 @@ static void spapr_machine_class_init(ObjectClas=
s *oc, void *data)
> > >      mc->init =3D ppc_spapr_init;
> > >      mc->reset =3D ppc_spapr_reset;
> > >      mc->block_default_type =3D IF_SCSI;
> > > -    mc->max_cpus =3D 255;
> > > +    mc->max_cpus =3D 1024;
> > >      mc->no_parallel =3D 1;
> > >      mc->default_boot_order =3D "";
> > >      mc->default_ram_size =3D 512 * M_BYTE; =20
> >=20
> >  =20
>=20
>=20
>=20


--Sig_/2sr8i+.Zcwu0JIxWir40fzj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAli0pJoACgkQAvw66wEB28KSUwCfQ2RaAkourbhYkmjvx7I8qzU6
eqMAn3xyrZXit3vdqTvwV5dAE0Ssw16f
=xWfr
-----END PGP SIGNATURE-----

--Sig_/2sr8i+.Zcwu0JIxWir40fzj--
