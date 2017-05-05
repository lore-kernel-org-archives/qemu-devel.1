Received: from eggs.gnu.org ([2001:4830:134:3::10]:47919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6fPe-0004Vh-Dz
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:44:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6fPa-0007s0-DE
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:44:58 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d6fPa-0007rs-5f
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:44:54 -0400
Received: by mail-wm0-x244.google.com with SMTP id u65so2095464wmu.3
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 08:44:54 -0700 (PDT)
Date: Fri, 5 May 2017 16:44:50 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170505154450.GG14316@stefanha-x1.localdomain>
References: <20170504055040.31904-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8S1fMsFYqgBC+BN/"
Content-Disposition: inline
In-Reply-To: <20170504055040.31904-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PULL 0/3] input patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org


--8S1fMsFYqgBC+BN/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2017 at 07:50:37AM +0200, Gerd Hoffmann wrote:
>   Hi,
>=20
> Input patch queue, with a new tracepoint and two bugfixes (one of them
> cve).
>=20
> please pull,
>   Gerd
>=20
> The following changes since commit e619b14746e5d8c0e53061661fd0e1da01fd4d=
60:
>=20
>   Merge remote-tracking branch 'sthibault/tags/samuel-thibault' into stag=
ing (2017-05-02 15:16:29 +0100)
>=20
> are available in the git repository at:
>=20
>   git://git.kraxel.org/qemu tags/pull-input-20170504-1
>=20
> for you to fetch changes up to 2222e0a633070f7f3eafcc9d0e95e7f1a4e6fe36:
>=20
>   input: Add trace event for empty keyboard queue (2017-05-03 14:20:12 +0=
200)
>=20
> ----------------------------------------------------------------
> input: limit kbd queue depth
> input: don't queue delay if paused
> input: Add trace event for empty keyboard queue
>=20
> ----------------------------------------------------------------
> Alexander Graf (1):
>       input: Add trace event for empty keyboard queue
>=20
> Gerd Hoffmann (1):
>       input: limit kbd queue depth
>=20
> Marc-Andr=E9 Lureau (1):
>       input: don't queue delay if paused
>=20
>  hw/input/hid.c        |  4 ++++
>  ui/input.c            | 18 +++++++++++++++---
>  hw/input/trace-events |  1 +
>  3 files changed, 20 insertions(+), 3 deletions(-)
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--8S1fMsFYqgBC+BN/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZDJ3yAAoJEJykq7OBq3PIGbQIAIfdxGXhU7cIs6YY35XI7aKx
kAAD7sJ0PHK0EG52C+eCPBrPm9glV+YtgRXGOyQs8p3LOOLwfC1qjsPluS9+ch4D
mOGvt6GAH4Zc/9RrtT88RQqjiGoun41v4Z+8lMWo1m1UCi8Y7X4CV1eZN6xL+2he
cWN68KiVwnLTjmdPKJgDm5r7TykzOY5dMuBvRH9gBHOpFvk3GzOiVRK6QpgHxTuN
bxN0Fo4hG+SyIhLQY+vhEjgwc+U2Pe/8gW0SpuwxS8xeWCceiPIrxFq4QYSnBu/p
kR7RAmVMdiz0PW1/1hm9O8ZW54/nwSkJmdntzInjekIjP/PyEBogeu5KRC+yc8k=
=fm0Q
-----END PGP SIGNATURE-----

--8S1fMsFYqgBC+BN/--
