Received: from eggs.gnu.org ([2001:4830:134:3::10]:40991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eJR3S-0000Wc-HP
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 16:35:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eJR3R-0002UK-G0
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 16:35:06 -0500
References: <1511798407-31129-1-git-send-email-pl@kamp.de>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <81c8d0e6-fb1e-703c-1d0b-c60d05dab162@redhat.com>
Date: Mon, 27 Nov 2017 22:34:51 +0100
MIME-Version: 1.0
In-Reply-To: <1511798407-31129-1-git-send-email-pl@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HOPdtp4WvpG87PM7TeSsC4ROBvjrg6AfO"
Subject: Re: [Qemu-devel] [PATCH for-2.11] block/nfs: fix nfs_client_open
 for filesize greater than 1TB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HOPdtp4WvpG87PM7TeSsC4ROBvjrg6AfO
From: Max Reitz <mreitz@redhat.com>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, qemu-stable@nongnu.org
Message-ID: <81c8d0e6-fb1e-703c-1d0b-c60d05dab162@redhat.com>
Subject: Re: [PATCH for-2.11] block/nfs: fix nfs_client_open for filesize
 greater than 1TB
References: <1511798407-31129-1-git-send-email-pl@kamp.de>
In-Reply-To: <1511798407-31129-1-git-send-email-pl@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-27 17:00, Peter Lieven wrote:
> DIV_ROUND_UP(st.st_size, BDRV_SECTOR_SIZE) was overflowing ret (int) if=

> st.st_size is greater than 1TB.
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  block/nfs.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Thanks, applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--HOPdtp4WvpG87PM7TeSsC4ROBvjrg6AfO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlochPsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Ar+gIAJS6nDsTun0Nh9z0NUicUxWrEY3ZnuUp
4mV2NJnQX7w4cPYsUqeSgcX2DFBmtpDbuGONY9Opv8kq2v8rNbGjiwSDk7XuYo3b
PqvlqY1iShGp+UAFLDWaVxY4AvONuTXMJRbThxh0k+uCVk3hplZjWC/DaInW6RSv
+es+L+yuZWcK1hIo4vwkxkGuaA6vlwpoBaPC3KrYIseAh5mT+rS+eb1ZFuezKrmw
ALF7ahGjuksY4KR5Guw6VT6JTO1xU+s/VPidkEFJALA4cJXT18HHdqNbEfi/0uJn
QZDb+fSrzQXZEZCkpToyuUbCbAEm8uBqbqCFdDuwrHl3a6kWskxaFnU=
=Z1nG
-----END PGP SIGNATURE-----

--HOPdtp4WvpG87PM7TeSsC4ROBvjrg6AfO--
