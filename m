Received: from eggs.gnu.org ([2001:4830:134:3::10]:43711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cJ5wu-000305-3Q
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 16:58:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cJ5wp-0007ly-9W
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 16:58:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cJ5wp-0007lY-3V
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 16:58:19 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2178E61B9A
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 21:58:17 +0000 (UTC)
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
	<20161212224325.20790-8-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6085d5a8-1082-928f-b541-85451209589a@redhat.com>
Date: Mon, 19 Dec 2016 15:58:15 -0600
MIME-Version: 1.0
In-Reply-To: <20161212224325.20790-8-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="88gRjGX0VNUBqlFDutxP7NAXICFSVVHHm"
Subject: Re: [Qemu-devel] [PATCH 07/54] char: use a feature bit for replay
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
--88gRjGX0VNUBqlFDutxP7NAXICFSVVHHm
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <6085d5a8-1082-928f-b541-85451209589a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/54] char: use a feature bit for replay
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
 <20161212224325.20790-8-marcandre.lureau@redhat.com>
In-Reply-To: <20161212224325.20790-8-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/12/2016 04:42 PM, Marc-Andr=C3=A9 Lureau wrote:
> Use a feature flag rather than a structure field for "replay".
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qemu-char.c           | 33 ++++++++++++++++++++-------------
>  include/sysemu/char.h |  3 ++-
>  2 files changed, 22 insertions(+), 14 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--88gRjGX0VNUBqlFDutxP7NAXICFSVVHHm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYWFf3AAoJEKeha0olJ0NqymoIAI+I65ndaXYieNZkd821Q107
OVXufFTMum4NmxuGVUY8JY3VjQRs3kXtLgSwUgXZoOzFy1o+QlZF0U8sEjnHoO+y
beBr8oWr+dZgHJwdwFE+r/Mk3Y3HimWniRWfNFSRgpPnLlkaxS8IhHSSKBgLY3BU
JTSXcO/1MsMVZrh5FW4KQWowR1GAFhW8gi6HpPYGnNvCYt/SFameZK5OYO/YQAsc
4KkKa7OcNgNxX1Kt07yMDpZGEY7YupTTDnlR9wM1nHqsD4dHKd0Vg50Do+zKhmGD
AdXzJdgxyuS5gL6Sbdhct4ci4sESP+s8q2fv37Fp5Gw5PUfENqLZ+sf5EU0d0ag=
=N5VS
-----END PGP SIGNATURE-----

--88gRjGX0VNUBqlFDutxP7NAXICFSVVHHm--
