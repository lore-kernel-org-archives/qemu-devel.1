Received: from eggs.gnu.org ([209.51.188.92]:35708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gi2U8-0001Tt-6R
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 14:28:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gi2U6-000120-Tv
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 14:28:52 -0500
References: <20190111191401.18317-1-armbru@redhat.com>
	<20190111191401.18317-2-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <40bf4388-bc85-aa1f-2723-d2d200181993@redhat.com>
Date: Fri, 11 Jan 2019 13:28:43 -0600
MIME-Version: 1.0
In-Reply-To: <20190111191401.18317-2-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Xyf50S3kUeGdNeqytWKLlQI9BdyKdHUPr"
Subject: Re: [Qemu-devel] [PATCH 1/1] block: Eliminate the S_1KiB, S_2KiB,
 ... macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, lbloch@janustech.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Xyf50S3kUeGdNeqytWKLlQI9BdyKdHUPr
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, lbloch@janustech.com, qemu-block@nongnu.org
Message-ID: <40bf4388-bc85-aa1f-2723-d2d200181993@redhat.com>
Subject: Re: [PATCH 1/1] block: Eliminate the S_1KiB, S_2KiB, ... macros
References: <20190111191401.18317-1-armbru@redhat.com>
 <20190111191401.18317-2-armbru@redhat.com>
In-Reply-To: <20190111191401.18317-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/11/19 1:14 PM, Markus Armbruster wrote:
> We define 54 macros for the powers of two >=3D 1024.  We use six, in si=
x
> macro definitions.  Four of them could just as well use the common MiB
> macro, so do that.  The remaining two can't, because they get passed
> to stringify.  Replace the macro by the literal number there.
> Slightly harder to read in one instance (1048576 vs. S_1MiB), so add a
> comment there.  The other instance is a wash: 65536 vs S_64KiB.  65536
> has been good enough for more than seven years there.
>=20
> This effectively reverts commit 540b8492618 and 1240ac558d3.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/qcow2.h        | 10 +++---
>  block/vdi.c          |  3 +-
>  include/qemu/units.h | 73 --------------------------------------------=

>  3 files changed, 7 insertions(+), 79 deletions(-)

Renders part of my v3 series useless (since I effectively did the same
reversions), but is indeed the simplest baseline that can possibly work.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--Xyf50S3kUeGdNeqytWKLlQI9BdyKdHUPr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw47msACgkQp6FrSiUn
Q2orxQf+KNekI5gQ6n6JpRZxrDSJPISm+ZMCXvL9wHzd/QI37jSKJ9xqblcHRc64
s+IbfOt4sxMguh4xDeAq/hL8KFSDCupqOFzLePd7HN2SPJqP+uoakg1FJkKqkIyT
i1Of00D/ZCIKZF+IWd6k1sPBiO/ZNJ5haqDJCAmH6peYYJI/bzzkwGMEGTk0yR6Y
noVQjlpaw419PUK7NeeBU/e4Wb4oorRgMOML0Vl7sW/xuuHJk1INro9txATCan43
MPtoH3QfdHZbA9M3j6jyJkSkx4QJEteT4cDae4aI1Bir2dvrVb6n0DGrsVvQ8pxk
Lk5Yv6U8KPDPjtvGd5/cGSXjjrS2Kg==
=1ohe
-----END PGP SIGNATURE-----

--Xyf50S3kUeGdNeqytWKLlQI9BdyKdHUPr--
