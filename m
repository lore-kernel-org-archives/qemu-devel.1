Received: from eggs.gnu.org ([2001:4830:134:3::10]:51558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebaEA-00011u-PN
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 18:01:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebaE9-0002No-Pm
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 18:01:10 -0500
References: <cover.1513342045.git.berto@igalia.com>
	<192f0a4a1888e7e18cb7cec9fdbeadad5417b4ef.1513342045.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fab2e9e4-50a0-1f21-9d06-969a90d0644a@redhat.com>
Date: Tue, 16 Jan 2018 17:00:59 -0600
MIME-Version: 1.0
In-Reply-To: <192f0a4a1888e7e18cb7cec9fdbeadad5417b4ef.1513342045.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TNkHqIIHfU2TsW18Heo5mnfsE4CkpPrWT"
Subject: Re: [Qemu-devel] [PATCH v2 24/32] qcow2: Update
 qcow2_update_snapshot_refcount() to support L2 slices
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
--TNkHqIIHfU2TsW18Heo5mnfsE4CkpPrWT
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <fab2e9e4-50a0-1f21-9d06-969a90d0644a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 24/32] qcow2: Update
 qcow2_update_snapshot_refcount() to support L2 slices
References: <cover.1513342045.git.berto@igalia.com>
 <192f0a4a1888e7e18cb7cec9fdbeadad5417b4ef.1513342045.git.berto@igalia.com>
In-Reply-To: <192f0a4a1888e7e18cb7cec9fdbeadad5417b4ef.1513342045.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 06:53 AM, Alberto Garcia wrote:
> qcow2_update_snapshot_refcount() increases the refcount of all
> clusters of a given snapshot. In order to do that it needs to load all
> its L2 tables and iterate over their entries. Since we'll be loading
> L2 slices instead of full tables we need to add an extra loop that
> iterates over all slices of each L2 table.
>=20
> This function doesn't need any additional changes so apart from that
> this patch simply updates the variable name from l2_table to l2_slice.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-refcount.c | 150 ++++++++++++++++++++++++++---------------=
--------
>  1 file changed, 80 insertions(+), 70 deletions(-)
>=20

> -    l2_table =3D NULL;
> +    l2_slice =3D NULL;
>      l1_table =3D NULL;
>      l1_size2 =3D l1_size * sizeof(uint64_t);
> =20
> +    slice_size =3D s->l2_slice_size * sizeof(uint64_t);

Again, better naming on s->l2_slice_size in an earlier patch may make
this more readable, at a cost of slight rebase churn.

The diff looks hideous, but that's thanks to indentation changes.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--TNkHqIIHfU2TsW18Heo5mnfsE4CkpPrWT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpehCsACgkQp6FrSiUn
Q2og1wf/d8i6EhsCol2nfX8ZXtLb7MTJaq0ufbYr08tF7ZImOsz0QDbh9/Xn2hjc
+njfwWdMb1I1q7eO+WWxJ+rDSH+nqGpOQEkRgw+ZxzG9GFFPmVZRllYwdrSIemJT
etk9TAisSc7TcsoVkYCwAbiHOOVcdqpCgC1ce/5bac7io6TmEGLxeiCt0iKhVkO8
3jXQbyVKj2Z6B3rOiZuo4gnLj89RM5Z9Kj4f17Ge7y4DA0UMxTiEvLOnk/hbi+DR
cOqm6AonUedcvKZDJETEQEacu6V1nKt9XyigcF7hsmmEIBA0MN2lCJbHvQf+s4j1
TOCVzPQLH6PBSVMEdIhLZ2pJPrijvA==
=zAWT
-----END PGP SIGNATURE-----

--TNkHqIIHfU2TsW18Heo5mnfsE4CkpPrWT--
