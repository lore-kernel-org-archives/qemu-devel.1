Received: from eggs.gnu.org ([2001:4830:134:3::10]:59058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fxXIj-00070V-VF
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 08:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fxXIj-0001e8-3W
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 08:52:53 -0400
References: <cover.1535983918.git.berto@igalia.com>
	<ccd55f9905b13f61515299977187c0b430b492bb.1535983918.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2a526c45-d61b-f923-a9c5-7dc96e058cc3@redhat.com>
Date: Wed, 5 Sep 2018 14:52:41 +0200
MIME-Version: 1.0
In-Reply-To: <ccd55f9905b13f61515299977187c0b430b492bb.1535983918.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="i3qSe3hDGmrqoMZb0iaupkvl1eBJBLzQT"
Subject: Re: [Qemu-devel] [PATCH v2 09/10] block: Allow changing
 'detect-zeroes' on reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i3qSe3hDGmrqoMZb0iaupkvl1eBJBLzQT
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <2a526c45-d61b-f923-a9c5-7dc96e058cc3@redhat.com>
Subject: Re: [PATCH v2 09/10] block: Allow changing 'detect-zeroes' on reopen
References: <cover.1535983918.git.berto@igalia.com>
 <ccd55f9905b13f61515299977187c0b430b492bb.1535983918.git.berto@igalia.com>
In-Reply-To: <ccd55f9905b13f61515299977187c0b430b492bb.1535983918.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-09-03 16:34, Alberto Garcia wrote:
> 'detect-zeroes' is one of the basic BlockdevOptions available for all
> drivers, but it's not handled by bdrv_reopen_prepare(), so any attempt
> to change it results in an error:
>=20
>    (qemu) qemu-io virtio0 "reopen -o detect-zeroes=3Don"
>    Cannot change the option 'detect-zeroes'
>=20
> Since there's no reason why we shouldn't allow changing it and the
> implementation is simple let's just do it.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Cc: Max Reitz <mreitz@redhat.com>
> ---
>  block.c               | 63 +++++++++++++++++++++++++++++++------------=
--------
>  include/block/block.h |  1 +
>  2 files changed, 40 insertions(+), 24 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--i3qSe3hDGmrqoMZb0iaupkvl1eBJBLzQT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluP0ZkACgkQ9AfbAGHV
z0CKFwgAv9/nuwNo2j1yxdC8N/QQAmheaPIK65F2IHNxZ7NnjVvEvCGr5fBHNf3/
aykMUPyCUzBQWUK4LdCH0HImTogjBl3Go/2WMuab5Tu5l35qBHK8SyFXQ66wR+qd
m48hm55Xsgc+agHSAqQ2wMp2gm2sltN9uo54RDJH4IdIcRzJzM4koiNCwI1HUcUE
QOmOU8cTfGllYntT88W2ZIykAOdHPiuYBlQ0/028w1N8MIkltZgu6+cWAAveyH0N
OtujE9SMlsQP3OzE226F8sD5j+UEsnCrpH+ioiRw0qUYLgKF2uEkIRsG0fqNzCRz
ApACPehBYygKyKm0pl7NhRSLhheBWw==
=PYdM
-----END PGP SIGNATURE-----

--i3qSe3hDGmrqoMZb0iaupkvl1eBJBLzQT--
