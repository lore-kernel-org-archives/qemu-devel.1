Received: from eggs.gnu.org ([2001:4830:134:3::10]:47529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNeQW-000074-HG
	for qemu-devel@nongnu.org; Tue, 29 May 2018 09:12:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNeQV-0007DZ-H1
	for qemu-devel@nongnu.org; Tue, 29 May 2018 09:12:36 -0400
References: <20180525163327.23097-1-kwolf@redhat.com>
	<20180525163327.23097-12-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ad8942cc-97e5-0e30-c84e-fe04064e96ce@redhat.com>
Date: Tue, 29 May 2018 15:12:20 +0200
MIME-Version: 1.0
In-Reply-To: <20180525163327.23097-12-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UEX3NGIvNw8ZbcAqVIcCoCFn6xfUKLB0J"
Subject: Re: [Qemu-devel] [PATCH 11/14] qemu-iotests: Rewrite 211 for
 blockdev-create job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UEX3NGIvNw8ZbcAqVIcCoCFn6xfUKLB0J
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <ad8942cc-97e5-0e30-c84e-fe04064e96ce@redhat.com>
Subject: Re: [PATCH 11/14] qemu-iotests: Rewrite 211 for blockdev-create job
References: <20180525163327.23097-1-kwolf@redhat.com>
 <20180525163327.23097-12-kwolf@redhat.com>
In-Reply-To: <20180525163327.23097-12-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-25 18:33, Kevin Wolf wrote:
> This rewrites the test case 211 to work with the new x-blockdev-create
> job rather than the old synchronous version of the command.
>=20
> All of the test cases stay the same as before, but in order to be able
> to implement proper job handling, the test case is rewritten in Python.=

>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/211     | 384 ++++++++++++++++++-------------------=
--------
>  tests/qemu-iotests/211.out | 123 ++++++++-------
>  tests/qemu-iotests/group   |   2 +-
>  3 files changed, 227 insertions(+), 282 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/211 b/tests/qemu-iotests/211
> index 1edec26517..2fd89cfb32 100755
> --- a/tests/qemu-iotests/211
> +++ b/tests/qemu-iotests/211

[...]
> +    iotests.img_info_log(disk_path)
> +    iotests.log(iotests.filter_testfiles(iotests.qemu_img_pipe(
> +        'map', '--output=3Djson', disk_path)))

The _filter_qemu_img_map wasn't there to filter the filename (it isn't
present in the JSON output anyway, from what I can see), but to filter
the offset.

I don't think we really need to filter the offset here, though, because
this test is for a single specific image format with very specific
options, so it should be OK.

(The only thing is that the filter_testfiles() call seems unnecessary.)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--UEX3NGIvNw8ZbcAqVIcCoCFn6xfUKLB0J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsNUbQACgkQ9AfbAGHV
z0B83wgAqTzebx7VGqTUG+9dxsXF6hCfRw8DLnvbRrs99zGp/gyCYhwORrgho37Z
Xb/yeKWaiugpoh03OQA3ZVl2S3XPVoZDiHtSfq2dMdM2DQvHhFPVjXtj/CLb1XMo
u6fwYphrO0rNR5tc/E+0tfSww+YNM9vuNx3o6hP9byMxHmlqbQCVAX/jvRv+oMHj
IaIqdX3VlDiNIrCeDHndqj5XIORhVG/fHwFv2Pjf3OhVjBKtkHlYHSuKcWLRPIkL
lCNzP9UYWSe4Woy/XRSLvefpq5WjUz97tyCqSwlRagXc8nM5lKYTWaPbguSwSw8A
FAVHldL3u6U1r7n8j+v9xlmIX9xq+Q==
=VMEb
-----END PGP SIGNATURE-----

--UEX3NGIvNw8ZbcAqVIcCoCFn6xfUKLB0J--
