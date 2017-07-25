Received: from eggs.gnu.org ([2001:4830:134:3::10]:54565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1da0WX-00026I-4S
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:09:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1da0WW-00027h-7l
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:09:21 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:38250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1da0WW-000274-0s
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:09:20 -0400
Received: by mail-wr0-x242.google.com with SMTP id g32so2691795wrd.5
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 07:09:19 -0700 (PDT)
Date: Tue, 25 Jul 2017 15:09:17 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170725140917.GO23343@stefanha-x1.localdomain>
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
	<1500645206-13559-10-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ugCSa1rMkiCAmd9S"
Content-Disposition: inline
In-Reply-To: <1500645206-13559-10-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 9/9] tests/libqtest: Enable compile-time
 format string checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org


--ugCSa1rMkiCAmd9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2017 at 03:53:26PM +0200, Markus Armbruster wrote:
> qtest_qmp() & friends pass their format string and variable arguments
> to qobject_from_jsonv().  Unlike qobject_from_jsonv(), they aren't
> decorated with GCC_FMT_ATTR().  Fix that to get compile-time format
> string checking.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/libqtest.h | 40 ++++++++++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 16 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ugCSa1rMkiCAmd9S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZd1ENAAoJEJykq7OBq3PIN5QH/1qJmav7dv+rIksI/MEDNqMg
LylvX1JsZ5AZphh2JNOHx/33AXPmiyMxpDpsghOvKLtbZImwJoIHs1XFMJBz8qD8
kO61aZ0cCufFbezKjNJ2QgQw4GZNSpi2s/3QuZTwZorr1GUQPCFaJj+1+m7SshNX
cg6hhzPzTmjEKnML5vzlxBaGuZlok56zOj92cml36WtC6PXVCiHB+UG6fTc1c+nk
QM/Riz8xpjPvpSOoCIPAWfIyU6e5De/IHooViXouqHhfchyRyxgKnA8mQ3pzFcDz
lVfIzzpfTZVP7n+WDdksOgE0Nf32QFvYtNRY37h74P9EEFRgab3bzwNlGl4p8w8=
=4yOQ
-----END PGP SIGNATURE-----

--ugCSa1rMkiCAmd9S--
