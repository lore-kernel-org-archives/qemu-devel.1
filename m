Received: from eggs.gnu.org ([2001:4830:134:3::10]:34626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cijqu-0005Oj-5L
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:38:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cijqt-0004ps-Ck
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:38:12 -0500
References: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
	<1488286469-9381-32-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1da5fa0d-ce3f-a0b9-fda1-7c326bf1ea19@redhat.com>
Date: Tue, 28 Feb 2017 16:38:03 +0100
MIME-Version: 1.0
In-Reply-To: <1488286469-9381-32-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hNnmcWGVvq3KXlh4N23rOAjxEREjNckn9"
Subject: Re: [Qemu-devel] [PATCH v3 31/44] blockjob: Factor out
 block_job_remove_all_bdrv()
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
--hNnmcWGVvq3KXlh4N23rOAjxEREjNckn9
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <1da5fa0d-ce3f-a0b9-fda1-7c326bf1ea19@redhat.com>
Subject: Re: [PATCH v3 31/44] blockjob: Factor out block_job_remove_all_bdrv()
References: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
 <1488286469-9381-32-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488286469-9381-32-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 28.02.2017 13:54, Kevin Wolf wrote:
> In some cases, we want to remove op blockers on intermediate nodes
> before the whole block job transaction has completed (because they bloc=
k
> restoring the final graph state during completion). Provide a function
> for this.
>=20
> The whole block job lifecycle is a bit messed up and it's hard to
> actually do all things in the right order, but I'll leave simplifying
> this for another day.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  blockjob.c               | 20 +++++++++++++-------
>  include/block/blockjob.h |  9 +++++++++
>  2 files changed, 22 insertions(+), 7 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--hNnmcWGVvq3KXlh4N23rOAjxEREjNckn9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAli1mVsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Ajl8H/26Y7uPkcPtmjjyFlFKGzEAcea7eM2Y4
BGrnXuj4jaT1VEd2kh2T8QMwB2+IjZHXEdpOQP7OBSV10xGVRvRYteQ/GjKASkw7
ZeYdG6AczYBFtOXnkS5pTNfse7AERyA9qtsVI8A+rrF9yQpFNKN3aaluRuYYsjHW
rot7TzRqmhcgXAD0HnItRwGfzspXtJoIId0brGqsHnRoCVXej9uc6NYzFG8swsST
psKOtOFRe0oP5UhNH5RgvrrInuZZlvP0AV3QZ7JhYEhHDbBkbACzrxPCszMkG1d3
ipUXuWHpDbz/Eqm36RmSaZz7yb8k0NCRfXFg1Ytfmln/Mh32K5tQVV4=
=kRj+
-----END PGP SIGNATURE-----

--hNnmcWGVvq3KXlh4N23rOAjxEREjNckn9--
