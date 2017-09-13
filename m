Received: from eggs.gnu.org ([2001:4830:134:3::10]:53290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ds8Ac-0007Rv-8Y
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 09:57:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ds8Ab-0002au-CO
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 09:57:38 -0400
References: <1505298088-10878-1-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cd6130cd-2785-4f51-cd3b-ac39f1f8b937@redhat.com>
Date: Wed, 13 Sep 2017 08:57:27 -0500
MIME-Version: 1.0
In-Reply-To: <1505298088-10878-1-git-send-email-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2NhWqWqxqqCkxXcbFjPKDFGkO7gEV9lJ7"
Subject: Re: [Qemu-devel] [PATCH] block: Clean up some bad code in the vvfat
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2NhWqWqxqqCkxXcbFjPKDFGkO7gEV9lJ7
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <cd6130cd-2785-4f51-cd3b-ac39f1f8b937@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: Clean up some bad code in the vvfat
 driver
References: <1505298088-10878-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1505298088-10878-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/13/2017 05:21 AM, Thomas Huth wrote:
> Remove the unnecessary home-grown redefinition of the assert() macro he=
re,
> and remove the unusable debug code at the end of the checkpoint() funct=
ion.
> The code there uses assert() with side-effects (assignment to the "mapp=
ing"
> variable), which should be avoided. Looking more closely, it seems as i=
t is
> apparently also only usable for one certain directory layout (with a fi=
le
> named USB.H in it) and thus is of no use for the rest of the world.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  block/vvfat.c | 26 ++------------------------
>  1 file changed, 2 insertions(+), 24 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2NhWqWqxqqCkxXcbFjPKDFGkO7gEV9lJ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm5OUcACgkQp6FrSiUn
Q2p2iAf/cBobHidjXyZymTRfydBJBtZDC0xGWagYjzxcY9KTT84CqCn/YBoNC6OZ
7GtMKupjfUleda3vZAVYfix7/SRp15FZMaeauL9jdU30UaOBStUNylw9/KzjpIyx
QUUQq441lRe9QcwQygt8xJ1ldXatOqq4DBitScWlGdf7PGErSzDPeO9KoiiONyCu
0TDMfUq5IUZVEpNm3lS6bQ6J2IJk9JB1i19fUVU7jUTvX7/rq77Xu0VpXoRtk81z
Y+ab5hbTPfp8iWyRDykiaMMOuPv3iYuZqMHeDBqteMMEnk8g6NASrRwwaIp7REXf
GHYalZpcZnJNNNq2KozRggSZj93jVA==
=5T5e
-----END PGP SIGNATURE-----

--2NhWqWqxqqCkxXcbFjPKDFGkO7gEV9lJ7--
