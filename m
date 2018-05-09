Received: from eggs.gnu.org ([2001:4830:134:3::10]:50401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGX5a-0002Ri-VU
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:57:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGX5a-00089s-8R
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:57:35 -0400
References: <20180502202051.15493-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8a815994-e84a-61fd-b69f-420e5d9d6461@redhat.com>
Date: Wed, 9 May 2018 23:57:26 +0200
MIME-Version: 1.0
In-Reply-To: <20180502202051.15493-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JwdsndkHXwqsffbgMChXmp8SQO1QXaRTU"
Subject: Re: [Qemu-devel] [PATCH 0/3] qemu-io/img: Fix -U/force-share
 conflict testing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JwdsndkHXwqsffbgMChXmp8SQO1QXaRTU
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <famz@redhat.com>, qemu-stable@nongnu.org
Message-ID: <8a815994-e84a-61fd-b69f-420e5d9d6461@redhat.com>
Subject: Re: [PATCH 0/3] qemu-io/img: Fix -U/force-share conflict testing
References: <20180502202051.15493-1-mreitz@redhat.com>
In-Reply-To: <20180502202051.15493-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-02 22:20, Max Reitz wrote:
> qemu-img and qemu-io try to detect when you use both -U and force-share=

> manually, but a conflict is not rejected with an error message but with=

> a segmentation fault.  I guess that works, but it's probably not the wa=
y
> it was meant to be.
>=20
>=20
> Max Reitz (3):
>   qemu-io: Use purely string blockdev options
>   qemu-img: Use only string options in img_open_opts
>   iotests: Add test for -U/force-share conflicts
>=20
>  qemu-img.c                 |  4 ++--
>  qemu-io.c                  |  4 ++--
>  tests/qemu-iotests/153     | 17 +++++++++++++++++
>  tests/qemu-iotests/153.out | 16 ++++++++++++++++
>  4 files changed, 37 insertions(+), 4 deletions(-)

Thanks for the review, applied to my block branch.

Max


--JwdsndkHXwqsffbgMChXmp8SQO1QXaRTU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrzbsYACgkQ9AfbAGHV
z0DpgQf+JEj0GKGfxG+ObMOMyi1TJXoSL2lWS+iU05i1nHJ3yz5Y8ba3XHjfWbSF
PQ1ZyXW7GjZIIKzEJimPtHb0EwiFWlKJg7DHpRaz+hxqXQwZ0Snq0ElUBcpk2grH
SS4upD4eQFtSX1Plf284bHglRRH+K+XS8hHJyim2ovw1rZvx/QkHKmQQKKQdLd8Q
p2OCa2jzwQUlOJS4IbnH/ChyLt6UbbmrR0YsPO77m+3TqH6tyeSveKJy961H4qti
TxD4jsRLEJ7Q/lFWk3KfeioH266gg7uKof6y6Y2t/+V0CheD+sWvW629vYwcMzab
YKGLR2vModhF1CR0LF10XdEMGqxmSQ==
=Gy+g
-----END PGP SIGNATURE-----

--JwdsndkHXwqsffbgMChXmp8SQO1QXaRTU--
