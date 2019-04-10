Received: from eggs.gnu.org ([209.51.188.92]:51900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEGdl-000189-4F
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 13:04:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEGdk-0006BN-6O
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 13:04:01 -0400
References: <cover.1551895813.git.berto@igalia.com>
	<e25b416f8646a476017f21a8484a05931b0e3f5a.1551895814.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1df28c23-7efe-310d-2955-432b9a4bb1ad@redhat.com>
Date: Wed, 10 Apr 2019 19:03:50 +0200
MIME-Version: 1.0
In-Reply-To: <e25b416f8646a476017f21a8484a05931b0e3f5a.1551895814.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wsXlU5LRRQdBRHDSEsLlWxlKtWPY1NAj4"
Subject: Re: [Qemu-devel] [PATCH v2 13/13] qemu-iotests: Test the
 x-blockdev-reopen QMP command
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
--wsXlU5LRRQdBRHDSEsLlWxlKtWPY1NAj4
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <1df28c23-7efe-310d-2955-432b9a4bb1ad@redhat.com>
Subject: Re: [PATCH v2 13/13] qemu-iotests: Test the x-blockdev-reopen QMP
 command
References: <cover.1551895813.git.berto@igalia.com>
 <e25b416f8646a476017f21a8484a05931b0e3f5a.1551895814.git.berto@igalia.com>
In-Reply-To: <e25b416f8646a476017f21a8484a05931b0e3f5a.1551895814.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.03.19 19:11, Alberto Garcia wrote:
> This patch adds several tests for the x-blockdev-reopen QMP command.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  tests/qemu-iotests/243     | 991 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/243.out |   5 +
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 997 insertions(+)
>  create mode 100644 tests/qemu-iotests/243
>  create mode 100644 tests/qemu-iotests/243.out
>=20
> diff --git a/tests/qemu-iotests/243 b/tests/qemu-iotests/243
> new file mode 100644
> index 0000000000..35b30092ca
> --- /dev/null
> +++ b/tests/qemu-iotests/243
> @@ -0,0 +1,991 @@

[...]

> +    # If an image has a backing file then the 'backing' option must be=

> +    # passed on reopen. We don't allow leaving the option out in this
> +    # case because it's unclear what the correct semantics would be.
> +    def test_missing_backing_options_1(self):

[...]

> +        # hd0 has no backing file: we can omit the 'backing' option
> +        self.reopen(opts)

[...]

> +        # Detach hd2 from hd0.
> +        self.reopen(opts, {'backing': None})
> +        self.reopen(opts, {}, "backing is missing for 'hd0'")

I don=E2=80=99t understand the second test.  hd0 has no default backing f=
ile and
it currently has no backing child attached to it.  Why would this call
fail now?

I=E2=80=99m asking because this no longer throws an error after =E2=80=9C=
block: Leave
BDS.backing_file constant=E2=80=9D of my =E2=80=9Cblock: Deal with filter=
s=E2=80=9D series.

Max


--wsXlU5LRRQdBRHDSEsLlWxlKtWPY1NAj4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlyuIfYACgkQ9AfbAGHV
z0C8IAf9F+SVG9TWeDOQfua02TtwAY/o9h92UZA6H3hfgXQNr4AkWDrqJgbKLoa8
2qswPehoi7vOF3KVv17I2Y270LbKwQOucb40QSJzGT2Pwbuted48nuSDmfujGikL
IIilMJ7zVkBIsetEVALew5V9bYr66rGIcouVytvqOXMjDFm5q0DsqsoERHDHRk/c
cK41W+K/zNBtHdaaa/2T6UjSX0JS2Ogq8ahwyIL2CiiHJu8Q81zDdGilg4UeOeYT
tjdk3VXOftOIkddxYmYUN+OA7TFTlppJkDcKYXttrYEWTS3S14HImFEFo37zHkha
2sR8nHdfrtCXeo3kdH/TxEumrO32pA==
=dRjU
-----END PGP SIGNATURE-----

--wsXlU5LRRQdBRHDSEsLlWxlKtWPY1NAj4--
