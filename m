Received: from eggs.gnu.org ([2001:4830:134:3::10]:34901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dxCcU-0000lf-Ui
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:43:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dxCcT-0002rY-VH
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:43:22 -0400
References: <20170927125340.12360-1-berrange@redhat.com>
	<20170927125340.12360-5-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5dec9dab-4e79-8194-42e8-2917dd4e0e8d@redhat.com>
Date: Wed, 27 Sep 2017 08:43:11 -0500
MIME-Version: 1.0
In-Reply-To: <20170927125340.12360-5-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fbmrEwsgXsX3MR5QFP4w0u3M3AaUEFRCW"
Subject: Re: [Qemu-devel] [PATCH v4 4/6] block: convert crypto driver to
 bdrv_co_preadv|pwritev
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
--fbmrEwsgXsX3MR5QFP4w0u3M3AaUEFRCW
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <5dec9dab-4e79-8194-42e8-2917dd4e0e8d@redhat.com>
Subject: Re: [PATCH v4 4/6] block: convert crypto driver to
 bdrv_co_preadv|pwritev
References: <20170927125340.12360-1-berrange@redhat.com>
 <20170927125340.12360-5-berrange@redhat.com>
In-Reply-To: <20170927125340.12360-5-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/27/2017 07:53 AM, Daniel P. Berrange wrote:
> Make the crypto driver implement the bdrv_co_preadv|pwritev
> callbacks, and also use bdrv_co_preadv|pwritev for I/O
> with the protocol driver beneath. This replaces sector based
> I/O with byte based I/O, and allows us to stop assuming the
> physical sector size matches the encryption sector size.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/crypto.c | 106 +++++++++++++++++++++++++++++--------------------=
--------
>  1 file changed, 54 insertions(+), 52 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--fbmrEwsgXsX3MR5QFP4w0u3M3AaUEFRCW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnLqu8ACgkQp6FrSiUn
Q2qoCAf+OrucHxsg+uHfgl4LZgiUHd0lCEx3RGzt48iImpUihPFbX1zCJ8eUyCII
+v3U0zy23rU/vcNtV+wWioBOCOaBO+hbB33dQ5tFWflywduDL2T2XJiAGKGghp/G
/BAa8Kn5LMDAyNrRCOxZ5DObChwRSntLTINhvxOYv/gk/U1nnz0mo7JRf7mDgo45
/53oT2B4b5bYL7rfcsKshHYWWSH3wyBrEZxJYfDOYDdofKj8ePASrWGtvm/4/kUO
iTGEEKaK/e1BjW9rnPZpCGGgpNDwgV6yCfOatS4UlbZvJF/a65a0lJWR2hzmDz/T
DIY/12Au5XA/9VQ1CGr2W51kjuXgIw==
=N0j+
-----END PGP SIGNATURE-----

--fbmrEwsgXsX3MR5QFP4w0u3M3AaUEFRCW--
