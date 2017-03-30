Received: from eggs.gnu.org ([2001:4830:134:3::10]:40848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctd0A-0002DV-CI
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:32:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctd09-0004P1-P8
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:32:46 -0400
References: <1490879707-6060-1-git-send-email-armbru@redhat.com>
	<1490879707-6060-10-git-send-email-armbru@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <12735019-29c3-a0bb-2c5f-adb88eb3f9b4@redhat.com>
Date: Thu, 30 Mar 2017 18:32:35 +0200
MIME-Version: 1.0
In-Reply-To: <1490879707-6060-10-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oJkL6KjJTfAECk7kLGGj0GIlppejdk1Q2"
Subject: Re: [Qemu-devel] [RFC v2 for-2.9 09/10] squash! nbd: Tidy up
 blockdev-add interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oJkL6KjJTfAECk7kLGGj0GIlppejdk1Q2
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp,
 namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com,
 pbonzini@redhat.com
Message-ID: <12735019-29c3-a0bb-2c5f-adb88eb3f9b4@redhat.com>
Subject: Re: [RFC v2 for-2.9 09/10] squash! nbd: Tidy up blockdev-add
 interface
References: <1490879707-6060-1-git-send-email-armbru@redhat.com>
 <1490879707-6060-10-git-send-email-armbru@redhat.com>
In-Reply-To: <1490879707-6060-10-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 30.03.2017 15:15, Markus Armbruster wrote:
> Drop backward -drive server.data.* compatibility gunk.  On squash,
> replace commit message's last paragraph "Unfortunately, SocketAddress
> is also visible..." by:
>=20
> Unfortunately, SocketAddress is also visible in -drive since 2.8:
>=20
>     -drive if=3Dnone,driver=3Dnbd,server.type=3Dinet,server.data.host=3D=
127.0.0.1,server.data.port=3D12345
>=20
> Nobody should be using it, as it's fairly new and has never been
> documented, so adding still more compatibility gunk to keep it working
> isn't worth the trouble.  You now have to use
>=20
>     -drive if=3Dnone,driver=3Dnbd,server.type=3Dinet,server.host=3D127.=
0.0.1,server.port=3D12345
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/nbd.c | 41 +----------------------------------------
>  1 file changed, 1 insertion(+), 40 deletions(-)

(Very-happily-)Reviewed-by: Max Reitz <mreitz@redhat.com>


--oJkL6KjJTfAECk7kLGGj0GIlppejdk1Q2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljdMyMSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AjZ8H/3Obn7R1/830S0HmHZR3R+WvAqFGG7z7
Dzz/clo9lQwlEheU8RpeodxLtLDkPeFAvdDBRw/0QYVPWKh8QR+tfjf9serGIwYu
GBXUeO3y3pP4yBik5NOPxP3YLD9SjXmAHnmNJ+GkD68hPMXVkNT+BZ/O9h7hPSUH
WqvKzmsUgSUIjOs9oG7YSC/2mUxgXfzniZTMaL7WMVNumDh1nQDraFY9Me2d2xQ+
JenmJhXRUctyUP9kzEGO1mr0zkfJfvX6xvxqI7xKNJb4qDZtn8px/4YZLteyyfPn
VpITTGNfE1AsZEDPSYNLkQMERHZJOrBsM1xiAqk6EgCaC+k/mMQ/87A=
=0SHL
-----END PGP SIGNATURE-----

--oJkL6KjJTfAECk7kLGGj0GIlppejdk1Q2--
