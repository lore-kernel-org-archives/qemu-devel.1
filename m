Received: from eggs.gnu.org ([2001:4830:134:3::10]:52735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ebnyT-00028q-2V
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:41:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ebnyP-0004Op-6P
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:41:53 -0500
References: <20171123020832.8165-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <aaf4927a-5540-f3da-4a43-7550e9903690@redhat.com>
Date: Wed, 17 Jan 2018 14:41:22 +0100
MIME-Version: 1.0
In-Reply-To: <20171123020832.8165-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6kDJmJa1IBO1jizMAdu3fcs0Y0lZW94Gx"
Subject: Re: [Qemu-devel] [PATCH 00/17] iotests: Fix iotests for weird
 formats/options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6kDJmJa1IBO1jizMAdu3fcs0Y0lZW94Gx
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>
Message-ID: <aaf4927a-5540-f3da-4a43-7550e9903690@redhat.com>
Subject: Re: [PATCH 00/17] iotests: Fix iotests for weird formats/options
References: <20171123020832.8165-1-mreitz@redhat.com>
In-Reply-To: <20171123020832.8165-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-23 03:08, Max Reitz wrote:
> This series fixes the qemu-iotests for qcow, vmdk, qcow2 v2 and qcow2 v=
3
> with refcount_bits=3D1.
>=20
> Patches 1 and 2 contain real fixes (not urgent, though, so no need to
> hurry for 2.11--we can take them into 2.11 if we want to, but there is
> no absolute need for them).
>=20
> Patches 3 and 4 add blkdebug events to qcow and vmdk so iotests 020 can=

> work with them even after patch 10.
>=20
> Patches 5 and 6 are general "fixes" for the iotests infrastructure.
>=20
> Patches 7, 8, and 9 add some missing skips under certain circumstances
> to tests that need them.
>=20
> The rest of this series (patches 10 through 17) actually fix tests so
> they work for the formats and options mentioned above.
>=20
> (Fun fact: qcow v1 wasn't broken before this series.  But it would be
>  broken by patch 10 if I didn't include patch 3.  That is why I
>  mentioned it above.)
>=20
>=20
> Personal note:  I should really stop writing bash tests, at least as
> soon as there is QMP involved.  While working on this series I got
> sidetracked a bit and actually wrote some iotests.py functions that may=

> come in handy next time I write a test.
>=20
> (I hate to write Python tests because the boilerplate seems so large an=
d
>  the debugging is so hard.  But there is test 194 which shows that it i=
s
>  possible to write simple bash-like tests as well--and that is how I
>  should probably write tests from now on.)
>=20
>=20
> Max Reitz (17):
>   block/vmdk: Fix , instead of ; at end of line
>   qcow2: No persistent dirty bitmaps for compat=3D0.10
>   block/qcow: Add blkdebug events
>   block/vmdk: Add blkdebug events
>   iotests: Fix _img_info for backslashes
>   iotests: Drop format-specific in _filter_img_info
>   iotests: Forbid 020 for non-file protocols
>   iotests: Skip 103 for refcount_bits=3D1
>   iotests: Disable some tests for compat=3D0.10
>   iotests: Fix 020 for vmdk
>   iotests: Fix 051 for compat=3D0.10
>   iotests: Fix 059's reference output
>   iotests: Fix 067 for compat=3D0.10
>   iotests: Make 089 compatible with compat=3D0.10
>   iotests: Make 184 image-less
>   iotests: Make 191 work with qcow2 options
>   iotests: Filter compat-dependent info in 198

Thanks all the reviewers, I've applied all patches except for patch 9 to
my block branch.

Max


--6kDJmJa1IBO1jizMAdu3fcs0Y0lZW94Gx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpfUoISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A9QcH/3dbuz2GTc0Cv7gsTz3NMY0zrZpGHEUe
U8MgpO8FN75NWEwwnHjeePXpW1+vc5SaaTrQ/lvNUyRiiMUqx6cRRrWhvsstGVZp
pvGO9Aq3uIGtQoxu1acgO7448ty+rorCTqI59xWvLBPCkhxFtfZT3yYo4iB9IZqz
CMZD13CvODjAQLHrpCStIGUmnAdiLn/7e9+Ld5X+nPz/1S7FMgBKU2piBedbdbB1
jsOIy4mF+9mNSV6nFbVbnpuOt4M57sX3nRIDqHGkD3BzSkDZUlMzx/S4O/KvqVs9
9lhnDa0eEvAl84XqOXhEjgHGTWjiExtr7IOVbNS7xXO6TIiAuOWZQ0M=
=6XzP
-----END PGP SIGNATURE-----

--6kDJmJa1IBO1jizMAdu3fcs0Y0lZW94Gx--
