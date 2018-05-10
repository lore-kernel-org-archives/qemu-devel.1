Received: from eggs.gnu.org ([2001:4830:134:3::10]:60738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fGmbm-000849-LY
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:31:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fGmbg-0006B7-UV
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:31:50 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:39182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fGmbg-0006Aq-Na
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:31:44 -0400
Received: by mail-wm0-x22a.google.com with SMTP id f8-v6so4763606wmc.4
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 07:31:44 -0700 (PDT)
Date: Thu, 10 May 2018 15:31:40 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180510143140.GA7734@stefanha-x1.localdomain>
References: <1525936711-24538-1-git-send-email-suhang16@mails.ucas.ac.cn>
	<1525936711-24538-3-git-send-email-suhang16@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <1525936711-24538-3-git-send-email-suhang16@mails.ucas.ac.cn>
Subject: Re: [Qemu-devel] [PATCH v7 2/2] Add QTest testcase for the Intel
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
Cc: darcysail@gmail.com, qemu-devel@nongnu.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 10, 2018 at 03:18:31PM +0800, Su Hang wrote:
> 'test.hex' file is a bare metal ARM software stored in Hexadecimal
> Object Format. When it's loaded by QEMU, it will print "Hello world!\n"
> on console.
>=20
> `pre_store` array in 'hexloader-test.c' file, stores the binary format
> of 'test.hex' file, which is used to verify correctness.
>=20
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

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa9FfMAAoJEJykq7OBq3PIAMMIAIqvVrMqS0+9z1UYxWXOLgRb
6U05twLgm2syepiSsBJdL9AaWqF2osK2p7/dlV2GCENJKOFsvThsfMUwbF0A0mQJ
/g0eL8c9t4HXBosmmlLYDSDXTAXKC+A/m68Ch/zHhDF6CmMT25sTjTqC1kvYmmK+
x477xSFUQ3DERcItFkHsvH5iJN2MTRInxQTd0a8286uxQrZu5+F6GyapIm5HLG8l
jhDZ5OpOxyuch4Wk7nDikQaSzQIqL0kz93Nf+reOgQPk32WPtUie54U8QRlObwqC
3AVKJCcJpZMk9eE2NiAYJ3EWETgMJ+7WvcO6xaOm7KHaUU8DO0lkn7mF9loqmyc=
=wLTu
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
