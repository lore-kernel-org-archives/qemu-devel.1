Received: from eggs.gnu.org ([2001:4830:134:3::10]:52290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZiFT-00005N-Ev
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:38:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZiFP-00029t-6a
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:38:31 -0400
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-3-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <12087bf6-7ff4-58f4-5a4a-1bdf1661abfb@redhat.com>
Date: Mon, 24 Jul 2017 13:38:22 -0500
MIME-Version: 1.0
In-Reply-To: <20170724182751.18261-3-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="20ghUWTjR34fFJVGgmlRFDATrevKUsx4s"
Subject: Re: [Qemu-devel] [PATCH for 2.10 02/35] loader: check
 get_image_size() return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--20ghUWTjR34fFJVGgmlRFDATrevKUsx4s
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Message-ID: <12087bf6-7ff4-58f4-5a4a-1bdf1661abfb@redhat.com>
Subject: Re: [PATCH for 2.10 02/35] loader: check get_image_size() return
 value
References: <20170724182751.18261-1-f4bug@amsat.org>
 <20170724182751.18261-3-f4bug@amsat.org>
In-Reply-To: <20170724182751.18261-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/24/2017 01:27 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> since a negative value means it errored.
>=20
> hw/core/loader.c:149:9: warning: Loss of sign in implicit conversion
>     if (size > max_sz) {
>         ^~~~
> hw/core/loader.c:171:9: warning: Loss of sign in implicit conversion
>     if (size > memory_region_size(mr)) {
>         ^~~~
>=20
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/core/loader.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--20ghUWTjR34fFJVGgmlRFDATrevKUsx4s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll2Pp4ACgkQp6FrSiUn
Q2pLsAf/RfE3pEOrMAx7aMYB+uR/dEwNGBIS8vPfuGZC3ltrTE77h0kFB69RoLKQ
kLIsMX8ilIcal1IsbjPVqx1BmJn3l2jyoO1RUm4RYEhp94aQDwcTqtu4OKXT1vB0
Tvkacj5BEaRobw6C/9uTzdQpJHRvna0TfKoFB+sIkXQ1LnQDptnkC/3ijinkxcvQ
kN+51gDxX/9mORMoFBF+Zs2sKzIedULvgoz6wy7Zau4JsQQmf7LzCKJlvnPjS6o+
D8AcFMvBkZNMEWJheWF3dtnBc69OX2/Oj36vX3zRs2sUgZWYF+qyqud61zmJNHIp
ymCyt46g/TSZS06F6dtj5k3PAzrX/g==
=oBmg
-----END PGP SIGNATURE-----

--20ghUWTjR34fFJVGgmlRFDATrevKUsx4s--
