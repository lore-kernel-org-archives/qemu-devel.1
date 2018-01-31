Received: from eggs.gnu.org ([2001:4830:134:3::10]:47031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egy1u-0002Fs-Bj
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:26:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egy1t-0004pM-Hu
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:26:46 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<f0af2748a7ceec3981dd42134667d254853b8c83.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d6fb50cc-8067-fa6c-90a9-86c168b8da10@redhat.com>
Date: Wed, 31 Jan 2018 20:26:37 +0100
MIME-Version: 1.0
In-Reply-To: <f0af2748a7ceec3981dd42134667d254853b8c83.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="YPuYgmJCsIjPO3MflxV590WFeANuOkazZ"
Subject: Re: [Qemu-devel] [PATCH v3 03/39] qcow2: Remove BDS parameter from
 qcow2_cache_get_table_addr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YPuYgmJCsIjPO3MflxV590WFeANuOkazZ
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <d6fb50cc-8067-fa6c-90a9-86c168b8da10@redhat.com>
Subject: Re: [PATCH v3 03/39] qcow2: Remove BDS parameter from
 qcow2_cache_get_table_addr()
References: <cover.1516978645.git.berto@igalia.com>
 <f0af2748a7ceec3981dd42134667d254853b8c83.1516978645.git.berto@igalia.com>
In-Reply-To: <f0af2748a7ceec3981dd42134667d254853b8c83.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 15:59, Alberto Garcia wrote:
> This function was only using the BlockDriverState parameter to get the
> cache table size (since it was equal to the cluster size). This is no
> longer necessary so this parameter can be removed.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2-cache.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--YPuYgmJCsIjPO3MflxV590WFeANuOkazZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpyGG0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ALakIAKK65TIeRwcurOU6B4AjvQix/4NofQG2
cKIlWXmBQTvLWyOLPPSqaCxU/ov3iMIS/VnE+4eY60qzZwg7OUxK+5DHrRQpNk4c
yL2yZ4vedWr5SgB6NoxKCq3GE8oeb72ShJkm22BE3h3nxXh1K0ghWSm/9lTwkEBW
4fKB7Bt0ygH0erO1jugtlArHyw+7+5RHpXb084EohLvJtRWmTbQdiHU4zwdwKpVg
6btXVqYT+bOrb73fv8N/MeMuIL1mp4A1x6cvWefzQIZEwy5FsJyIowUAYNxz3ez9
Q2q6xG+9RdzttCTZPNTnpufjngu2PwckxHYm9GY42r/YyxyWxw+IuLM=
=gyJK
-----END PGP SIGNATURE-----

--YPuYgmJCsIjPO3MflxV590WFeANuOkazZ--
