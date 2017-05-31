Received: from eggs.gnu.org ([2001:4830:134:3::10]:41488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dG532-0000Dh-Vp
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:56:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dG532-0001AB-8l
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:56:33 -0400
References: <20170524202842.26724-1-eblake@redhat.com>
	<20170524202842.26724-5-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2727f1d6-3c50-de2e-9679-86e0eeb05457@redhat.com>
Date: Wed, 31 May 2017 16:56:20 +0200
MIME-Version: 1.0
In-Reply-To: <20170524202842.26724-5-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3GSoxTrhUphFJSJTPP3qGRnukgDGQcqub"
Subject: Re: [Qemu-devel] [PATCH v2 4/5] block: Simplify use of
 BDRV_BLOCK_RAW
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3GSoxTrhUphFJSJTPP3qGRnukgDGQcqub
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, Jeff Cody <jcody@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <2727f1d6-3c50-de2e-9679-86e0eeb05457@redhat.com>
Subject: Re: [PATCH v2 4/5] block: Simplify use of BDRV_BLOCK_RAW
References: <20170524202842.26724-1-eblake@redhat.com>
 <20170524202842.26724-5-eblake@redhat.com>
In-Reply-To: <20170524202842.26724-5-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-24 22:28, Eric Blake wrote:
> The lone caller that cares about a return of BDRV_BLOCK_RAW
> (namely, io.c:bdrv_co_get_block_status) completely replaces the
> return value, so there is no point in passing BDRV_BLOCK_DATA.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>

Technically true, but conflicts with the documentation in block.h.

If you really want this changed, you should document in block.h what
exactly it is that BDRV_BLOCK_RAW does.

Max


--3GSoxTrhUphFJSJTPP3qGRnukgDGQcqub
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZLtmUEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQJO0
B/9jnEK5WU7rcMV2QB/vWH0pR1PCTb9Xlzegt4/P7aY6MlHC3OAo6kUgPxlSY8f8
M+jNAKjKDq3CPR9sbkZRKjljRtK2OLJ7fK4ya7Ue7w4M1fDvlExsQMFrNUnuzqQ2
KHRP1A5pScU7wiBlZQ1bN4kndBZ5iCxl7UH05Hkl5DAlnW/XGNkYu2ozO5gIwsF+
PJ8LN4avUqa/wzErhjzF3NRMiK8k5xeQNoMN3j5gQXkLAIvBipt3LZywzLdCUHtm
s70njAfzd0AV9G4Ex+tP9pJ2Jte9YnH7DAh3wpb1kCsWvrO9p/C4AFDbwp2xjCeZ
+f3BsuIsZ4QgKpA3ZmzDaXX5
=kvob
-----END PGP SIGNATURE-----

--3GSoxTrhUphFJSJTPP3qGRnukgDGQcqub--
