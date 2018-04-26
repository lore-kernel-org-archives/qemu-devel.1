Received: from eggs.gnu.org ([2001:4830:134:3::10]:39635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBVZl-00064m-7G
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 21:19:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBVZh-0008IV-6a
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 21:19:57 -0400
Date: Thu, 26 Apr 2018 11:19:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180426011916.GB8800@umbus.fritz.box>
References: <20180425093424.18713-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline
In-Reply-To: <20180425093424.18713-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH] spapr: fix entry point for secondary CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 11:34:24AM +0200, C=E9dric Le Goater wrote:
> Secondary CPUs do not start at SPAPR_ENTRY_POINT but at an address
> given by the guest OS.
>=20
> Fixes commit c79128c14c20 ("spapr: Make a helper to set up cpu entry
> point state")
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Oops.  Since I haven't send that patch upstream yet, I've folded this
fix in rather than including it as a separate patch.

Note that ppc-for-<whatever> are rebasing trees, so commit ids in
there aren't stable.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrhKRIACgkQbDjKyiDZ
s5IIeBAAhtyOTBACs3pFwI2zyUYFg33Wkca1djspWhfQU6Uj0xzSpfhr5RpRyZPs
5iE0nknmdNfew10/M124yxjlR+GWFR5bIZDYMgSQ/MfWko29VSxhpLLOOQdYW6Ah
ejoryiXx6gr3MW8o2rn8Lo/tvJfGXpaqnMLCFxbSpjDY8kWzlpSLtxab6YQ26e3A
/JmVKzOSabL/x9cwKLYJnJ1oOjtC1VD9A+kfKgXfzsopCG+V9ors5Zz3uIWW7hGm
9nP3TlFG+BB/yVNykrQ3tGBENn1BQt/ss2tJ+R8o59fNTaTqEu7fmZ7QZUddQhdF
EwSSyRlgiooTpu1npxirbpkLB4al3x3DUfvWzjTYy4f4W4EKI6T2d3wx/u+LeIsD
HZkaKX3VLf99NfS85wM389oUZCnk007019NJb5RkkluyBm1ZBmEb0qWmpLz3rSyi
mgjxDv1ZsDs5Qvjovj1H7OMIImk0F5M6++Lw/vzk9nSnkvCi3NCQZ64WAxCGq9mf
BW2SOZgAAfu3J60xUfHnHSkSXRKeDyxX7hAcVHz4SR9WFa3tm65UClUtU/0OdJVi
TA1OY1eece/k4HdPZOchgHrvSqhKGTw6BFQHOfsIxGYqd6YPzkADrPraa6JwcPBW
c//4TXmMyYkUPRPIHizIXINPBoLZyX+S9/bjvFYPLZtUBSqRhLg=
=hOix
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
