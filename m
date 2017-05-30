Received: from eggs.gnu.org ([2001:4830:134:3::10]:40337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFpGz-0002mE-6m
	for qemu-devel@nongnu.org; Tue, 30 May 2017 18:05:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFpGu-0001fd-Vw
	for qemu-devel@nongnu.org; Tue, 30 May 2017 18:05:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dFpGu-0001fD-Ns
	for qemu-devel@nongnu.org; Tue, 30 May 2017 18:05:48 -0400
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
	<20170530143052.165002-9-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ea32db8a-2cd9-106a-28ff-7fbab530049b@redhat.com>
Date: Tue, 30 May 2017 17:05:45 -0500
MIME-Version: 1.0
In-Reply-To: <20170530143052.165002-9-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BfI3psXj3soLvfDjbUVb4rQ90CXvUeQWE"
Subject: Re: [Qemu-devel] [PATCH 08/19] nbd/server: get rid of fail: return
 rc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BfI3psXj3soLvfDjbUVb4rQ90CXvUeQWE
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org
Message-ID: <ea32db8a-2cd9-106a-28ff-7fbab530049b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 08/19] nbd/server: get rid of fail: return rc
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
 <20170530143052.165002-9-vsementsov@virtuozzo.com>
In-Reply-To: <20170530143052.165002-9-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/30/2017 09:30 AM, Vladimir Sementsov-Ogievskiy wrote:
> "goto fail" error handling scheme is not needed for just returning
> error code. Better is return it immediately.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/server.c | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--BfI3psXj3soLvfDjbUVb4rQ90CXvUeQWE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLey5AAoJEKeha0olJ0NqhdQH/ROVatvHKMYjyON9iEMOplRd
93g+7Pg08Ssbg6x0n7E+0vNqtmBFxwsNJWsK93CqIyB3TBW6txwACY5Q3c30TwfD
pj9oBwFNi4f8CIMboO8sXwmYKhrYjcclw980/rDnM7jjypKgcBel2+Zn3vaxJNot
9/xyNnWIfrwendwqyGByM+VdH5uciK59V/0wNzp04gy84t4xrUOL/mEwTc+1w/1T
Ylj/30x0z/IkREWjxVP/Lnd2eMx90NRDBG7wOfE7wMd2VeeF8ST7paxu4DJirnUJ
RhPWHlKcfPyNI8A+DDEhRCOlOtXt7NMqfkOOOZHlrMkJGewQXFSujdJgaJkrCU4=
=GjAe
-----END PGP SIGNATURE-----

--BfI3psXj3soLvfDjbUVb4rQ90CXvUeQWE--
