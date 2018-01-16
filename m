Received: from eggs.gnu.org ([2001:4830:134:3::10]:37394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebZK7-0004iC-Sr
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 17:03:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebZK5-0001tJ-59
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 17:03:13 -0500
References: <cover.1513342045.git.berto@igalia.com>
	<7f36799a9e28207fc4b78ea96447b5668147b7f9.1513342045.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <70425722-79e9-a867-d4ec-aa1d6c51d99a@redhat.com>
Date: Tue, 16 Jan 2018 16:03:00 -0600
MIME-Version: 1.0
In-Reply-To: <7f36799a9e28207fc4b78ea96447b5668147b7f9.1513342045.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wfqj4mIxwqgtIZLQhFe4m0kZ2uNNkr3G9"
Subject: Re: [Qemu-devel] [PATCH v2 12/32] qcow2: Add offset_to_l1_index()
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
--wfqj4mIxwqgtIZLQhFe4m0kZ2uNNkr3G9
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <70425722-79e9-a867-d4ec-aa1d6c51d99a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 12/32] qcow2: Add offset_to_l1_index()
References: <cover.1513342045.git.berto@igalia.com>
 <7f36799a9e28207fc4b78ea96447b5668147b7f9.1513342045.git.berto@igalia.com>
In-Reply-To: <7f36799a9e28207fc4b78ea96447b5668147b7f9.1513342045.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 06:53 AM, Alberto Garcia wrote:
> Similar to offset_to_l2_index(), this function returns the index in
> the L1 table for a given guest offset. This is only used in a couple
> of places and it's not a particularly complex calculation, but it
> makes the code a bit more readable.
>=20
> Although in the qcow2_get_cluster_offset() case the old code was
> taking advantage of the l1_bits variable, we're going to get rid of
> the other uses of l1_bits in a later patch anyway, so it doesn't make
> sense to keep it just for this.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 4 ++--
>  block/qcow2.h         | 5 +++++
>  2 files changed, 7 insertions(+), 2 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wfqj4mIxwqgtIZLQhFe4m0kZ2uNNkr3G9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpedpQACgkQp6FrSiUn
Q2qyvggApxL6G5x1Wlwrzs+gqDouNWjJt6WHpMtLOKt7786rCxhEJZYCvlOVZgoA
kBse4RjX2LrIMICX4Bns90d9u7qWp//vuqtua966ykXOJUiLqYj4RfDxRFum8eh8
mVTjYe5M7aSj2YgBbMlEjP5I1DAi3fWKjFelCFK6PswdGAiFuxAktvblv1TH2ZIw
3fbOjw07rPGP/TOF/8iE3gNC+VVOdXi9DlbpdCs30HvIWBQnhnTyREr5Iamo29QR
S3ylXgxtaoFKFqbu2/xUT0lAjPOmxoa/bGefr8d6acqdVqxHheWJdttuQXLhN0gt
N5B9fj9MKgS/MaLIrjFR2GNHv1aaog==
=UrXr
-----END PGP SIGNATURE-----

--wfqj4mIxwqgtIZLQhFe4m0kZ2uNNkr3G9--
