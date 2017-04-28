Received: from eggs.gnu.org ([2001:4830:134:3::10]:36536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d47zp-0004G6-Op
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:39:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d47zm-0004o8-LE
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:39:49 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d47zm-0004nk-EK
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:39:46 -0400
Received: by mail-wm0-x243.google.com with SMTP id y10so11681283wmh.0
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 08:39:46 -0700 (PDT)
Date: Fri, 28 Apr 2017 16:39:43 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170428153943.GC10286@stefanha-x1.localdomain>
References: <20170428122444.23361-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pk6IbRAofICFmK5e"
Content-Disposition: inline
In-Reply-To: <20170428122444.23361-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] (RFC) remove the GThread coroutine
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>


--Pk6IbRAofICFmK5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 28, 2017 at 01:24:43PM +0100, Daniel P. Berrange wrote:
> At the 2016 summit it was suggested that we delete the GThread
> coroutine impl since it is not fully functional, and you can
> debug the ucontext impl with our GDB helper script.
>=20
> I don't recall the subject being raised again since the summit
> so here's a proposal to delete the GThread impl, as a way to
> trigger input from anyone who thinks we need to keep it......
>=20
> Daniel P. Berrange (1):
>   coroutine: remove GThread implementation
>=20
>  .travis.yml              |   5 +-
>  configure                |  19 ++---
>  util/coroutine-gthread.c | 198 -----------------------------------------=
------
>  3 files changed, 6 insertions(+), 216 deletions(-)
>  delete mode 100644 util/coroutine-gthread.c

Happy to merge this but waiting in case anyone wants to discuss it.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Pk6IbRAofICFmK5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZA2I/AAoJEJykq7OBq3PIDmMH/RFblepNs4th9dvM5DP3iQ6U
CGIW8IOYaMDBTa1axVvdXvHZk/L6xBqvTIqIiRN9k8eMCxrw9puGBi59zA9BAxp5
3zSFdFtrgK/FwbWAEqYmhCh83Mj9lJWVH516XxJWFxLLNUpEmcDxkjeJFqhlQZ1G
+iMz0/tr/vEmcvQgaz8urweRKnIcHBZ+lwMOAgy6NadgqiikvB3nqomeOhyQ/J0k
ihvkL9q51BvGYbeF7OcA5uwmqmBH1G1TTQwjJvtpEcBY5r/bF/NboEFuW5LIJzjw
x/KQPWGrWSwEjavxOv6UrO2VfbrWsEwNnlnTezRmeRfuIlsp9GD79B8kjwJQZ34=
=yKoX
-----END PGP SIGNATURE-----

--Pk6IbRAofICFmK5e--
