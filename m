Received: from eggs.gnu.org ([2001:4830:134:3::10]:45423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cQazr-0000CT-LA
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:32:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cQazq-0002Oz-Or
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:32:27 -0500
References: <1483969476-7172-1-git-send-email-kwolf@redhat.com>
	<1483969476-7172-15-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2a5b7944-69a3-044a-f065-844c368ec5b4@redhat.com>
Date: Mon, 9 Jan 2017 08:32:17 -0600
MIME-Version: 1.0
In-Reply-To: <1483969476-7172-15-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="crV1GoeAc5qm0c4KEIa8f7Nxmr2a6GkuI"
Subject: Re: [Qemu-devel] [PULL 14/14] block: Rename raw-{posix,
 win32} to file-*.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--crV1GoeAc5qm0c4KEIa8f7Nxmr2a6GkuI
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <2a5b7944-69a3-044a-f065-844c368ec5b4@redhat.com>
Subject: Re: [Qemu-devel] [PULL 14/14] block: Rename raw-{posix, win32} to
 file-*.c
References: <1483969476-7172-1-git-send-email-kwolf@redhat.com>
 <1483969476-7172-15-git-send-email-kwolf@redhat.com>
In-Reply-To: <1483969476-7172-15-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/09/2017 07:44 AM, Kevin Wolf wrote:
> From: Eric Blake <eblake@redhat.com>
>=20
> These files deal with the file protocol, not the raw format (the
> file protocol is often used with other formats, and the raw
> format is not forced to use the file protocol).  Rename things
> to make it a bit easier to follow.
>=20
> Suggested-by: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  MAINTAINERS               |    4 +-
>  block/Makefile.objs       |    4 +-
>  block/file-posix.c        | 2616 +++++++++++++++++++++++++++++++++++++=
++++++++
>  block/file-win32.c        |  781 ++++++++++++++
>  block/gluster.c           |    4 +-
>  block/raw-posix.c         | 2616 -------------------------------------=
--------
>  block/raw-win32.c         |  781 --------------

Did you forget to configure rename detection?

It doesn't impact the validity of the pull request, but sure makes for a
larger hit on the inbox.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--crV1GoeAc5qm0c4KEIa8f7Nxmr2a6GkuI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYc57xAAoJEKeha0olJ0Nq1RwIAI+LOxQil382D910BSUWp/Yu
UXnqv2zGDuks35eQ/i2nJL6+Ac39DA4Jd55d0qZiEEbB55kk4sW+zADQnRKBhjOb
u0E5BNovSN2estxszEvtyaQ+VUpeguHa2jUYYbMpUYIjmSQIRJLb8c+Ge52voghP
Z1TDescQx41YYAK1V8B7xzB7sTOKup5Jebepb2j+5VZwf0M2BHxdcZ2j/vkMIj9L
mean7AyeseoSDK9Xls16heyVxyV+0+ghrlUTsjIf8QCXaM+tOmj360Ti3q1s3udM
iNLs1ciFNz4r3FGotlHm4ekPiX2jXR+7ZQYLj9H8OuSDrqn311e09NhNmmIV4ug=
=qS4m
-----END PGP SIGNATURE-----

--crV1GoeAc5qm0c4KEIa8f7Nxmr2a6GkuI--
