Received: from eggs.gnu.org ([2001:4830:134:3::10]:50634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d48ca-0002LX-Qt
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 12:19:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d48cZ-0007fs-Pr
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 12:19:52 -0400
References: <1493261907-18734-1-git-send-email-lidongchen@tencent.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3684ce67-a2c0-01ee-b1d2-d96f1b45b8a2@redhat.com>
Date: Fri, 28 Apr 2017 18:19:41 +0200
MIME-Version: 1.0
In-Reply-To: <1493261907-18734-1-git-send-email-lidongchen@tencent.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="N9ARxJDmjUilaSSwKnGVQXasbAkgm8IiQ"
Subject: Re: [Qemu-devel] [PATCH v3] qemu-img: use blk_co_pwrite_zeroes for
 zero sectors when compressed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jemmy858585@gmail.com, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Lidong Chen <lidongchen@tencent.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--N9ARxJDmjUilaSSwKnGVQXasbAkgm8IiQ
From: Max Reitz <mreitz@redhat.com>
To: jemmy858585@gmail.com, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org,
 Lidong Chen <lidongchen@tencent.com>
Message-ID: <3684ce67-a2c0-01ee-b1d2-d96f1b45b8a2@redhat.com>
Subject: Re: [PATCH v3] qemu-img: use blk_co_pwrite_zeroes for zero sectors
 when compressed
References: <1493261907-18734-1-git-send-email-lidongchen@tencent.com>
In-Reply-To: <1493261907-18734-1-git-send-email-lidongchen@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.04.2017 04:58, jemmy858585@gmail.com wrote:
> From: Lidong Chen <lidongchen@tencent.com>
>=20
> When the buffer is zero, blk_co_pwrite_zeroes is more effective than
> blk_co_pwritev with BDRV_REQ_WRITE_COMPRESSED. This patch can reduce
> the time for converting qcow2 images with lots of zero data.
>=20
> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
> ---
>    v3 changelog:
>        fix some spelling errors and code style.
>    v2 changelog:
>        unify the compressed and non-compressed code paths.
> ---
>  qemu-img.c | 44 ++++++++++++++------------------------------
>  1 file changed, 14 insertions(+), 30 deletions(-)

Thank you, I have applied the patch to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--N9ARxJDmjUilaSSwKnGVQXasbAkgm8IiQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkDa50SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AamEH/1NTlTceY/gTQVXg3JQytJZjlZrRJCIT
MBedKoeEKS1zGOgK/jCDr+M4PvPyR63nkE1msz6V9p8f2uRPO0ZnsSPXZctQ1e0M
puDeGoxexhAd5jQWHc7zKLAy+rESImHmaeHAZMNF1vlspVTrXb+kAho5Mn9NVD74
YkgeXHEo0qmuZTFjxFiGi5S7j249xhkqFW4EAo/onwpa3TT1+M07Bf3hdHQ2uCR+
DtThRoUpkdG9s1T+lFWhyZQG9uPir2wF3cRzEuF8RkhwZWe/34tUh2sFeiqI7l3f
OQtZS6WyDqEdLA9iYFEyDiNYz+gHKp91GD98k4mavx7omu/g2W8VCMY=
=/HNS
-----END PGP SIGNATURE-----

--N9ARxJDmjUilaSSwKnGVQXasbAkgm8IiQ--
