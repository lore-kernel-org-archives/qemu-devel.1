Received: from eggs.gnu.org ([2001:4830:134:3::10]:50445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fIEUt-0003Nx-Ci
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:30:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fIEUq-0000ex-Aa
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:30:43 -0400
Date: Mon, 14 May 2018 15:30:37 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180514143037.GQ5182@stefanha-x1.localdomain>
References: <20180511222052.8734-1-ehabkost@redhat.com>
	<20180511222052.8734-11-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GTGEtWEe6jD60dxL"
Content-Disposition: inline
In-Reply-To: <20180511222052.8734-11-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC 10/10] python: futurize -f
 lib2to3.fixes.fix_numliterals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>


--GTGEtWEe6jD60dxL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 11, 2018 at 07:20:52PM -0300, Eduardo Habkost wrote:
> Convert octal literals into the new syntax.
>=20
> This is necessary for Python 3 compatibility.
>=20
> Done using:
>=20
>   $ py=3D$( (g grep -l -E '^#!.*python';find -name '*.py' -printf '%P\n';=
) | \
>     sort -u | grep -v README.sh4)
>   $ futurize -w -f lib2to3.fixes.fix_numliterals $py
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  scripts/qmp/qom-fuse   |  6 +++---
>  tests/qemu-iotests/118 | 24 ++++++++++++------------
>  2 files changed, 15 insertions(+), 15 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--GTGEtWEe6jD60dxL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa+Z2NAAoJEJykq7OBq3PIjFwH/3jJJNm3HaeM0UNPVD1a91vS
13v7NNm02WlbaGlJWEh3Mzf0LQY1W7ZeznsYB+uE2j89eWqU7U1b9FuSNX04Bg4C
EkxtY3Kuhrmzcg9cTvl1fLXMbenolGYxJhYtIFiAOHZ3X+YRFWP50ry9QbKEM04i
wdQ9/N4CHaHCtNJfXmmxJoRsRfkKm6BOIVz8sCJLb+/gULotXABv9RZ5yoU63Iv6
x079HFaqNkSNlcqDHyVbCAi3SN+ZbymoHwluYhJFdsbpY4LClu/hjSbAa/Ao2mZI
cuJFjum/+Y2S3xnHX7ZNaxoVGGg/cnjDi7QmfLQYG0LFWQ9KoMdhDspkCGPQa30=
=PC1f
-----END PGP SIGNATURE-----

--GTGEtWEe6jD60dxL--
