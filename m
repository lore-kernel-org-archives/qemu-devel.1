Received: from eggs.gnu.org ([2001:4830:134:3::10]:36998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dhtkZ-0004bg-Qt
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 04:32:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dhtkW-0002Dc-Ma
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 04:32:27 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35269)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dhtkW-0002DQ-Em
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 04:32:24 -0400
Received: by mail-wm0-x244.google.com with SMTP id r77so3956078wmd.2
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 01:32:24 -0700 (PDT)
Date: Wed, 16 Aug 2017 09:32:20 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170816083220.GA3180@stefanha-x1.localdomain>
References: <20170816072104.24420-1-famz@redhat.com>
	<20170816072104.24420-4-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <20170816072104.24420-4-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 3/9] qemu.py: Add "wait()" method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Kamil Rytarowski <kamil@netbsd.org>, stefanha@redhat.com, pbonzini@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2017 at 03:20:58PM +0800, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  scripts/qemu.py | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index e5f314efdb..3e7eb44035 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -144,6 +144,11 @@ class QEMUMachine(object):
>              self._post_shutdown()
>              raise
> =20
> +    def wait(self):
> +        self._popen.wait()
> +        self._qmp.close()
> +        self._post_shutdown()
> +

Please include docstrings for public methods.

Is this method for users who do not use shutdown() because the guest
halts itself?

Why is self._load_io_log() not called?

Stefan

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZlAMUAAoJEJykq7OBq3PI/gEH/0jrJhrp00Dju1xDN10afl/D
+SoQOM7BbPnVjCb0v+hnbVBJRuTAYjwAzrbnT59WCvOHNMYdsvphyiI668DBSyOl
cK01LMCZ5RTkxDwx1eNq/uV9eLMbzuL/Lerfy6b3+4Gt3C5dcgpdS3G+5SMSgwIC
tIwzCEDv4P8LrKWwLczEfdaHRyCbcjVnqtHF0EzN4nskatdUB7DAgLRNb/eHUL9v
Hfi5XBbISe6fQsxvy5Ng+8VJRFZYNJb+pP+yx//i36SJ5+vRkrb2V88d/ZsP7FXg
hxRkR1ZaGDNzPFYD4iuqwqWnqMUJu/kZvhc8yoOaqWgR3edtIlSypzLGJYLw1y0=
=hPzP
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
