Received: from eggs.gnu.org ([2001:4830:134:3::10]:47582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egv9e-0002rH-W8
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:22:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egv9c-0002YV-AU
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:22:34 -0500
References: <20180120154412.9990-1-mreitz@redhat.com>
	<20180120154412.9990-7-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6d72625c-f41c-e9eb-a4ac-e12569469a35@redhat.com>
Date: Wed, 31 Jan 2018 10:22:17 -0600
MIME-Version: 1.0
In-Reply-To: <20180120154412.9990-7-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="E78nHwJJPnq5d1OkihiDAepYAnEs56lu5"
Subject: Re: [Qemu-devel] [PATCH v2 6/6] block: Deprecate "backing": ""
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E78nHwJJPnq5d1OkihiDAepYAnEs56lu5
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <6d72625c-f41c-e9eb-a4ac-e12569469a35@redhat.com>
Subject: Re: [PATCH v2 6/6] block: Deprecate "backing": ""
References: <20180120154412.9990-1-mreitz@redhat.com>
 <20180120154412.9990-7-mreitz@redhat.com>
In-Reply-To: <20180120154412.9990-7-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/20/2018 09:44 AM, Max Reitz wrote:
> We have a clear replacement, so let's deprecate it.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  qapi/block-core.json | 4 ++--
>  block.c              | 4 ++++
>  qemu-doc.texi        | 7 +++++++
>  qemu-options.hx      | 4 ++--
>  4 files changed, 15 insertions(+), 4 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--E78nHwJJPnq5d1OkihiDAepYAnEs56lu5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpx7TkACgkQp6FrSiUn
Q2otPwgAowyd7BSg1n+NTCcE27qAELu5BoCdDwWb5/mV6vej8R35t1X4XcZsWBRU
P0WiIUoSb1/PoZEKOgTA9VgkDCTljFUrbyHJnKKwMf0TC1CUeMTYGv61EK2Y7bOc
8f3B4oIVU1mAwMB9KT/lAYglGfMnWHYeRHL6JYcgku8rvTPgI+0MSw5VtG6SmS+Q
o6WWS2MVRTTW0tMEsnkG1hr5jEq8QcJ/mB7c5qzYMZ08mAtuzjBDvSMBEIYYaHoM
W5nW0eHDZLWJgpO5j169b1KG7J6ziJEaRb/9eApKw7dBPL2mS8yv6igS5fRKj5Ej
axdR4QOjVK4M1L0bdpJMgos8a4JGYQ==
=t4Ua
-----END PGP SIGNATURE-----

--E78nHwJJPnq5d1OkihiDAepYAnEs56lu5--
