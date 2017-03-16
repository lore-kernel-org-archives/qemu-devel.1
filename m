Received: from eggs.gnu.org ([2001:4830:134:3::10]:52384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1coK41-0002ZE-AE
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 21:18:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1coK3x-0007j0-AR
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 21:18:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9975)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1coK3x-0007il-23
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 21:18:45 -0400
References: <20170315092940.1367-1-stefanha@redhat.com>
	<20170315092940.1367-4-stefanha@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a04f6be2-710a-4f12-b2da-1c631670a236@redhat.com>
Date: Thu, 16 Mar 2017 02:18:36 +0100
MIME-Version: 1.0
In-Reply-To: <20170315092940.1367-4-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Pckc4dpfHq6xvpUGwhiX58dqkxXQmHsqn"
Subject: Re: [Qemu-devel] [RFC v2 3/8] qcow2: extract preallocation
 calculation function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Nir Soffer <nsoffer@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Pckc4dpfHq6xvpUGwhiX58dqkxXQmHsqn
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Nir Soffer <nsoffer@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>,
 Alberto Garcia <berto@igalia.com>
Message-ID: <a04f6be2-710a-4f12-b2da-1c631670a236@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 3/8] qcow2: extract preallocation
 calculation function
References: <20170315092940.1367-1-stefanha@redhat.com>
 <20170315092940.1367-4-stefanha@redhat.com>
In-Reply-To: <20170315092940.1367-4-stefanha@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 15.03.2017 10:29, Stefan Hajnoczi wrote:
> Calculating the preallocated image size will be needed to implement
> .bdrv_measure().  Extract the code out into a separate function.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/qcow2.c | 134 +++++++++++++++++++++++++++++++++-----------------=
--------
>  1 file changed, 76 insertions(+), 58 deletions(-)

So let's see whether it will be this or
http://lists.nongnu.org/archive/html/qemu-block/2017-03/msg00342.html
that lands first! ;-)

Max


--Pckc4dpfHq6xvpUGwhiX58dqkxXQmHsqn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljJ5+wSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ApXIIAJtIK1lGDuwq020YNuOlheu/9JSaPtBi
cDlJ3LNwQG2M+Y+1ksD4eg9+iH/pi+TRRKVauup4UvwAHLFqfWqvguNj3e4l6rAs
rwl6nHaToJsTDH5ugiWsCCg3TMTrBl3bzFS0EoQEMO9AQSdP9Wf9FABFi2GmWsrS
xvsw/8+4p/z4uWBRh4bVfdPbuH2DmaYUkQA0BoOClizI85Wv2FzrONJM1ITNjUus
6SIfoNnDa0vgWDdd0I3qPPiCIo9izTfMhAF+c1lo0Y526ktGB3vzAZq2OodRLMQB
LOi6h8Lu1eSevzeN4d4Y1yZ4Ga4s1t11RhhBneHfg9w6oaOt0Txx4aY=
=jX4y
-----END PGP SIGNATURE-----

--Pckc4dpfHq6xvpUGwhiX58dqkxXQmHsqn--
