Received: from eggs.gnu.org ([2001:4830:134:3::10]:57049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eYb1b-0002i5-PQ
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eYb1Y-0005xP-Js
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:15:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eYb1Y-0005wy-Ak
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:15:48 -0500
References: <1515431442-23795-1-git-send-email-peter.maydell@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <61e82ebc-52c6-1023-1eea-6fa39775fdc5@redhat.com>
Date: Mon, 8 Jan 2018 11:15:45 -0600
MIME-Version: 1.0
In-Reply-To: <1515431442-23795-1-git-send-email-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="84XfgO7NLbndYDkwTfLMyuKmpI7Lx31mM"
Subject: Re: [Qemu-devel] [PATCH] configure: Fix incorrect string comparison
 operator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--84XfgO7NLbndYDkwTfLMyuKmpI7Lx31mM
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, patches@linaro.org
Message-ID: <61e82ebc-52c6-1023-1eea-6fa39775fdc5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] configure: Fix incorrect string comparison
 operator
References: <1515431442-23795-1-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1515431442-23795-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/08/2018 11:10 AM, Peter Maydell wrote:
> In commit c97d6d2cdf97ed we accidentally added code to configure
> that uses '=3D=3D' for string equality testing. This is a bashism --
> the portable way to write this is '=3D'.
>=20
> This fixes the "Unexpected operator error" complaint produced
> if the system /bin/sh is dash.
>=20
> Fixes: c97d6d2cdf97ed
> Reported-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> As an aside, it's annoying that this doesn't make configure fail;
> otherwise it wouldn't have got through my build tests.
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--84XfgO7NLbndYDkwTfLMyuKmpI7Lx31mM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpTp0EACgkQp6FrSiUn
Q2ooIAf/Yq0G2oYG8DmedTNy3ZxgjjI9tAAY89R8vRUdqC6a6CaDD6136PhYrT8Y
E9RrE8bzJIA6p2/YgfptlIqnRR7/ZKiOd4G9Oc9Y/fPQRryx3F6bZXmhLBwZMhaV
JTRcsHkos1wDPW1Tr6R1WW7UdGlJbVG0vm0VujiBrD4HcmppHu4z+R6lLr1D0BqZ
ypKsnWrrj9ASqLmdFSd7OCuF64yNrD+VZPKgnbGdcuy/YM34ckJxwbYHdUkcoVWg
ZPf7udbz3fVCZa3V6rdT4jV2AdXfvmURLWjTJpMEXJyfQwB1MZD6NAiTTlWX4NlW
6/GoRiorBHUKkHGHa73CFyOpjmQpZQ==
=bYYv
-----END PGP SIGNATURE-----

--84XfgO7NLbndYDkwTfLMyuKmpI7Lx31mM--
