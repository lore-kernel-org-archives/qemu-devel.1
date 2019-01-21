Received: from eggs.gnu.org ([209.51.188.92]:41224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1glX6g-0002pt-30
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:47:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1glX6f-0005Ji-Dt
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:47:06 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:51438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1glX6f-0005Ie-6i
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:47:05 -0500
Received: by mail-wm1-x332.google.com with SMTP id b11so10293571wmj.1
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 02:47:05 -0800 (PST)
Date: Mon, 21 Jan 2019 10:47:02 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190121104702.GF30536@stefanha-x1.localdomain>
References: <20190118173103.4903-1-berrange@redhat.com>
	<20190118173103.4903-3-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jkO+KyKz7TfD21mV"
Content-Disposition: inline
In-Reply-To: <20190118173103.4903-3-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] trace: enforce that every
 trace-events file has a final newline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>


--jkO+KyKz7TfD21mV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 18, 2019 at 05:31:01PM +0000, Daniel P. Berrang=E9 wrote:
> When generating the trace-events-all file, the build system simply
> concatenates all the individual trace-events files. If any one of those
> files does not have a final newline, the printf format string will have
> the contents of the first line of the next file appended to it, which is
> usually a '#' comment.
>=20
> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> ---
>  hw/gpio/trace-events          | 2 +-
>  scripts/tracetool/__init__.py | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--jkO+KyKz7TfD21mV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcRaMmAAoJEJykq7OBq3PI8dIIAIS2qonVx5RIBjHDJuzEQA65
uegstgKWsdxD4148l2IB6AL7YTjP319bTWAe95eWi/R8GJfkHZhqP5BCl1gqf3jB
tHio8oyzsWjpjD2GEgyk29mhlbp0rKT3+nY8Mf0D0ged43vpXcOz9UXOc7uqV/iS
MxPMILW2oDqKt+MWf7ackyjb1qMNT3Il2dHpUDCvaDoMw7JH2/5JQgXwSjIvtCqA
xGWSIub86O6DU4BiSigUeHiG82OXzshypdEMRQfFkvfGGXBMJnWg842wko7rjm8r
0sznlGGEuq6Jy4qC5t21iUZsXdkZMZ7lRqg5ODjC2CHKQ4zIsn40etQRtnINmb0=
=AR1y
-----END PGP SIGNATURE-----

--jkO+KyKz7TfD21mV--
