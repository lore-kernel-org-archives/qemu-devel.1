Received: from eggs.gnu.org ([2001:4830:134:3::10]:51190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dwd86-0005K0-E3
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:49:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dwd83-00051j-Bp
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:49:38 -0400
Date: Tue, 26 Sep 2017 09:49:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170925234925.GE12504@umbus>
References: <1506264466-28252-1-git-send-email-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6e7ZaeXHKrTJCxdu"
Content-Disposition: inline
In-Reply-To: <1506264466-28252-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 0/7] mac_dbdma: tidy-up and QOMify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--6e7ZaeXHKrTJCxdu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 24, 2017 at 03:47:39PM +0100, Mark Cave-Ayland wrote:
> Whilst looking at implementing another DBDMA device for the Mac machines
> I noticed a couple of things: firstly there were some unused fields still
> in DBDMAState, and secondly the existing code still used global functions
> to register DMA channels and handle the relationship between macio IDE and
> DBDMA.
>=20
> This patchset removes the now-unused fields from DBDMA state, QOMifys the
> DBDMA device, uses a QOM object link to allow the macio IDE object to
> reference the DBDMA device, and then finally removes the global DBDMA_*
> functions substituting them instead for QOM methods.
>=20
> Note: this patchset does not apply to master but on top of David's
> ppc-for-2.11 branch since there are merge conflicts with my previous
> patchset. Hopefully the Based-On line below is enough to keep patchew
> happy, even though it wasn't the final version applied to the ppc-for-2.11
> branch.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Based-on: 1505668548-16616-1-git-send-email-mark.cave-ayland@ilande.co.uk=
 (ppc: more Mac-related fixups)

I've applied 1-5/7.  There are a couple of details I'm not 100%
convinced on, but it's still better than what was there before.  6 & 7
I'm still thinking about.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6e7ZaeXHKrTJCxdu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnJlgAACgkQbDjKyiDZ
s5IRlxAAwcnQi1bZBBfvdcvQGSb0zQUsp8wttZZnVDN6L7rBw53aK7y15enPvGFG
SjhKu+Y8b8nfSlkL6yOzXaZyZiAKWBJiXX4XtgXkgY6ry5WzCck5AFZOqBDG6MOD
/JfQU3sN9e44UUUCcfotn8w4WKKAPxjkU503q8+9b8slAK1W4/A6KytENIHz1awh
bxVb2bPZBF/c1si0HuhOXi6CXPYtbOyaMy2kXhZw+tE06m5orlf5QsLcK4gp409n
wv7nPCmOug971bRCqk66H6HsrsBTq/Sudmcc3UG56pEznXSLPnyTkWWzTKjZmd93
0iZhiUeUpCcH4ixJESBtEyTYW//Jhtbh2HWlaK+2yJWM0du/NKMDi2Nt6JA5vHn/
b8417SLja07eOXhJXV4MqzBGkoieni8ahQ7s8DzM7Ms98KMDnRN5M4MRPnSKgHb2
N5yKzh6sfL0e5tYzN571s+pEwq549+kJ6Ems/wlspfBcthhYTXZ2mDu6nxh84RmE
+qWnOHXBGxklu3LAW/jHr80ZWLAtAim4UiK6rXoA3drdJGVo3TBGc3PQDbWWicbB
/fJ7JetSj3dNo4NYt90oaTJUKI705iWwIu7J2uRqbf9I1pPq9lbJc38JYwJKaz8G
hCIiuXuOPMSTMkc+PhnQW4+9H30AUdzDs3attXXl+Rwkga/NhiA=
=X1Zn
-----END PGP SIGNATURE-----

--6e7ZaeXHKrTJCxdu--
