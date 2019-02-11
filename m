Received: from eggs.gnu.org ([209.51.188.92]:48663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gt1Ei-0007LN-Gh
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 21:22:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gt1Eh-0005Jg-8S
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 21:22:20 -0500
Date: Mon, 11 Feb 2019 10:22:11 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190211022211.GA18083@stefanha-x1.localdomain>
References: <20190206162901.19082-1-crosa@redhat.com>
	<20190206162901.19082-2-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <20190206162901.19082-2-crosa@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/1] Introduce a Python module
 structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Markus Armbruster <armbru@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Max Reitz <mreitz@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2019 at 11:29:01AM -0500, Cleber Rosa wrote:
> This is a simple move of Python code that wraps common QEMU
> functionality, and are used by a number of different tests
> and scripts.
>=20
> By treating that code as a real Python module, we can more easily:
>  * reuse code
>  * have a proper place for the module's own unittests
>  * apply a more consistent style
>  * generate documentation
>=20
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  configure                                  |  1 +
>  scripts/qemu.py =3D> python/qemu/__init__.py | 11 ++++++-----
>  {scripts/qmp =3D> python/qemu}/qmp.py        |  0
>  {scripts =3D> python/qemu}/qtest.py          |  5 +++--
>  scripts/device-crash-test                  |  2 ++
>  scripts/qmp/__init__.py                    |  0
>  scripts/qmp/qemu-ga-client                 |  5 ++++-
>  scripts/qmp/qmp-shell                      |  4 +++-
>  scripts/render_block_graph.py              |  2 ++
>  tests/acceptance/avocado_qemu/__init__.py  |  5 ++---
>  tests/acceptance/virtio_version.py         |  2 +-
>  tests/migration/guestperf/engine.py        |  7 ++++---
>  tests/qemu-iotests/235                     |  2 +-
>  tests/qemu-iotests/238                     |  2 +-
>  tests/qemu-iotests/iotests.py              |  4 ++--
>  tests/vm/basevm.py                         |  2 +-
>  16 files changed, 33 insertions(+), 21 deletions(-)
>  rename scripts/qemu.py =3D> python/qemu/__init__.py (98%)
>  rename {scripts/qmp =3D> python/qemu}/qmp.py (100%)
>  rename {scripts =3D> python/qemu}/qtest.py (98%)
>  delete mode 100644 scripts/qmp/__init__.py

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcYNxTAAoJEJykq7OBq3PItnUH/iSIcjsW4sUAnHg75IVksogv
T4DKHkAE+kem2+J5tpp9AsRnXFO/eGpWqbUnH5NIxngS7BVe/zYk+5c7lL5Bm8o8
P9oa551UYvejM2xpyhdWddX1fBtDhfXBi9C0tqTxaTwQl3G9hAcNEeVM53Weckll
QnssV9x0t6dN0WBTpFDEs6SZnTM3JSQqVkd07T8dxOlcpOEykY3refLJ7k+hTWcE
fD7eB5IjJC27us8xVWKdNwVxBCGkJRbXM1c1Aq3XeMgS7eg9Ivq/zFT2um075sE3
l6mEwohDx6Szou0L4wlK/65j70HLuZRofBNNMOLQP+1kC5V35GdZcSZMQznzbbk=
=ow+l
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
