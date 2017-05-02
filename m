Received: from eggs.gnu.org ([2001:4830:134:3::10]:44517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d5Ybi-0003o8-1G
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d5Ybe-00016r-PH
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:16:49 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36530)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d5Ybe-00016X-IA
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:16:46 -0400
Received: by mail-wm0-x242.google.com with SMTP id u65so4889402wmu.3
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 07:16:46 -0700 (PDT)
Date: Tue, 2 May 2017 15:16:43 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170502141643.GH22502@stefanha-x1.localdomain>
References: <20170429164750.17414-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82evfD9Ogz2JrdWZ"
Content-Disposition: inline
In-Reply-To: <20170429164750.17414-1-samuel.thibault@ens-lyon.org>
Subject: Re: [Qemu-devel] [PULL 0/9] slirp updates
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


--82evfD9Ogz2JrdWZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 29, 2017 at 06:47:41PM +0200, Samuel Thibault wrote:
> The following changes since commit 81b2d5ceb0cfb4cdc2163492e3169ed714b0cd=
a9:
>=20
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20170426' into =
staging (2017-04-26 20:50:49 +0100)
>=20
> are available in the git repository at:
>=20
>   http://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>=20
> for you to fetch changes up to eb5d4f5329df83ea15244b47f7fbca21adaae41b:
>=20
>   slirp: VMStatify remaining except for loop (2017-04-29 18:44:16 +0200)
>=20
> ----------------------------------------------------------------
> slirp updates
>=20
> ----------------------------------------------------------------
> Dr. David Alan Gilbert (6):
>       slirp/smb: Replace constant strings by glib string
>       slirp: VMState conversion; tcpcb
>       slirp: VMStatify sbuf
>       slirp: Common lhost/fhost union
>       slirp: VMStatify socket level
>       slirp: VMStatify remaining except for loop
>=20
> Marc-Andr=E9 Lureau (1):
>       slirp: tftp, copy sockaddr_size
>=20
> Samuel Thibault (1):
>       slirp: fix pinging the virtual ipv4 DNS server
>=20
> Vincent Bernat (1):
>       slirp: allow host port 0 for hostfwd
>=20
>  net/slirp.c     |  32 ++--
>  slirp/ip_icmp.c |   5 +-
>  slirp/sbuf.h    |   4 +-
>  slirp/slirp.c   | 494 +++++++++++++++++++++++++++++++-------------------=
------
>  slirp/socket.h  |  24 ++-
>  slirp/tcp_var.h |   6 +-
>  slirp/tftp.c    |   2 +-
>  7 files changed, 310 insertions(+), 257 deletions(-)
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--82evfD9Ogz2JrdWZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZCJTLAAoJEJykq7OBq3PIWckIAKzE2+m+hbsUdGtu/nRZUGcI
YxTM2ir9RXW8HF35OWNPERqePN4WMYQFy0ceU9iQhr+QtvhMJLEbUh+rYKlcV4dL
qWwhYfZpXArS2rjH6ty+2MRQkYPv9Mj/RYNRqpEOVA0Y+z96VUJ7CY2PQNYXbLzt
kNzpUDDaJwyDOTElS4RETfThj7XNeybb3Q3Qy5vdoLflF5FhAauXUyJgblfF01BL
MyutNZKRcGpVtGdf5LPqY/kKp3fDY6dkcBdiZ3uJqdB3Vb8MRY0px2n45hRsI8da
3KykQZSkyg281UzwsgjIGgAkQ4aPPKMBTGtOwt08cuq6afLVWYWZupuv/q16vjA=
=qhtu
-----END PGP SIGNATURE-----

--82evfD9Ogz2JrdWZ--
