Received: from eggs.gnu.org ([2001:4830:134:3::10]:50866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnnX6-0005Ra-3S
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 10:34:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnnX4-0003rB-Sy
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 10:34:40 -0400
References: <20170314111157.14464-1-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fc89f163-33d1-e37d-49e5-fb934fc4ebc7@redhat.com>
Date: Tue, 14 Mar 2017 09:34:28 -0500
MIME-Version: 1.0
In-Reply-To: <20170314111157.14464-1-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0Cf5aXOQX3EkxBcoS6lrHechEuuIQOMBi"
Subject: Re: [Qemu-devel] [PATCH] nbd-client: fix handling of hungup
 connections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0Cf5aXOQX3EkxBcoS6lrHechEuuIQOMBi
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <fc89f163-33d1-e37d-49e5-fb934fc4ebc7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] nbd-client: fix handling of hungup
 connections
References: <20170314111157.14464-1-pbonzini@redhat.com>
In-Reply-To: <20170314111157.14464-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/14/2017 06:11 AM, Paolo Bonzini wrote:
> After the switch to reading replies in a coroutine, nothing is
> reentering pending receive coroutines if the connection hangs.
> Move nbd_recv_coroutines_enter_all to the reply read coroutine,
> which is the place where hangups are detected.  nbd_teardown_connection=

> can simply wait for the reply read coroutine to detect the hangup
> and clean up after itself.
>=20
> This wouldn't be enough though because nbd_receive_reply returns 0
> (rather than -EPIPE or similar) when reading from a hung connection.
> Fix the return value check in nbd_read_reply_entry.
>=20
> This fixes qemu-iotests 083.
>=20
> Reported-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/nbd-client.c | 12 ++++++------
>  nbd/client.c       |  2 +-
>  2 files changed, 7 insertions(+), 7 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--0Cf5aXOQX3EkxBcoS6lrHechEuuIQOMBi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYx/90AAoJEKeha0olJ0NqOAUH/0rt97zXJ1wvOt/+pQwq/VDD
apojUBCGTGEPNMpr/ZWOxjBYcVaYBVaWX7oIJ4m2pSvZt5YZ49rEYNx34mYBFYnD
nK285vS3KP3xWEOmGJvDQMF1IDvVyTEKHpDyvv3q8M4V3rkmInKHpp6cxx9LJ71r
XLHcpOjGwCYbc4sLi5ZRNLo8/sGLNUiF3JjP32qZdVZ951ih10LZ0IsV4wzoLgts
oYNUfCVPpdTM6je96WZFL4Bs4Qse/9kgEHVnicQQ6LbjXWc3Xb20YbKrg2loOuWb
LkJx6yujptVg6OG2LumkgqQj0i2/8tdG+13mMWgWcM0oK/eVclfH6083J3r46Fk=
=el7i
-----END PGP SIGNATURE-----

--0Cf5aXOQX3EkxBcoS6lrHechEuuIQOMBi--
