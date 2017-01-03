Received: from eggs.gnu.org ([2001:4830:134:3::10]:49675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOV2Q-0001no-VR
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 14:46:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOV2N-0007e1-UP
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 14:46:27 -0500
References: <20170103182801.9638-1-berrange@redhat.com>
	<20170103182801.9638-2-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9acc22d2-0dbc-df6e-89dd-45d1ac54b5f3@redhat.com>
Date: Tue, 3 Jan 2017 13:46:15 -0600
MIME-Version: 1.0
In-Reply-To: <20170103182801.9638-2-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="67eGvUG74dB7jPMTcDdcwLKWEtRlGN9un"
Subject: Re: [Qemu-devel] [PATCH v1 01/15] block: expose crypto option names
 / defs to other drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--67eGvUG74dB7jPMTcDdcwLKWEtRlGN9un
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <9acc22d2-0dbc-df6e-89dd-45d1ac54b5f3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 01/15] block: expose crypto option names /
 defs to other drivers
References: <20170103182801.9638-1-berrange@redhat.com>
 <20170103182801.9638-2-berrange@redhat.com>
In-Reply-To: <20170103182801.9638-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/03/2017 12:27 PM, Daniel P. Berrange wrote:
> The block/crypto.c defines a set of QemuOpts that provide
> parameters for encryption. This will also be needed by
> the qcow/qcow2 integration, so expose the relevant pieces
> in a new block/crypto.h header.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/crypto.c | 61 +++++++--------------------------------
>  block/crypto.h | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  2 files changed, 102 insertions(+), 50 deletions(-)
>  create mode 100644 block/crypto.h
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--67eGvUG74dB7jPMTcDdcwLKWEtRlGN9un
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYa/+HAAoJEKeha0olJ0Nq5e0H/RSoYVk4me3VqIbNUge0IYDr
fxgEYmzFGU0pSWZSandc2unQQj6ZU5ZUFY+qTOzarj0HpKjA1d7dDqMaDObwvyl1
tepv1KyZ/Lzjx6Guh4RsHCZgj8oSxUzojpoK/vCjP5pR5jogZI4Z55hjE9m6w8Rw
6arXv2vg0Y4KoVSNh+UFYToTTHK7/QAlFpSOs/dVP/+8aGeKRcx8Jg5wySSpcPfi
XaQKs4e82TL5TYu9071CC99lGO6Xullil0pqFK2vneP4GF6Bo9L3i6xTFexWAO/6
P/l0fGwuH0uqK9eo1ulLWHaj6XJ7iRe4Amp1UB2Kj5AphrPYYRSB13YQv0Nuyo8=
=fop3
-----END PGP SIGNATURE-----

--67eGvUG74dB7jPMTcDdcwLKWEtRlGN9un--
