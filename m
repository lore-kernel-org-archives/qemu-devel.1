Received: from eggs.gnu.org ([2001:4830:134:3::10]:52417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6fdq-0001o0-70
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:59:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6fdn-0004sa-06
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:59:38 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36231)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d6fdm-0004s1-PN
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:59:34 -0400
Received: by mail-wm0-x244.google.com with SMTP id u65so2175912wmu.3
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 08:59:34 -0700 (PDT)
Date: Fri, 5 May 2017 16:59:31 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170505155931.GJ14316@stefanha-x1.localdomain>
References: <20170504104806.8120-1-cornelia.huck@de.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DesjdUuHQDwS2t4N"
Content-Disposition: inline
In-Reply-To: <20170504104806.8120-1-cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PULL 0/8] s390x: basic 3270 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: peter.maydell@linaro.org, borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org


--DesjdUuHQDwS2t4N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2017 at 12:47:58PM +0200, Cornelia Huck wrote:
> [This should not conflict with the outstanding s390x pull request
> which deals with LOADPARM and booting.]
>=20
> The following changes since commit e619b14746e5d8c0e53061661fd0e1da01fd4d=
60:
>=20
>   Merge remote-tracking branch 'sthibault/tags/samuel-thibault' into stag=
ing (2017-05-02 15:16:29 +0100)
>=20
> are available in the git repository at:
>=20
>   git://github.com/cohuck/qemu tags/s390x-3270-20170504
>=20
> for you to fetch changes up to 9e8b3009b7dbe4c2f3e407999e30813122fa4af9:
>=20
>   s390x/3270: Mark non-migratable and enable the device (2017-05-04 10:34=
:37 +0200)
>=20
> ----------------------------------------------------------------
> Basic support for using channel-attached 3270 'green-screen'
> devices via tn3270. Actual handling of the data stream is
> delegated to x3270; more info at http://wiki.qemu.org/Features/3270
>=20
> ----------------------------------------------------------------
>=20
> Jing Liu (6):
>   chardev: Basic support for TN3270
>   s390x/css: Add an algorithm to find a free chpid
>   s390x/3270: 3270 data stream handling
>   s390x/3270: Add the TCP socket events handler for 3270
>   s390x/3270: Detect for continued presence of a 3270 client
>   s390x/3270: Mark non-migratable and enable the device
>=20
> Yang Chen (2):
>   s390x/3270: Add abstract emulated ccw-attached 3270 device
>   s390x/3270: Add emulated terminal3270 device
>=20
>  chardev/char-socket.c             |  76 +++++++---
>  chardev/char.c                    |  11 +-
>  default-configs/s390x-softmmu.mak |   1 +
>  hw/char/Makefile.objs             |   1 +
>  hw/char/terminal3270.c            | 293 ++++++++++++++++++++++++++++++++=
++++++
>  hw/s390x/3270-ccw.c               | 174 ++++++++++++++++++++++
>  hw/s390x/Makefile.objs            |   1 +
>  hw/s390x/css.c                    |  24 ++++
>  include/hw/s390x/3270-ccw.h       |  53 +++++++
>  include/hw/s390x/css.h            |   2 +
>  include/sysemu/char.h             |   8 ++
>  qapi-schema.json                  |   3 +
>  12 files changed, 625 insertions(+), 22 deletions(-)
>  create mode 100644 hw/char/terminal3270.c
>  create mode 100644 hw/s390x/3270-ccw.c
>  create mode 100644 include/hw/s390x/3270-ccw.h
>=20
> --=20
> 2.11.0
>=20
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--DesjdUuHQDwS2t4N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZDKFjAAoJEJykq7OBq3PIKz0H/2zWGAp52VjD2jYsQ44oqRl9
vq4ATCcSKm87+Xzgg5mcsTIqWXbqhJGYtBsZ07jKm0omyLfMqovJCORGdiiKO0Jz
BeFFqSwkX0ig3FnsgFx7ZfWwENaJcwUouo7ozuvBGSS3graqvcq6o8AqjwhcQJh4
Nn+SPJIqCjAm0rJ9Nlzas7IjzBLdOuE9znIMXwjC5mNWqCrRsQTSufEi+v9xkel0
YGYkG3AR45E6s7aUrb+JNov2PqrkYlYXa0yfI8c6whHFnKAT68RimGuN73OC32/r
nqHEET1PEjINZz7ySTzl79ukbXgGt1E4+VApsoqTCV3vPeuDYVK1tyExDn2iYCI=
=FtIM
-----END PGP SIGNATURE-----

--DesjdUuHQDwS2t4N--
