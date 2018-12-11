Received: from eggs.gnu.org ([2001:4830:134:3::10]:35563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWWUw-0001T6-Pm
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 20:06:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWWUv-0004Tn-Mq
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 20:06:06 -0500
Date: Tue, 11 Dec 2018 11:23:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181211002334.GX4261@umbus.fritz.box>
References: <20181207085635.4291-1-mark.cave-ayland@ilande.co.uk>
	<20181207085635.4291-2-mark.cave-ayland@ilande.co.uk>
	<20181210051730.GQ4261@umbus.fritz.box>
	<051b02d7-0b82-3224-9780-4192ef10b9ba@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PaACFu8FWA0UZxdw"
Content-Disposition: inline
In-Reply-To: <051b02d7-0b82-3224-9780-4192ef10b9ba@linaro.org>
Subject: Re: [Qemu-devel] [RFC PATCH 1/6] target/ppc: introduce get_fpr()
 and set_fpr() helpers for FP register access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--PaACFu8FWA0UZxdw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 12:25:26PM -0600, Richard Henderson wrote:
> On 12/9/18 11:17 PM, David Gibson wrote:
> > On Fri, Dec 07, 2018 at 08:56:30AM +0000, Mark Cave-Ayland wrote:
> >> These helpers allow us to move FP register values to/from the specifie=
d TCGv_i64
> >> argument.
> >>
> >> To prevent FP helpers accessing the cpu_fpr array directly, add extra =
TCG
> >> temporaries as required.
> >=20
> > It's not obvious to me why that's a desirable thing.  I'm assuming
> > it's somehow necessary for the stuff later in the series, but I think
> > we need a brief rationale here to explain why this isn't just adding
> > extra reg copies for the sake of it.
>=20
> Note that while this introduces extra opcodes, in many cases it does not =
change
> the number of machine instructions that are generated.  Recall that acces=
sing
> cpu_fpr[N] implies a load from env.  This change makes the load explicit.

I realised that a bit later in looking at the series.  I think a
paraphrasing of the above in the commit message would still be
helpful.

> The change does currently prevent caching cpu_fpr[N] in a host register. =
 That
> can and will be fixed by optimizing on memory operations instead.  (There=
 is a
> patch that has been outstanding for 13 months to do this.  I intend to fi=
nally
> get around to merging it during the 4.0 cycle.)
>=20
>=20
> r~
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PaACFu8FWA0UZxdw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwPA4EACgkQbDjKyiDZ
s5JoNA/+MhWC+HFlybf+LVjBXq1oTte3Dvtmm6GXWuB6PT5AgNvskNaX2Mui4HnI
VIubBk2S6MmqO8Z2JKR8Mhq1qIu0i4Jfef121sr9hMQRefphh5c6bnvgQ1KvVIbO
ok5+vqz2cu8/tyVWPVNKDNyHPmbLXYvbMJdYuQ3cs06IfNKBKcKVlzPikKsJ6Y5u
WGdbPZJ+N1mJghNpxnNvrVxHu9PYNWondaSN+XRgCSokgMj5tVkDoeIjV2gqBClA
CRh+U85mOC++bErZLYykLrXCTE26+kIbZVRTlphlo0548c9wp5Yqr2J4tq/6NtCm
srdzlyl/HRT818Ed4dDIGo0/ie20uiN9sBoiEaX7MEVHlPK1tTZX2Ply3V+iTyvB
oty6y20tQ3a5PLFLyiINt3wUkT35uvry7ZEsRK8L95+lgBfeLePOJbg68w46NTCY
y5lkluosY9VVdUtV54IzLjLKQsH4MuOSrjItEevT65Cee0cWkRDJkGMzLCJalKml
cCIR446uAez0Ob8/L0ctsY2legrYARwhgF5jFeC7AUjmBT14IsYg1IGXSlXJKYCR
kaPFgySiXBtqFXIV9taGY/Mlow2v3wMbyCVms4+p8xrm/4INYgJvDHjRd+js6ZgU
ENk+2d1yF6rbCQYQQuJBTrHm7prk6rllzv8NKEjhUpHIyVI58E4=
=fN1P
-----END PGP SIGNATURE-----

--PaACFu8FWA0UZxdw--
