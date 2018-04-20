Received: from eggs.gnu.org ([2001:4830:134:3::10]:47341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f9RZH-0008HM-Op
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:38:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f9RZH-0007gG-1E
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:38:55 -0400
Date: Fri, 20 Apr 2018 16:38:46 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180420083846.GQ15181@stefanha-x1.localdomain>
References: <20180416165849.28864-1-mreitz@redhat.com>
	<20180416165849.28864-9-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l8yJEXo8J9fv7OFY"
Content-Disposition: inline
In-Reply-To: <20180416165849.28864-9-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 8/9] iotests: Copy 197 for COR
 filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--l8yJEXo8J9fv7OFY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 16, 2018 at 06:58:48PM +0200, Max Reitz wrote:
> iotest 197 tests copy-on-read using the (now old) copy-on-read flag.
> Copy it to 215 and modify it to use the COR filter driver instead.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/215     | 120 +++++++++++++++++++++++++++++++++++++++=
++++++
>  tests/qemu-iotests/215.out |  26 ++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 147 insertions(+)
>  create mode 100755 tests/qemu-iotests/215
>  create mode 100644 tests/qemu-iotests/215.out

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--l8yJEXo8J9fv7OFY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa2acWAAoJEJykq7OBq3PIjq8H/1TZ3sjS5lUevDZLT+EvCeMB
aJMBlbnxj1aAwqIO7GMJDWIwtFVmS+dN4UUA3jxlSNKTuuNYyupcWYHtKm4vIj2U
OmC2BACUgjghPCl93Ly+nU5co7LEOJ4UB7YXXlHsZ0DGF8WVhYN0r5CeFQK+Kd+h
Dt++gs4W8f2m+82XsnsWcFKMg0+pMOzAyaFWTGr+7SycHzMhkg6DlAB/T44SqgFp
ihIuoyVzXjKpLSmOBOTdzCeuJvniVyfiMjSD46vbwesLv3hhcjKNrupIwsWb/v7T
MGdGaeN7wQmx7sFutDfHO00FtT7Hk6EVqzItR4wEqLrNGXphwnWZv+1Db3mOWmA=
=2kPi
-----END PGP SIGNATURE-----

--l8yJEXo8J9fv7OFY--
