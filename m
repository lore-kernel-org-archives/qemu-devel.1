Received: from eggs.gnu.org ([2001:4830:134:3::10]:51171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fp2EA-0004MT-QA
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:05:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fp2E9-0002Dy-Rn
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:05:02 -0400
Date: Mon, 13 Aug 2018 11:57:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180813015744.GG4079@umbus>
References: <20180810224645.10659-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3607uds81ZQvwCD0"
Content-Disposition: inline
In-Reply-To: <20180810224645.10659-1-hpoussin@reactos.org>
Subject: Re: [Qemu-devel] [PATCH] qemu-doc: mark ppc/prep machine as
 deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>, "reviewer:Incompatible changes" <libvir-list@redhat.com>


--3607uds81ZQvwCD0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 11, 2018 at 12:46:45AM +0200, Herv=E9 Poussineau wrote:
> 40p machine type should be used instead.
>=20
> Signed-off-by: Herv=E9 Poussineau <hpoussin@reactos.org>
> ---
>  qemu-deprecated.texi | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 9920a85adc..9c7ff3fe2d 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -218,6 +218,12 @@ support page sizes < 4096 any longer.
>  These machine types are very old and likely can not be used for live mig=
ration
>  from old QEMU versions anymore. A newer machine type should be used inst=
ead.
> =20
> +@subsection prep (PowerPC) (since 3.1)
> +
> +This machine type uses an unmaintained firmware, broken in lots of ways,
> +and unable to start post-2004 operating systems. 40p machine type should=
 be
> +used instead.
> +
>  @section Device options
> =20
>  @subsection Block device options

Applied to ppc-for-3.1, thanks.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3607uds81ZQvwCD0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltw5ZgACgkQbDjKyiDZ
s5IZNxAAkylX+8Xe4O3YmGn001dFerSAL6D6T7iYCvUKwQ2boe1zoo+fPQcM2F0m
gf52njbVOpIr8y2dFtgvAKC6CY1XaCH+AMe1ijOGmuzlUaYGw6Mxo8lJJbj1kqlc
YNO8WxfXtEcqb8Kx9HoslH//d+OXQlQ6G/oHAE3Cg0MNaI5CO4gVtnp+g8p9hLjo
7xPELZ31YpC6dqun3UV2Dl7CO0sUD1+6COcnkT1WKlFl9j+8X4QSDSCK6c5lnqJK
Sabu25dK3RZp3jzHy0fePXUWOBM8mv0uNXYh7tbC6oZZDdq4NToYAs44gGvkUofx
4fTcHlsZVnMeqPiNGUPUD+HfyeahvwQVA1myPH4mqy3IF8DZWp7hJ1MhPKk5AImJ
xM55qD1AANd+17a54ZVt/DUKghigBMdRg4pkgNiQfBEaVp3lClvq5enSNkMXWm2N
pd6gTMnHcp2GQMAifpeLueMH3raJhTXnHJUI7LKReXwZFIiEW8ekHNSXbc2bQfw1
hheJakgdZqwZNTz/Yr5ybxPyoFLWNs3GkasSqQOBCrZSjTlU8QnckBCxFxsQcyj+
oYZrA3V+yvjE/ngY2ODiEK0rzugE875EgUZyt/slYiGtCV+2fnoLM+qoziJOhgQQ
CWtAoIrz1T0LSXCdVvuz6dW2tgyszskz0PZDoTTOZ6J3prpyycI=
=nHvh
-----END PGP SIGNATURE-----

--3607uds81ZQvwCD0--
