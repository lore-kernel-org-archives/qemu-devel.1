Received: from eggs.gnu.org ([2001:4830:134:3::10]:50686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYIC7-0006jU-CQ
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 15:05:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYIC4-0001zo-K3
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 15:04:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cYIC4-0001zb-EM
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 15:04:52 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A172F80F8D
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 20:04:52 +0000 (UTC)
References: <20170130133954.31353-1-marcandre.lureau@redhat.com>
	<20170130133954.31353-26-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cf66d033-fcea-b126-be8a-9679b03dd21b@redhat.com>
Date: Mon, 30 Jan 2017 14:04:50 -0600
MIME-Version: 1.0
In-Reply-To: <20170130133954.31353-26-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FgfPumlUKvFQUQ5SDrEGaPTu9iNnw7k55"
Subject: Re: [Qemu-devel] [PATCH v2 25/41] char: move ringbuf/memory to its
 own file
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
--FgfPumlUKvFQUQ5SDrEGaPTu9iNnw7k55
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <cf66d033-fcea-b126-be8a-9679b03dd21b@redhat.com>
Subject: Re: [PATCH v2 25/41] char: move ringbuf/memory to its own file
References: <20170130133954.31353-1-marcandre.lureau@redhat.com>
 <20170130133954.31353-26-marcandre.lureau@redhat.com>
In-Reply-To: <20170130133954.31353-26-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2017 07:39 AM, Marc-Andr=C3=A9 Lureau wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  chardev/char-ringbuf.c | 249 +++++++++++++++++++++++++++++++++++++++++=
++++++++
>  chardev/char.c         | 218 -----------------------------------------=
--
>  chardev/Makefile.objs  |   1 +
>  3 files changed, 250 insertions(+), 218 deletions(-)
>  create mode 100644 chardev/char-ringbuf.c
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--FgfPumlUKvFQUQ5SDrEGaPTu9iNnw7k55
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYj5xiAAoJEKeha0olJ0NqXDIH/11DirEpspEQku/rqiyOs0QQ
c5c/r4OtParfvcDS7qL48aDCPM0a6H/4ugKIsm9lOT764fjz3pL7fThJd+axoELN
p08S9sA7vWC8H7o4H6pst/SKHsI7xHRh6Qz9tTwmOnpIcg4JYNzuySPZOrgy+P5U
40fkqWeXe0O6hMmc+WFOdrwt/tru/R7Hx+ABQSnW2y76TksG8R9lfZosRe7JdxHx
CWnFlLT9slVEYXxvSB1+ryOLkzUznydZ0AUtGCh55SyLX1fDRZCsGd6wQP7orX9R
HcZJQtfzJjri4jdNk3R+8lV1vnrrvQDNi+l3xayTc85ZfwFsV1IF3JIW/mxw7Lg=
=tkhA
-----END PGP SIGNATURE-----

--FgfPumlUKvFQUQ5SDrEGaPTu9iNnw7k55--
