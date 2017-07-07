Received: from eggs.gnu.org ([2001:4830:134:3::10]:41631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTale-0006F1-NI
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 17:26:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTald-0005rE-PV
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 17:26:26 -0400
References: <20170707143028.692-1-pbutsykin@virtuozzo.com>
	<20170707143028.692-4-pbutsykin@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <15af9be5-dbc2-cac1-31b4-432492fb7477@redhat.com>
Date: Fri, 7 Jul 2017 16:26:18 -0500
MIME-Version: 1.0
In-Reply-To: <20170707143028.692-4-pbutsykin@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HGBH6nCg3WMXxmwMvGKtKbX823hkVpIqf"
Subject: Re: [Qemu-devel] [PATCH v3 3/4] qcow2: add shrink image support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HGBH6nCg3WMXxmwMvGKtKbX823hkVpIqf
From: Eric Blake <eblake@redhat.com>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, den@openvz.org
Message-ID: <15af9be5-dbc2-cac1-31b4-432492fb7477@redhat.com>
Subject: Re: [PATCH v3 3/4] qcow2: add shrink image support
References: <20170707143028.692-1-pbutsykin@virtuozzo.com>
 <20170707143028.692-4-pbutsykin@virtuozzo.com>
In-Reply-To: <20170707143028.692-4-pbutsykin@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/07/2017 09:30 AM, Pavel Butsykin wrote:
> This patch add shrinking of the image file for qcow2. As a result, this=
 allows
> us to reduce the virtual image size and free up space on the disk witho=
ut
> copying the image. Image can be fragmented and shrink is done by punchi=
ng holes
> in the image file.
>=20
> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
> ---
>  block/qcow2-cluster.c  |  40 +++++++++++++++++++
>  block/qcow2-refcount.c | 103 +++++++++++++++++++++++++++++++++++++++++=
++++++++
>  block/qcow2.c          |  42 +++++++++++++++-----
>  block/qcow2.h          |  14 +++++++
>  qapi/block-core.json   |   3 +-
>  5 files changed, 191 insertions(+), 11 deletions(-)
>=20

> +++ b/qapi/block-core.json
> @@ -2372,7 +2372,8 @@
>              'cluster_alloc_bytes', 'cluster_free', 'flush_to_os',
>              'flush_to_disk', 'pwritev_rmw_head', 'pwritev_rmw_after_he=
ad',
>              'pwritev_rmw_tail', 'pwritev_rmw_after_tail', 'pwritev',
> -            'pwritev_zero', 'pwritev_done', 'empty_image_prepare' ] }
> +            'pwritev_zero', 'pwritev_done', 'empty_image_prepare',
> +            'l1_shrink_write_table', 'l1_shrink_free_l2_clusters' ] }

Missing documentation for the additions.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--HGBH6nCg3WMXxmwMvGKtKbX823hkVpIqf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZX/x6AAoJEKeha0olJ0Nq4I0H/1NDeWtkeW49pcqetABbrT5k
DI2VPyM0Uxgg6Ys/6T09PZfq90kfNazy+H2VybHd9t/fmKR3sG6hO18ImAGiOXl7
f0faE9mpaMGXjr6iuS41tuL9jNB5DDBMmFsviEqu3vAZnyHgEXlDBYICuO9Vc6PY
e7yux6GwhamVL7moJJP5x14dzvE8spgObM7X6nlDLvKYGxmCg2fTc8D/B8Cf1QYL
8L3BP+nPMBTDe1q6lDovnFnjOXFXT3aZxamF4iXxwz1a//47rUkc4vYXZGTzrSmQ
JtDdn77+hK7+sKKzXPIABkjZ3ki+anIebHInTJTdbbWxrGfMjWUpEiO7J4CowrU=
=6DI5
-----END PGP SIGNATURE-----

--HGBH6nCg3WMXxmwMvGKtKbX823hkVpIqf--
