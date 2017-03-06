Received: from eggs.gnu.org ([2001:4830:134:3::10]:56738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ckzxZ-0006Gk-VG
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 16:14:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ckzxY-0001Ti-Mb
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 16:14:25 -0500
References: <148883028050.294.11008388161426256258@0e2666bad730>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <eeca4643-db8b-4092-0afc-2e9b1c1213d2@redhat.com>
Date: Mon, 6 Mar 2017 22:14:16 +0100
MIME-Version: 1.0
In-Reply-To: <148883028050.294.11008388161426256258@0e2666bad730>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="X3rooD95P4F0lR7BGuA1hUpcxqFfDEc2J"
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/3] block: Add errp to b{lk,
 drv}_turncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--X3rooD95P4F0lR7BGuA1hUpcxqFfDEc2J
From: Max Reitz <mreitz@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <eeca4643-db8b-4092-0afc-2e9b1c1213d2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/3] block: Add errp to b{lk,
 drv}_turncate()
References: <148883028050.294.11008388161426256258@0e2666bad730>
In-Reply-To: <148883028050.294.11008388161426256258@0e2666bad730>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.03.2017 20:58, no-reply@patchew.org wrote:
> Hi,
>=20
> This series seems to have some coding style problems. See output below =
for
> more information:
>=20
> Message-id: 20170306195255.15806-1-mreitz@redhat.com
> Subject: [Qemu-devel] [PATCH for-2.10 0/3] block: Add errp to b{lk, drv=
}_turncate()
> Type: series
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
>=20
> BASE=3Dbase
> n=3D1
> total=3D$(git log --oneline $BASE.. | wc -l)
> failed=3D0
>=20
> # Useful git options
> git config --local diff.renamelimit 0
> git config --local diff.renames True
>=20
> commits=3D"$(git log --format=3D%H --reverse $BASE..)"
> for c in $commits; do
>     echo "Checking PATCH $n/$total: $(git log -n 1 --format=3D%s $c)...=
"
>     if ! git show $c --format=3Demail | ./scripts/checkpatch.pl --mailb=
ack -; then
>         failed=3D1
>         echo
>     fi
>     n=3D$((n+1))
> done
>=20
> exit $failed
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> From https://github.com/patchew-project/qemu
>  - [tag update]      patchew/1488826849-32384-1-git-send-email-armbru@r=
edhat.com -> patchew/1488826849-32384-1-git-send-email-armbru@redhat.com
>  * [new tag]         patchew/20170306195255.15806-1-mreitz@redhat.com -=
> patchew/20170306195255.15806-1-mreitz@redhat.com
> Auto packing the repository for optimum performance. You may also
> run "git gc" manually. See "git help gc" for more information.
> Switched to a new branch 'test'
> 4ef1757 block: Add some bdrv_truncate() error messages
> 3e348c6 block: Add errp to BD.bdrv_truncate()
> 1ba2c64 block: Add errp to b{lk, drv}_truncate()
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> Checking PATCH 1/3: block: Add errp to b{lk, drv}_truncate()...
> Checking PATCH 2/3: block: Add errp to BD.bdrv_truncate()...
> Checking PATCH 3/3: block: Add some bdrv_truncate() error messages...
> ERROR: suspect code indent for conditional statements (7, 11)
> #35: FILE: block/file-posix.c:1358:
>         if (offset > raw_getlength(bs)) {
> +           error_setg(errp, "Cannot grow device files");
>=20
> total: 1 errors, 0 warnings, 73 lines checked

Surrounding conditional block is not correctly aligned; pre-existing,
didn't notice. Will fix in v2.

Max

>=20
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>=20
> =3D=3D=3D OUTPUT END =3D=3D=3D
>=20
> Test command exited with code: 1
>=20
>=20
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org
>=20



--X3rooD95P4F0lR7BGuA1hUpcxqFfDEc2J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAli90SgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ATvoH/iJ+pEOuegSonA2b1wzmT/fqcEpKAsYq
8UKbonbJFCzOkcrPEZJXUUF2ugv40sPcKoZrS2PzFqkSLa+kt2L7s3ua1YStaurx
SNXyH9YPXfZn2Iv+yERmQCi29hlOE6c12CGTVE53t1k67hZudqmn1AjwtxiKW1kf
OkeBBnRcRsNei5Ry0vt3/nlhSMYfMphvg7jYC/+Icotjg7hR0xvaQ6dLFIgK0F9o
06hD4Th+cUHHKjvCx8sh80OZtzfbhdqueKRsL6fRjXCdE843WgcpG0w2AhpcvUND
P9pCAy+xQkDxd+UEZgsz5w26MlZVG8OXZox53WCvUHTFy87A+8azMVg=
=7GLM
-----END PGP SIGNATURE-----

--X3rooD95P4F0lR7BGuA1hUpcxqFfDEc2J--
