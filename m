Received: from eggs.gnu.org ([2001:4830:134:3::10]:43658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJheI-0005v7-61
	for qemu-devel@nongnu.org; Fri, 18 May 2018 11:50:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJheE-0004Jd-WD
	for qemu-devel@nongnu.org; Fri, 18 May 2018 11:50:30 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:39226)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJheE-0004JV-QH
	for qemu-devel@nongnu.org; Fri, 18 May 2018 11:50:26 -0400
Received: by mail-qk0-x243.google.com with SMTP id z75-v6so6782261qkb.6
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 08:50:26 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1526595970.git.julian@codesourcery.com>
	<651c4ec90c74a9ed34c5d200038de0e7c4ecc39c.1526595970.git.julian@codesourcery.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b8c154da-0a3e-b450-5233-abcef069e9e7@amsat.org>
Date: Fri, 18 May 2018 12:50:15 -0300
MIME-Version: 1.0
In-Reply-To: <651c4ec90c74a9ed34c5d200038de0e7c4ecc39c.1526595970.git.julian@codesourcery.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="5vFWiBtR5VxsptiTzPyHwFHtmJq5fzUWV"
Subject: Re: [Qemu-devel] [PATCH 1/2] Add generic Nios II board.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julian Brown <julian@codesourcery.com>, qemu-devel@nongnu.org
Cc: Andrew Jenner <andrew@codesourcery.com>, =?UTF-8?Q?Marek_Va=c5=a1ut?= <marek.vasut@gmail.com>, =?UTF-8?Q?Marek_Va=c5=a1ut?= <marex@denx.de>, Chris Wulff <crwulff@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5vFWiBtR5VxsptiTzPyHwFHtmJq5fzUWV
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Julian Brown <julian@codesourcery.com>, qemu-devel@nongnu.org
Cc: Andrew Jenner <andrew@codesourcery.com>,
 =?UTF-8?Q?Marek_Va=c5=a1ut?= <marek.vasut@gmail.com>,
 =?UTF-8?Q?Marek_Va=c5=a1ut?= <marex@denx.de>, Chris Wulff <crwulff@gmail.com>
Message-ID: <b8c154da-0a3e-b450-5233-abcef069e9e7@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 1/2] Add generic Nios II board.
References: <cover.1526595970.git.julian@codesourcery.com>
 <651c4ec90c74a9ed34c5d200038de0e7c4ecc39c.1526595970.git.julian@codesourcery.com>
In-Reply-To: <651c4ec90c74a9ed34c5d200038de0e7c4ecc39c.1526595970.git.julian@codesourcery.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Julian,

You should Cc the NiosII maintainers for faster review (done).

(From
https://wiki.qemu.org/Contribute/SubmitAPatch#CC_the_relevant_maintainer:=
)

$ ./scripts/get_maintainer.pl -f hw/nios2/
Chris Wulff <crwulff@gmail.com> (maintainer:NiosII)
Marek Vasut <marex@denx.de> (maintainer:NiosII)

On 05/17/2018 07:38 PM, Julian Brown wrote:
>=20
> This patch adds support for a generic MMU-less Nios II board that can
> be used e.g. for bare-metal compiler testing.  Nios II booting is also
> tweaked so that bare-metal binaries start executing in RAM starting at
> 0x00000000, rather than an alias at 0xc0000000, which allows features
> such as unwinding to work when binaries are linked to start at the
> beginning of the address space.
>=20
> The generic_nommu.c parts are by Andrew Jenner, based on code by Marek
> Vasut.

Can you get/add their S-o-b?

> Signed-off-by: Julian Brown <julian@codesourcery.com>
> ---
>  hw/nios2/Makefile.objs   |   2 +-
>  hw/nios2/boot.c          |   5 +-
>  hw/nios2/generic_nommu.c | 128 +++++++++++++++++++++++++++++++++++++++=
++++++++
>  3 files changed, 133 insertions(+), 2 deletions(-)
>  create mode 100644 hw/nios2/generic_nommu.c

It seems your email client messed your patch up, see
https://wiki.qemu.org/Contribute/SubmitAPatch#Do_not_send_as_an_attachmen=
t

Can you resend?

Regards,

Phil.


--5vFWiBtR5VxsptiTzPyHwFHtmJq5fzUWV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlr+9jcACgkQ4+MsLN6t
wN7jGw//WNHgbYVxtM+JiDzF7KPG0l4lQPhryYA4BYaWNbclZnY72uBTWXWEHsS4
zl03IIv+Z9ZbPZ9tfibnUikww39s2GIPIRJC+fhcxxucVcdlWxxTYuf18V1dRCZy
juyjmOsoFbhgMwk2XQxzqpRrjkmPJmCxrqEe0828vXne98AKlgt66K69t09lo0cR
KtXZbrIHESgmF1lqcquBpgp0pL8UDm6fDBX6HN7gVtSZFxcVHSv559Qn5ULJiQxt
6fU2xWTccubDlanvX97OiUGgRgV9oJTMlTxZT36+irtIARtPFugqkiZQCn3Dv23c
0aFVKpHwbqpYc48Y1ddXbe20WXylWpQx7ODluqWADFdRMaxyQpjp6cmM2g4hzmtT
hipK9BwS/ztucSd7MMOJDC5uzDKxZpcaVvU0wDN5yQqxVvtdnxYieQDoBbUyLGiN
Eiy1KLSgFWwBZ1NZpMwJCitHKbZ2M72y+SiniBmDd6c9siqpHAA/Vl7FBu88uOwD
Xns78Ujt6pdytta/7RmrQcx59r9zOz3kTJA6udDJj5FIcS3jMzEfQIPV1z5wCxVh
7a9ccvyQCHiCVj7YhSej16L7p5O0U+7JQ2Nk5QyL/9iIjuedXOUWqRszh9fkgKA6
T0l52RU7C2O2BHJ8MN0LhQRsLFT0ioSw6FXP7/XcBZzMBr2ClgA=
=EkN9
-----END PGP SIGNATURE-----

--5vFWiBtR5VxsptiTzPyHwFHtmJq5fzUWV--
