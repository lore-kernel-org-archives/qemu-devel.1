Received: from eggs.gnu.org ([2001:4830:134:3::10]:42908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fOLFj-0005hk-D8
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:56:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fOLFf-00038D-F8
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:56:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48384 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fOLFf-00037r-AI
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:56:15 -0400
Date: Thu, 31 May 2018 11:56:13 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180531105613.GF27838@stefanha-x1.localdomain>
References: <20180530184156.15634-1-crosa@redhat.com>
	<20180530184156.15634-6-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kbCYTQG2MZjuOjyn"
Content-Disposition: inline
In-Reply-To: <20180530184156.15634-6-crosa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 5/5] Acceptance tests: add Linux kernel
 boot and console checking test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Fam Zheng <famz@redhat.com>, Amador Pahim <amador@pahim.org>


--kbCYTQG2MZjuOjyn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 30, 2018 at 02:41:56PM -0400, Cleber Rosa wrote:
> This test boots a Linux kernel, and checks that the given command
> line was effective in two ways:
>=20
>  * It makes the kernel use the set "console device" as a console
>  * The kernel records the command line as expected in the console
>=20
> Given that way too many error conditions may occur, and detecting the
> kernel boot progress status may not be trivial, this test relies on a
> timeout to handle unexpected situations.  Also, it's *not* tagged as a
> quick test for obvious reasons.
>=20
> It may be useful, while interactively running/debugging this test, or
> tests similar to this one, to show some of the logging channels.
> Example:
>=20
>  $ avocado --show=3DQMP,console run boot_linux_console.py
>=20
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/acceptance/boot_linux_console.py | 47 ++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 tests/acceptance/boot_linux_console.py

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--kbCYTQG2MZjuOjyn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbD9TNAAoJEJykq7OBq3PIz/YH/jkk4q851Td3d5Gx41ZnV96H
stgw6z4J1arxvTh+KGCF4lW7u4dqQJ7NZiiIjrlNb4i/SyZ4jhi9NVCIQzkX9jiM
g4RBgK6DFCB8vWgE3okUZcMxHnFhm+ceDz5lT319aWhNsiSsuqGjgECKM6kfnzUT
fVrzSSdjCMXOvzCtD3oU0ew0fN14GDs0wPHvquKc6MmkuKj1Z2eJ05PyT0CaLvNM
z/rPpE4wyQYQeYfImoyPN3GSuZFgZU0tvs9I8bBVP7ucXSUqoMKWThLgELzFTOit
LTEmV7OY3z7A8/qmN/GJ6cMR2lvt5OkdwSGSM/RpdbTi62nN6Rf/LuG2TfGrZHU=
=TOjf
-----END PGP SIGNATURE-----

--kbCYTQG2MZjuOjyn--
