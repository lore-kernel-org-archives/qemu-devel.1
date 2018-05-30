Received: from eggs.gnu.org ([2001:4830:134:3::10]:41456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fO0cy-0002VE-Ao
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:54:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fO0cu-0004mW-5W
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:54:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43456 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fO0ce-0004Nq-01
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:54:52 -0400
Date: Wed, 30 May 2018 13:54:21 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180530125421.GJ14623@stefanha-x1.localdomain>
References: <20180529193730.9204-1-crosa@redhat.com>
	<20180529193730.9204-2-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2VXyA7JGja7B50zs"
Content-Disposition: inline
In-Reply-To: <20180529193730.9204-2-crosa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/5] Add functional/acceptance tests
 infrastructure
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


--2VXyA7JGja7B50zs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 29, 2018 at 03:37:26PM -0400, Cleber Rosa wrote:
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index 0ca1a2d4b5..5e090c87fb 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -484,3 +484,156 @@ supported. To start the fuzzer, run
> =20
>  Alternatively, some command different from "qemu-img info" can be tested=
, by
>  changing the ``-c`` option.
> +
> +Acceptance tests using the Avocado Framework
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The ``tests/acceptance`` directory hosts functional tests, also known
> +as acceptance level tests.  They're usually higher level, and may
> +interact with external resources and with various guest operating
> +systems.

Can you give more concrete examples of what acceptance tests do?  This
will make it easier for readers to understand where Avocado fits in.

Things that come to mind: checking the behavior of QMP commands and
guest OS commands.

> +To run all tests in the current directory, tagged in a particular way,
> +run:
> +
> +.. code::
> +
> +  avocado run -t <TAG> .

What is TAG?  I guess this identifies a subset of tests to run?

> +QEMUMachine
> +~~~~~~~~~~~
> +
> +The QEMUMachine API should be somewhat familiar to QEMU hackers.  It's
> +used in the Python iotests, device-crash-test and other Python scripts.

This is not useful to someone who isn't a QEMU hacker :).

Please explain that QEMUMachine is a class for controlling a QEMU
instance, including command-line arguments and monitor commands/events.

--2VXyA7JGja7B50zs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbDp79AAoJEJykq7OBq3PICOwH/1H1MR6Oq+kmUFnoQ9ZUcPX/
NXKioJi4kG117RAteNvrXvCfhxGg7PWzSSVPhp0uvLnRVGcRAD18RRBP+Ds8HN5l
ivSGsR+8kYlZ8fjXuu4PuSNcihQ9g7umO3xFv7ApneHDjOeFJvacVflkqLyEtCEI
yNsT1M+NfCim4+8lNZO+9iUlxEL/H5+D9qUxmuxe94m8Ry6/x3d+0sdo4xkjy58D
kJRSMGWfJhuWCe2S3bYSAm2p+agOzX71uhae3UWQ8XiDpK/8jW2AXVNpy/AH08yq
27TzYrXWGkIrz5VOQ354ZIOcol3yR+trdqlMybZpBLjmsX2ddhhNGWMXyrdF8Gw=
=HQza
-----END PGP SIGNATURE-----

--2VXyA7JGja7B50zs--
