Received: from eggs.gnu.org ([2001:4830:134:3::10]:42124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fO0f7-0004K0-FB
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fO0f6-0006Zs-OJ
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:57:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42432 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fO0f6-0006ZW-KQ
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:57:08 -0400
Date: Wed, 30 May 2018 13:57:05 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180530125705.GL14623@stefanha-x1.localdomain>
References: <20180529193730.9204-1-crosa@redhat.com>
	<20180529193730.9204-4-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yQDbd2FCF2Yhw41T"
Content-Disposition: inline
In-Reply-To: <20180529193730.9204-4-crosa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/5] Acceptance tests: add quick VNC
 tests
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


--yQDbd2FCF2Yhw41T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 29, 2018 at 03:37:28PM -0400, Cleber Rosa wrote:
> This patch adds a few simple behavior tests for VNC.
>=20
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/acceptance/vnc.py | 60 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 tests/acceptance/vnc.py
>=20
> diff --git a/tests/acceptance/vnc.py b/tests/acceptance/vnc.py
> new file mode 100644
> index 0000000000..b1ef9d71b1
> --- /dev/null
> +++ b/tests/acceptance/vnc.py
> @@ -0,0 +1,60 @@
> +# Simple functional tests for VNC functionality
> +#
> +# Copyright (c) 2018 Red Hat, Inc.
> +#
> +# Author:
> +#  Cleber Rosa <crosa@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +from avocado_qemu import Test
> +
> +
> +class Vnc(Test):
> +    """
> +    :avocado: enable
> +    :avocado: tags=3Dvnc,quick
> +    """
> +    def test_no_vnc(self):
> +        self.vm.add_args('-nodefaults', '-S')
> +        self.vm.launch()

If this pattern becomes very common maybe vm.launch() should become
vm.launch(*extra_args) to make this a one-liner:

  self.vm.launch('-nodefaults', '-S')

--yQDbd2FCF2Yhw41T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbDp+hAAoJEJykq7OBq3PIC/QH/jCVANPab1hTcLG/h/D+l6te
Yhgs9gTfVKyGjb7DTV74+kSElxT0Ifh71ecJXfQgJc45IxSgB1jsggN/dSr7sson
I1NInK1uiIj3VxSyi530/co+HbX6f9gjd3oNwKuMCX8Sxq9EPw8O8wz7ROFOX49K
L9rOmYgBNW4AnjLdNk28psFcQZOqc3PniRhPtkAvAPdJMhyLgVbe1R+d0SB8n3Zi
sq3rHp8PiUAou2UcUJ/gcDgX1MkMNLtXN8KB26Ody1FAvssx6C2puHRoDGEuCAfg
K0b0Xe1wT9dcI7GMtiRmOCDYcvZrMnAKWM6OFjWHduATR+QAd+xDQmiG4SlQ3Gc=
=vbDa
-----END PGP SIGNATURE-----

--yQDbd2FCF2Yhw41T--
