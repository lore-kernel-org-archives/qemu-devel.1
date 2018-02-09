Received: from eggs.gnu.org ([2001:4830:134:3::10]:59233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ekCzH-0005AB-GI
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:01:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ekCzG-0005mU-O6
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:01:27 -0500
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-7-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5f5dd6af-9972-cf74-12a1-35899e005848@redhat.com>
Date: Fri, 9 Feb 2018 19:01:03 +0100
MIME-Version: 1.0
In-Reply-To: <20180208192328.16550-7-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6dW9TyWgXyeZzrIK5gba0eDwMlM7Jdjs0"
Subject: Re: [Qemu-devel] [PATCH 06/27] qcow2: Use QCryptoBlockCreateOptions
 in qcow2_create2()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6dW9TyWgXyeZzrIK5gba0eDwMlM7Jdjs0
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <5f5dd6af-9972-cf74-12a1-35899e005848@redhat.com>
Subject: Re: [PATCH 06/27] qcow2: Use QCryptoBlockCreateOptions in
 qcow2_create2()
References: <20180208192328.16550-1-kwolf@redhat.com>
 <20180208192328.16550-7-kwolf@redhat.com>
In-Reply-To: <20180208192328.16550-7-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-08 20:23, Kevin Wolf wrote:
> Instead of passing the encryption format name and the QemuOpts down, us=
e
> the QCryptoBlockCreateOptions contained in BlockdevCreateOptions.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2.c | 62 +++++++++++++++++++++++++++++++++++++++++++--------=
--------
>  1 file changed, 45 insertions(+), 17 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--6dW9TyWgXyeZzrIK5gba0eDwMlM7Jdjs0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlp94d8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AX/0H/2FGTD4Ft5kf5LR/oMEkdOjjWuqHecO6
kK/rP8VNlfncZtlyfzTHI1ybUoZNyLtOM3SCuFo52JOgsZkdcT4mZteD7qnjWwFp
I/hIRSCMK3fD22a9tblLdQ9w3dA6pdhsQCKeSbFktMwIu0OZ1Gfjcgo/qBrgvGk8
GLXl5lSVMiXnOk67Wl7SDFQDkHpujkAdqSB1H79gO6MeV0ScDFrihG5kOcvCSADz
Bine3W6+3cq8QXXc4bvCnZ7R2Bw6vHI9dKfnOthlP6CyRDh0aLVQLUfHRt94/E3c
7Itlzr+GfZPrNH5/OznAMripSzTeT7dtu1QtChDmBxDJijZttYgXJa0=
=uVSo
-----END PGP SIGNATURE-----

--6dW9TyWgXyeZzrIK5gba0eDwMlM7Jdjs0--
