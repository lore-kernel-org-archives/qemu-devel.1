Received: from eggs.gnu.org ([2001:4830:134:3::10]:56616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciu9d-0004yT-72
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 21:38:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciu9a-0001a6-3u
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 21:38:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ciu9Z-0001Zx-SN
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 21:38:10 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 84BA6C057FA5
	for <qemu-devel@nongnu.org>; Wed,  1 Mar 2017 02:38:09 +0000 (UTC)
References: <20170227134202.2991-1-marcandre.lureau@redhat.com>
	<20170227134202.2991-2-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a3fd7e0b-9216-4f8b-4873-e79a61dca315@redhat.com>
Date: Tue, 28 Feb 2017 19:57:48 -0600
MIME-Version: 1.0
In-Reply-To: <20170227134202.2991-2-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DbUCa7cTDvXhc7htahLxasGb9aWb8eMfo"
Subject: Re: [Qemu-devel] [PATCH v2 01/21] char: remove
 qemu_chr_be_generic_open
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
--DbUCa7cTDvXhc7htahLxasGb9aWb8eMfo
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <a3fd7e0b-9216-4f8b-4873-e79a61dca315@redhat.com>
Subject: Re: [PATCH v2 01/21] char: remove qemu_chr_be_generic_open
References: <20170227134202.2991-1-marcandre.lureau@redhat.com>
 <20170227134202.2991-2-marcandre.lureau@redhat.com>
In-Reply-To: <20170227134202.2991-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/27/2017 07:41 AM, Marc-Andr=C3=A9 Lureau wrote:
> The function simply alias and hides the real event function.

s/alias/aliases/

>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/sysemu/char.h |  1 -
>  chardev/char-pty.c    |  2 +-
>  chardev/char-socket.c |  2 +-
>  chardev/char.c        | 10 ++--------
>  ui/console.c          |  2 +-
>  ui/gtk.c              |  2 +-
>  6 files changed, 6 insertions(+), 13 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--DbUCa7cTDvXhc7htahLxasGb9aWb8eMfo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtiqcAAoJEKeha0olJ0NqX3AH/2YDsLJRKeLB5jSHar/1l8aA
0Tv/y+femjxPy9Kkmyhhj8H3jG0yVmMIUeXH3dV4tXt1dQdTbE6/m1ITw1bBE+H8
ItpT0EslnYmkdMJ0aekoWddgZApsM8WbHu2ZN7641z5Ondt2DzvDJo905gxT/rKB
AY8xG2MxdRifXvjiPcYxgoxpFPP5weRSqYSQL69CfFx5A98VSSvtoB3y4CRggbCo
LwmsdGLSRuGCuZOiL9JsWoYWEIxC6LMq9b+Ld/6cJ8OPk0NFB63A9mM//jcftsib
9FKDpmJzU4bYZbYyrJ36Q8EJV5KWeGPJn9yfx3c3wzgHPgi5nud9H5JZQDSsU/k=
=dRFB
-----END PGP SIGNATURE-----

--DbUCa7cTDvXhc7htahLxasGb9aWb8eMfo--
