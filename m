Received: from eggs.gnu.org ([209.51.188.92]:49071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gz0wQ-0000gj-1c
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 10:16:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gz0wK-0001oc-Od
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 10:16:14 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gz0wJ-0001eS-1d
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 10:16:08 -0500
Received: by mail-wm1-x343.google.com with SMTP id x7so6188472wmj.0
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 07:15:37 -0800 (PST)
Date: Wed, 27 Feb 2019 15:15:35 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190227151535.GE22539@stefanha-x1.localdomain>
References: <20190222153254.22739-1-stefanha@redhat.com>
	<87imx8uu99.fsf@dusky.pond.sub.org>
	<20190225092846.GA4757@angien.pipo.sk>
	<20190225174001.GI379@stefanha-x1.localdomain>
	<87a7iincg0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C94crkcyjafcjHxo"
Content-Disposition: inline
In-Reply-To: <87a7iincg0.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH] qmp: add query-qemu-capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org


--C94crkcyjafcjHxo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 26, 2019 at 10:09:19AM +0100, Markus Armbruster wrote:
> Stefan Hajnoczi <stefanha@redhat.com> writes:
> > On Mon, Feb 25, 2019 at 10:28:46AM +0100, Peter Krempa wrote:
> >> On Mon, Feb 25, 2019 at 09:50:26 +0100, Markus Armbruster wrote:
> >> > Stefan Hajnoczi <stefanha@redhat.com> writes:
> >> Other than the above, this is a welcome improvement as I've personally
> >> ran into scenarios where a feature in qemu was fixed but it was
> >> impossible to detect whether given qemu version contains the fix as it
> >> did not have any influence on the QMP schema.
> >
> > I'd like to make things as simpler as possible, but no simpler :).
> >
> > The simplest option is that the advertised features are set in stone at
> > build time (e.g. selected with #ifdef if necessary).  But then we have
> > no way of selecting features at runtime (e.g. based on kernel features).
> >
> > What do you think?
>=20
> I think we should map the problem space, identify cases with actual
> uses, then design a solution that covers them and can plausibly grow to
> cover cases we anticipate.
>=20
> The migrate-with-cache-direct-off-on-linux case is compile-time static.
>=20
> Do we have or have we had a case that is not compile-time static?

I can't think of something that both requires query-qemu-features and
isn't compile-time static.  But that could be because not many things
require query-qemu-features :).

The philosophy on Linux seems to be: distros compile QEMU against
headers that accurately reflect the system features that are available.
Therefore there isn't a lot of runtime fallback logic in case a new QEMU
is running on an old host.  This means we can get by with compile-time
static features only.

One possible exception is the ENOSYS/ENOTSUP fallback code in
block/file-posix.c:handle_aiocb_write_zeroes() and
handle_aiocb_copy_range().

Stefan

--C94crkcyjafcjHxo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcdqmWAAoJEJykq7OBq3PIsboH/jYRSoVSOZdr9BK+/A7XSq0w
pQCDrHuYi/+f2S4q2sWpBDnSdORomECiKZLa98lvnA0mhKD95Yzw4ePBteuRb2jj
EVyj2CKZ9gM+8uy0SkIPnCGvACyv18hsKl9T+An1eKDL8dlgW+YRSu6HazdgaQWc
PzX5ksWEu8GNzuVo406PQkpfvuTh/V8SWTnuqpiV0dJ5ZQPvc319Ge5A26dEgKpJ
8f6AOr+StaAs1tvKKQQGlVBUhtuOvIAPlbBs5aKhf3omwEgj99txlnfb8R0yCcwc
488dkDFZfnXARsijk70uXCm6wNjPHZD+XR2XbC0HD0KwePxZtOP0zz+e/HcywzE=
=D32B
-----END PGP SIGNATURE-----

--C94crkcyjafcjHxo--
