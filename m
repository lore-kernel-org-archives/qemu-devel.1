Received: from eggs.gnu.org ([2001:4830:134:3::10]:36619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ffNZD-0006mx-2l
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 06:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ffNZB-0007o9-T9
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 06:50:51 -0400
Date: Tue, 17 Jul 2018 20:50:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180717105006.GA2272@umbus.fritz.box>
References: <152949925592.606785.4717120428688653960.stgit@bahia.lan>
	<20180621011809.GD32328@umbus.fritz.box>
	<20180621152321.3ab81d51@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <20180621152321.3ab81d51@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v2 for-2.11.2] spapr: make pseries-2.11 the
 default machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-stable@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 21, 2018 at 03:23:21PM +0200, Greg Kurz wrote:
> On Thu, 21 Jun 2018 11:18:09 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Wed, Jun 20, 2018 at 02:54:15PM +0200, Greg Kurz wrote:
> > > The spapr capability framework was introduced in QEMU 2.12. It allows
> > > to have an explicit control on how host features are exposed to the
> > > guest. This is especially needed to handle migration between hetero-
> > > geneous hosts (eg, POWER8 to POWER9). It is also used to expose fixes/
> > > workarounds against speculative execution vulnerabilities to guests.
> > > The framework was hence backported to QEMU 2.11.1, especially these
> > > commits:
> > >=20
> > > 0fac4aa93074 spapr: Add pseries-2.12 machine type
> > > 9070f408f491 spapr: Treat Hardware Transactional Memory (HTM) as an
> > >  optional capability
> > >=20
> > > 0fac4aa93074 has the confusing effect of making pseries-2.12 the defa=
ult
> > > machine type for QEMU 2.11.1, instead of the expected pseries-2.11. T=
his
> > > patch changes the default machine back to pseries-2.11.
> > >=20
> > > Unfortunately, 9070f408f491 enforces the HTM capability for pseries-2=
=2E11
> > > to be enabled by default, ie, when not passing cap-htm on the command
> > > line. This breaks several 'make check' testcases that run qemu-system=
-ppc64
> > > with TCG.
> > >=20
> > > The only sane way to fix this is to adapt the impacted testcases so t=
hat
> > > they all pass cap-htm=3Doff in this case. This patch does that as wel=
l.
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > > v2: - have the testcases to pass cap-htm=3Doff instead of violating t=
he
> > >       capabilities logic.
> > >=20
> > > Upstream doesn't need anything like that since newer pseries machine =
types
> > > start with HTM disabled by default. This is really a oneshot fix for =
2.11.2,
> > > and I've tried to make it as small as possible.
> > >=20
> > > This is a full replacement of the previous version. It is based on Mi=
ke's
> > > staging tree for 2.11: =20
> >=20
> > Thanks for fixing this up
> >=20
> > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> >=20
> > Btw, 2.11.z should probably have the 2.12 machine type removed
> > entirely, as well as (obviously) not being the default.  Not within
> > scope for this patch, though.
> >=20
>=20
> Well... it is indeed weird but I don't think it hurts. Also, people
> may have started using pseries-2.12 with QEMU 2.11.1 (I seem to
> remember Mike told me about something like this the other day)...

I came back to thinking about this and realized this is a terrible
idea.  The problem is that because of the way we define the latest
machine type, then backwards compat props for the earlier ones, it's
very likely that the "pseries-2.12" in 2.11 won't be the same as
pseries-2.12 in 2.12, simply because 2.11 won't have the necessary
features to implement pseries-2.12 as in 2.12.


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltNyd4ACgkQbDjKyiDZ
s5J+1A//eBfhcUm5vO7ZRoRnz2FqMSQee+iRaDtmQ508Vj3mMeM4WudKWwa6lqL9
w5JkeF14vr+ytocvtJ3e86brs+m4lWOleg4DKujSl5Lq7Zco25ypxpHiyFkIwTw/
qkvCocmp8HHN7yQLroP9jCCXwaEbJfdRuszW7HQXm62XPms4CQrnfMXwPgp57Ttc
9ORCsWbK9Qy/zX8zrNYog6abu/OZMByhqHs1CQrL247XfdBELcX1DjKeOCvcvk41
ZPNA00joRCGds3l/h6IBjPsF1bkT54e3AboramWqGkPiNfAKZNwajEW3VyBhrTy7
qMKsBrXOIg7DW+nOPMuW6vM7TkOi1tevvP5fu/F/zNUSNrdSuWbOhur4iJ5HJJqp
Qk5QemYTVmUhK45Rilss/hyBxJHHULHAU/wF7Jmz6843KeKWQG23S3ljdAWaUd87
BNu7+kJ/NNTVYu/junO0sj6WdyPFwpBNU2V61fb0iVoPryoESsm2tlhGL4E5Y0IH
vu4axFfnyGRrmEVAAwNcn2GsWYJ1HUQuNuSzBSlFsw4fdysutDc1vk2QHHVAXMhH
FzeyaV1dBvqxjK4FQpW201GoBDEcnr944FAYNuZpvwP+mPIWeIj5EEVrCfY6yDL9
lKiFiUdotcmUh9HOoDwNDkkfQAxvJyssfHvgNSHCN6UJh+GJwqA=
=x8GL
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
