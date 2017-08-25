Received: from eggs.gnu.org ([2001:4830:134:3::10]:56404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dlM1R-0006IW-83
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 17:20:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dlM1P-0008G9-GL
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 17:20:09 -0400
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
	<20170804151440.320927-5-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <29ab02e4-edc9-0554-c90a-88d14712c829@redhat.com>
Date: Fri, 25 Aug 2017 16:20:00 -0500
MIME-Version: 1.0
In-Reply-To: <20170804151440.320927-5-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="F92VcPEvdnVWQG2FJrxtvecUaS2it9JvU"
Subject: Re: [Qemu-devel] [PATCH 04/17] nbd/client: fix nbd_send_request to
 return int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F92VcPEvdnVWQG2FJrxtvecUaS2it9JvU
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <29ab02e4-edc9-0554-c90a-88d14712c829@redhat.com>
Subject: Re: [PATCH 04/17] nbd/client: fix nbd_send_request to return int
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
 <20170804151440.320927-5-vsementsov@virtuozzo.com>
In-Reply-To: <20170804151440.320927-5-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/04/2017 10:14 AM, Vladimir Sementsov-Ogievskiy wrote:
> Fix nbd_send_request to return int, as it returns a return value
> of nbd_write (which is int), and the only user of nbd_send_request's
> return value (nbd_co_send_request) consider it as int too.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/nbd.h | 2 +-
>  nbd/client.c        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--F92VcPEvdnVWQG2FJrxtvecUaS2it9JvU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmglIAACgkQp6FrSiUn
Q2p46Qf9HuOnUKE1NBUmjtvdzwP/XGiltyg0Jtj9IlwFdqiD2hh8I0Z0FfM6np+F
j/cjg4daiBoVv0mAry579LGJGbmW7i+3A8lomCrMt5q5vAxy1dIWX0XpFGoxzeXt
RCzMQKRayWoD5eroxXRk2BnkB5hIHK4tOf3ZZBxWEvlaDBzujmPV7offwfUoCBbK
6YMyupQdHlyDqNua61eePzhOnYqbrKuI8QF5OL97bLsoXA5CYbtmtXSwhTX9bxrr
Rocb4R3HbnWjfUVRSUKNVXus40uebhD4NVgwQg3xsRXpTA5p0LZ0wLw/EOMAGHVj
TE+q9KB7sPguVcbJEKmmJ+Qamz1dcA==
=YmJ/
-----END PGP SIGNATURE-----

--F92VcPEvdnVWQG2FJrxtvecUaS2it9JvU--
