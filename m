Received: from eggs.gnu.org ([2001:4830:134:3::10]:50596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eGnmg-0002rs-HR
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 10:14:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eGnma-00076k-Ra
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 10:14:54 -0500
References: <20171120145006.551-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <97f5c48d-ee07-88c5-c8e1-5a7495a8d6a1@redhat.com>
Date: Mon, 20 Nov 2017 09:14:36 -0600
MIME-Version: 1.0
In-Reply-To: <20171120145006.551-1-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qOd1mevkbGkCeFH34891rL8gSbiksXV5t"
Subject: Re: [Qemu-devel] [PATCH for-2.11 0/3] block: Error out on load_vm
 with active dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qOd1mevkbGkCeFH34891rL8gSbiksXV5t
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com,
 den@openvz.org, qemu-devel@nongnu.org
Message-ID: <97f5c48d-ee07-88c5-c8e1-5a7495a8d6a1@redhat.com>
Subject: Re: [PATCH for-2.11 0/3] block: Error out on load_vm with active
 dirty bitmaps
References: <20171120145006.551-1-kwolf@redhat.com>
In-Reply-To: <20171120145006.551-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/20/2017 08:50 AM, Kevin Wolf wrote:
> Following the discussing at
> https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg03572.html
> this implements the error return for loading a snapshot while dirty
> bitmaps are active.
>=20
> Kevin Wolf (3):
>   block: Add errp to bdrv_snapshot_goto()
>   block: Add errp to bdrv_all_goto_snapshot()
>   block: Error out on load_vm with active dirty bitmaps

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
>  include/block/snapshot.h |  6 ++++--
>  block/snapshot.c         | 43 +++++++++++++++++++++++-----------------=
---
>  migration/savevm.c       |  6 +++---
>  qemu-img.c               |  6 +++---
>  4 files changed, 33 insertions(+), 28 deletions(-)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qOd1mevkbGkCeFH34891rL8gSbiksXV5t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloS8VwACgkQp6FrSiUn
Q2rwpwf/ecbsChZm6xGnFp/RQmIT3yo4w3p1YjRbMbg+AazoMvTPK6PxQ0zIqQ4P
jvkjHOmcKhtIT8hVP8DU0T3XpUXddAVIsUuKu6K2Xw5DXENx/E5NDgqp7PJ+vdsc
yhCMhb8nrdYDsx3zKDOnb9BYsvfF8gFCl/QObCZYhzuDAcuplpdcIBAR4tWKiG6S
lRhgtcCfet/bevdBes040lTojVHhTt8Q5hc9+c6Gi0TCe91+cUbeDvbn4TvrBlEl
jaMAA0TsUkYK8RD1cYXyvNB2WcUwbinNh73WXpEL7XoMFlarBhrO0x3Babf5XTb5
fOu98yQG0vTF0F8GLjaygdOkYHgAEA==
=5lj0
-----END PGP SIGNATURE-----

--qOd1mevkbGkCeFH34891rL8gSbiksXV5t--
