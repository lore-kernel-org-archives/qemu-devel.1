Received: from eggs.gnu.org ([209.51.188.92]:39873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLCEa-0007bk-4c
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 15:46:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLCEY-0000cQ-T1
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 15:46:39 -0400
References: <cover.1556562150.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <af631418-7a2b-db53-21ee-66b305912ae7@redhat.com>
Date: Mon, 29 Apr 2019 14:46:22 -0500
MIME-Version: 1.0
In-Reply-To: <cover.1556562150.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5uwl9wD1oXuwOiUlMpw2HiANXgstrxY0B"
Subject: Re: [Qemu-devel] [PATCH 0/5] Remove bdrv_read() and bdrv_write()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5uwl9wD1oXuwOiUlMpw2HiANXgstrxY0B
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <af631418-7a2b-db53-21ee-66b305912ae7@redhat.com>
Subject: Re: [PATCH 0/5] Remove bdrv_read() and bdrv_write()
References: <cover.1556562150.git.berto@igalia.com>
In-Reply-To: <cover.1556562150.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/29/19 1:42 PM, Alberto Garcia wrote:
> Hi,
>=20
> this API only had a few users left so it can be easily removed.

Sounds very similar to my earlier attempt at the same:

https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg02769.html

>=20
> Regards,
>=20
> Berto
>=20
> Alberto Garcia (5):
>   qcow2: Replace bdrv_write() with bdrv_pwrite()
>   vdi: Replace bdrv_{read,write}() with bdrv_{pread,pwrite}()
>   vvfat: Replace bdrv_{read,write}() with bdrv_{pread,pwrite}()
>   block: Remove bdrv_read() and bdrv_write()
>   qcow2: Remove BDRVQcow2State.cluster_sectors
>=20
>  block/io.c             | 36 ------------------------------------
>  block/qcow2-refcount.c |  4 ++--
>  block/qcow2.c          |  1 -
>  block/qcow2.h          |  1 -
>  block/vdi.c            | 11 ++++++-----
>  block/vvfat.c          | 10 ++++++----
>  include/block/block.h  |  4 ----
>  7 files changed, 14 insertions(+), 53 deletions(-)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--5uwl9wD1oXuwOiUlMpw2HiANXgstrxY0B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzHVI4ACgkQp6FrSiUn
Q2oAbQf+Ifmt7tpHibthsi2s8c2UNtq++QEXo0WF2TtWgKSYOAzLxOXlyy9NXiPQ
Z1C8nJPs3pXmiMolIM7dTiW54PFohZiVR91ZV3AymUlKeuCytos7+orgOm/G0S+9
deneW6j9stAJPp6voKuXi0r6O8rWszyJDQI8sx4JgmgjfQGAvnTnnxNMkNojhR2v
rVxEl1z3oxtNs2FWsnsw7MqFBHSvWTsdVtSsje9d/lystjuw6V7b7HcgmQAZ0QmQ
oU75C9UBOKeHjtfaXUjvAsT1t71rEp7q2ZUVcVTDxrPyo4dsJW9scDzr9hYWQaIz
AZrtoeB8/RR7BIb0ehW7EgRUyC/PXQ==
=CWgE
-----END PGP SIGNATURE-----

--5uwl9wD1oXuwOiUlMpw2HiANXgstrxY0B--
