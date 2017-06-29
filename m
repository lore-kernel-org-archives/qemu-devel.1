Received: from eggs.gnu.org ([2001:4830:134:3::10]:33001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQcHA-0005Bg-1t
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:26:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQcH5-0008DE-E6
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:26:40 -0400
References: <20170629162046.4135-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <875e1a54-863c-a632-9cad-9880416d8693@redhat.com>
Date: Thu, 29 Jun 2017 11:26:22 -0500
MIME-Version: 1.0
In-Reply-To: <20170629162046.4135-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2DRE7LqvELXkQNGNLFGwqbCsNDB2rnjkr"
Subject: Re: [Qemu-devel] [PATCH] backends: remove empty trace-events file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2DRE7LqvELXkQNGNLFGwqbCsNDB2rnjkr
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <875e1a54-863c-a632-9cad-9880416d8693@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] backends: remove empty trace-events file
References: <20170629162046.4135-1-berrange@redhat.com>
In-Reply-To: <20170629162046.4135-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/29/2017 11:20 AM, Daniel P. Berrange wrote:
> The content of the backends/trace-events file was entirely
> removed in
>=20
>   commit 6b10e573d15ef82dbc5c5b3726028e6642e134f6
>   Author: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>   Date:   Mon May 29 12:39:42 2017 +0400
>=20
>     char: move char devices to chardev/
>=20
> Leaving the empty file around, causes tracetool to generate
> an empty .dtrace file which makes the dtrace compiler throw
> a syntax error.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  Makefile.objs         | 1 -
>  backends/trace-events | 0
>  2 files changed, 1 deletion(-)
>  delete mode 100644 backends/trace-events

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2DRE7LqvELXkQNGNLFGwqbCsNDB2rnjkr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZVSouAAoJEKeha0olJ0NqEWQIAIKw6ZO28mq+lpH03u2U+iox
3z6tqq9y1ud78oHXwPZIK5qp85RKTMSXpHn6MX8zlmCS7ghKL8QqqSu9uvodQB0x
1frUeh81ySx7QNxxzNfUXlcKI3Eq+g8jQkdj/tqd+uxNTrIxApXO1cf6J+cuy2VR
xLC9Blqqgm6KGUGJr4cyu8dRcw4sLisGSYxBdz+qOJNTOSuN3KRDpA3JvHiHDwC1
g8KdJCAcIjypIYU9mJUn5HSJ//jPdG9PUmq8GS7bCPiAzeqQ73NHGD65bSBas1uA
NSDfRA9vrMYvufD2R8m/yGT3FDSodH3QxY51oONiYhaZ2VPkV8hRI4j6OIQG5H4=
=UYio
-----END PGP SIGNATURE-----

--2DRE7LqvELXkQNGNLFGwqbCsNDB2rnjkr--
