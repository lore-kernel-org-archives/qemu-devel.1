Received: from eggs.gnu.org ([2001:4830:134:3::10]:35621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6KRu-00005C-Lt
	for qemu-devel@nongnu.org; Thu, 04 May 2017 13:21:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6KRt-00068O-P4
	for qemu-devel@nongnu.org; Thu, 04 May 2017 13:21:54 -0400
References: <1493916761-32319-1-git-send-email-kwolf@redhat.com>
	<1493916761-32319-4-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4a775c24-d244-55d3-3b81-42fa1ab1eeca@redhat.com>
Date: Thu, 4 May 2017 12:21:43 -0500
MIME-Version: 1.0
In-Reply-To: <1493916761-32319-4-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iMAS1TUJqljoxQv63Gri6rDkPHTGrvqae"
Subject: Re: [Qemu-devel] [PATCH 3/6] block: Drop permissions when migration
 completes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iMAS1TUJqljoxQv63Gri6rDkPHTGrvqae
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Message-ID: <4a775c24-d244-55d3-3b81-42fa1ab1eeca@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/6] block: Drop permissions when migration
 completes
References: <1493916761-32319-1-git-send-email-kwolf@redhat.com>
 <1493916761-32319-4-git-send-email-kwolf@redhat.com>
In-Reply-To: <1493916761-32319-4-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/04/2017 11:52 AM, Kevin Wolf wrote:
> With image locking, permissions affect other qemu processes as well. We=

> want to be sure that the destination can run, so let's drop permissions=

> on the source when migration completes.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c                   | 12 +++++++++++-
>  block/block-backend.c     | 25 +++++++++++++++++++++++++
>  include/block/block_int.h |  7 ++++---
>  3 files changed, 40 insertions(+), 4 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--iMAS1TUJqljoxQv63Gri6rDkPHTGrvqae
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZC2MoAAoJEKeha0olJ0Nq9oAH/RCSyaqmaoQzH6+26OsVunmN
A24ddeqpwBd5wsmPZNqwNodls8b3AICAy5K97xC1puIAY/UuzxogD6LdtYBw02j4
+mXBT4TaCMgU7BfblHq7sYmEzedPDwgb7WTANHBGXGWQBJD9eB88Jc5HiO/8wQLs
pCuisELm6izv5K8ohAtT04sj9tCKmx0SRT0vxj5oU5fDSrDLIPL4jOpnF7w3BeCy
n55poz6qXFApaSioJ0IXeMY9mralnoTqoHd5xp1bAEUeblJ2oel12P/YWIR6N9mb
pWikwhQCasTG5MerDkFN0wvXUv2WYkq5nHT4QyggTnZAtqikHuZp24ksndQ9FJI=
=tU3D
-----END PGP SIGNATURE-----

--iMAS1TUJqljoxQv63Gri6rDkPHTGrvqae--
