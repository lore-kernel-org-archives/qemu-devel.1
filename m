Received: from eggs.gnu.org ([2001:4830:134:3::10]:50182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etxM9-00021c-MQ
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:21:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etxM6-0002hR-HP
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:21:21 -0500
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:45091)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1etxM6-0002h1-8m
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:21:18 -0500
Received: by mail-wr0-x231.google.com with SMTP id p104so6032905wrc.12
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 07:21:18 -0800 (PST)
Date: Thu, 8 Mar 2018 15:21:15 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180308152115.GB2769@stefanha-x1.localdomain>
References: <20180306154650.24075-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
In-Reply-To: <20180306154650.24075-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] trace: include filename when printing
 parser error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 06, 2018 at 03:46:50PM +0000, Daniel P. Berrang=E9 wrote:
> Improves error messages from:
>=20
>   ValueError: Error on line 72: need more than 1 value to unpack
>=20
> To
>=20
>   ValueError: Error at /home/berrange/src/virt/qemu/trace-events:72:
>     need more than 1 value to unpack
>=20
> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> ---
>  scripts/simpletrace.py        | 4 ++--
>  scripts/tracetool.py          | 2 +-
>  scripts/tracetool/__init__.py | 6 ++++--
>  3 files changed, 7 insertions(+), 5 deletions(-)

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaoVTqAAoJEJykq7OBq3PIZjAH/itMd3AbKb29DPr6MYk7q2Pg
epJeVY5BcAJ7B+SCTmb2u34zHBpaguo1RTr1xbRaEfSnY1EQ4qQsMplWyPFc3HwU
d+R/NnwD864UctBoGOWRXUqIwgyTP4BcRY0vl9cOSoEtdW77Xjvf1+SFekBxFW6B
htq5gtf0eJWvCyJ2QUSVRYdR579rtlgaDa/PSp0pOSDcQOH/6IRIzKGfFATmn35k
H9HI5Ny7hBET0l+p7qyW3g7kCSdK+pX9HbP90vYsnVaX4TWNLUUGDXPzWlhMvOon
GC1iAfAqfO+5AXjALPGR7UJu5y55JE1JAXmdSGN48EEawjaDs6kF+ltCoQ1kExE=
=HLSU
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
