Received: from eggs.gnu.org ([2001:4830:134:3::10]:33401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cGQdH-0003Aa-2h
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 08:27:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cGQdE-00071u-Ep
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 08:27:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cGQdE-00070P-8V
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 08:27:04 -0500
Date: Mon, 12 Dec 2016 13:27:01 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20161212132701.GB4074@stefanha-x1.localdomain>
References: <20161212111857.23399-1-pbonzini@redhat.com>
	<20161212111857.23399-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline
In-Reply-To: <20161212111857.23399-2-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/11] exec: optimize remaining
 address_space_* cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, mst@redhat.com, borntraeger@de.ibm.com


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 12, 2016 at 12:18:47PM +0100, Paolo Bonzini wrote:
> Do them right before the next patch generalizes them into a multi-included
> file.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  exec.c | 126 +++++++++++++++++++++++++++++++++++++++++++++++++++++------=
------
>  1 file changed, 103 insertions(+), 23 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYTqWlAAoJEJykq7OBq3PIQrIH/i0jJoN7Mi08oeX2uwnfNAj3
cjYjMSNiVHpUumr+n03V5UnBGrGb46TMX5T9xr7MpLnsRM5/+1iwyDFbi3wsiPC+
0iGIpf6Cm8GwnWSI1V/CNBvBQMC5+mdLukFtI15c2EekTbIzqslItnI63aVdGYto
R8E+jP2Os1yHUg1nUtz/hg4afdFHqF81lAv/y71U28Vlc4dCQ3fTaiDbdWNTZE2c
NJ0C5bped1RoBdu2T9rWM8jJ4aQQFErhkTH9xjNQZwrCuaBmWagcB/XA17o45nAz
RdF7ReOoipud+Fvl1kH3H/GZOl+APPppimyu4gbJwdQJtu7syFLDehS7SFgdXm8=
=HXPa
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
