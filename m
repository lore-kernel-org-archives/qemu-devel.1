Received: from eggs.gnu.org ([2001:4830:134:3::10]:46701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPcxJ-00042e-Lt
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 17:25:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPcxE-0003Jd-Pr
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 17:25:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cPcxE-0003JO-J8
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 17:25:44 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BFC3C7F7B7
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 22:25:44 +0000 (UTC)
References: <20170105165329.17227-1-marcandre.lureau@redhat.com>
	<20170105165329.17227-19-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c4b94ddb-5baa-a521-7450-1d37a6609e58@redhat.com>
Date: Fri, 6 Jan 2017 16:25:42 -0600
MIME-Version: 1.0
In-Reply-To: <20170105165329.17227-19-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6CBpvRu7615wgTs8X7OG3X2CFLBOFP57C"
Subject: Re: [Qemu-devel] [PATCH 18/20] baum: use a common prefix for chr
 callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6CBpvRu7615wgTs8X7OG3X2CFLBOFP57C
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <c4b94ddb-5baa-a521-7450-1d37a6609e58@redhat.com>
Subject: Re: [PATCH 18/20] baum: use a common prefix for chr callbacks
References: <20170105165329.17227-1-marcandre.lureau@redhat.com>
 <20170105165329.17227-19-marcandre.lureau@redhat.com>
In-Reply-To: <20170105165329.17227-19-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2017 10:53 AM, Marc-Andr=C3=A9 Lureau wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  backends/baum.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--6CBpvRu7615wgTs8X7OG3X2CFLBOFP57C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYcBlmAAoJEKeha0olJ0NqDFoH/iYzabfGZ27Zfem4Iwjm8z9q
Cuqvz4XCQWzZCYtXGt7qoIjs28eZVwLwye/j1HvBSpAMGQSqFgGV+4+LxAGEv8eh
7VkZaGzZ+eJnJ9O7oc0ptnlH894/8T8Xsvn6vbpkIiMG3R02iy1+mcdMJSpL5wdR
LvHIzmTpzU0UnAbUmfy9L25mMogII/D4IyhoI7RUhRyjp0cKDoD0zR7aqi5iVtar
+mqJ1rZ6HkZfOgpDHaJdDdNYzwIM2tTUz2UnqtdoU1KjoMEuWBQJisCM+c5C2bA/
AvhW5l5CqqJ0WHNftXs2OtG095TEQ+hRCo+MDQfGevm5OHNsKwTfTevUB3/S3Ys=
=73I9
-----END PGP SIGNATURE-----

--6CBpvRu7615wgTs8X7OG3X2CFLBOFP57C--
