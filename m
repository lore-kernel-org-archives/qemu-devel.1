Received: from eggs.gnu.org ([2001:4830:134:3::10]:50068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eba8e-0006Di-Ra
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 17:55:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eba8d-0004rc-UC
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 17:55:28 -0500
References: <cover.1513342045.git.berto@igalia.com>
	<8f5a1687d5999f3eecb989dd25b57144cc850b28.1513342045.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c755ed9d-ed20-52eb-60b6-cf702b683a42@redhat.com>
Date: Tue, 16 Jan 2018 16:55:16 -0600
MIME-Version: 1.0
In-Reply-To: <8f5a1687d5999f3eecb989dd25b57144cc850b28.1513342045.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sAxT12jKhhlREHkW3yIIuYnAM5yGmczox"
Subject: Re: [Qemu-devel] [PATCH v2 22/32] qcow2: Update discard_single_l2()
 to support L2 slices
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
--sAxT12jKhhlREHkW3yIIuYnAM5yGmczox
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <c755ed9d-ed20-52eb-60b6-cf702b683a42@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 22/32] qcow2: Update discard_single_l2()
 to support L2 slices
References: <cover.1513342045.git.berto@igalia.com>
 <8f5a1687d5999f3eecb989dd25b57144cc850b28.1513342045.git.berto@igalia.com>
In-Reply-To: <8f5a1687d5999f3eecb989dd25b57144cc850b28.1513342045.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 06:53 AM, Alberto Garcia wrote:
> discard_single_l2() limits the number of clusters to be discarded to
> the amount that fits inside an L2 table. Since we'll be loading L2
> slices instead of full tables we need to update that limit.
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


--sAxT12jKhhlREHkW3yIIuYnAM5yGmczox
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpegtQACgkQp6FrSiUn
Q2ontwf+NlTZ9rbYwcZ9coCossB60QNa83JrD4m2TIY73UdK+ctL7B2GQ3L4X7Ih
cFdYN0GWShw3II3zD4zazfML1mHDiSkuhDJMzODxk67uRfgJq4GstisKD3cokCgT
8egfrx+lnyNSPSd6lxnESDPgrL++c1B6+1/eO9KETM5TRgiS0/vtIjEcCTcHQ+ar
L9wNS2a3+4+wlMLhbowp8xEhsnyVlDpYHdjnMHwa/jDDNA98RxLJHdS9Nr0Dq4ze
elUzd7RiawFOOp4s0a8TWQYMFj2JiX/T08dICB3IM4UJwAun7PdoKWHJFqZCyc28
XYxEJdYfbl71gTP8W6QBN23Cm6jGdg==
=xYZh
-----END PGP SIGNATURE-----

--sAxT12jKhhlREHkW3yIIuYnAM5yGmczox--
