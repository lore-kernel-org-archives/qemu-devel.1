Received: from eggs.gnu.org ([2001:4830:134:3::10]:47726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dEFOD-0003A2-V1
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:34:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dEFO9-0006Rd-Ce
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:34:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dEFO9-0006RE-3X
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:34:45 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E097D80B29
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 13:34:41 +0000 (UTC)
References: <20170526110456.32004-1-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a7ef40a9-536e-2008-0f2a-4883bc92b770@redhat.com>
Date: Fri, 26 May 2017 08:34:38 -0500
MIME-Version: 1.0
In-Reply-To: <20170526110456.32004-1-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lmO1deILBtSiH5QL6oi7NwLqgxPH7Jq5J"
Subject: Re: [Qemu-devel] [PATCH] numa-test: fix query-cpus leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, ehabkost@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lmO1deILBtSiH5QL6oi7NwLqgxPH7Jq5J
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: imammedo@redhat.com, ehabkost@redhat.com
Message-ID: <a7ef40a9-536e-2008-0f2a-4883bc92b770@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] numa-test: fix query-cpus leaks
References: <20170526110456.32004-1-marcandre.lureau@redhat.com>
In-Reply-To: <20170526110456.32004-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/26/2017 06:04 AM, Marc-Andr=C3=A9 Lureau wrote:
> Fix test leaks introduced in commit 2941020a476.
>=20
> (and small extra space removed)
>=20
> Spotted by ASAN.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/numa-test.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lmO1deILBtSiH5QL6oi7NwLqgxPH7Jq5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZKC7uAAoJEKeha0olJ0NqyDEIAKXrcQpGjIpPKEf7xNLlWST/
TKkv5qLDXoU1aLXh7NPUOKtuna0vkcRbvoDzkf1zVF2zuBnPuzbJmk1pNsdB/ujx
3S6OOB9fvUSgXZ12fqdgAvB/iFga/+zZ16J9YWiYco48X/ADGB/v+5kYhf1Xp5Gy
UqKPzZt2WY7ngeQ2jDx3PJ4XMLpbswRCg9iaihaTxXCiwoJskLmBKdY93TFbuNqO
ZIMnZ0gmbQfX9Z1MnJbp8g20xKUfMRXwBEaX7wlnesvC8PlymK4j4Xj6QV8HlHjO
hp1HvWvoAp8jMR/lGNGeK3LbZlL9wRgqtdS/zU2mItD+PoxxA0uCEjWaRsxtaIo=
=k3S8
-----END PGP SIGNATURE-----

--lmO1deILBtSiH5QL6oi7NwLqgxPH7Jq5J--
