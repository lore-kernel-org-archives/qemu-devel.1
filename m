Received: from eggs.gnu.org ([2001:4830:134:3::10]:45008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtxnh-0001xf-VL
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:17:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtxnd-0001sG-So
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:17:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dtxnd-0001rl-Je
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:17:29 -0400
References: <20170918024402.3265-1-famz@redhat.com>
	<20170918024402.3265-5-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <234e0e32-0f16-c621-6062-a2ee140efdf6@redhat.com>
Date: Mon, 18 Sep 2017 10:17:21 -0500
MIME-Version: 1.0
In-Reply-To: <20170918024402.3265-5-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PPjBB7fkQlAVjtXaBC9pJQuTloqbMmV2n"
Subject: Re: [Qemu-devel] [PATCH v8 04/13] tests: Add a test key pair
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Kamil Rytarowski <kamil@netbsd.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PPjBB7fkQlAVjtXaBC9pJQuTloqbMmV2n
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com,
 Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Kamil Rytarowski <kamil@netbsd.org>
Message-ID: <234e0e32-0f16-c621-6062-a2ee140efdf6@redhat.com>
Subject: Re: [PATCH v8 04/13] tests: Add a test key pair
References: <20170918024402.3265-1-famz@redhat.com>
 <20170918024402.3265-5-famz@redhat.com>
In-Reply-To: <20170918024402.3265-5-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/17/2017 09:43 PM, Fam Zheng wrote:
> This will be used by setup test user ssh.

Shouldn't the commit message have more details about WHY we are checking
in a private key? The conversation last time included useful gems such as=
:

Some guests require the key to exist prior to provisioning the guest,
and reusing a pre-built key avoids consuming entropy every time the
testsuite is run.  Because the private key is well-known, care must be
taken to use the key ONLY in situations that cannot be compromised by
external network clients.

>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/keys/id_rsa     | 27 +++++++++++++++++++++++++++
>  tests/keys/id_rsa.pub |  1 +
>  2 files changed, 28 insertions(+)
>  create mode 100644 tests/keys/id_rsa
>  create mode 100644 tests/keys/id_rsa.pub
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--PPjBB7fkQlAVjtXaBC9pJQuTloqbMmV2n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm/44EACgkQp6FrSiUn
Q2oHtAf/YbNReUNycX/0ogADao7O9dPQ2TFyR1MjZSui4Atz6Ud7hZdcwy9N24/d
xC61OpDVOUP1lKPL53RY9gtu6LqprtNiaZln7AExgQbm2akJtv9s1vITpfi25Q+7
7lopjYv3byTjGRtA0jcCRyhenpdys+y31+4ACoBlSfzjPNJY6kB4KUEKjyL9ehId
psxGAd2Y8uRPGmwvQl2szjyp7Zmkc2zmyH48lIXBlmpSVVe1BT7ylcsWaf1bO6yl
9PnJASb0DVXteRVLOBqzXuDAIq7wILGjNlhKTxiwM4gr3yJekwaz+pPgPCQEFfJw
N0//1IA8W/QqpJB1OyCK++RGKiAcFA==
=ERPc
-----END PGP SIGNATURE-----

--PPjBB7fkQlAVjtXaBC9pJQuTloqbMmV2n--
