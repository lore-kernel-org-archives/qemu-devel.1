Received: from eggs.gnu.org ([2001:4830:134:3::10]:38241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYFdW-0008Kr-Pm
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 12:21:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYFdS-000375-Pu
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 12:21:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cYFdS-00036b-Gr
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 12:20:58 -0500
References: <20170130105116.29337-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <979418bd-35a8-a8c8-2a65-0813bd54b5da@redhat.com>
Date: Mon, 30 Jan 2017 11:20:56 -0600
MIME-Version: 1.0
In-Reply-To: <20170130105116.29337-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="amtasqmQvs3bpjr71paqvJp38ePOcaNPN"
Subject: Re: [Qemu-devel] [PATCH] io: fix decoding when multiple websockets
 frames arrive at once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Brian Rak <brak@gameservers.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--amtasqmQvs3bpjr71paqvJp38ePOcaNPN
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Brian Rak <brak@gameservers.com>
Message-ID: <979418bd-35a8-a8c8-2a65-0813bd54b5da@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] io: fix decoding when multiple websockets
 frames arrive at once
References: <20170130105116.29337-1-berrange@redhat.com>
In-Reply-To: <20170130105116.29337-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2017 04:51 AM, Daniel P. Berrange wrote:
> The qio_channel_websock_read_wire() method will read upto 4096

s/upto/up to/

> bytes off the socket and then decode the websockets header and
> payload. The code was only decoding a single websockets frame,
> even if the buffered data contained multiple frames. This meant
> that decoding of subsequent frames was delayed until further
> input arrived on the socket. This backlog of delayed frames
> gets worse & worse over time.
>=20
> Symptom was that when connecting to the VNC server via the
> built-in websockets server, mouse/keyboard interaction would
> start out fine, but slowly get more & more delayed until it
> was unusable.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  io/channel-websock.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--amtasqmQvs3bpjr71paqvJp38ePOcaNPN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYj3X4AAoJEKeha0olJ0Nq6YoH/0im0VfcRbZURfaUxRBtZkMS
6jxAMTp4aP3WsqZAhEFSmZPWqK+jpH2EWPoVBEilcVxOYWWVaPRnwmZ4TyC7Psk2
r48pRHgreXFiaaSX6wiBvhkOMBjAosW/5c/7WDxCAVr19ANLeA5CC7Wyy6/TlaCx
PLAOZulcITeyWTPeoV+WSXTzB9YGtGLvCFJhttIvm3o2AyQM2B1tkawoS5ypQlH/
38tDxntRbpycRSer0hymo37y5160UxCUtqCBkZfnpFiJEeVB+5dZpysDUg/JtgJj
RA3vy/wXMzeRvvPYnGUF+eyxRk6GJ1v9HS7QIpWzSHdQWdNbMK78B0BYLgyTG+k=
=xaPa
-----END PGP SIGNATURE-----

--amtasqmQvs3bpjr71paqvJp38ePOcaNPN--
