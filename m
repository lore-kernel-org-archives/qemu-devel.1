Received: from eggs.gnu.org ([209.51.188.92]:37143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gmyej-0004Nq-Sb
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:24:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gmyei-0004YU-V7
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:24:13 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36237)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gmyei-0004Y6-LD
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:24:12 -0500
Received: by mail-wm1-x343.google.com with SMTP id p6so6086463wmc.1
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 02:24:12 -0800 (PST)
Date: Fri, 25 Jan 2019 10:24:09 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190125102409.GA28305@stefanha-x1.localdomain>
References: <20190124125154.474650-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <20190124125154.474650-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] trace: improve runstate tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, stefanha@redhat.com


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 24, 2019 at 03:51:54PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Trace previous state, move tracepoint to runstate_set start (to cover
> all cases for debugging), add string representations of traced states.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  vl.c         | 7 +++++--
>  trace-events | 4 ++--
>  2 files changed, 7 insertions(+), 4 deletions(-)

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcSuPJAAoJEJykq7OBq3PINzgH/RHwJ6bHBe1eC7+O9L9npY9K
eze+KwPp6oMn3/L0qDYt7MqVw/I67VVb7RrZkYacQFXXHBaWlr0xJZ32Bf5GwOuf
5nVYuSyvOJdo/cGt3FlaEgL8EAnn8I1vJPrOU+Zqdp6Vvrpm+j/iG4ckwaiFwhjQ
wwVDtP2JXFXol6aqhwpIweRH6yc3CsFIYswSsN2xM7jJMELwQVOWzwHaMr/iPEUa
IuALP+oudlxSq+EruuaHB1saEr2KeyKh4r5C7p1FSD0kcOBxwzDzZO/MJZTzMktK
rXgko10/RAYhoXnm0vBLY5LDe4sKxRYHGPKXVeBI2ktVa0BlBERfOsEfa7EmybY=
=9rSE
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
