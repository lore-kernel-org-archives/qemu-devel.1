Received: from eggs.gnu.org ([2001:4830:134:3::10]:39593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFpEc-00027f-Uo
	for qemu-devel@nongnu.org; Tue, 30 May 2017 18:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFpEY-00014x-Pc
	for qemu-devel@nongnu.org; Tue, 30 May 2017 18:03:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dFpEY-00013o-HC
	for qemu-devel@nongnu.org; Tue, 30 May 2017 18:03:22 -0400
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
	<20170530143052.165002-7-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0bddb29d-8ae8-2124-7ad4-18a605d71b5d@redhat.com>
Date: Tue, 30 May 2017 17:03:19 -0500
MIME-Version: 1.0
In-Reply-To: <20170530143052.165002-7-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AqurVMf3HRTXGr5IfO452tH4KV00sqSEv"
Subject: Re: [Qemu-devel] [PATCH 06/19] nbd/server: remove NBDClientNewData
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AqurVMf3HRTXGr5IfO452tH4KV00sqSEv
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org
Message-ID: <0bddb29d-8ae8-2124-7ad4-18a605d71b5d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/19] nbd/server: remove NBDClientNewData
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
 <20170530143052.165002-7-vsementsov@virtuozzo.com>
In-Reply-To: <20170530143052.165002-7-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/30/2017 09:30 AM, Vladimir Sementsov-Ogievskiy wrote:
> "co" field of NBDClientNewData is unused, so let's just use client
> pointer instead of extra structure.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/server.c | 25 +++++++------------------
>  1 file changed, 7 insertions(+), 18 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

Might be worth mentioning in the commit message that it has never been
used, all the way back to its declaration in commit 1a6245a5.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--AqurVMf3HRTXGr5IfO452tH4KV00sqSEv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLewnAAoJEKeha0olJ0NqXYYIAKwqUCe1ClaAaSdhKXHir5z/
5CIFXAY/Ck00ifvBLYEZO2sHtmuD3goSoF2CjS56q0mlWIOtNtyjDiYDe3fBwaP8
ESBbo8oNkuHFkAXxkG9dARNKblVpi86ikuLeahJ7yzCXWwvxFV61zqb05oAYk1XB
liI392dCDHGww6phzlN5yiR0LWWxpqyB2Jy5IHVst7D9/aiSZXlCZt9mPOqhp6Wl
2ioRTgVxm10x3hVKlar6DvloqWOYFd+ficTrNN/5WsugWDupMZM1Ek+crXk0I5yc
/NPvo1Lcvwa2t4ExBadmfRo+Tx7eDcYbW6CGc0T9Uepk9wgE5rEfK2tEwQlJC3w=
=Kgf4
-----END PGP SIGNATURE-----

--AqurVMf3HRTXGr5IfO452tH4KV00sqSEv--
