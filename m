Received: from eggs.gnu.org ([2001:4830:134:3::10]:39847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMVyl-00030X-I4
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:27:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMVyi-00063z-EU
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:26:59 -0500
Date: Wed, 6 Dec 2017 20:20:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171206092035.GW3057@umbus.fritz.box>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-20-clg@kaod.org>
	<20171201040115.GC30161@umbus.fritz.box>
	<02120b7e-cd8b-af61-7d35-8289253828f6@kaod.org>
	<20171205070004.GL3057@umbus.fritz.box>
	<1512485426.2224.95.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7kW37LRKoI6fR2de"
Content-Disposition: inline
In-Reply-To: <1512485426.2224.95.camel@kernel.crashing.org>
Subject: Re: [Qemu-devel] [PATCH 19/25] spapr: add hcalls support for the
 XIVE interrupt mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--7kW37LRKoI6fR2de
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 08:50:26AM -0600, Benjamin Herrenschmidt wrote:
> On Tue, 2017-12-05 at 18:00 +1100, David Gibson wrote:
> > > The CPU revision. But we won't introduce XIVE exploitation mode on=20
> > > anything else than DD2.0 which has full XIVE support. Even STORE_EOI=
=20
> > > that we should be adding.
> >=20
> > Hrm.  Host CPU?  That's a problem - if guest visible properties like
> > this vary with the host CPU, migration breaks.
>=20
> I don't think this is going to be a problem in practice. The
> availability of trigger comes from OPAL but in practice, all virtual
> interrupts are going to support it always,

Ok.  It still makes me nervous to derive guest visible features from
the host.  I'd prefer to just hardwire the XIVE model to always/never
advertise it and simply fail if that isn't workable for the host kernel.

> only some of the HW
> originated ones (PCIe MSIs for example and LSIs) won't. And we don't
> migrate with PCIe devices passed through.

=2E. and cross that bridge when we come to it.

> So the guest need the info, but we should be ok with migration from P9
> DD2.0 onwards. Nobody sane cares about P9 DD1.0.
>=20
> Any future chip will have to ensure that we don't lose that property in
> HW least we lost migration, but that would break AIX too so I'm
> reasonably confident the HW guys will get that right ;-)
>=20
> > >=20
> > > > If it varies with host capabilities, that's going to be real pain f=
or
> > > > migration.
> > >=20
> > > Yes. I am not aware of any future extension but I agree this is
> > > something we need to keep an eye on.
> >=20
> > I'm not talking about future extension, I'm meaning right now.
>=20
> No, no issue right now.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7kW37LRKoI6fR2de
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlontl4ACgkQbDjKyiDZ
s5IMaA//SZC2KAXQ5XbgKhZmJ7K0qI8iGKc8sp8DuAwbkf3tEQIgB8t9ske6kQG8
jmyA33YKC+bzCcLxsf1MbEUd6o6oLBnFcyhOkHM2jHCk26+TqPrKP9zehmurRQ5A
3B7Pj/aajH2aHzawlL4rwjpAyPzkGS8siboMgLoMINAsgiFEOIKHx+sK2zkYw42Q
8f/FLQcu3zNhUZi6d6jvHb5CklbpzdPLpVP8h8YDIYcILgJkAJJSd8PjE492JdQY
pO2drXCA8iWHlEMjEZCB4gjC8spbXlqwqVQ3KiTiyh4v+4MGepkmcjtvKqzMs9u2
iddv+evj6H1MTCtdWeL2nnFJZyO2gC18wivPsvUwXX2xO2aZprzzfhvYArOZKwUo
KjJYM+f0ZX0LXzpXKaP4giCKvc7NR7ANX8JS9TlkN4jDmT3Gm08RdCKPsIGLWu5/
f2FWEuopkZIbDe4rtxpv9NNdmH8CQtkLS1Lh1q7oN71Ft6HsK97yTmp0223wXP1i
MLQ7Np1kI01PB80FeFPeTfFV2q/f9QVqI6CCrt6kxoWpozsI1EOyJV6peHknC0/z
wgtovtJu2UByst3Z4mwl1FBLwF+LjS+q8uOpVXGUyS1oat8NGWvJaIdk1KaXV8Nl
Kv/Pbb0uiE2SnZV3bdHeimW0HHgqkjGPa1279WQGg5vjFxU3Yg8=
=PMyU
-----END PGP SIGNATURE-----

--7kW37LRKoI6fR2de--
