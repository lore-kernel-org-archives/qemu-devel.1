Received: from eggs.gnu.org ([2001:4830:134:3::10]:60737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eX9IQ-0004Ry-Qu
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:27:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eX9I7-0004EV-17
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:27:14 -0500
References: <20171222151846.28110-1-kwolf@redhat.com>
	<20171222151846.28110-6-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dd37d402-f68a-46bc-5ca4-e3bb6c56b30e@redhat.com>
Date: Thu, 4 Jan 2018 11:24:44 -0600
MIME-Version: 1.0
In-Reply-To: <20171222151846.28110-6-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="giXmPZQJXyEZT32B91at7aLIctdsAC82S"
Subject: Re: [Qemu-devel] [PULL v3 05/35] test-bdrv-drain: Test BlockDriver
 callbacks for drain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--giXmPZQJXyEZT32B91at7aLIctdsAC82S
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Message-ID: <dd37d402-f68a-46bc-5ca4-e3bb6c56b30e@redhat.com>
Subject: Re: [Qemu-devel] [PULL v3 05/35] test-bdrv-drain: Test BlockDriver
 callbacks for drain
References: <20171222151846.28110-1-kwolf@redhat.com>
 <20171222151846.28110-6-kwolf@redhat.com>
In-Reply-To: <20171222151846.28110-6-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/22/2017 09:18 AM, Kevin Wolf wrote:
> This adds a test case that the BlockDriver callbacks for drain are
> called in bdrv_drained_all_begin/end(), and that both of them are calle=
d
> exactly once.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/test-bdrv-drain.c | 137 ++++++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/Makefile.include  |   2 +
>  2 files changed, 139 insertions(+)
>  create mode 100644 tests/test-bdrv-drain.c

Hmm. This adds a new binary that should be listed in tests/.gitignore
for the sake of in-tree compilation.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--giXmPZQJXyEZT32B91at7aLIctdsAC82S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpOY1wACgkQp6FrSiUn
Q2qFowgAmCP+WHsVyRN71dbk+lFvXJEPCIP/kewpMYLnL/DGgdF9qTW9xTtqKfBt
dGiPmOFf2iSb1IxFbcMk2jP7QicfwCcpAolyD9fluYIveIVQF08LiyV8YMMqfLLQ
a2GNSAcwE2uCAQeUaHJJ5C53F+MZpdID4OcXjYCc8bMTAVcmE53DOdv8rky8ZWKA
gD5+NUlG9Ac22NirqVSwohx2SUfGc9wGiPXfKhDoKSjeTJJp/Qm4uwUnhcGFjv0T
+ocM2U/c9OnoyxYIGiOO7epCX0UCkmIaQNSqGLY+9T+B68Zhcs/JCzX3NiyyGI3Y
eq4iyOVRX8FNh/mWmRVjRx0zp81cgQ==
=eYms
-----END PGP SIGNATURE-----

--giXmPZQJXyEZT32B91at7aLIctdsAC82S--
