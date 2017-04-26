Received: from eggs.gnu.org ([2001:4830:134:3::10]:43753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3Oe8-0007sk-2B
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:14:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3Oe7-0004la-4q
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:14:24 -0400
References: <1493192202-3184-1-git-send-email-armbru@redhat.com>
	<1493192202-3184-2-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <11cba40b-32c0-a660-b8b9-f6bb0da989d4@redhat.com>
Date: Wed, 26 Apr 2017 10:14:09 -0500
MIME-Version: 1.0
In-Reply-To: <1493192202-3184-2-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RfRDrUo4pGEdTqNcHRkdTJJ1i2aTx3X8D"
Subject: Re: [Qemu-devel] [PATCH 1/7] sockets: Prepare vsock_parse() for
 flattened SocketAddress
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RfRDrUo4pGEdTqNcHRkdTJJ1i2aTx3X8D
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com, pbonzini@redhat.com,
 qemu-block@nongnu.org
Message-ID: <11cba40b-32c0-a660-b8b9-f6bb0da989d4@redhat.com>
Subject: Re: [PATCH 1/7] sockets: Prepare vsock_parse() for flattened
 SocketAddress
References: <1493192202-3184-1-git-send-email-armbru@redhat.com>
 <1493192202-3184-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1493192202-3184-2-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2017 02:36 AM, Markus Armbruster wrote:
> I'm going to flatten SocketAddress: rename SocketAddress to
> SocketAddressLegacy, SocketAddressFlat to SocketAddress, eliminate
> SocketAddressLegacy except in external interfaces.
>=20
> vsock_parse() returns a newly allocated VsockSocketAddress.  Lift the
> allocation from vsock_parse() into its caller socket_parse() to
> prepare for flattening SocketAddress.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  util/qemu-sockets.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--RfRDrUo4pGEdTqNcHRkdTJJ1i2aTx3X8D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZALlBAAoJEKeha0olJ0NqqxUH/iYRWl6t+HYNXLEzthZIMgA4
Y0Q1xlklhm8+h8yQ/LezF0/Eef3GOeOZqfRevPThFf0qTR5LPbWcH0vloojMirve
w5ta7BSU1WfmQ6cbkaSyZdPDYgzTmcCpuuipXTJ9E8qT6I+8xEUm0U9FfirdjYoz
R96pba+2ATbc04YUiKur2Ry/mK7G1nYwK3wTVdgK0bHSohbGajXQi2EpdV6J1k9M
+Ppz5LBEkZQT/QhCVflCJo0FbhixJSNmw/U9Brer1Yb6REr/zMsDGLI4OiwEHgIe
nCR7YAQkitK1t+Dt6JcuoDCwgUdbn+Hmvcz101gr1TxsXYGcrm+w/6XCALsgJHA=
=WW6C
-----END PGP SIGNATURE-----

--RfRDrUo4pGEdTqNcHRkdTJJ1i2aTx3X8D--
