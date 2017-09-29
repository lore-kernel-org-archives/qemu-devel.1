Received: from eggs.gnu.org ([2001:4830:134:3::10]:49010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxuuc-0005tJ-Hc
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 09:01:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxuuY-0002DX-Jm
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 09:01:02 -0400
References: <20170929121613.25997-1-pbutsykin@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2140c3b0-987c-ae7f-06b7-28ccccf656d1@redhat.com>
Date: Fri, 29 Sep 2017 15:00:40 +0200
MIME-Version: 1.0
In-Reply-To: <20170929121613.25997-1-pbutsykin@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="T1wta8TwFIRKRwiq8fOU5l4GTxmFfDNlw"
Subject: Re: [Qemu-devel] [PATCH v4 0/2] Truncate the tail of the image file
 in qcow2 shrinking
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, jsnow@redhat.com, den@openvz.org
List-ID: <qemu-devel.nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--T1wta8TwFIRKRwiq8fOU5l4GTxmFfDNlw
From: Max Reitz <mreitz@redhat.com>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, jsnow@redhat.com, den@openvz.org
Message-ID: <2140c3b0-987c-ae7f-06b7-28ccccf656d1@redhat.com>
Subject: Re: [PATCH v4 0/2] Truncate the tail of the image file in qcow2
 shrinking
References: <20170929121613.25997-1-pbutsykin@virtuozzo.com>
In-Reply-To: <20170929121613.25997-1-pbutsykin@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-29 14:16, Pavel Butsykin wrote:
> Now after shrinking the qcow2 image, at the end of the image file, ther=
e might
> be a tail that probably will never be used. Although it will not bring =
any
> tangible benefit, we can cut the tail if it is. Yes, it will not free u=
p disk
> space, but if the blocks were be allocated sequentially and the image i=
s not
> heavily fragmented then the virtual size of the image file will be comm=
ensurate
> with the real size. It also doesn't look like a great plus.. Well, at l=
east we
> can discuss it.
>=20
> Changes from v1:
> - rewrite qcow2_get_last_cluster() function according to Max's comments=
=2E (2)
>=20
> Changes from v2:
> - report a warning if truncation of the tail of the image file failed. =
(2)
>=20
> Pavel Butsykin (2):
>   qcow2: fix return error code in qcow2_truncate()
>   qcow2: truncate the tail of the image file after shrinking the image
>=20
>  block/qcow2-refcount.c | 22 ++++++++++++++++++++++
>  block/qcow2.c          | 27 +++++++++++++++++++++++++--
>  block/qcow2.h          |  1 +
>  3 files changed, 48 insertions(+), 2 deletions(-)

Thanks, applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--T1wta8TwFIRKRwiq8fOU5l4GTxmFfDNlw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnOQ/gSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AVKEIALXz5TIzTql4XU+U8+IN3abBdeE6vyvz
6hypzUSoc+35MopX3HgRSwnEyg5PLSzFRQIcvMdiEMXLnjPsn0sV+6N8VOnQBBpB
TutHCRiWDY+gNvWKHfyqxGbHnjX8sM+vX8eySPXSVBgQSpOxRgJxDG1OJ3zkaFmI
zba9kVE9oFA8qLQaN01BDw4cZpsfPWtX+uDwm1JbadraPMx7QUFqLiFjpspr/sAK
YFzvRP1YgDJApdjjviaGtm0FFQkTBg7x4/j8ttZ/ToAskEDQrbC78ch09DB+etIl
EFiu9uARmjZCmtV7iAXkB4tAiG5IZwneb2r7qH96bm/jp0l18bm9HsQ=
=QrWd
-----END PGP SIGNATURE-----

--T1wta8TwFIRKRwiq8fOU5l4GTxmFfDNlw--
