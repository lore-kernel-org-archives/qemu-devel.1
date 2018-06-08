Received: from eggs.gnu.org ([2001:4830:134:3::10]:38804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fRHhy-0002Mb-10
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 09:45:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fRHhx-0008Mq-1l
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 09:45:38 -0400
Date: Fri, 8 Jun 2018 14:45:27 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180608134527.GA980@stefanha-x1.localdomain>
References: <20180608122952.2009-1-ehabkost@redhat.com>
	<20180608122952.2009-3-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <20180608122952.2009-3-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 02/10] python: futurize -f
 libfuturize.fixes.fix_absolute_import
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-block@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Juan Quintela <quintela@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 08, 2018 at 09:29:44AM -0300, Eduardo Habkost wrote:
> Make implicit relative imports explicit and add "from __future__ import
> absolute_import" at the top of each relevant module.
>=20
> This is necessary for Python 3 compatibility.
>=20
> Done using:
>=20
>   $ py=3D$( (g grep -l -E '^#!.*python';find -name '*.py' -printf '%P\n';=
) | \
>     sort -u | grep -v README.sh4)
>   $ futurize -w -f libfuturize.fixes.fix_absolute_import $py
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v1 -> v2:
> * Moved "from __future__ import" line after copyright header
> ---
>  scripts/qmp/qemu-ga-client           | 3 ++-
>  scripts/qmp/qmp                      | 3 ++-
>  scripts/qmp/qmp-shell                | 3 ++-
>  scripts/qmp/qom-fuse                 | 3 ++-
>  scripts/qmp/qom-get                  | 3 ++-
>  scripts/qmp/qom-list                 | 3 ++-
>  scripts/qmp/qom-set                  | 3 ++-
>  scripts/qmp/qom-tree                 | 3 ++-
>  tests/image-fuzzer/qcow2/__init__.py | 3 ++-
>  tests/image-fuzzer/qcow2/layout.py   | 3 ++-
>  10 files changed, 20 insertions(+), 10 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbGoh3AAoJEJykq7OBq3PI3qcH/R2g3noJgbAp8jWWjR/NU4Da
GRBnd+eWTJopZ5Vm4tJHCoJaDxnHP2KvAuBr4pXDKDsHCpPE8J8MhbdFExwt/nMJ
+Kpx4wAIKfW00nP+Nwdfoo+LdtHyCrC+pQi/6dEvrCAygPbBz2qhyjR3PIXug0Lg
wPXc2TiGpxTskzYfxzawu9LdKa0iFttbfCb8P35ZU8xFzHLeWzAK47dcQUkBuVfA
LKe3yxG4FaX0syWGul6qVPDKNj76VR4xDzbmQZPc6NG8lugvzrTJWSqrrm1CKMda
kq6QL4WsArL9/Y9KSHVPeqEgpKeZ9i7D592Tb2ISxVOoUf7zQhOanM6UVS8jPkc=
=4+ag
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
