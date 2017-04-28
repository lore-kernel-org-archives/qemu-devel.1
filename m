Received: from eggs.gnu.org ([2001:4830:134:3::10]:33033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d47qt-0000Xv-Jn
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:30:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d47qq-0007ir-EV
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:30:35 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d47qq-0007hj-8B
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:30:32 -0400
Received: by mail-wm0-x244.google.com with SMTP id u65so11593115wmu.3
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 08:30:32 -0700 (PDT)
Date: Fri, 28 Apr 2017 16:30:28 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170428153028.GB10286@stefanha-x1.localdomain>
References: <20170427223628.20893-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Content-Disposition: inline
In-Reply-To: <20170427223628.20893-1-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] qmp-shell: add persistent command
 history
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 27, 2017 at 06:36:28PM -0400, John Snow wrote:
> Use the existing readline history function we are utilizing
> to provide persistent command history across instances of qmp-shell.
>=20
> This assists entering debug commands across sessions that may be
> interrupted by QEMU sessions terminating, where the qmp-shell has
> to be relaunched.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>=20
> v3: Hardcoded limit of 1024 lines of history for now,
>     as setting limits in ~/.inputrc does not appear to work (Nir)
>=20
> v2: Adjusted the errors to whine about non-ENOENT errors, but still
>     intercept all errors as non-fatal.
>     Save history atexit() to match bash standard behavior
>=20
>  scripts/qmp/qmp-shell | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZA2AUAAoJEJykq7OBq3PIVdkH/iIqtwZX1xOp5cCW+Pdab5oq
jmPWS/TMpjwwn5jBFigizJoD+6IwBYvy379j/bDFAjLoW/mOoAum6uifGJxjg9Rf
evwvpcDfq/S3xlIensZHOyxsu0MPz534xW03iIBmwjKd6i2LC2IIb/aYw3F3IS7a
xuFY/XWEhQ+2TSOicAX61Gb8dBhF124/e1qBF5KPf4D1ui5gum2N4FJeyYX/LJqm
VZkyZL4O1XhOrHYdZHwa00KeCf2mNJSYTpzj6MsrtsaLZlh3zTFLzKYVBzDTz1sd
AdhnBmP7AtX1h1MJkfDS4Hcz+t3gewEPAm98zYKSLzu4RdL9og3Hy+WGbImkxDo=
=v4L8
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--
