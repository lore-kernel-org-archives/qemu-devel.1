Received: from eggs.gnu.org ([2001:4830:134:3::10]:43065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPUjk-0003Lm-9X
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 08:39:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPUjh-0002nx-61
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 08:39:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cPUjg-0002nl-UJ
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 08:39:13 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BAB754E4E6
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 13:39:12 +0000 (UTC)
References: <20170105160701.22118-1-berrange@redhat.com>
	<20170105160701.22118-2-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d78c2c83-795a-0b65-a478-bc899ac32320@redhat.com>
Date: Fri, 6 Jan 2017 07:39:10 -0600
MIME-Version: 1.0
In-Reply-To: <20170105160701.22118-2-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GUHAoJvlhoAlJkvWgTNToFxQWPi1S9cCd"
Subject: Re: [Qemu-devel] [PATCH 1/8] ui: fix regression handling bare
 'websocket' option to -vnc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GUHAoJvlhoAlJkvWgTNToFxQWPi1S9cCd
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <d78c2c83-795a-0b65-a478-bc899ac32320@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/8] ui: fix regression handling bare
 'websocket' option to -vnc
References: <20170105160701.22118-1-berrange@redhat.com>
 <20170105160701.22118-2-berrange@redhat.com>
In-Reply-To: <20170105160701.22118-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2017 10:06 AM, Daniel P. Berrange wrote:
> The -vnc argument is documented as accepting two syntaxes for
> the 'websocket' option, either a bare option name, or a port
> number. If using the bare option name, it is supposed to apply
> the display number as an offset to base port 5700. e.g.
>=20
>   -vnc localhost:3,websocket
>=20
> should listen on port 5703, however, this was broken in 2.3.0 since
>=20
>   commit 4db14629c38611061fc19ec6927405923de84f08
>   Author: Gerd Hoffmann <kraxel@redhat.com>
>   Date:   Tue Sep 16 12:33:03 2014 +0200
>=20
>     vnc: switch to QemuOpts, allow multiple servers
>=20
> instead qemu tries to listen on port "on" which gets looked up in
> /etc/services and fails.
>=20
> Fixes bug: #1455912
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  ui/vnc.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--GUHAoJvlhoAlJkvWgTNToFxQWPi1S9cCd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYb53+AAoJEKeha0olJ0NqP7MH/3nOdZUIb5kGK6OkjlFZgK//
ogd/RPuLDe/FzvFV2ZxmefN1jPfpXQ8Tc1xKWS0vNaBvSmxhGad0a3BaeC6Vu2ha
5+aUUiC9iQ3B76XMgFiA5VTJGX7FP3pfRMcCqCbB1pzzaE4QrEMkxXmCbF+87PEc
mLR/ehCzLVPhMJFmVD6T5a4Ba8xVBAZo+qb0ZvOyCIG9Woe9mOu2k8WsrRTdCFSd
sEX19k++ven1vFEJpfH1HnlUmWbLNE3UNzn6LIALYZFrggtv8QcYytnwCnxHrcJb
L47jF618ZDPcqlzbczaU2bCfYe8xwPsMSI1B3AvvzovdIFbAnyBXzGHC8qDsb8E=
=BGnj
-----END PGP SIGNATURE-----

--GUHAoJvlhoAlJkvWgTNToFxQWPi1S9cCd--
