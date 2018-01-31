Received: from eggs.gnu.org ([2001:4830:134:3::10]:50694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egyEV-0002Zs-6z
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:39:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egyEU-0005Ha-FR
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:39:47 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<245ecc9693e29fa6398d20ac5a90ef8dcdc23cda.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <54ee204a-714e-5403-c446-e65fc08da96d@redhat.com>
Date: Wed, 31 Jan 2018 20:39:37 +0100
MIME-Version: 1.0
In-Reply-To: <245ecc9693e29fa6398d20ac5a90ef8dcdc23cda.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VLpoziSMqzSCXaj4obbAftso1EnMGrlvA"
Subject: Re: [Qemu-devel] [PATCH v3 11/39] qcow2: Remove BDS parameter from
 qcow2_cache_is_table_offset()
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
--VLpoziSMqzSCXaj4obbAftso1EnMGrlvA
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <54ee204a-714e-5403-c446-e65fc08da96d@redhat.com>
Subject: Re: [PATCH v3 11/39] qcow2: Remove BDS parameter from
 qcow2_cache_is_table_offset()
References: <cover.1516978645.git.berto@igalia.com>
 <245ecc9693e29fa6398d20ac5a90ef8dcdc23cda.1516978645.git.berto@igalia.com>
In-Reply-To: <245ecc9693e29fa6398d20ac5a90ef8dcdc23cda.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 15:59, Alberto Garcia wrote:
> This function was only using the BlockDriverState parameter to pass it
> to qcow2_cache_get_table_addr(). This is no longer necessary so this
> parameter can be removed.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2-cache.c    | 3 +--
>  block/qcow2-refcount.c | 6 +++---
>  block/qcow2.h          | 3 +--
>  3 files changed, 5 insertions(+), 7 deletions(-)

I was hoping you'd smuggle something funny into one of the commit
messages of these patches to test whether we'd actually read them. :(

Reviewed-by: Max Reitz <mreitz@redhat.com>


--VLpoziSMqzSCXaj4obbAftso1EnMGrlvA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpyG3kSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A9hcH/i60j1kkrUTSbO29CmTNup3tZwDsdOLR
0DQ/B1Hq/qUR3dx7hyDEORvR2MiF4TbJeFs0O9LC9UD5O9WsVBAGV+UnAEn1h4pM
u8JvEphabw5Eht1Hn6Mn1Gc3elO3cscBt8Mnig7b6XxJWHRIb7HlDvNzwXiV8WUR
bCe2lEadJ6EvNMd2GQkfUNpT3ibUkN03ZNPopWjZm4d4dpuURtF7xDS7+78pjaLY
HMKtQ8L/UWr1cNZlwX5hlJeQ0zn86XrOW0CAW+aNQBtqR1ons02rU9W2cg1kQxV6
eM2irTNCtrRKXQghxjRoIvXjrL1O8JpTKSn7ICiQJcvKS0V6jtVIpm4=
=hUgE
-----END PGP SIGNATURE-----

--VLpoziSMqzSCXaj4obbAftso1EnMGrlvA--
