Received: from eggs.gnu.org ([2001:4830:134:3::10]:49832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNeZP-00047i-MO
	for qemu-devel@nongnu.org; Tue, 29 May 2018 09:21:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNeZO-0005eG-NS
	for qemu-devel@nongnu.org; Tue, 29 May 2018 09:21:47 -0400
References: <20180525163327.23097-1-kwolf@redhat.com>
	<20180525163327.23097-13-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7877147f-48bd-e69b-0d29-8ce15a83d6cd@redhat.com>
Date: Tue, 29 May 2018 15:21:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180525163327.23097-13-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TcxvNxlzUSTCR63SyprZpaqGBKD5W813M"
Subject: Re: [Qemu-devel] [PATCH 12/14] qemu-iotests: Rewrite 212 for
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
--TcxvNxlzUSTCR63SyprZpaqGBKD5W813M
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <7877147f-48bd-e69b-0d29-8ce15a83d6cd@redhat.com>
Subject: Re: [PATCH 12/14] qemu-iotests: Rewrite 212 for blockdev-create job
References: <20180525163327.23097-1-kwolf@redhat.com>
 <20180525163327.23097-13-kwolf@redhat.com>
In-Reply-To: <20180525163327.23097-13-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-25 18:33, Kevin Wolf wrote:
> This rewrites the test case 212 to work with the new x-blockdev-create
> job rather than the old synchronous version of the command.
>=20
> All of the test cases stay the same as before, but in order to be able
> to implement proper job handling, the test case is rewritten in Python.=

>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/212     | 483 +++++++++++++++++--------------------=
--------
>  tests/qemu-iotests/212.out | 181 ++++++++++-------
>  tests/qemu-iotests/group   |   2 +-
>  3 files changed, 290 insertions(+), 376 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/212 b/tests/qemu-iotests/212
> index e5a1ba77ce..5ac4947b82 100755
> --- a/tests/qemu-iotests/212
> +++ b/tests/qemu-iotests/212

[...]

> +import iotests
> +from iotests import imgfmt
> +
> +iotests.verify_image_format(supported_fmts=3D['parallels'])
> +iotests.verify_protocol(supported=3D['file'])
> +
> +def blockdev_create(vm, options):
> +    result =3D vm.qmp_log('x-blockdev-create', job_id=3D'job0', option=
s=3Doptions)
> +
> +    if 'return' in result:
> +        assert result['return'] =3D=3D {}
> +        vm.run_job('job0')
> +    iotests.log("")
> +
> +with iotests.FilePath('t.vdi') as disk_path, \

't.vdi', are you sure about that? ;-)

(You thought I wouldn't read the boiler plate anymore, didn't you?  Ha!)

With that fixed:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--TcxvNxlzUSTCR63SyprZpaqGBKD5W813M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsNU98ACgkQ9AfbAGHV
z0CCBgf/Vkk8Qt0i1Pv3Pboca5z8OVr8zSel95/OgaQ/c0CgQCa9ivRftEyov07f
REOsSGBmVGBbzInWwnCke7b8shRhHtQ9slwRf6+GTxl+BqDP2oFCHtu+TUHcvPb+
Ko/Eh0fPotM3FVYoewzmUOgdMQ0e+j7VnMfmYXmKKuo9mbPgWTuQIFjPwTWHSD1M
m87C81nqLw/H42ff4p2GvFidBLCyWv4Fcr1MT+xWVDSTIu6hHUEYEGXQXiDWmJgJ
6aPDLlFih5p5Pnj49bcnBmOA8HXFa22T6Q4f332MDPiNNE4bL9Dv8KgbMhHy7Ni2
SvHHzfjgkHJC/Z8Yp+yFJe4oG2A6VA==
=sNJY
-----END PGP SIGNATURE-----

--TcxvNxlzUSTCR63SyprZpaqGBKD5W813M--
