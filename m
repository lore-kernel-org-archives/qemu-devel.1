Received: from eggs.gnu.org ([2001:4830:134:3::10]:45282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gLwLn-0008Jy-ER
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 15:28:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gLwLj-0006Dv-HZ
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 15:28:53 -0500
References: <cover.1541595424.git.berto@igalia.com>
	<9f849af9a99edbe97e449843bb8c20f6aab8f6fe.1541595424.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <72e9f3bf-b80c-1331-b040-df3db08c1e8c@redhat.com>
Date: Sun, 11 Nov 2018 21:28:25 +0100
MIME-Version: 1.0
In-Reply-To: <9f849af9a99edbe97e449843bb8c20f6aab8f6fe.1541595424.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NrwWFZVZnpyaurDbYLq92qFkCI0nop1Jn"
Subject: Re: [Qemu-devel] [PATCH v4 10/15] qemu-io: Put flag changes in the
 options QDict in reopen_f()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NrwWFZVZnpyaurDbYLq92qFkCI0nop1Jn
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <72e9f3bf-b80c-1331-b040-df3db08c1e8c@redhat.com>
Subject: Re: [PATCH v4 10/15] qemu-io: Put flag changes in the options QDict
 in reopen_f()
References: <cover.1541595424.git.berto@igalia.com>
 <9f849af9a99edbe97e449843bb8c20f6aab8f6fe.1541595424.git.berto@igalia.com>
In-Reply-To: <9f849af9a99edbe97e449843bb8c20f6aab8f6fe.1541595424.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07.11.18 13:59, Alberto Garcia wrote:
> When reopen_f() puts a block device in the reopen queue, some of the
> new options are passed using a QDict, but others ("read-only" and the
> cache options) are passed as flags.
>=20
> This patch puts those flags in the QDict. This way the flags parameter
> becomes redundant and we'll be able to get rid of it in a subsequent
> patch.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  qemu-io-cmds.c             | 27 ++++++++++++++++++++++++++-
>  tests/qemu-iotests/133     |  9 +++++++++
>  tests/qemu-iotests/133.out |  8 ++++++++
>  3 files changed, 43 insertions(+), 1 deletion(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--NrwWFZVZnpyaurDbYLq92qFkCI0nop1Jn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvokOkACgkQ9AfbAGHV
z0AQRggAqJT8reZpHPNJV3ExmvpOzrRO42QpDfnTayBj0fXndp9+vrzgThsCe5vm
Q/78fFOGl1ZrVRybZ9DhnodOhZeGGl5+SNcFUuFIyjJtOeDI92i504oWQyhIjJE2
wCpLDho3VPwQFcYZK5PV6t/lCr47X8RBcOMTy2ndEDvldAJGFfwo4jb5Vi8g8plK
tlmoB5dRq5YaQqzVM1ndjPFbPv7T+nWRUAjS3zWBHMNihJxl/buAOS91UtaK1JYb
FsQt4L96ed1ButTa4Fh+4FaGB+mVwRq2175wxenCWLP/Z3lya9ZXHNtvpFVOZE3q
ptuUSkdhzBGt3U2LumoX6oTVuDaZGQ==
=S7A+
-----END PGP SIGNATURE-----

--NrwWFZVZnpyaurDbYLq92qFkCI0nop1Jn--
