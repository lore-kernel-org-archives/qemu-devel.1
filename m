Received: from eggs.gnu.org ([2001:4830:134:3::10]:35021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ePvz2-0001YP-Ld
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 14:49:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ePvz1-0006ph-UI
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 14:49:24 -0500
References: <20171215080446.10671-1-famz@redhat.com>
	<20171215080446.10671-3-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <77427d85-f950-069b-938f-7f67ba66a906@redhat.com>
Date: Fri, 15 Dec 2017 13:49:14 -0600
MIME-Version: 1.0
In-Reply-To: <20171215080446.10671-3-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="K2OUW6gp7wl21Inafff99DjXBadUvhtjR"
Subject: Re: [Qemu-devel] [PATCH 2/2] iotests: Test creating overlay when
 guest running
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--K2OUW6gp7wl21Inafff99DjXBadUvhtjR
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <77427d85-f950-069b-938f-7f67ba66a906@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] iotests: Test creating overlay when
 guest running
References: <20171215080446.10671-1-famz@redhat.com>
 <20171215080446.10671-3-famz@redhat.com>
In-Reply-To: <20171215080446.10671-3-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 02:04 AM, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/qemu-iotests/153     | 4 ++++
>  tests/qemu-iotests/153.out | 3 +++
>  2 files changed, 7 insertions(+)
>=20
> diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
> index fa25eb24bd..22cb9c69a7 100755
> --- a/tests/qemu-iotests/153
> +++ b/tests/qemu-iotests/153
> @@ -32,6 +32,7 @@ _cleanup()
>  {
>      _cleanup_test_img
>      rm -f "${TEST_IMG}.base"
> +    rm -f "${TEST_IMG}.overlay"
>      rm -f "${TEST_IMG}.convert"

Conflicts with the series to clean up iotests to run in a per-test
directory with automatic cleanup, but the resolution is obvious.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--K2OUW6gp7wl21Inafff99DjXBadUvhtjR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlo0JzoACgkQp6FrSiUn
Q2qVHAgAg2GWrEQ8a0i39MT3AtBQ0dV9DgMAej5cmZa5vCEAwKgBKliGw8aaX/O3
wIqWUMDf6G/Nbv2aVS8/uLXz3FrzMtrO8mfbGlzwLCK++sLH+RpcDislW3amBen5
+DtEBCfFP9Njt1IdylS+/4SzRwBlpj5O9WAn8dAd7fgPfkdofl3lMl0iu0OpQI4C
A5SgtlhhDiyDWSn2qJOr7hg9ZPEndG6hs7U+TsGxUXJopdMOEPinrMMdQuADQhOh
xc6p7u/+tE+v29kCzsMeUnRhb0pVLpL9yBgVOTaQl80YZxgipIA6PVeJoOQT8u70
F9y0wzHejlDJjxjCfJeu0xG61DCF2g==
=mZUw
-----END PGP SIGNATURE-----

--K2OUW6gp7wl21Inafff99DjXBadUvhtjR--
