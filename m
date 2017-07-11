Received: from eggs.gnu.org ([2001:4830:134:3::10]:48643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUvKe-0001GE-Vi
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:36:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUvKb-0002bb-6B
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:36:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dUvKb-0002b4-00
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:36:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ED2FF158AA0
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 13:35:59 +0000 (UTC)
Date: Tue, 11 Jul 2017 14:35:54 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170711133554.GT17792@stefanha-x1.localdomain>
References: <20170710072027.7948-1-famz@redhat.com>
	<20170710072027.7948-3-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TJ9V72hR/LoebVea"
Content-Disposition: inline
In-Reply-To: <20170710072027.7948-3-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 2/5] iothread: Don't error on windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com


--TJ9V72hR/LoebVea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2017 at 03:20:24PM +0800, Fam Zheng wrote:
> aio_context_set_poll_params is called unconditionally from iothread
> initialization code and the contract is that if max_ns =3D=3D 0 polling is
> disabled, or otherwise windows reports and error. The current default
> being non-zero will always make win32 to exit on an "-object iothread"
> option, which is not nice.
>=20
> Default to zero on windows and keep going.
>=20
> (While we are at it, move the definition to the header, because it will
> be shared with iothread-group.)
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  include/sysemu/iothread.h | 12 ++++++++++++
>  iothread.c                |  6 ------
>  util/aio-win32.c          |  4 +++-
>  3 files changed, 15 insertions(+), 7 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--TJ9V72hR/LoebVea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZNQ6AAoJEJykq7OBq3PIfGMH/izikr+hHb9VIQN9MhU1av08
qRShR+IDrbPcbI2FnUT7BVGEZ2xRgNz1TfVP3wkN6t18l2D2uhuXWmat8jvSEXZn
gSEicKnd752KafXoQD7xJpvfUUpk41bxjzXM8B4NBc3gF0wGDkcQQy9zcOBCG0Z8
+VWNFewaA3dl8KJsztXG6x0BQn//yzfemFktbupOfpq4M0SK3HjCU6abjYHiuFkA
gGlYtKcz5y1eK0XekxIkt+MvfHoFXrR6/Xe+FN1cnjRrwh8otK5l8ZfnSVxzvaci
jf7aX9f35Tcxv5kD4YUn5vd8hwSYz4phGJTEfE826/1IpAN0RlP8n54inX3kvEY=
=DnIi
-----END PGP SIGNATURE-----

--TJ9V72hR/LoebVea--
