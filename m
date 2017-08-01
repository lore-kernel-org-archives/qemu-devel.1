Received: from eggs.gnu.org ([2001:4830:134:3::10]:50171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dcU8x-0006uo-47
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 06:11:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dcU8t-0002Hn-0X
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 06:11:15 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dcU8s-0002HY-QI
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 06:11:10 -0400
Received: by mail-wm0-x242.google.com with SMTP id r77so2273394wmd.2
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 03:11:10 -0700 (PDT)
Date: Tue, 1 Aug 2017 11:11:07 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170801101107.GG13521@stefanha-x1.localdomain>
References: <20170731085110.1050-1-apahim@redhat.com>
	<20170731085110.1050-6-apahim@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PyMzGVE0NRonI6bs"
Content-Disposition: inline
In-Reply-To: <20170731085110.1050-6-apahim@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 5/7] qemu.py: use os.path.null instead
 of /dev/null
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, berrange@redhat.com, ehabkost@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, crosa@redhat.com, ldoktor@redhat.com


--PyMzGVE0NRonI6bs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 31, 2017 at 10:51:08AM +0200, Amador Pahim wrote:
> For increased portability, let's use os.path.devnull.
>=20
> Signed-off-by: Amador Pahim <apahim@redhat.com>
> ---
>  scripts/qemu.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--PyMzGVE0NRonI6bs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZgFO7AAoJEJykq7OBq3PINuoIAJYhYphlS9nCqq/zgv+xb5vf
vaUB02CVJ6V66x9j31kVgewk9PQoKB94v3B6kQ0BOzUZA3+R0GOxgI2Vubk5jtma
DqE0LBmCEwIAXoohj4GmZAzTAnT+fCDs8NZoCxenvFVpXcJRjbJ4X12YywVb6/F3
cFQDrTiEXuWL4rg8iY7ZuX+kLAgMobjc6KUU7/rRR5LlPrDG20FPRirO0GCD+o5A
GJJ+4GrnoyG9eqvWvvZg5GmCMYoVf+qo/PY+hKAYOodeQJlGH4aC2xl0YCRKQvhx
Y2VsKQrqToPKdw8bLi1B/uZGcKKJFSfVExwPWjMuIOnfMvzHrSE04VVogpMMP1Q=
=cRX9
-----END PGP SIGNATURE-----

--PyMzGVE0NRonI6bs--
