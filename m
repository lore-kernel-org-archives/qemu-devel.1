Received: from eggs.gnu.org ([209.51.188.92]:35222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hCVjt-0001Be-2X
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 16:47:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hCVjr-00009c-Lo
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 16:47:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hCVjm-00089o-Mw
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 16:47:03 -0400
References: <20190405184037.16799-1-dgilbert@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b0340220-870c-c3a6-9ce8-592ae2f6e061@redhat.com>
Date: Fri, 5 Apr 2019 14:30:39 -0500
MIME-Version: 1.0
In-Reply-To: <20190405184037.16799-1-dgilbert@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="f63j5Yw2EoHyf37xmyea0nSW1T44oVe5p"
Subject: Re: [Qemu-devel] [PATCH for-4.0] test qgraph.c: Fix segs due to out
 of scope default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com, e.emanuelegiuseppe@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f63j5Yw2EoHyf37xmyea0nSW1T44oVe5p
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, e.emanuelegiuseppe@gmail.com
Message-ID: <b0340220-870c-c3a6-9ce8-592ae2f6e061@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0] test qgraph.c: Fix segs due to out
 of scope default
References: <20190405184037.16799-1-dgilbert@redhat.com>
In-Reply-To: <20190405184037.16799-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/5/19 1:40 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> The test uses the trick:
>    if (!opts) {
>      opts =3D &(QOSGraph...Options) { };
>    }
>=20
>   in a couple of places, however the temporary created
> by the &() {}  goes out of scope at the bottom of the if,
> and results in a seg or assert when opts-> fields are
> used (on fedora 30's gcc 9).
>=20
> Fixes: fc281c802022cb3a73a5
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  tests/libqos/qgraph.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Fixing it for 4.0 would be nice (we can't promise that everything in 4.0
is clean for gcc 9, but as long as we have to do -rc3 anyways, fixing
undefined behavior into something well-defined like this seems reasonable=
)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--f63j5Yw2EoHyf37xmyea0nSW1T44oVe5p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlynrN8ACgkQp6FrSiUn
Q2pYJwf7Bz9t8TrzBGBhG/XemR+x0MtuDQBcuzMiOEOP40oigL5VpTbPzikxqWck
ECd4snSHIa4TGbL527KKYPgGzm4+cl3PLLZjjmXUbQhFRQU6ZzJLJ8PJaMpUzciN
uBafbIPSJgHPMw0sZBrxkMhrJWDam/Auo/IFfQ4D20TvvrRVCiw5xZUvDGxSYa2v
+hsS8jTqkjFvs0Ps14+3C8IWyJu5QeWvUWbHLrzkKtzz1metx91W5Uf6CuKdbC51
DHG+v5qTCmO/9L1hrIrSbiTxjE8gVahfsQ9ISST9fgnBAmOQtAE2UmQeWv7xsoQ4
fjuHIt8ruryOvKY+NOjQZclALodDfg==
=rdjJ
-----END PGP SIGNATURE-----

--f63j5Yw2EoHyf37xmyea0nSW1T44oVe5p--
