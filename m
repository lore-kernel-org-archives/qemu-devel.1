Received: from eggs.gnu.org ([2001:4830:134:3::10]:33770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cFOjF-0003IC-5N
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 12:13:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cFOjE-0004mx-Em
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 12:13:01 -0500
References: <1479835586-74394-1-git-send-email-vsementsov@virtuozzo.com>
	<1479835586-74394-15-git-send-email-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ec0c7435-1718-bc8c-e5ec-dc2080af4330@redhat.com>
Date: Fri, 9 Dec 2016 18:12:49 +0100
MIME-Version: 1.0
In-Reply-To: <1479835586-74394-15-git-send-email-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OPXlj8E83rWME74qAAjjd3cNseMVor6uQ"
Subject: Re: [Qemu-devel] [PATCH 14/21] block: add
 bdrv_can_store_dirty_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OPXlj8E83rWME74qAAjjd3cNseMVor6uQ
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <ec0c7435-1718-bc8c-e5ec-dc2080af4330@redhat.com>
Subject: Re: [PATCH 14/21] block: add bdrv_can_store_dirty_bitmap
References: <1479835586-74394-1-git-send-email-vsementsov@virtuozzo.com>
 <1479835586-74394-15-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1479835586-74394-15-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 22.11.2016 18:26, Vladimir Sementsov-Ogievskiy wrote:
> This will be needed to check some restrictions before making bitmap
> persistent in qmp-block-dirty-bitmap-add (this functionality will be
> added by future patch)
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block.c                   | 22 ++++++++++++++++++++++
>  include/block/block.h     |  2 ++
>  include/block/block_int.h |  2 ++
>  3 files changed, 26 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--OPXlj8E83rWME74qAAjjd3cNseMVor6uQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlhK5hESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AyesH/icfALdY8+SXhAked+uTfVVn7q0yGXfw
PNr4d80v9Exf7WE/uu8DzIYvGg+QVK1ixPZZhKwegKvPHAfIdSWrjjXH7aVvZfCK
7u+hs9tpVAFhX0NQjjlNXQuLQO50bXQFpDfUjMEZyYw8lqjs+ho/6R6HBN3k9Dj4
wkY87KGpZMZIjL5NK1GgG1m2JrDujlcAHyPXg47ztZ0V7UV2ZGRqSnYii5CKj2Qj
n5PA9KMPb+5uyY8t9zlqUbBsCggEaxn9osAkWs3EBHXst2HzYAOqTgvk/P6pem9W
y/qut6M+OrkHBL+meVCRt6AZfinM54V6cSTf1cHqaJBiWJqKoM/qrFo=
=fbK5
-----END PGP SIGNATURE-----

--OPXlj8E83rWME74qAAjjd3cNseMVor6uQ--
