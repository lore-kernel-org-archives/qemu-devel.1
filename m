Received: from eggs.gnu.org ([2001:4830:134:3::10]:42044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddhxh-0005al-6j
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 15:08:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddhxg-0004gI-6z
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 15:08:41 -0400
References: <20170804151013.13057-1-den@openvz.org>
	<20170804151013.13057-2-den@openvz.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ea713f4c-3f71-7d1e-6d65-edbc83c5c5b2@redhat.com>
Date: Fri, 4 Aug 2017 14:08:27 -0500
MIME-Version: 1.0
In-Reply-To: <20170804151013.13057-2-den@openvz.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0aVWMd0gxnTwB1sbb64cuKtjxUHdn3l3r"
Subject: Re: [Qemu-devel] [PATCH 1/3] block: respect error code from
 bdrv_getlength in handle_aiocb_write_zeroes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0aVWMd0gxnTwB1sbb64cuKtjxUHdn3l3r
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <ea713f4c-3f71-7d1e-6d65-edbc83c5c5b2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] block: respect error code from
 bdrv_getlength in handle_aiocb_write_zeroes
References: <20170804151013.13057-1-den@openvz.org>
 <20170804151013.13057-2-den@openvz.org>
In-Reply-To: <20170804151013.13057-2-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/04/2017 10:10 AM, Denis V. Lunev wrote:
> Original idea beyond the code in question was the following: we have fa=
iled
> to write zeroes with fallocate(FALLOC_FL_ZERO_RANGE) as the simplest
> approach and via fallocate(FALLOC_FL_PUNCH_HOLE)/fallocate(0). We have =
the
> only chance now: if the request comes beyond end of the file. Thus we
> should calculate file length and respect the error code from that op.
>=20
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/file-posix.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--0aVWMd0gxnTwB1sbb64cuKtjxUHdn3l3r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmExiwACgkQp6FrSiUn
Q2rFCQgAlm9X4Zz46bQcA1gHbAoNQcSUor80bpQoodNbm3r2xw1soiyg5pIBqkxN
DXtDaJq866CjtlO8B2f70gvFz+xlAAEZvm7H9h1w3FUGzydTLL1GSHAFJC4dmd3j
OtwKTU3BnsuI3JThMSw6xSCejIN8SwHFqIlpbdSeWSt+hyjQDfiE6F7ZjGWOzp/C
t0xD5718jTel8xVYLAim6fj/YA4plpkpHeEXG1rB7bXTcHWAfIIwXvZloZWsOg6B
KZVrQk0JWHrU2xY1hxxqUu4i/1EcSCAYFnaI98QYzMQ1Nxcf4jNJo9sG6iXDeDXF
o69zsz0IN9Mdci4yczcyQiIDvYToAQ==
=Yc8P
-----END PGP SIGNATURE-----

--0aVWMd0gxnTwB1sbb64cuKtjxUHdn3l3r--
