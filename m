Received: from eggs.gnu.org ([2001:4830:134:3::10]:60492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cso3E-0004x2-8n
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 06:08:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cso3D-0003lO-9N
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 06:08:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cso3D-0003l9-3z
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 06:08:31 -0400
Date: Tue, 28 Mar 2017 11:08:28 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170328100828.GG26523@stefanha-x1.localdomain>
References: <20170327131718.18268-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aYDVKSzuImP48n7V"
Content-Disposition: inline
In-Reply-To: <20170327131718.18268-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] trace: fix tcg tracing build breakage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Emilio G . Cota" <cota@braap.org>, "Daniel P . Berrange" <berrange@redhat.com>, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>


--aYDVKSzuImP48n7V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 27, 2017 at 02:17:18PM +0100, Stefan Hajnoczi wrote:
> Commit 0ab8ed18a6fe98bfc82705b0f041fbf2a8ca5b60 ("trace: switch to
> modular code generation for sub-directories") forgot to convert "tcg"
> trace events to the modular code generation approach where each
> sub-directory has its own trace-events file.
>=20
> This patch fixes compilation for "tcg" trace events.  Currently they are
> only used in the root ./trace-events file.
>=20
> "tcg" trace events can only be used in the root ./trace-events file for
> the time being.
>=20
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Suggested-by: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  docs/tracing.txt                         |  3 +++
>  trace/Makefile.objs                      | 16 ++++++++--------
>  scripts/tracetool/format/tcg_h.py        |  1 +
>  scripts/tracetool/format/tcg_helper_c.py |  1 +
>  4 files changed, 13 insertions(+), 8 deletions(-)

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--aYDVKSzuImP48n7V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY2jYcAAoJEJykq7OBq3PID20H/2rQhT5eGv5jyeKq4W7xUvE5
8/DMeaqPeqnXeuZTSaJ4sd0YE3FjfZRdO53z46Bq4OwSvaa8vW7NpX8vaR2LDwIQ
JVEDdnTsajeJ5XOOSiTz2PiwCM5K9091HbSIhgawO2P/Gr37RW0YweVY56KdHUZ3
sFTvzfgRqs7iY9VuP6m9BsICEaFhgqP2GEGHTseoWd/bUgrYQbyTIou8ccqLfE30
ztshuyasMukfoTc6b1COBbwO8wvPH2e13gU+7HM+FVbwU+9UeQqgIJqBMQDee9po
wnnSD28jGlc9XJPiqithLjHTPYUsCNqd/0Gb2zqD/BelVQS80dZhFEbPUEBUdh8=
=tPv1
-----END PGP SIGNATURE-----

--aYDVKSzuImP48n7V--
