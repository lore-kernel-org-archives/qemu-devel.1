Received: from eggs.gnu.org ([2001:4830:134:3::10]:37665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egxXN-0000cr-Hz
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 13:55:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egxXM-0000Z3-OH
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 13:55:13 -0500
References: <20180118105841.GA1897@liangdeMacBook-Pro.local>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <fc921c84-f068-db12-f054-b38049013a9c@redhat.com>
Date: Wed, 31 Jan 2018 19:54:54 +0100
MIME-Version: 1.0
In-Reply-To: <20180118105841.GA1897@liangdeMacBook-Pro.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7yNfakVm29lUSJPABi2OQNvZN0ZNq5Q70"
Subject: Re: [Qemu-devel] [PATCH] hbitmap: fix missing restore count when
 finish deserialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liang Li <liliangleo@didichuxing.com>, vsementsov@virtuozzo.com, famz@redhat.com
Cc: qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7yNfakVm29lUSJPABi2OQNvZN0ZNq5Q70
From: Max Reitz <mreitz@redhat.com>
To: Liang Li <liliangleo@didichuxing.com>, vsementsov@virtuozzo.com,
 famz@redhat.com
Cc: qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>,
 John Snow <jsnow@redhat.com>
Message-ID: <fc921c84-f068-db12-f054-b38049013a9c@redhat.com>
Subject: Re: [PATCH] hbitmap: fix missing restore count when finish
 deserialization
References: <20180118105841.GA1897@liangdeMacBook-Pro.local>
In-Reply-To: <20180118105841.GA1897@liangdeMacBook-Pro.local>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-18 11:58, Liang Li wrote:
> The .count of HBitmap is forgot to set in function
> hbitmap_deserialize_finish, let's set it to the right value.
>=20
> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Cc: Fam Zheng <famz@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: John Snow <jsnow@redhat.com>
> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
> Signed-off-by: Liang Li <liliangleo@didichuxing.com>
> ---
>  util/hbitmap.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/util/hbitmap.c b/util/hbitmap.c
> index 289778a..58a2c93 100644
> --- a/util/hbitmap.c
> +++ b/util/hbitmap.c
> @@ -630,6 +630,7 @@ void hbitmap_deserialize_finish(HBitmap *bitmap)
>      }
> =20
>      bitmap->levels[0][0] |=3D 1UL << (BITS_PER_LONG - 1);
> +    bitmap->count =3D hb_count_between(bitmap, 0, bitmap->size - 1);
>  }
> =20
>  void hbitmap_free(HBitmap *hb)

Actually CC-ing John...

(Looks good to me, though.)

Max


--7yNfakVm29lUSJPABi2OQNvZN0ZNq5Q70
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpyEP4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Ali8IAKa3F29cDIVcImZHtaNvFLThewNRj2Gd
6+2tjijf6hhcEeLDW9exfDDxH1uUtG1pY7Y9SPXnWCD4EsRbOFgwwfKHaauLkwNt
gcL3NZ0jtTt3FniJaiqH4NHJSQ2MCrqoMT5xFtTnQvhMSSpxSjK2GTG4eAwJtBJb
VztOoysuSUQ8S0siWusLsynTRRV20oRG6Nn1LzUL018maRub9nb0TGlpjetakO/n
ulGf5xayOZrgLv8eV08IvmVFNgamceklrdWoJRE71f0vXcMMRsqnWRdW/GvOjX2j
Y2nl5Muo5n23bgoHU2RVKOVq66pQ8dkPt2If1sb+3o5xR3hEY4aXl3k=
=YJHz
-----END PGP SIGNATURE-----

--7yNfakVm29lUSJPABi2OQNvZN0ZNq5Q70--
