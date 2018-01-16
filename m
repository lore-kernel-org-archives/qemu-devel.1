Received: from eggs.gnu.org ([2001:4830:134:3::10]:60333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebZ4P-00050V-JT
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 16:47:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebZ4O-00086i-Ge
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 16:47:01 -0500
References: <cover.1513342045.git.berto@igalia.com>
	<eb8ef83fece2863b8a209570a2a994a66f357c16.1513342045.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1b2b5566-f751-aa54-6d74-501e8f7d893b@redhat.com>
Date: Tue, 16 Jan 2018 15:46:49 -0600
MIME-Version: 1.0
In-Reply-To: <eb8ef83fece2863b8a209570a2a994a66f357c16.1513342045.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AQzmFXbn2iVpvyiGuYds2GyKRuybLOyDf"
Subject: Re: [Qemu-devel] [PATCH v2 08/32] qcow2: Remove BDS parameter from
 qcow2_cache_destroy()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AQzmFXbn2iVpvyiGuYds2GyKRuybLOyDf
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <1b2b5566-f751-aa54-6d74-501e8f7d893b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 08/32] qcow2: Remove BDS parameter from
 qcow2_cache_destroy()
References: <cover.1513342045.git.berto@igalia.com>
 <eb8ef83fece2863b8a209570a2a994a66f357c16.1513342045.git.berto@igalia.com>
In-Reply-To: <eb8ef83fece2863b8a209570a2a994a66f357c16.1513342045.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 06:53 AM, Alberto Garcia wrote:
> This function was never using the BlockDriverState parameter so it can
> be safely removed.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cache.c |  2 +-
>  block/qcow2.c       | 16 ++++++++--------
>  block/qcow2.h       |  2 +-
>  3 files changed, 10 insertions(+), 10 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--AQzmFXbn2iVpvyiGuYds2GyKRuybLOyDf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpecskACgkQp6FrSiUn
Q2ofzAgApuMpXrYjwyOt4VMvwZ2yyrUmWrcdswOJyd5ubzuQzYdf0uTmbZ7lVwGt
FgQIpjeb0s4TXJi59jyPO7rH/0JeJZcO37pMD+OmO4kXJUo03PBQ6WQRZ+o5Vna+
7uwzYQfFgP4yhPojO9vkqhjilr44oPS3JafeACW922sKDvxbIXfOCjxttXumjdUg
VC3p0peQAxi9+T+KDtyqfLZk6I8OXHbHl5+pOCrPIqxU6pypSlY2oBpphlEy7KA4
Cr4xrxH03c+GbvcdP2iWM5hWwmNM4GAhB5F4dEX8x1VSD/tPTQfXJr1iO/If+BOk
JpPXrScHqcw4XF6YZ0C5uw7Gp8oe5g==
=4oil
-----END PGP SIGNATURE-----

--AQzmFXbn2iVpvyiGuYds2GyKRuybLOyDf--
