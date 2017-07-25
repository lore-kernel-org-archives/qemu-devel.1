Received: from eggs.gnu.org ([2001:4830:134:3::10]:50826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da3bU-0000c6-BU
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:26:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da3bT-00049V-Ee
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:26:40 -0400
References: <20170725155644.20214-1-mreitz@redhat.com>
	<20170725155644.20214-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <01a63f5d-d46f-519e-fd9c-e33b566afa65@redhat.com>
Date: Tue, 25 Jul 2017 12:26:31 -0500
MIME-Version: 1.0
In-Reply-To: <20170725155644.20214-2-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ACKP6dVVI6X7L3DAbWnmqP5opkTEFRuDg"
Subject: Re: [Qemu-devel] [PATCH 1/2] iotests: Fix test 156
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ACKP6dVVI6X7L3DAbWnmqP5opkTEFRuDg
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <01a63f5d-d46f-519e-fd9c-e33b566afa65@redhat.com>
Subject: Re: [PATCH 1/2] iotests: Fix test 156
References: <20170725155644.20214-1-mreitz@redhat.com>
 <20170725155644.20214-2-mreitz@redhat.com>
In-Reply-To: <20170725155644.20214-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/25/2017 10:56 AM, Max Reitz wrote:
> On one hand, the _make_test_img invocation for creating the target imag=
e
> was missing a -u because its backing file is not supposed to exist at
> that point.
>=20
> On the other hand, nobody noticed probably because the backing file is
> created later on and _cleanup failed to remove it: The quotation marks
> were misplaced so bash tried to deleted a file literally called

s/deleted/delete/

> "$TEST_IMG{,.target}..." instead of resolving the globs.  Thus, the

Technically brace expansion, not globs.

> files stayed around after the first run and qemu-img create did not
> complain about a missing backing file on any run but the first.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/156 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ACKP6dVVI6X7L3DAbWnmqP5opkTEFRuDg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll3f0cACgkQp6FrSiUn
Q2oRlgf+L2CPMi9dUVx5QhXZCTjX1EspsD1y0ehJxUwEj2yyxB/MXSO2lbq6f84p
OSiuUhCmgvK4c+QQNSj+HKRz4k3kRsL2Ck93MmNdDDWLrMgRU/7i7sGbpTKmxNdf
AFwhcFJS56KlnRB3OkAnIf2bHoDVStaYjw8vu8zsoaTPeOvmsPJkgvS2DzYc8VH5
PTxeV73IPWHhKMxqMEpDxYrnsZovZKNTwG5Fo0uvWj1STCEiOTskKVddXwedaiKj
AAf/+oOTFzrkVUfLQrfTof886R5AzI9iNVFv12QPiLHEZcTpyiR+upf0Zui6x3Bd
Iz6JU7UMg5KbCZej2oQK3Q6i3mnW9Q==
=KpfH
-----END PGP SIGNATURE-----

--ACKP6dVVI6X7L3DAbWnmqP5opkTEFRuDg--
