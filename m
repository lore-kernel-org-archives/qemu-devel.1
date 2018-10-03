Received: from eggs.gnu.org ([2001:4830:134:3::10]:39979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1g7iH9-0004bD-HL
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:37:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1g7iH2-0000im-Py
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:37:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1g7iH0-0000ew-Nr
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:37:12 -0400
Date: Wed, 3 Oct 2018 15:37:01 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181003143701.GB3012@stefanha-x1.localdomain>
References: <20180827184103.32190-1-jusual@mail.ru>
	<20180827184103.32190-3-jusual@mail.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Content-Disposition: inline
In-Reply-To: <20180827184103.32190-3-jusual@mail.ru>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] tests/test-char: Check websocket
 chardev functionality
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: qemu-devel@nongnu.org, Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Steffen =?iso-8859-1?Q?G=F6rtz?= <mail@steffen-goertz.de>


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 27, 2018 at 09:41:03PM +0300, Julia Suvorova wrote:
> Test order:
>     Creating server websocket chardev
>     Creating usual tcp chardev client
>     Sending handshake message from client
>     Receiving handshake reply
>     Sending ping frame with "hello" payload
>     Receiving pong reply
>     Sending binary data "world"
>     Checking the received data on server side
>     Checking of closing handshake
>=20
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
>  tests/test-char.c | 125 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 125 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbtNQNAAoJEJykq7OBq3PIOdUH/jgFglptPakt3h2/QC+uYTgQ
cLlBFiO7NyuZnXdhLADGnKBjCDuHJ4qQb46Asnd7w8y87yFVrCXFxj7tLfTqb5uF
U1RPkC+dLfQUaYFF5wScFKdKNCDW4l0mLtiImblAkZaMrkgmXo5RkTkMDinghrRX
3/Qaj002GtoW7RYZnZTNHKjBeYtppCgVWwpUC3oeNCRtM3oWAoQ+QTpZuqqmPkMB
b662ZUggmK0+BhOHT0P0AVaEwUZAXlKiQKg1HKi8y0mMSdDhkGGwBDrGww5gTHnv
nihf5irwXT2d1WAKyrbs7Vu3zbqc7NiuhzVZqe7GcVA1eyckS3rWPCbd1Qh7TAs=
=x+XT
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--
