Received: from eggs.gnu.org ([2001:4830:134:3::10]:47352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fOhuq-0007sF-KB
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:08:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fOhul-0007ZV-Kr
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:08:16 -0400
References: <20180509200059.31125-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5c7de9b6-6611-4f4e-8b5c-aa63573a25d8@redhat.com>
Date: Fri, 1 Jun 2018 13:08:00 +0200
MIME-Version: 1.0
In-Reply-To: <20180509200059.31125-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DWFgj1hKb1c74f2zIJ2GRHgpJlJLmrFJx"
Subject: Re: [Qemu-devel] [PATCH v2 0/2] qcow2: Repair OFLAG_COPIED when
 fixing leaks
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
--DWFgj1hKb1c74f2zIJ2GRHgpJlJLmrFJx
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <5c7de9b6-6611-4f4e-8b5c-aa63573a25d8@redhat.com>
Subject: Re: [PATCH v2 0/2] qcow2: Repair OFLAG_COPIED when fixing leaks
References: <20180509200059.31125-1-mreitz@redhat.com>
In-Reply-To: <20180509200059.31125-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 22:00, Max Reitz wrote:
> Suppose you have an image with consistent OFLAG_COPIED and refcounts.
> Now further suppose that image has leaked clusters (single reference,
> but refcount 2).  When checking such an image with qemu-img check, it
> will notify you of the leakage, and that's it.
>=20
> Now when trying to repair that image, you naturally use -r leaks becaus=
e
> that should be sufficient and you want to give qemu-img check just as
> many "permissions" as it needs so it doesn't destroy your image by
> accident.  But while the qcow2 driver will fix the refcounts, alas! it
> will now complain about OFLAG_COPIED because that should be set now.
> However, it will not set that without -r all.  So, congratulations, now=

> you have an image that qemu-img check tells you is really corrupted.
>=20
> This series makes -r leaks fix OFLAG_COPIED as well, but only if
> repairing the refcounts was completely successful.
>=20
> There is a Red Hat Bugzilla entry here:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1527085
>=20
> ...but I'm afraid the bug description is set to confidential, although =
I
> don't know why.  Sorry. :-/
> For everyone who cannot read it, let's say the test case in this series=

> may very well be a good indication of what you don't see.
>=20
>=20
> v2:
> - Reworded the comment in patch 2 on why the test does not support
>   refcount_bits=3D1 -- it's not just because of the snapshotting, but
>   mostly because we test OFLAG_COPIED and refcount_bits=3D1 won't get u=
s
>   far there [Eric]
>=20
>=20
> git-backport-diff against v1:
>=20
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream p=
atch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, resp=
ectively
>=20
> 001/2:[----] [--] 'qcow2: Repair OFLAG_COPIED when fixing leaks'
> 002/2:[0003] [FC] 'iotests: Repairing error during snapshot deletion'
>=20
>=20
> Max Reitz (2):
>   qcow2: Repair OFLAG_COPIED when fixing leaks
>   iotests: Repairing error during snapshot deletion
>=20
>  block/qcow2-refcount.c     | 25 ++++++++-----
>  tests/qemu-iotests/217     | 90 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/217.out | 42 ++++++++++++++++++++++
>  tests/qemu-iotests/group   |  1 +
>  4 files changed, 150 insertions(+), 8 deletions(-)
>  create mode 100755 tests/qemu-iotests/217
>  create mode 100644 tests/qemu-iotests/217.out

Applied to my block branch.

Max


--DWFgj1hKb1c74f2zIJ2GRHgpJlJLmrFJx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsRKRAACgkQ9AfbAGHV
z0DqmAf+PyR/xjRkvKbU9RlRy4eC2PdpVALFBO0LeiN/F136sOLpP1siEDLIAdmx
uT83Gq7/T9lazjtOKiaM7IcudHlVnkKiO1Y+Tizbvv3Em7vg+juZlrMwFPYAz0kd
5mfygZ7szEm1JQiaFL1tM2P/Mj5i34ugwA+tFs3OSxEHQlk29ZYdjJhaaXlYa47q
CzH5c8SeE/kAXVy7tBvJW87f2H+zw+zypRowTdKRktkD0yZKsMMgE/jW9M7nRI/f
J5ZQgIZPLjoi6wLSDhrfjn5qozV3aMNIC1Vx75PA+1S3fZWdRNgNUAevXRI4kkN3
O2111Usr1oa4S01ej/aJoORy37yYyg==
=7Blu
-----END PGP SIGNATURE-----

--DWFgj1hKb1c74f2zIJ2GRHgpJlJLmrFJx--
