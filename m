Received: from eggs.gnu.org ([2001:4830:134:3::10]:40113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e1b7M-0000YZ-NZ
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 12:41:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e1b7L-0000ta-PC
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 12:41:24 -0400
References: <20170929170843.3711-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3a2b0230-c78f-fe60-4114-d04f1eaf4189@redhat.com>
Date: Mon, 9 Oct 2017 18:41:14 +0200
MIME-Version: 1.0
In-Reply-To: <20170929170843.3711-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="INPE8BrQIOI7QqtH98enD5j2FjBCECsdI"
Subject: Re: [Qemu-devel] [PATCH v3] iotests: Add test for dataplane
 mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--INPE8BrQIOI7QqtH98enD5j2FjBCECsdI
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <3a2b0230-c78f-fe60-4114-d04f1eaf4189@redhat.com>
Subject: Re: [PATCH v3] iotests: Add test for dataplane mirroring
References: <20170929170843.3711-1-mreitz@redhat.com>
In-Reply-To: <20170929170843.3711-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-29 19:08, Max Reitz wrote:
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

Applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--INPE8BrQIOI7QqtH98enD5j2FjBCECsdI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnbpqoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AHj8H/3C7wpA3+SiQwucpXZq6m2UfXgQyFfc4
doUWDTdam5gl7FVnSOQdIq1dKilBeVQac9padCVzhhTH2bWuoJRbx+8tasbJsra2
Xja3LfPFNqIjO8nf6MzhVwc9Ynt9XYif0d/You/oSheMkkwNxGOO0haAgNyPoSH8
ZlG1EHlXs+dyoIt599KR4NDtTqZPjuZOaunAteZTfusZn0NzQsyi8sjwxzvn8Hbc
m6AC1X+fmi8f2NejR+SQFbVc1I13doUR8CBE86BvW0suIQp0d4JzzVbBmukTAKEy
tBkhFn+YawPmx9OMRRw8eFFBIzKxLQogGK89m5RcS9iKSSjEHEPtM2U=
=udXg
-----END PGP SIGNATURE-----

--INPE8BrQIOI7QqtH98enD5j2FjBCECsdI--
