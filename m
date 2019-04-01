Received: from eggs.gnu.org ([209.51.188.92]:33842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hAuZt-0005MM-DG
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 06:54:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hAuZs-00043H-Hx
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 06:54:09 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hAuZs-00042h-7b
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 06:54:08 -0400
Received: by mail-wm1-x342.google.com with SMTP id q16so9875824wmj.3
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 03:54:07 -0700 (PDT)
Date: Mon, 1 Apr 2019 10:07:24 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190401090724.GA643@stefanha-x1.localdomain>
References: <5FF901C1-0AA5-4308-A65C-C448D0A2BA63@oracle.com>
	<20190305172905.GD13806@stefanha-x1.localdomain>
	<2D7F11D0-4A02-4A0F-961D-854240376B17@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <2D7F11D0-4A02-4A0F-961D-854240376B17@oracle.com>
Subject: Re: [Qemu-devel] Following up questions related to QEMU and I/O
 Thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Li <wei.d.li@oracle.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2019 at 08:16:36AM -0700, Wei Li wrote:
> Thanks Stefan for your reply and guidance!
>=20
> We spent some time on exploring the multiple I/O Threads approach per you=
r feedback. Based on the perf measurement data, we did see some IOPS improv=
ement for multiple volumes, which is great. :)
>=20
> In addition, IOPS for single Volume will still be a bottleneck, it seems =
like multiqueue block layer feature which Paolo is working on may be able t=
o help improving the IOPS for single volume.
>=20
> @Paolo, @Stefan,=20
> Would you mind sharing the multiqueue feature code branch with us? So tha=
t we could get some rough idea about this feature and maybe start doing som=
e exploration?=20

Paolo last worked on this code, so he may be able to send you a link.

Stefan

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcodTMAAoJEJykq7OBq3PI9E4H/jxWgrKtvSl0eqCWSf5Ge5Nv
n5+P0r/Xe44nyiP70gk43IQHtr12HYPx2VakqHIPtPiVDiSCaUnl1SP/GuMeSjr0
KkHdJB8Us1Enem1eirRMukWkE3QH5Mpc/ZQbTJBuppQ5iu6GJxTXIBJDGhKrOiq2
k/d3qZqiwCfu5V/MozvYoShe6s+xWnzBoUgf4K2LfjaPdBKvRUEuyoSC+iC3knjD
7rdCP1zjLWl+X4OCebcudZbJguvmnM45nlQpFHz7xRgsdsPSiQpoy6DYxwEJ/PeG
nClD/9SP0b0+OKCz3NkZDUw6E0346hcmOOifYMyzeBksBjPsUbEiKF4TdUmyOZQ=
=80a3
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
