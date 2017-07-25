Received: from eggs.gnu.org ([2001:4830:134:3::10]:54379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1da0Ve-0001VS-Qz
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:08:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1da0Vb-0001io-5q
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:08:26 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1da0Va-0001hv-Ux
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:08:23 -0400
Received: by mail-wm0-x242.google.com with SMTP id r77so3284564wmd.2
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 07:08:22 -0700 (PDT)
Date: Tue, 25 Jul 2017 15:08:19 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170725140819.GN23343@stefanha-x1.localdomain>
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
	<1500645206-13559-9-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GOzekVbrLdOLv44p"
Content-Disposition: inline
In-Reply-To: <1500645206-13559-9-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 8/9] tests/libqtest: Clean up how we read
 the QMP greeting
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


--GOzekVbrLdOLv44p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2017 at 03:53:25PM +0200, Markus Armbruster wrote:
> qtest_init() still uses the qtest_qmp_discard_response(s, "") hack to
> receive the greeting, even though we have qtest_qmp_receive() since
> commit 66e0c7b.  Put it to use.
>=20
> Bonus: gets rid of an empty format string.  A step towards
> compile-time format string checking without triggering
> -Wformat-zero-length.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/libqtest.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--GOzekVbrLdOLv44p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZd1DTAAoJEJykq7OBq3PIVXkH/ig8+4ZtdG+smz7fR9rg+U/8
APB+vLbtbU0B/hScoOAHCJ+7NzqeayP2tz0cvXjcTFcykTA5h3tvnSIgJB5A3jfH
u6Bs+MEOmg7xrmp+VpAv3GyDG/3UXB/IyX417Dky4/Bjj9XQ3GTVboT9EwxaLnt8
zrYOfdDQFUbwUmVrk9QZEQZrX4u7b5gWF/zc6RWzx+cxSfj8Z/l4TkTpd5zMaDIE
htDIB402Ylee50d2KWLQb9XMmQAW5HfhuzrdW6OIH1yJKLs3Wfnu6udHQJ2YNHmF
5TWlg1NkJG6+PseyrqUB5T7dMS5MX7u6EDSzBnHM7Wk/AVvR392pvEw2FqnAkQE=
=25z7
-----END PGP SIGNATURE-----

--GOzekVbrLdOLv44p--
