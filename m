Received: from eggs.gnu.org ([2001:4830:134:3::10]:40024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cv3lw-0000XI-My
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:20:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cv3lt-0000oM-Ht
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:20:00 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:34200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cv3lt-0000nU-9s
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:19:57 -0400
Received: by mail-wr0-x22a.google.com with SMTP id l43so175821548wre.1
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 08:19:57 -0700 (PDT)
Date: Mon, 3 Apr 2017 16:19:53 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170403151953.GE3539@stefanha-x1.localdomain>
References: <CA+KKJYCOKxea1TJY0Uu8HSzYLoh3G=EX-DeKbM+r40HhoxfJrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jTMWTj4UTAEmbWeb"
Content-Disposition: inline
In-Reply-To: <CA+KKJYCOKxea1TJY0Uu8HSzYLoh3G=EX-DeKbM+r40HhoxfJrw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] debug: made printf always compile in debug
 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Danil Antonov <g.danil.anto@gmail.com>
Cc: qemu-devel@nongnu.org


--jTMWTj4UTAEmbWeb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 27, 2017 at 02:50:47PM +0300, Danil Antonov wrote:
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index 2b0f3e1..bf880c1 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -39,13 +39,16 @@
>  #include "qom/qom-qobject.h"
>  #include "qapi/qmp/qint.h"
>=20
> -//#define DEBUG
>=20
> -#ifdef DEBUG
> -# define ACPI_PCIHP_DPRINTF(format, ...)     printf(format, ## __VA_ARGS=
__)
> -#else
> -# define ACPI_PCIHP_DPRINTF(format, ...)     do { } while (0)
> -#endif
> +#ifndef DEBUG
> +#define DEBUG 0
> +#endif
> +
> +#define ACPI_PCIHP_DPRINTF(fmt, ...) do {     \
> +    if (DEBUG) {                              \
> +        fprintf(stderr, fmt, ## __VA_ARGS__); \
> +    }                                         \
> +} while (0);

The semicolon isn't necessary.  The caller provides it.

  ACPI_PCIHP_DPRINTF("foo\n");

It's normal to define statement-like macros with do { ... } while (0)
and no semicolon in the definition.

--jTMWTj4UTAEmbWeb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY4mgZAAoJEJykq7OBq3PIXBcH/iy5asad9rNCrzP5PlcmbI9D
+wsfxnaTqdVRDHyJvItiaUSxwCHMNz98MMygLvFa70aIxyRVxHjtbHOpBd5K1PVq
JrZMz4dBLfiJMUxB+WhD5U+tbs1RrqTXIIHH+cplJ/6P+OH7twHdgNK8mk++vhDB
VtFvHUzj2hCtxh4dUlBWSPgQew78lnTzWQhA/KYbQepGvWECUXHZeFlLIZH7xGsA
esPY3WpsQa4qUm+hzcPrRvDzy0HL+LzuLJ140hxCOZcPD7ttTB6dRygcu2UQWe82
CHw59yFKidKD8cdYy3PtJTwkmogJaUP2htFeszjTseuuCq+r+kh8hb3K8ijtAr8=
=ctWR
-----END PGP SIGNATURE-----

--jTMWTj4UTAEmbWeb--
