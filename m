Received: from eggs.gnu.org ([2001:4830:134:3::10]:56435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebYol-0006w9-Nm
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 16:30:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebYok-00057Q-Nk
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 16:30:51 -0500
References: <cover.1513342045.git.berto@igalia.com>
	<5acef77483178b4ab6b63dfaf63f4737fc376a20.1513342045.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4590388c-d66c-6cab-5790-26aa78b78312@redhat.com>
Date: Tue, 16 Jan 2018 15:30:27 -0600
MIME-Version: 1.0
In-Reply-To: <5acef77483178b4ab6b63dfaf63f4737fc376a20.1513342045.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Hk6ebTobB4kKwPqNhze86A0SEllpNddXq"
Subject: Re: [Qemu-devel] [PATCH v2 04/32] qcow2: Remove BDS parameter from
 qcow2_cache_get_table_idx()
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
--Hk6ebTobB4kKwPqNhze86A0SEllpNddXq
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <4590388c-d66c-6cab-5790-26aa78b78312@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 04/32] qcow2: Remove BDS parameter from
 qcow2_cache_get_table_idx()
References: <cover.1513342045.git.berto@igalia.com>
 <5acef77483178b4ab6b63dfaf63f4737fc376a20.1513342045.git.berto@igalia.com>
In-Reply-To: <5acef77483178b4ab6b63dfaf63f4737fc376a20.1513342045.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 06:53 AM, Alberto Garcia wrote:
> This function was only using the BlockDriverState parameter to get the
> cache table size (since it was equal to the cluster size). This is no
> longer necessary so this parameter can be removed.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cache.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Hk6ebTobB4kKwPqNhze86A0SEllpNddXq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpebvMACgkQp6FrSiUn
Q2o8hwgAjImy6izqUF7F/TB2/KcTZ4LExYm7o5hhqOl3NGA/AS9AeEst366Rgvqb
L9u8+7FPBsNEPwLw3/iWI9dTUL143HSg6YJ9mExAKtXHg+/TPsBMa+PFU/CRm0Yu
02pKeXvRalGIixxCbdIwHkclZ5XG9ATqCTsHvrjzjvSZvtTwcui8b9r6WL0ZW8qf
f3yjGzi5cXm3pWZGUDRRs9Fl2sK7svjzXfefIVQd5k1A1WGpzApnU4tMSecOklGd
BYvR4OFB0ERADN2gCMEyihZBzsBAeM/dkwWJQc83K5CSnyDr5DGtlng6HfqlrdeE
PhZN3VRvu+7jtORR1Us6VhQthlemFQ==
=qmwR
-----END PGP SIGNATURE-----

--Hk6ebTobB4kKwPqNhze86A0SEllpNddXq--
