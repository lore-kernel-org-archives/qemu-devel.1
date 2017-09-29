Received: from eggs.gnu.org ([2001:4830:134:3::10]:58540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dxzAG-0008Dv-LQ
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 13:33:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dxzAF-0005OC-KE
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 13:33:28 -0400
References: <20170929170843.3711-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cf6e8f28-760c-57ae-184b-d9b07c28f0f2@redhat.com>
Date: Fri, 29 Sep 2017 12:33:16 -0500
MIME-Version: 1.0
In-Reply-To: <20170929170843.3711-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ntXxq21J7iUNSqGOP8PTXJ7i8rJrSQQlx"
Subject: Re: [Qemu-devel] [PATCH v3] iotests: Add test for dataplane
 mirroring
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Jeff Cody <jcody@redhat.com>
List-ID: <qemu-devel.nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ntXxq21J7iUNSqGOP8PTXJ7i8rJrSQQlx
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Jeff Cody <jcody@redhat.com>
Message-ID: <cf6e8f28-760c-57ae-184b-d9b07c28f0f2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] iotests: Add test for dataplane mirroring
References: <20170929170843.3711-1-mreitz@redhat.com>
In-Reply-To: <20170929170843.3711-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/29/2017 12:08 PM, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> v3: Make the test actually pass (the reference output from v2 only
>     worked with v1 of the test...)
> ---
>  tests/qemu-iotests/127     | 97 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/127.out | 14 +++++++
>  tests/qemu-iotests/group   |  1 +
>  3 files changed, 112 insertions(+)
>  create mode 100755 tests/qemu-iotests/127
>  create mode 100644 tests/qemu-iotests/127.out
>=20

> +_cleanup()
> +{
> +    _cleanup_qemu
> +    _cleanup_test_img
> +    _rm_test_img "$TEST_IMG.overlay0"
> +    _rm_test_img "$TEST_IMG.overlay1"
> +}
> +trap "_cleanup; exit \$status" 0 1 2 3 15

Semantic conflict with Jeff's patches for './check -s' to preserve
intermediate files.  Otherwise,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ntXxq21J7iUNSqGOP8PTXJ7i8rJrSQQlx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnOg9wACgkQp6FrSiUn
Q2qcdAf/Yp6BpJaGkXJuqq93otmun9xUJNovIc+V070Lgh0uHdfjRX9eHxY+CEa3
zSxlDt6FF88fx17PnowgloZgqCc3YTv56q7DvpiBgOQhgXtPXVg7xrQ2/tpRzSW2
dH8ymz5sgFkXvZJSievu5Rqpwu1ZqWswFv+vZMe2DePehkePk7iqIaxW7uZpoqHV
lZx1KiPctSb7edxHILkgkr1ap9/NWXKCLQ3MlPx6ErDpSmyOC3soxIa4uEUW+XWY
d7Ju3vmrDSeugEJAOiF23tgvKdAOV7GZ+sthPFCZQxccL/b80d0FCw8RPbUPYRCN
HvmB1DDwDWVo8Whh7AwJ32mXJ7G0Gw==
=ZgHw
-----END PGP SIGNATURE-----

--ntXxq21J7iUNSqGOP8PTXJ7i8rJrSQQlx--
