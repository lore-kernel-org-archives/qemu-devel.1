Received: from eggs.gnu.org ([2001:4830:134:3::10]:52752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1flXm5-0000qC-A3
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 06:57:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1flXm2-0002v1-6F
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 06:57:37 -0400
Date: Fri, 3 Aug 2018 16:49:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180803064918.GF11211@umbus.fritz.box>
References: <20180801035357.7804-1-david@gibson.dropbear.id.au>
	<CAFEAcA-FitsqU3kQJTFGSFgOh6Zsf2Zy2fO3OTnL5c+Tzi5pog@mail.gmail.com>
	<alpine.BSF.2.21.1808011300070.7488@zero.eik.bme.hu>
	<CAFEAcA-=c7O+h3c-gQ=31q0oyLzJhDNmEBzv4X2Yp_TBfYhC-w@mail.gmail.com>
	<20180802070824.GC11211@umbus.fritz.box>
	<CAFEAcA8sGVjGgXxR8ivSWJ6oDKJPfEGnWUuHh_quZK2GDSgU2A@mail.gmail.com>
	<20180802140744.GD11211@umbus.fritz.box>
	<21de1d73-448a-36c2-0989-3de1f9d64a02@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QNDPHrPUIc00TOLW"
Content-Disposition: inline
In-Reply-To: <21de1d73-448a-36c2-0989-3de1f9d64a02@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 0/2] ppc-for-3.0 queue 20180801
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, BALATON Zoltan <balaton@eik.bme.hu>


--QNDPHrPUIc00TOLW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 03, 2018 at 07:49:12AM +0200, Thomas Huth wrote:
> On 08/02/2018 04:07 PM, David Gibson wrote:
> > On Thu, Aug 02, 2018 at 10:16:32AM +0100, Peter Maydell wrote:
> >> On 2 August 2018 at 08:08, David Gibson <david@gibson.dropbear.id.au> =
wrote:
> >>> The macio fix, however, *is* a regression from 2.12.  Whether it's
> >>> severe enough to warrant another -rc, I'm not sure.  It is a bad
> >>> pointer access which is, well, bad.  It doesn't seem to bite
> >>> obviously, needing valgrind to pick it up, but possibly that's just
> >>> luck.
> >>
> >> I thought those introspection-bugs like the macio ones weren't
> >> regressions ?
> >=20
> > Well, I ran Thomas's testcase on master and it generates several
> > valgrind warnings, which don't appear on either 2.12 or master+the
> > patch.
>=20
> Maybe the macio bug is something new, but we had plenty of these
> introspetion bugs in the other code (mainly the ARM code) which were
> clearly there since a looong time already and nobody ever complained. So
> it seems quite unusual that upper layer tools / the users are using the
> introspection feature of QEMU. Thus I'd say this bug is not important
> enough to block the release. We could fix it in the stable branch
> instead.

Understood, I'll punt the patch to my 3.1 staging tree.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--QNDPHrPUIc00TOLW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltj+usACgkQbDjKyiDZ
s5KgWw/8DsWNYW4tWbIpQJXL3nF4JczCAhOAJe2I3RTrWdZJ/V0r4CC9qaKiE+Fm
i+OMkKUf1h1zmaFOoMAZl5NovXd9ekU7eSQkBG4WMTRTV2pliRuXkG1w4ZUWbT0J
zbjdzBKdL4O8d8ROGe9hAcZUPCT+fiwAZDmraEvmgnOMMyK02ahQVP6v7eaKLKr5
t0pV15EvDV5NQCJB92srP2Qf2iZBrawIE88PuJU9PLh7K56qgIkOhCninjNF4zJB
1HeaQIV7fZt3DPRtynU/KkCrpQVEeIeWHscaW2CWhHCgEeyJHW2vqa+cdbipSE7x
J8X3GkzqqWjDRbgxviSEccoiMTpyz0NxBmhDuM/5JAG94clugp9Fkcjb/ArpfAx0
aqaiaELjjn9RI1+jeQZGsLYwBBhVxI0Oefp2loNSjmbG6CPzmEEAelNC9l025UcR
KnPc3kCrsfoEv4YCElZ/6+dJ6RgQmzbQvT375cK0l3noT04OrlPcbtZyV64Ob+Ex
LLjaoXE9LRttM60mrOy4cABQ/LJhfUxFQf8H0d6tl9VZhKWwHEru5fi/KiFjnT/5
8Vp/U9OY6NihZaJ0BwcgTpA4LzlXTYgEvmcEvZuewioQ79gPuhGOo5vkuXn+Xai1
Xs/I96Vjssbvg4qDAE71tfDIiUQqfw+YTaRaj6iqAZ8cBLQkeyI=
=tzuo
-----END PGP SIGNATURE-----

--QNDPHrPUIc00TOLW--
