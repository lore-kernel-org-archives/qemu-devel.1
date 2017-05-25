Received: from eggs.gnu.org ([2001:4830:134:3::10]:44003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDx0m-00050P-VP
	for qemu-devel@nongnu.org; Thu, 25 May 2017 13:57:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDx0m-0008OT-0y
	for qemu-devel@nongnu.org; Thu, 25 May 2017 13:57:25 -0400
References: <20170525152628.37628-1-vsementsov@virtuozzo.com>
	<20170525152628.37628-5-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0333cea2-78ca-cf4d-4ebc-3f88c93f0a30@redhat.com>
Date: Thu, 25 May 2017 12:57:15 -0500
MIME-Version: 1.0
In-Reply-To: <20170525152628.37628-5-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MD6rcJCKt0nrx8DeH5wNNf6flXGeDlare"
Subject: Re: [Qemu-devel] [PATCH 4/7] common: make get_human_readable_size
 public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MD6rcJCKt0nrx8DeH5wNNf6flXGeDlare
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <0333cea2-78ca-cf4d-4ebc-3f88c93f0a30@redhat.com>
Subject: Re: [PATCH 4/7] common: make get_human_readable_size public
References: <20170525152628.37628-1-vsementsov@virtuozzo.com>
 <20170525152628.37628-5-vsementsov@virtuozzo.com>
In-Reply-To: <20170525152628.37628-5-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/25/2017 10:26 AM, Vladimir Sementsov-Ogievskiy wrote:
> To be reused from qemu-img check.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qapi.c          | 2 +-
>  include/qemu-common.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)

Would it be better to use size_to_str() added in commit 22951aa?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--MD6rcJCKt0nrx8DeH5wNNf6flXGeDlare
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJxr7AAoJEKeha0olJ0Nqtc4IAJCBVYLD5+gyMA3eemxZJsb4
JQO8Mak41RwgKoFBM1eJ7OCk1FF0fH3qkAw0o5mf6mpVIGJ9qK7/Z1v++aYPQ8Nd
r7ESZ5nEfjdQOXTvjgVLL72aUOcl4plgp+YdGoIcNx9s3IUciS1aBAjetMQW8kDF
lAqZKGqdeqplL7ZPPAd8o3e+l+9T8sYC/hh5W2HOLirRhnwzKagu+evsa2SdpYLR
0LtZZd+2zrXSQYQpGLbsx2b9nh5pJsEMhNeHIHF/0jZOOdHV+80u4uvUrGIWbiVy
smhRXsXAqOGJzm8bDL4HiFI9xySkF+PtreASfwJEV+zU7sNbIVPm6Z6NAapM+tU=
=G5o7
-----END PGP SIGNATURE-----

--MD6rcJCKt0nrx8DeH5wNNf6flXGeDlare--
