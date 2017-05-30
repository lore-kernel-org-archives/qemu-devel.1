Received: from eggs.gnu.org ([2001:4830:134:3::10]:41565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFdTC-0001ya-RZ
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:29:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFdT8-0006Gm-Vn
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:29:42 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:32970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dFdT8-0006GK-Oz
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:29:38 -0400
Received: by mail-wm0-x242.google.com with SMTP id b84so23781570wmh.0
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 02:29:38 -0700 (PDT)
Date: Tue, 30 May 2017 10:29:35 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170530092935.GJ11362@stefanha-x1.localdomain>
References: <20170527214618.32626-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RUqJLqMNe5u4kDWT"
Content-Disposition: inline
In-Reply-To: <20170527214618.32626-1-samuel.thibault@ens-lyon.org>
Subject: Re: [Qemu-devel] [PULL 0/3] slirp updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, jan.kiszka@siemens.com


--RUqJLqMNe5u4kDWT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 27, 2017 at 11:46:15PM +0200, Samuel Thibault wrote:
> The following changes since commit 9964e96dc9999cf7f7c936ee854a795415d19b=
60:
>=20
>   Merge remote-tracking branch 'jasowang/tags/net-pull-request' into stag=
ing (2017-05-23 15:01:31 +0100)
>=20
> are available in the git repository at:
>=20
>   http://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>=20
> for you to fetch changes up to 2e30230aa95a2d6cfaadac015bd96c3db19c45e4:
>=20
>   Fix total IP header length in forwarded TCP packets (2017-05-27 23:35:0=
0 +0200)
>=20
> ----------------------------------------------------------------
> slirp updates
>=20
> ----------------------------------------------------------------
> Marc-Andr=E9 Lureau (1):
>       slirp: fix leak
>=20
> Sjors Gielen (1):
>       Fix total IP header length in forwarded TCP packets
>=20
> Tao Wu (1):
>       slirp: Fix wrong mss bug.
>=20
>  slirp/socket.c    | 3 +++
>  slirp/tcp_input.c | 4 ++--
>  slirp/tcp_subr.c  | 4 ++--
>  3 files changed, 7 insertions(+), 4 deletions(-)
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--RUqJLqMNe5u4kDWT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLTt/AAoJEJykq7OBq3PIT6AH/3QLb/P7kXUfBoT5X4aEiaRx
9IoR4lO2em+eZwM9mmu/edXqf/sWd+bvrNwitcLzKub/2qeySxjv5zvssnUtmos9
1CLemiQ8vrRCurNg2Zlg7TW0e1Xt5qxOqqkerY0hm8e0DAaDJ3w0fXIJ45EbWSSr
m+7+cMptgpS0U7jBcB4ktb7lyDSss8eyLZZoAJo5F45Z7esxzN6gmBMRcmsjEG7N
UiCx6j33uCxwTwuzB7B+7H+HH0UIhABn+6jtRU6OVH0EFyYV3/PIg/xrYDbeT7zI
oXJ/9X/R7rjRSKMy+2L/xIJ1iSn0cupXzBhBjZDugprl72MfBZQGc3PX4nxl/PI=
=Woo7
-----END PGP SIGNATURE-----

--RUqJLqMNe5u4kDWT--
