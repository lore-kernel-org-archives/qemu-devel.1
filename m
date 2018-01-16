Received: from eggs.gnu.org ([2001:4830:134:3::10]:50645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebaBi-0008EK-SI
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 17:58:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebaBi-0007mY-2K
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 17:58:38 -0500
References: <cover.1513342045.git.berto@igalia.com>
	<6884a0a3917beeb854eede711b0d88acb0960ff5.1513342045.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dbdfc2b8-c033-cfb5-f0bc-5c4340063657@redhat.com>
Date: Tue, 16 Jan 2018 16:58:27 -0600
MIME-Version: 1.0
In-Reply-To: <6884a0a3917beeb854eede711b0d88acb0960ff5.1513342045.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PRlxQdBiXQpE4zidbGVA2fX0J0KvZcHXl"
Subject: Re: [Qemu-devel] [PATCH v2 23/32] qcow2: Update zero_single_l2() to
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
--PRlxQdBiXQpE4zidbGVA2fX0J0KvZcHXl
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <dbdfc2b8-c033-cfb5-f0bc-5c4340063657@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 23/32] qcow2: Update zero_single_l2() to
 support L2 slices
References: <cover.1513342045.git.berto@igalia.com>
 <6884a0a3917beeb854eede711b0d88acb0960ff5.1513342045.git.berto@igalia.com>
In-Reply-To: <6884a0a3917beeb854eede711b0d88acb0960ff5.1513342045.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 06:53 AM, Alberto Garcia wrote:
> zero_single_l2() limits the number of clusters to be zeroed to the
> amount that fits inside an L2 table. Since we'll be loading L2 slices
> instead of full tables we need to update that limit.
>=20
> Apart from that, this function doesn't need any additional changes, so
> this patch simply updates the variable name from l2_table to l2_slice.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>=20
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--PRlxQdBiXQpE4zidbGVA2fX0J0KvZcHXl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpeg5MACgkQp6FrSiUn
Q2omSwgAqp0ViTd7DF926bAebppBu37DD7+l6AFhY+IR/epybrcPeDeL/xmynP1o
HJG92BujIoJpFg5TRdRKi/KGY4JEHXniJNMP7bmaEzG26Kjy0/aJ3D/CBNHM5LhS
hWMS/lFfETRmbkQmHmORyaPOq82ztsMfXLmsMzwktgIJ+zvmj9xncAyMmegn8tpP
8p0jMDP/iilW9mpB1JUESa5tnK2YeXOeGSLatkvPzBOnPoZSahwnSTwt5SxivHrw
jKKBmZJUuKR/FePlEjyUf61S/U9ld3SWgFT6CWcK5gPmwbGAFMyD99c+GMTUMagC
tQKoNA+569Lpqx7fEyg5JYd8sJ0Aog==
=E5Te
-----END PGP SIGNATURE-----

--PRlxQdBiXQpE4zidbGVA2fX0J0KvZcHXl--
