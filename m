Received: from eggs.gnu.org ([2001:4830:134:3::10]:60278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fIWpl-0003bR-Mc
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:05:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fIWph-0001Fd-Mm
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:05:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55808 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fIWph-0001FE-Gk
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:05:25 -0400
Date: Tue, 15 May 2018 11:05:23 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180515100523.GJ14755@stefanha-x1.localdomain>
References: <1526348758-6643-1-git-send-email-suhang16@mails.ucas.ac.cn>
	<1526348758-6643-3-git-send-email-suhang16@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NgG1H2o5aFKkgPy/"
Content-Disposition: inline
In-Reply-To: <1526348758-6643-3-git-send-email-suhang16@mails.ucas.ac.cn>
Subject: Re: [Qemu-devel] [PATCH v8 2/2] Add QTest testcase for the Intel
 Hexadecimal Object File Loader.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Su Hang <suhang16@mails.ucas.ac.cn>
Cc: stefanha@gmail.com, jim@groklearning.com, joel@jms.id.au, qemu-devel@nongnu.org


--NgG1H2o5aFKkgPy/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 15, 2018 at 09:45:58AM +0800, Su Hang wrote:
> 'test.hex' file is a bare metal ARM software stored in Hexadecimal
> Object Format. When it's loaded by QEMU, it will print "Hello world!\n"
> on console.
>=20
> `pre_store` array in 'hexloader-test.c' file, stores the binary format
> of 'test.hex' file, which is used to verify correctness.
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Su Hang <suhang16@mails.ucas.ac.cn>
> ---
>  MAINTAINERS                          |  6 ++++
>  tests/Makefile.include               |  2 ++
>  tests/hex-loader-check-data/test.hex | 12 ++++++++
>  tests/hexloader-test.c               | 56 ++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 76 insertions(+)
>  create mode 100644 tests/hex-loader-check-data/test.hex
>  create mode 100644 tests/hexloader-test.c

Please add the ./configure change needed to make this test work for
out-of-tree builds.  I sent an emailing explaining how the necessary
symlink can be created in ./configure in reply to the previous series.

Stefan

--NgG1H2o5aFKkgPy/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa+rDjAAoJEJykq7OBq3PIFJMH/A0XA7t68B4tvxFcUIZFt+8F
/E7IaSKeElI8qAJ2551+xn0Zs8TScplNiypPfN1o7rEyczqrntwiFulCMLDZXMkC
bpi/mqJQ7evdDjiJhCpJxtS8BA6eRmHFDnC3KQLDCFbfEn6iWLeNKE7o7ghRTy4i
vtMtqQHHazPF0Y+STXn/uZcYMiqIa+/euXjh5gJcl2Cu305KVqun7Xn5nSbZybQY
LBmGhYjl1X7I+zFp1JzrfH6VuJth9rmw05FLRiS97LvVU5n1oeE0aJMarzcVIjvL
rRS3YDl3e2f/ob7XNIto4rz6e0oRFdu6w3jfCQhKLmUMHiOeg3e79CU4s05FU9w=
=G5Y2
-----END PGP SIGNATURE-----

--NgG1H2o5aFKkgPy/--
