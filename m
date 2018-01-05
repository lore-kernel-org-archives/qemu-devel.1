Received: from eggs.gnu.org ([2001:4830:134:3::10]:51895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eXINp-0001pq-UJ
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 22:09:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eXINm-0004tx-Gw
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 22:09:25 -0500
Date: Fri, 5 Jan 2018 14:05:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180105030542.GD24581@umbus.fritz.box>
References: <20180104194952.2836-1-programmingkidx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lymARMIdFDV9dylT"
Content-Disposition: inline
In-Reply-To: <20180104194952.2836-1-programmingkidx@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2] Update dtc to fix compilation problem
 on Mac OS 10.6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--lymARMIdFDV9dylT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 04, 2018 at 02:49:52PM -0500, John Arbuckle wrote:
> Currently QEMU does not build on Mac OS 10.6
> because of a missing patch in the dtc
> subproject. Updating dtc to make the patch
> available fixes this problem.
>=20
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>

Applied, thanks.

> ---
> v2 changes:
> Updated the commit to point to version 1.4.6.
>=20
>  dtc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/dtc b/dtc
> index 558cd81bdd..e54388015a 160000
> --- a/dtc
> +++ b/dtc
> @@ -1 +1 @@
> -Subproject commit 558cd81bdd432769b59bff01240c44f82cfb1a9d
> +Subproject commit e54388015af1fb4bf04d0bca99caba1074d9cc42

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lymARMIdFDV9dylT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpO64MACgkQbDjKyiDZ
s5IN+Q/9HinTgV+pqolQxN/S/GiBhf77UxJFe4sCim8T/1UcyBP38r7szUMjIBXg
0bCpE4FR3nhIjhR5rp/NJFqE7psJusIj0ctXqrUspP1YpJxkvNZC/O4BKhDn3rGc
lPQ7/i6tpgKg5QmVJmP+kGvVAwlkUGNj1Fb0MRNVgTd5piezjCEYDkKcqb9vmESb
bSxWy6RBQtLB16fpb5K9eR7rwmKpwos4yTZftP9betWsiR7Bz1MUE37arEGLfVAg
pEssjlhfLv83rGa7Rnfq0rsOU4UR8V5CoUx//bsP6E2/jvpGSDQI3hpkOgypXc2M
NnZb/YEYgH9v0VHOaO4s7exkgRvZk6qyU4Ab5vBq7q6sx5P7WooX0O4M/SsqI7Sw
CiIs/p2l3sXi9yYvjUN7/x2p89zf+lfdHy+1IIVjAIIVvaMjB7izAl3kXaPliKkz
RdkTA/l9WtAgNYeipZ7Myl97YlOudNslCGJ4fTLWvXbDv+xcOEDs6Noqz1RUp1sD
OVozQnYhg8rU8l931fp4yfMW6oAViMxXISsHrDDMdaorPpSmvXPPzvb1gXfaHWsQ
qbYxEibeg4AvQvE48p6VSMh29nLlrvhNX3/OEmH/XEPLI+wUiHneG8RHGXiQQ2zX
+5G0pyC1uuQtHR5yaiAKEkT9KsS4//WHOY5wUmCUhwsEI0/vChg=
=yQ9Z
-----END PGP SIGNATURE-----

--lymARMIdFDV9dylT--
