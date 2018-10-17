Received: from eggs.gnu.org ([2001:4830:134:3::10]:42706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gCi54-0002ir-Ij
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:25:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gCi51-0004wJ-Er
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:25:30 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37526)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gCi4z-0004qx-4L
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:25:26 -0400
Received: by mail-wm1-x341.google.com with SMTP id 185-v6so1385720wmt.2
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 02:25:23 -0700 (PDT)
Date: Wed, 17 Oct 2018 10:25:20 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181017092520.GE22755@stefanha-x1.localdomain>
References: <20181016175042.578-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qFgkTsE6LiHkLPZw"
Content-Disposition: inline
In-Reply-To: <20181016175042.578-1-crosa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 0/3] Bootstrap Python venv and
 acceptance/functional tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Laszlo Ersek <lersek@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>


--qFgkTsE6LiHkLPZw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2018 at 01:50:39PM -0400, Cleber Rosa wrote:
> TL;DR
> =3D=3D=3D=3D=3D
>=20
> Allow acceptance tests to be run with `make check-acceptance`.
>=20
> Details
> =3D=3D=3D=3D=3D=3D=3D
>=20
> This introduces a Python virtual environment that will be setup within
> the QEMU build directory, that will contain the exact environment that
> tests may require.

Looks useful!

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--qFgkTsE6LiHkLPZw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbxwAAAAoJEJykq7OBq3PIVAgIAMmrB3sgGQjLY8XatrYOR/Wj
xDJF7xsnyGFProHsbkhRnVJyrtAhFLivqglA5lX9Q9/k5xe0spaXga16EqwT51LL
xd+V63Es1MJ/oG1JBfoPJamh2uYRe00S16BgtabRx2LSANbZ14sjMecH4BQRS6A5
rNmI+/XYgWvDhnjS0D2nUpuf2HZBnnA0kjI9j0+cLcT0OvMShNaRwYwbFbJGsy3b
aGZt7npJwaGR6WyPQYDNcWGJNE3shIHG4a4BCK26F2vVjEKWCOZZguICJHS+GS5j
bH2qubUZmgMI4BFRzYjd7rU7oQE0LgFZlTQeAlzCcqA/omhKzZfqdyNJzYIMtiE=
=+Yva
-----END PGP SIGNATURE-----

--qFgkTsE6LiHkLPZw--
