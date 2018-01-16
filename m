Received: from eggs.gnu.org ([2001:4830:134:3::10]:48528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eba4f-00033p-G9
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 17:51:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eba4e-0002Ee-GS
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 17:51:21 -0500
References: <cover.1513342045.git.berto@igalia.com>
	<0cfc3621612922be4fb61894118ef982a61a23d7.1513342045.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7a1f7fce-7f30-d116-7afa-5d1529cd0cab@redhat.com>
Date: Tue, 16 Jan 2018 16:51:10 -0600
MIME-Version: 1.0
In-Reply-To: <0cfc3621612922be4fb61894118ef982a61a23d7.1513342045.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lPKWvwDTZ9vaQcxQqXXWG55E48R97sST2"
Subject: Re: [Qemu-devel] [PATCH v2 20/32] qcow2: Update handle_copied() to
 support L2 slices
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
--lPKWvwDTZ9vaQcxQqXXWG55E48R97sST2
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <7a1f7fce-7f30-d116-7afa-5d1529cd0cab@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 20/32] qcow2: Update handle_copied() to
 support L2 slices
References: <cover.1513342045.git.berto@igalia.com>
 <0cfc3621612922be4fb61894118ef982a61a23d7.1513342045.git.berto@igalia.com>
In-Reply-To: <0cfc3621612922be4fb61894118ef982a61a23d7.1513342045.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 06:53 AM, Alberto Garcia wrote:
> handle_copied() loads an L2 table and limits the number of checked
> clusters to the amount that fits inside that table. Since we'll be
> loading L2 slices instead of full tables we need to update that limit.
>=20
> Apart from that, this function doesn't need any additional changes, so
> this patch simply updates the variable name from l2_table to l2_slice.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lPKWvwDTZ9vaQcxQqXXWG55E48R97sST2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpegd4ACgkQp6FrSiUn
Q2pHrQgAm2uKsHTooU87LwY734T9bEdxueHYNE6p5XrhGHYhSTh1hMJkY5Wkk225
PgFx+YgWXcoWYhMyPo1ksKw1Koh9Fp8xldc8izbMbK24U3CuhTe6rJRF6sX5BDnI
K/FU54FIGHWgRqAHaLvuxeOaETGg2o0tF0szAwSEUzQ7awCsPcgmKijeVP5TFO9A
DRqSRYly2cPxAz23UqcM64QgcU4MPpdSBsrtntvcIO9hZoFE0UWSBgK/1Rx92+DY
OFuTo4S5L5IxSDQcg7yaGfrFwszRIWjhSvBCcg9KPgKfJ/qCic4F+4f+Vxfnvgl0
Put5S/a3xduvE00t8+XVLC9Uhddv5g==
=KD4B
-----END PGP SIGNATURE-----

--lPKWvwDTZ9vaQcxQqXXWG55E48R97sST2--
