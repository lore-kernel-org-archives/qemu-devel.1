Received: from eggs.gnu.org ([209.51.188.92]:44270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hJIzQ-00053B-Uq
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:35:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hJIl4-0001in-UQ
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:20:24 -0400
References: <20190424103747.10173-1-thuth@redhat.com>
	<20190424103747.10173-4-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <167b6b7c-3fef-47e8-d30d-09abfe1e50ba@redhat.com>
Date: Wed, 24 Apr 2019 09:14:29 -0500
MIME-Version: 1.0
In-Reply-To: <20190424103747.10173-4-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gihy7ScO5bQVPVVZmlxviIEpVeYcfDTsn"
Subject: Re: [Qemu-devel] [PATCH 3/6] tests/qemu-iotests: Do not hard-code
 the path to bash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gihy7ScO5bQVPVVZmlxviIEpVeYcfDTsn
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>
Message-ID: <167b6b7c-3fef-47e8-d30d-09abfe1e50ba@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/6] tests/qemu-iotests: Do not hard-code the
 path to bash
References: <20190424103747.10173-1-thuth@redhat.com>
 <20190424103747.10173-4-thuth@redhat.com>
In-Reply-To: <20190424103747.10173-4-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/24/19 5:37 AM, Thomas Huth wrote:
> bash is installed in a different directory on non-Linux systems like
> FreeBSD. Do not hard-code /bin/bash here so that the tests can run
> there, too.

These tests were obviously copy-and-pasted from a fork point prior to
commit 11a82d14.

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qemu-iotests/239 | 2 +-
>  tests/qemu-iotests/240 | 2 +-
>  tests/qemu-iotests/241 | 2 +-
>  tests/qemu-iotests/243 | 2 +-
>  tests/qemu-iotests/244 | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--gihy7ScO5bQVPVVZmlxviIEpVeYcfDTsn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzAb0UACgkQp6FrSiUn
Q2pSpggAn0Vi5CAUsUPfx4aPFC1TACLvJBiPKzD38UtY9PYx4vx6/ahUXBSdeB2P
nApO9+iHFT1z+gjkXnBTnUCbNjO7KLzvDvX9KnLN0+f8YW0iPm8n7mUQN7uOhBnR
R0VkmdWN0Cw4UQ/gVLp+OOV50nVPOpcqApOisSI47fThJxytzXx7TyCSumqKurxi
+bSFD00bHo/N5c0TWZyFdbe/CGS7M/mM77Ww1N+JipJQ+tr/y+D2pybphG5/flAp
xlULDH2FByZOt5APqeG9/VKSUsjx9mLkMFNNkZoIbFfbhHC0RhvUWJm6XQb6+RpZ
Q5cWZPKfQroXALmQJPrEFhW5HS78lg==
=AmWS
-----END PGP SIGNATURE-----

--gihy7ScO5bQVPVVZmlxviIEpVeYcfDTsn--
