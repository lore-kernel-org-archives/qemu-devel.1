Received: from eggs.gnu.org ([2001:4830:134:3::10]:39709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUfqL-0003n0-De
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 17:03:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUfqK-0002je-HU
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 17:03:45 -0400
References: <20170710163029.129912-1-vsementsov@virtuozzo.com>
	<20170710163029.129912-7-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3af32ef6-6957-c24b-a8f7-b2068365b5b1@redhat.com>
Date: Mon, 10 Jul 2017 16:03:26 -0500
MIME-Version: 1.0
In-Reply-To: <20170710163029.129912-7-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="E9LvVmW8QVvNVACB8lnAgLXoJ43fGgeKS"
Subject: Re: [Qemu-devel] [PATCH v7 06/16] qapi: add dirty-bitmaps migration
 capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E9LvVmW8QVvNVACB8lnAgLXoJ43fGgeKS
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, famz@redhat.com,
 stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com,
 mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org,
 dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com
Message-ID: <3af32ef6-6957-c24b-a8f7-b2068365b5b1@redhat.com>
Subject: Re: [PATCH v7 06/16] qapi: add dirty-bitmaps migration capability
References: <20170710163029.129912-1-vsementsov@virtuozzo.com>
 <20170710163029.129912-7-vsementsov@virtuozzo.com>
In-Reply-To: <20170710163029.129912-7-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/10/2017 11:30 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/migration.c | 9 +++++++++
>  migration/migration.h | 1 +
>  qapi-schema.json      | 4 +++-
>  3 files changed, 13 insertions(+), 1 deletion(-)
>=20

> +++ b/qapi-schema.json
> @@ -903,12 +903,14 @@
>  # @return-path: If enabled, migration will use the return path even
>  #               for precopy. (since 2.10)
>  #
> +# @dirty-bitmaps: If enabled, QEMU will migrate named dirty bitmaps. (=
since 2.9)

We've missed 2.9; this should be 2.10.

> +#
>  # Since: 1.2
>  ##
>  { 'enum': 'MigrationCapability',
>    'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
>             'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ra=
m',
> -           'block', 'return-path' ] }
> +           'block', 'return-path', 'dirty-bitmaps' ] }
> =20
>  ##
>  # @MigrationCapabilityStatus:
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--E9LvVmW8QVvNVACB8lnAgLXoJ43fGgeKS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZY+ueAAoJEKeha0olJ0NqkuwH+gPNoWrDarW0P7Cv+YiEMWuc
CQK3Uck5jI7GlkeCl57+5U4v+L9IAuhsOCWIllpjSLoq/aQYRLmo506bEDqcCOZv
UCfyBg5K+LXRaL10D1l5r5lYsMtqRB26MGaJf3fElKTtk/96G5wbw7yy0dQVpdhY
+zo1nz7T+K6N8XcM+oaPuMJ2/DNNYSbdQtH5ADgZiOdqRr9DDTB86YVlfpL9u0rs
PQRm1rxRDvQQalrnHOTQvHr5JwaSghSWJnAqO3yUVfMVxNJMAeGSoqGNLoZCvux3
pbqVYtgu0kxLpgfFQcToKJVaGH3e5NypRrPzM0PrW8dfuC/nNt8ZP1Vasx1ED2g=
=jgOe
-----END PGP SIGNATURE-----

--E9LvVmW8QVvNVACB8lnAgLXoJ43fGgeKS--
