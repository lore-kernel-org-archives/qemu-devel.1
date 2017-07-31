Received: from eggs.gnu.org ([2001:4830:134:3::10]:39586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dcATs-0005CL-9d
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:11:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dcATr-0004DI-2F
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:11:32 -0400
Date: Mon, 31 Jul 2017 22:53:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170731125331.GI2652@umbus.fritz.box>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100553345.27487.10049014405920351882.stgit@bahia>
	<20170726035838.GQ8978@umbus.fritz.box>
	<9a4c0fee-68b7-bf36-674a-2868b827f428@amsat.org>
	<20170731123441.488afecf@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CEUtFxTsmBsHRLs3"
Content-Disposition: inline
In-Reply-To: <20170731123441.488afecf@bahia.lan>
Subject: Re: [Qemu-devel] [for-2.11 PATCH 04/26] spapr_drc: use
 g_strdup_printf() instead of snprintf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>


--CEUtFxTsmBsHRLs3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 31, 2017 at 12:34:41PM +0200, Greg Kurz wrote:
> On Mon, 31 Jul 2017 07:11:45 -0300
> Philippe Mathieu-Daud=E9 <f4bug@amsat.org> wrote:
>=20
> > Hi David,
> >=20
> > On 07/26/2017 12:58 AM, David Gibson wrote:
> > > On Tue, Jul 25, 2017 at 07:58:53PM +0200, Greg Kurz wrote: =20
> > >> Passing a stack allocated buffer of arbitrary length to snprintf()
> > >> without checking the return value can cause the resultant strings
> > >> to be silently truncated.
> > >>
> > >> Signed-off-by: Greg Kurz <groug@kaod.org> =20
> > >=20
> > > Applied to ppc-for-2.11. =20
> >=20
> > Isn't it 2.10 material?
> >=20
>=20
> Hi Philippe,
>=20
> Well... this patch doesn't fix any bug actually since the stack buffers
> are large enough. It is more a question of coding style.
>=20
> Something like below would have been more appropriate I guess:
>=20
> "Building strings with g_strdup_printf() is a QEMU common practice."
>=20
> No big deal.

Exactly.  It's not a bugfix, so it doesn't go into 2.10 - we've passed
the hard freeze.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CEUtFxTsmBsHRLs3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll/KEkACgkQbDjKyiDZ
s5IlYRAAtU7E7HePE1aaWgTwMflgmZf0a0b6Ll9JIK9IxyJrgatRBR7ICZ7/Ker+
VQVqeftoE7EDcYOvvP6L5/VNzxO25WBZyqNz3hYoLQbI3sfhY8Gpfz7ipMK07JZk
IedmwBdNZBW+lvbu63A0kDHYvFP+VruWCO//SovvNRcjZJ2DexpyznP/80WoEMvx
JxIuYwWSJ2Hd+sTnh74z/UY38u57Jb2xpHdiD67t0zRlo6V89txLlDNPucRuEr5Q
oOYxiCQyNg81zkNFEUB4DoZ/scMaMu6gImBCpxcnrofKgwXyXiNKheO/bNCUSqvN
whu4JmX+MFNYlHEQf9cthA643ujBP+7TJwUH+sQdim6vDtRTauTFihFYZAB7+Fzn
9jZ1bu6xShyEN75DqyJQMQgGR9Q9eJYH04+bwz7MM6n5XI9L4Jeg353HBax06w/G
xIYBwpwHrw6pMJ015ASZCXpzi/Jj+cUoOQAB8h1enc9HF4v3K021OvThryJlwZN0
0T+KBfYf0YOlSHK+kifbUWGW6xjmWjlDV94zdUMPdjndisk5kTu61YQPC+KPnGj4
qbDCx7UNX8vcdcI+GA1601edhKqz9h6zcxyX7wHa8mggle+mIAaIwOWqNTtiZ2L5
tcq+Dwt79kIoQ4I8Ur5xIqgLA+tvN7BrxwcDiJpRGUrIoLBHyOI=
=jpsA
-----END PGP SIGNATURE-----

--CEUtFxTsmBsHRLs3--
