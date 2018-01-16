Received: from eggs.gnu.org ([2001:4830:134:3::10]:49177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eba6J-0004Gk-JJ
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 17:53:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eba6I-00030t-Lw
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 17:53:03 -0500
References: <cover.1513342045.git.berto@igalia.com>
	<976f6bac137cdbdf45e5aafe140aad5833db087f.1513342045.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bcf28518-2c74-ae76-e13c-db3d561bc473@redhat.com>
Date: Tue, 16 Jan 2018 16:52:54 -0600
MIME-Version: 1.0
In-Reply-To: <976f6bac137cdbdf45e5aafe140aad5833db087f.1513342045.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8xSeqofWGAtAY36Bj1iJCcDAvvZ93meO5"
Subject: Re: [Qemu-devel] [PATCH v2 21/32] qcow2: Update handle_alloc() to
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
--8xSeqofWGAtAY36Bj1iJCcDAvvZ93meO5
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <bcf28518-2c74-ae76-e13c-db3d561bc473@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 21/32] qcow2: Update handle_alloc() to
 support L2 slices
References: <cover.1513342045.git.berto@igalia.com>
 <976f6bac137cdbdf45e5aafe140aad5833db087f.1513342045.git.berto@igalia.com>
In-Reply-To: <976f6bac137cdbdf45e5aafe140aad5833db087f.1513342045.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 06:53 AM, Alberto Garcia wrote:
> handle_alloc() loads an L2 table and limits the number of checked
> clusters to the amount that fits inside that table. Since we'll be
> loading L2 slices instead of full tables we need to update that limit.
>=20
> Apart from that, this function doesn't need any additional changes, so
> this patch simply updates the variable name from l2_table to l2_slice.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>=20
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--8xSeqofWGAtAY36Bj1iJCcDAvvZ93meO5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpegkYACgkQp6FrSiUn
Q2q5iQgAogWNb6FLmgKwClgM3wAaMH2mrXbALd0M7voY9qpHQvB2JunePy8/AKuK
gEiX4tn6AzCStwjoGT4T/Je5cXLh1LXHZxfL5TNt5TxT+V523Elo35x53kb/g7SJ
8qFK+WV7c9cGmMLghCBjd8M3m8gDhA3IVGn0mBQCb5UqEL/5/Z++lTiOSRGLPeNN
z3Z9YhzlqKft9KhzErDAx5iqw80qHgM/hLmXOMMp4trNNOgA8DBPdZH5L+D7zTfm
C8sKnpFTFu60PuGrVgoDWNSl5t4MRzDJ0j+EpVywO5U9rfLU+9jOgIzeu+HtOTYZ
Mt/6FWEutbOk5APyCWk9ruZy0+DP1Q==
=lmqZ
-----END PGP SIGNATURE-----

--8xSeqofWGAtAY36Bj1iJCcDAvvZ93meO5--
