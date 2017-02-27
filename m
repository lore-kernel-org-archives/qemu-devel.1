Received: from eggs.gnu.org ([2001:4830:134:3::10]:58308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciAGy-0007iR-6Y
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 20:38:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciAGv-0003I0-2q
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 20:38:44 -0500
Date: Mon, 27 Feb 2017 12:09:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170227010953.GN17615@umbus.fritz.box>
References: <20170224045531.7026-1-aik@ozlabs.ru>
	<20170224101350.043b97a6@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RL02At1kLqUPtqvA"
Content-Disposition: inline
In-Reply-To: <20170224101350.043b97a6@bahia.lan>
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
To: Greg Kurz <groug@kaod.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <gkurz@linux.vnet.ibm.com>


--RL02At1kLqUPtqvA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 24, 2017 at 10:13:50AM +0100, Greg Kurz wrote:
> On Fri, 24 Feb 2017 15:55:31 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>=20
> > From: Greg Kurz <gkurz@linux.vnet.ibm.com>
> >=20
> > Some systems can already provide more than 255 hardware threads.
> >=20
> > Bumping the QEMU limit to 1024 seems reasonable:
> > - it has no visible overhead in top;
> > - the limit itself has no effect on hot paths.
> >=20
> > Cc: Greg Kurz <gkurz@linux.vnet.ibm.com>
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> >=20
> > With ulimit -u/-n bumped (nproc and nofile), I was able to boot a guest
> > with 1024 CPUs, both with threads=3D1 and threads=3D8.
> >=20
> > It takes time though - 3:15 to get to the guest shell but it is probably
> > expected on 160-threads machine.

Yes, I'd expect so, that's a lot of overcommit.  Plus, switching from
one vcpu to another on the same host thread will, IIRC, require two
full partition switches, which are pretty slow on Power.

> I remember something similiar at the time... also I had to give more
> RAM to the guest to be able to run 1024 CPUs (sth like 6 gigs versus
> 512 megs for 1 CPU). With the same amount of guest RAM, each extra CPU
> would cause the memory used by QEMU to grow about 8 megs.

Hm... that seems like rather a lot.  Any idea why?

>=20
> > ---
> >  hw/ppc/spapr.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index e465d7ac98..46b81a625d 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2712,7 +2712,7 @@ static void spapr_machine_class_init(ObjectClass =
*oc, void *data)
> >      mc->init =3D ppc_spapr_init;
> >      mc->reset =3D ppc_spapr_reset;
> >      mc->block_default_type =3D IF_SCSI;
> > -    mc->max_cpus =3D 255;
> > +    mc->max_cpus =3D 1024;
> >      mc->no_parallel =3D 1;
> >      mc->default_boot_order =3D "";
> >      mc->default_ram_size =3D 512 * M_BYTE;
>=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--RL02At1kLqUPtqvA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYs3xhAAoJEGw4ysog2bOSum4QAOLSbf07Zu0dOKBBwqKz6uA1
VOsqDiGu/mGddyjgy/FVBfZc7JmM099b9qhXfBA15+CStcOmxN5a3EnYsrzjHuoh
8kuRjC1dGwuhGFnOsE/qoTrWYa2sFEQY3VvVNJwnoX4pcUbsUV8FZhocD61WCldQ
ibOOzBNe3SKy5FZZ3v8VQPHgnCGXOmMueZNdc+aMBB+AJzpQoq2wwH6vb22k54f8
VU3TZ6nsrjipUcE74eV/L5WIGtmBELnxOKccFOf+LRnZwvDaLZUPWTLTaAGX1j7L
/dMrDGZBQ5YlYFQn7MldlAp3OZghudlasCFhPIUTNRE2i9+mafWIa3iqVpWsnP8d
M2kyOzoaMCqf6fsa981vvS9Y7XSAEQV+/SZ7VmQV8wG+97agYyW6rt5URnvZ+Zpe
UFOA1Y5DbJk2OnLKFa/0O1bdhsv9aA0448kCm6OHexomKfLiJPi+pLr7UQTi1xdZ
XU3eQkLZxcLaNuJNwgbVbVMqCMvQ0duuP63xRPsY43lOXNLIexmlhnMW0IEM5ir8
xTHCdmriIjyukrt1PuxHbLjlnsCD11qIiUiOnBwpNd8mo5bE8AdB0ROvZgapUBuZ
9K6FqEBn1Whs0ka9sodgSGM0XKmRs4hYgBd8Dn4HkWN0YPxsQ+dsduDeiRjGVzx8
DT4vo3W3Eunv8aRB2/A6
=aj12
-----END PGP SIGNATURE-----

--RL02At1kLqUPtqvA--
