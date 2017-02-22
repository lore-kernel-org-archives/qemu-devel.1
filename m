Received: from eggs.gnu.org ([2001:4830:134:3::10]:40779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgW88-00082Y-Js
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:34:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgW87-0000As-SP
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:34:48 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-4-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <31b9aaeb-d27f-042c-719d-b1099b6732f8@redhat.com>
Date: Wed, 22 Feb 2017 13:34:37 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-4-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VnPnhWx0E46FVkpXJp0GpLmOiLE7Fkpet"
Subject: Re: [Qemu-devel] [PATCH 03/54] mirror: Resize active commit base in
 mirror_run()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VnPnhWx0E46FVkpXJp0GpLmOiLE7Fkpet
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <31b9aaeb-d27f-042c-719d-b1099b6732f8@redhat.com>
Subject: Re: [PATCH 03/54] mirror: Resize active commit base in mirror_run()
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-4-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-4-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:57, Kevin Wolf wrote:
> This is more consistent with the commit block job, and it moves the cod=
e
> to a place where we already have the necessary BlockBackends to resize
> the base image when bdrv_truncate() is changed to require a BdrvChild.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/mirror.c | 50 ++++++++++++++++++++++----------------------------=

>  1 file changed, 22 insertions(+), 28 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--VnPnhWx0E46FVkpXJp0GpLmOiLE7Fkpet
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlithV0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AbncH/15Vie3AVtuqYNpTl4R3UBv7PYc2Va6d
vSld+LwoRmcQ0aV/pt/ZmwxwzqpeNyhmo0bJinPLddkcPlAVRY6y18iURk0s+l5g
ufz8J6IlrkL2l0yva/3COZ2aovtiVNY2QI9AUbwdZeXahv6nMhpUm3Lfg1AXMngt
bZtq21ViB3s5Vsd/mGryrARkBnhigljlGaSFO3oltVga4s8roAQXWKXBZsZ+I/rP
5UAyxULmpNd8/dnEWafvIxoBvbB+NE1sem5BRni+lR8bnG7Z5hMzjtKGQ3uAbo1z
LOGImGihOlIcRS6syK2Gdlxtm5xj2ulS7b0LH1dudx1ToFHeoZgsvJw=
=hZN/
-----END PGP SIGNATURE-----

--VnPnhWx0E46FVkpXJp0GpLmOiLE7Fkpet--
