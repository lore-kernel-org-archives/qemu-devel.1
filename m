Received: from eggs.gnu.org ([209.51.188.92]:44842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gkBgA-0007Ee-Ih
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:42:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gkBg8-0006an-8U
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:42:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gkBg6-0006X7-8N
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:42:06 -0500
Date: Thu, 17 Jan 2019 17:42:02 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190117174202.GB18457@stefanha-x1.localdomain>
References: <20190117161640.5496-1-jusual@mail.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
Content-Disposition: inline
In-Reply-To: <20190117161640.5496-1-jusual@mail.ru>
Subject: Re: [Qemu-devel] [PATCH v4 0/3] tests/microbit-test: Add UART
 device test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Steffen =?iso-8859-1?Q?G=F6rtz?= <contrib@steffen-goertz.de>


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 17, 2019 at 07:16:37PM +0300, Julia Suvorova wrote:
> v4:
>     * Replace sprintf with g_strdup_printf [Peter]
>     * Move socket connection to qtest library [Peter]
>     * Use memcmp instead of strcmp [Stefan]
>     * Remove using global_qtest [Thomas]
> v3:
>     * Fix directory leak [Stefan]
>=20
> Based-on: <20190110094020.18354-1-stefanha@redhat.com>
>=20
> Julia Suvorova (3):
>   tests/libqtest: Introduce qtest_init_with_serial()
>   tests/microbit-test: Make test independent of global_qtest
>   tests/microbit-test: Check nRF51 UART functionality
>=20
>  tests/libqtest.c      |  26 ++++
>  tests/libqtest.h      |  11 ++
>  tests/microbit-test.c | 331 +++++++++++++++++++++++++++---------------
>  3 files changed, 250 insertions(+), 118 deletions(-)

I posted a minor comment which can be touched up when merging.

Thanks for doing the global_qtest removal!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcQL5qAAoJEJykq7OBq3PIwBcH+wZqRJrPr9COTrXjlW1qfiZC
JDbNyDcmsQkqz/8eMupRzNH3zWQDkFyY1hQRwP7/ut3CM7Fk+Z0XaSoueFI5eytp
YL3nW+xYKI3rNz0LLgqetxyczQKX+hD5l5t+VGeCw8uXdotEm55ZdXetru/TRH5T
pOsEa1uRGCOqSg8p4gEP9OHIjGtFT5h6oQJc0O4kKORfjNGHb/m+5xiroe87Jn32
LHfQLmxENNWKY2N5ue9rd3AXfaG+b09oBwL8yI3/x+SJhtjIIn3zdSI+V+9TV+lj
Tbl5FOQN0HPaMRXLFod+I+b0qqhFtp6JKsWdp+C4H/Z4zrOd6nMeYQAivsDVk/U=
=qZpz
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--
