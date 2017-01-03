Received: from eggs.gnu.org ([2001:4830:134:3::10]:48727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cOS0W-0006he-Rf
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 11:32:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cOS0S-0006cO-TA
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 11:32:16 -0500
Date: Tue, 3 Jan 2017 16:32:09 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170103163209.GJ14707@stefanha-x1.localdomain>
References: <1483263585-8101-1-git-send-email-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cDtQGJ/EJIRf/Cpq"
Content-Disposition: inline
In-Reply-To: <1483263585-8101-1-git-send-email-hpoussin@reactos.org>
Subject: Re: [Qemu-devel] [PATCH] ui/gtk: fix crash at startup when no
 console is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Weil <sw@weilnetz.de>, qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>


--cDtQGJ/EJIRf/Cpq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 01, 2017 at 10:39:45AM +0100, Herv=E9 Poussineau wrote:
> This patch fixes a segfault at QEMU startup, introduced in a08156321ab9a7=
d2fed9ee77dbfeea2a61ffd153.
> gd_vc_find_current() return NULL, which is dereferenced without checking =
it.
>=20
> While at it, disable the whole 'View' menu if no console exists.
>=20
> Reproducer: qemu-system-i386 -M none -nodefaults
>=20
> Signed-off-by: Herv=E9 Poussineau <hpoussin@reactos.org>
> ---
>  ui/gtk.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Oops, sorry!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--cDtQGJ/EJIRf/Cpq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYa9IJAAoJEJykq7OBq3PIQPcH/0yUqvVvSbeh/YznGjSrcMXB
7ZzMT0hX0a6EgJ+AxUU7c3DkaQHfMX/RkzuaC6N3/YWpkYfMxoB04oLWWx5PVI9K
zyK4MC4OaT3OLNxmqsOEyDkAKJMrcPlIjyQEEmyTXy61L5P0Exwz6/tG9b8wJ3I+
fJKpQWkIrBafCwZEdiiAxTtGa5eHr8Ob3BbahW/ppNWtc486HhD2/cofr22MA52d
dsIzvo9RGnEDSM5ZQ4Ptot+Shxqr8ARKyXuThEgbXVacf0dzKy0dJZJbwYPHHLas
mNl4FtOGuszQjQVVRMBTwSJ6NdmHAQdQqcoJbmpbR9D4LPE/2Q873N0ZBYMGZpQ=
=JEIO
-----END PGP SIGNATURE-----

--cDtQGJ/EJIRf/Cpq--
