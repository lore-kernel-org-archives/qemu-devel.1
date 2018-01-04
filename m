Received: from eggs.gnu.org ([2001:4830:134:3::10]:35937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eWvts-0001HO-Gd
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 22:09:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eWvtr-0004rF-GT
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 22:09:00 -0500
Date: Thu, 4 Jan 2018 14:05:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180104030526.GW24581@umbus.fritz.box>
References: <20171228001742.62202-1-programmingkidx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GTZ+2qEBTXdGs1w1"
Content-Disposition: inline
In-Reply-To: <20171228001742.62202-1-programmingkidx@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] Update dtc to fix compilation problem on
 Mac OS 10.6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-ppc@nongnu.org


--GTZ+2qEBTXdGs1w1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2017 at 07:17:42PM -0500, John Arbuckle wrote:
> Currently QEMU does not build on Mac OS 10.6
> because of a missing patch in the dtc
> subproject. Updating dtc to make the patch
> available fixes this problem.
>=20
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>

So, after some thought I decided I wasn't comfortable updating the
qemu dtc to a random git hash of the master dtc tree, rather than an
actual named and tagged dtc release.

So, I wrapped up a new v1.4.6 release of dtc including your fix.
Could you resend the qemu update to point it at that release.

> ---
>  dtc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/dtc b/dtc
> index 558cd81bdd..e671852042 160000
> --- a/dtc
> +++ b/dtc
> @@ -1 +1 @@
> -Subproject commit 558cd81bdd432769b59bff01240c44f82cfb1a9d
> +Subproject commit e671852042a77b15ec72ca908291c7d647e4fb01

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GTZ+2qEBTXdGs1w1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpNmfYACgkQbDjKyiDZ
s5KH/w/+IOvzgV8/FLPRwWlJiY95V68XfGJ0+/VPFKIhnxwr0Mxy3fsm5i7/ZEff
iylCoS1pf7KczZbACehn4u19BLgAV4+Q4qruX3/J9a2dOxk8tsajvFQFaTBi42WA
MQ2/gH/X1JxHWEpkdjHm3WsODejm+74eECoWQrAAxRqmg/NmU1nwesqqcAqIc51C
xcpO8n2BS8sawnERKrid71Tqmdod80m3RTqJoaHjhxG0z6p+Mtc9LHn5lwpxcvMw
H4U/nVFP6rS1FAJ4YNIqKtE5isBcwtdskdJm2r1s66+m0yLyHY9exATdn0FC5RQj
ZVvNPOh2jdXXQAAUoHnnXH/lm0GBD88M7jUJCFNOmC2YD3pgQHO/hMXaAjBrycWw
derB0O0iQQFxCMAalvFFkM6YYd6U302WXoj3TF61zvvzsL08w1gr3faPxVFydwk7
6Axsc1r0vXUnYWU7f1tsRnLYMYmlcdhln+yrD8Pjl8tTdQFpvGu82sgoFRuGR+ls
b9EausZVoQChsRLlulZVzj3MgpFIxxgRCIJ39TglZbNdHR7uBdtMEvAevwfMU3C6
SfIzHWbIWXgpFm9S4791cN6d6ngGGIKG+jCoRTnwMRaMAKkeukPKJRzt7iGwNzh5
ggAMYLDZ3gUyimgJxhQlfvE6/dr3Wf0qMSmYyzpUxfINcyY5OoE=
=8uxj
-----END PGP SIGNATURE-----

--GTZ+2qEBTXdGs1w1--
