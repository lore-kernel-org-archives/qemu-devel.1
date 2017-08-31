Received: from eggs.gnu.org ([2001:4830:134:3::10]:53837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnQra-0004gW-8z
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:54:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnQrZ-00030i-F7
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:54:34 -0400
References: <20170831110518.10741-1-berrange@redhat.com>
	<20170831110518.10741-3-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dc675dcb-63f6-1cd5-5267-bd9f6743fdad@redhat.com>
Date: Thu, 31 Aug 2017 09:54:23 -0500
MIME-Version: 1.0
In-Reply-To: <20170831110518.10741-3-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QJKhomTkwvsrikxcxDO8KXulhi9LiJb92"
Subject: Re: [Qemu-devel] [PATCH v2 2/4] block: use BDRV_SECTOR_SIZE in
 crypto driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QJKhomTkwvsrikxcxDO8KXulhi9LiJb92
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <dc675dcb-63f6-1cd5-5267-bd9f6743fdad@redhat.com>
Subject: Re: [PATCH v2 2/4] block: use BDRV_SECTOR_SIZE in crypto driver
References: <20170831110518.10741-1-berrange@redhat.com>
 <20170831110518.10741-3-berrange@redhat.com>
In-Reply-To: <20170831110518.10741-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/31/2017 06:05 AM, Daniel P. Berrange wrote:
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/crypto.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>=20
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--QJKhomTkwvsrikxcxDO8KXulhi9LiJb92
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmoIx8ACgkQp6FrSiUn
Q2qCkQgAmtFD+iiJGvl6rMW6kzSNCw5eO8yarcMwaB3i7i+AjMISl16usvuUBZG8
rAbudX8iUJGeGqj9ri2dO38lNgHds1l4sZTEOyqm+e2WDKnRrWLex1t9dKNDvF1s
5+5bUvMPtghJouin1LHh6CUg/Qa+gOckYKzzSHOVYF5dM2JNTDTmqVyXzzN4kJJf
KtAj365rl5cNgPruajjGtZMsVHdEXBU4ifH2XUuJQ3zK6VfLGwEMMEz4RwWOI+zV
tvzCZ8yJSJc7T370Azu4NoUdjFysMBCXQe/BSYa9IEA8tFtmVpvzQIctpGZ20R/F
O+zr8HGJc1GLbeohI1CtbN311JSjLw==
=kkzq
-----END PGP SIGNATURE-----

--QJKhomTkwvsrikxcxDO8KXulhi9LiJb92--
