Received: from eggs.gnu.org ([2001:4830:134:3::10]:46761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOtWn-0006j7-UH
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 16:55:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOtWk-0004Kr-R5
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 16:55:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cOtWk-0004K5-KD
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 16:55:22 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A9A6F3D97B
	for <qemu-devel@nongnu.org>; Wed,  4 Jan 2017 21:55:22 +0000 (UTC)
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
	<20161212224325.20790-12-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f0cac613-67d4-269e-9c83-4454e4bc79b3@redhat.com>
Date: Wed, 4 Jan 2017 15:55:19 -0600
MIME-Version: 1.0
In-Reply-To: <20161212224325.20790-12-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dpUxVrkTM1HPglt6SoNn4viSbXgnPwuBf"
Subject: Re: [Qemu-devel] [PATCH 11/54] char: rename TCPChardev and
 NetChardev
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
--dpUxVrkTM1HPglt6SoNn4viSbXgnPwuBf
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <f0cac613-67d4-269e-9c83-4454e4bc79b3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 11/54] char: rename TCPChardev and NetChardev
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
 <20161212224325.20790-12-marcandre.lureau@redhat.com>
In-Reply-To: <20161212224325.20790-12-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/12/2016 04:42 PM, Marc-Andr=C3=A9 Lureau wrote:
> Rename the types to follow the name of the chardev kind.
> - socket: TCPChardev -> SocketChardev
> - udp: NetChardev -> UdpChardev
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qemu-char.c | 74 ++++++++++++++++++++++++++++++-----------------------=
--------
>  1 file changed, 37 insertions(+), 37 deletions(-)

Mechanical.
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--dpUxVrkTM1HPglt6SoNn4viSbXgnPwuBf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYbW9HAAoJEKeha0olJ0NqW18IAKqJlz85LFRdxONcuvOVMZV/
xf+C/4IFBTAWX5GtoFO7e5VsesHz/02OU2PwFyReS8HnS3tNyDK0hk7WQLzTMEo6
8etNIBczRzWdVVOVzRY3BHmWwjBWECLgsD8MxlXTwSFCxR/Un1GjSLRx4u8mQb0T
km87qG+Z4vhsI/5UpkmFDu3JqjT3Fs0GTBgmq1PTjcEVtRuyQUuMo3Pc7i4a1wlU
yGbPNbqVDMD5VW2I1zh/S7fiLcDXulIH3u0GpT5XPEtZA4bL8NnrkR+2Z5ZNRtkc
CzN7+co0zv/mLU4QhV54vZ8abvjtdiQJ5w9dy0GDKQHHIwiov4YuerKXvxn2vMo=
=YIJH
-----END PGP SIGNATURE-----

--dpUxVrkTM1HPglt6SoNn4viSbXgnPwuBf--
