Received: from eggs.gnu.org ([2001:4830:134:3::10]:37307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dsLG1-00014k-Rp
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 23:56:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dsLFz-0000xp-9P
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 23:56:05 -0400
Date: Thu, 14 Sep 2017 13:48:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170914034800.GJ3972@umbus.fritz.box>
References: <20170911095059.101e0cfc@bahia.lan> <20170911093032.GA2857@work-vm>
	<20170911104854.GB2784@umbus.fritz.box>
	<20170912162100.GD2225@work-vm>
	<1bb6a27d-89a5-2e70-6976-74ab24430ec4@ilande.co.uk>
	<4f0cb74a-ae00-5921-291c-49c9acdb3e02@ilande.co.uk>
	<d7dd9adf-4727-aeb5-b8ad-ac8c22c2f4bf@ozlabs.ru>
	<20170913060203.GG7550@umbus.fritz.box>
	<760c3889-8561-9bce-e565-ccbcb9eb8cf5@ilande.co.uk>
	<20170913191309.56bf8fa4@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LQAwcd5tHl0Qlnzi"
Content-Disposition: inline
In-Reply-To: <20170913191309.56bf8fa4@bahia.lan>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 2/4] ppc: add CPU IRQ state to
 PPC VMStateDescription
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alexey Kardashevskiy <aik@ozlabs.ru>, lvivier@redhat.com, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-ppc@nongnu.org


--LQAwcd5tHl0Qlnzi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2017 at 07:13:09PM +0200, Greg Kurz wrote:
> On Wed, 13 Sep 2017 17:44:54 +0100
> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:
>=20
> > On 13/09/17 07:02, David Gibson wrote:
> >=20
> > >>> Alexey - do you recall from your analysis why these fields were no
> > >>> longer deemed necessary, and how your TCG tests were configured? =
=20
> > >>
> > >> I most certainly did not do analysis (my bad. sorry) - I took the pa=
tch
> > >> from David as he left the team, fixed to compile and pushed away. I =
am also
> > >> very suspicions we did not try migrating TCG or anything but pseries=
=2E My
> > >> guest that things did not break (if they did not which I am not sure=
 about,
> > >> for the TCG case) because the interrupt controller (XICS) or the
> > >> pseries-guest took care of resending an interrupt which does not see=
m to be
> > >> the case for mac99. =20
> > >=20
> > > Right, that's probably true.  The main point, though, is that these
> > > fields were dropped a *long* time ago, when migration was barely
> > > working to begin with.  In particular I'm pretty sure most of the
> > > non-pseries platforms were already pretty broken for migration
> > > (amongst other things).
> > >=20
> > > Polishing the mac platforms up to working again, including migration,
> > > is a reasonable goal.  But it can't be at the expense of pseries,
> > > which is already working, used in production, and much better tested
> > > than mac99 or g3beige ever were. =20
> >=20
> > Oh I completely agree since I'm well aware pseries likely has more users
> > than the Mac machines - my question was directed more about why we
> > support backwards migration.
> >=20
>=20
> Downstream support backward migration because end users/customers ask for=
 it
> for maximum flexibility when it comes to move workloads around different =
systems
> with different QEMU versions. This is fairly usual in data centers with m=
any
> systems.

One specific case where this matters is if you want to update the qemu
version on an entire cluster of hosts.  Management layers like
oVirt/RHV allow you to do that without disrupting guests by migrating
them off each host, one by one, allowing you to remove it from the
cluster, update and then reinsert after which guests may be migrated
onto it again.

But that process could obviously take a fair while for a big cluster;
days or even weeks.   In the meantime you have a cluster with mixed
qemu versions, and since oVirt/RHV/whatever will also migrate guests
around the cluster to load balance, that means the possibility of a
backwards migration.

> As others already said, breaking things upstream may turn downstream work
> into a nightmare (and FWIW, most of the people working on ppc are also
> involved in downstream work).

Right.  And I even used to work as a RHV support tech too :).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LQAwcd5tHl0Qlnzi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm5++0ACgkQbDjKyiDZ
s5It+Q/8CXcF8Fejbg7qs9GOVWfXNLUfYziLyPLGUFNZZv2tvCxcRmhduxMJmfKj
uwWeoHs4dVs7yetekRXBgLktgG5adLNFiThCC4fd44smACXRH2ie3PtzshzlrqvX
Tsznjg5Rfb5SpBmRceTLTPPav3x0B1wpMei3isdefcmhMvSn5GnXq3+hVTBneJUK
polvrY2pDgqKUhlYZu6tl0O0bs3OIfoRf8+qEQODWaYL3ZRZuLyfwf3KtQGhtB+J
0psGic06gy5XfsGOGP4USuwDrltUD3XAl1nyL3rSAZlnWGzyevK+6Da6z2iDpoOV
vHpx8IVhbR5XcmumS7nx7Aib8a8kHpwf9QWj8aDuS+4HeRaGHWgkDQn2U1NyW398
2QjYjsTw8Fh604RmA7YigdvRl7VNYTZzCDUZL1UBH3HRLS/qnPlwKkdTe3Nohzsr
CaPKiOmpn8X/DT/JZb1cdc30vC3+H8EyTtLJkNKUJVFqhtlpqsxbb4OLBthmqiK1
A/sQ50cJgrWg2Iz8vyO3P9EYsiwE2X0qlFSVRcNB+ujck31Xzu7Esf9gi5VCpBRF
RybUGRZkxrYcRL3aK/p3buv8dWGW4Zxbtm9liSvP5OifftRaz+uNjKt/a4YKoElS
EcyK4j3P69lyKW9gqGY2U0v0IHXhJyTZwEVHYUafD3QuvdjK/nA=
=48j2
-----END PGP SIGNATURE-----

--LQAwcd5tHl0Qlnzi--
