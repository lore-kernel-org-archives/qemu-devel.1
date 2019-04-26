Received: from eggs.gnu.org ([209.51.188.92]:55678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hK7l2-0006dl-6W
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 16:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hK7hK-0007iy-No
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 16:43:55 -0400
References: <cover.1554985749.git.berto@igalia.com>
	<9dc45741ca93573c3c782f2333129ee6ed1e9274.1554985749.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e2d7327f-f9e8-60bf-e135-f38a0c955685@redhat.com>
Date: Fri, 26 Apr 2019 22:43:48 +0200
MIME-Version: 1.0
In-Reply-To: <9dc45741ca93573c3c782f2333129ee6ed1e9274.1554985749.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5dXhesZZVSm11Joonf9d9JnoyZ7XSmDNv"
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 1/2] commit: Make base read-only
 if there is an early failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5dXhesZZVSm11Joonf9d9JnoyZ7XSmDNv
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <e2d7327f-f9e8-60bf-e135-f38a0c955685@redhat.com>
Subject: Re: [PATCH for-4.1 v2 1/2] commit: Make base read-only if there is an
 early failure
References: <cover.1554985749.git.berto@igalia.com>
 <9dc45741ca93573c3c782f2333129ee6ed1e9274.1554985749.git.berto@igalia.com>
In-Reply-To: <9dc45741ca93573c3c782f2333129ee6ed1e9274.1554985749.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11.04.19 14:32, Alberto Garcia wrote:
> You can reproduce this by passing an invalid filter-node-name (like
> "1234") to block-commit. In this case the base image is put in
> read-write mode but is never reset back to read-only.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/commit.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--5dXhesZZVSm11Joonf9d9JnoyZ7XSmDNv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzDbYQACgkQ9AfbAGHV
z0DXkAf/YqBVOfsS6cIhv/kXge+iuWhJYdlMDV17x+EOfddtXyiMNIuAqhU5JTNu
TH8o5CcBA8I+p/32z9rDer/OR0R6d2aGcYQTwjxUXkJR3QZIPf6JxU/ZmZovsK+r
1fjBR/68RP2KFLtsKyZu0ANAwpcR5GsOW5WyaJE4ipDLflK2d9KZApXkbcyjhuWx
Fi3BiFoE5QpoQVA1OST5hps+iGfhfXCaj/UAigjN1lUWH5TH2qZmdLtcPataurI3
cMabjO77ALMBd2PsvXxsdHT4Lio5sfMtivzsNKoD+WKPujkwXj1PNWbJBmlG9wq2
9cFKdlQWGQrI7CN0W3pHZT6TmxvV5Q==
=HbZE
-----END PGP SIGNATURE-----

--5dXhesZZVSm11Joonf9d9JnoyZ7XSmDNv--
