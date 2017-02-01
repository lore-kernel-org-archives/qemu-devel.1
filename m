Received: from eggs.gnu.org ([2001:4830:134:3::10]:33194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZ3vO-0001z4-DG
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 18:02:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZ3vN-0007Gr-Gr
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 18:02:50 -0500
References: <1479837270-79005-1-git-send-email-vsementsov@virtuozzo.com>
	<1479837270-79005-13-git-send-email-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <66a96c8e-c291-0501-37da-9e815d87240c@redhat.com>
Date: Thu, 2 Feb 2017 00:02:37 +0100
MIME-Version: 1.0
In-Reply-To: <1479837270-79005-13-git-send-email-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vGJ686kIF2V4acXlJpWWs6a3De0ak8WHw"
Subject: Re: [Qemu-devel] [PATCH 12/17] migration: add postcopy migration of
 dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vGJ686kIF2V4acXlJpWWs6a3De0ak8WHw
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com,
 famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com,
 quintela@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org,
 dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com
Message-ID: <66a96c8e-c291-0501-37da-9e815d87240c@redhat.com>
Subject: Re: [PATCH 12/17] migration: add postcopy migration of dirty bitmaps
References: <1479837270-79005-1-git-send-email-vsementsov@virtuozzo.com>
 <1479837270-79005-13-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1479837270-79005-13-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 22.11.2016 18:54, Vladimir Sementsov-Ogievskiy wrote:
> Postcopy migration of dirty bitmaps. Only named dirty bitmaps,
> associated with root nodes and non-root named nodes are migrated.
>=20
> If destination qemu is already containing a dirty bitmap with the same =
name
> as a migrated bitmap (for the same node), than, if their granularities =
are
> the same the migration will be done, otherwise the error will be genera=
ted.
>=20
> If destination qemu doesn't contain such bitmap it will be created.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/migration/block.h      |   1 +
>  include/migration/migration.h  |   4 +
>  migration/Makefile.objs        |   2 +-
>  migration/block-dirty-bitmap.c | 679 +++++++++++++++++++++++++++++++++=
++++++++
>  migration/migration.c          |   3 +
>  migration/savevm.c             |   2 +
>  migration/trace-events         |  14 +
>  vl.c                           |   1 +
>  8 files changed, 705 insertions(+), 1 deletion(-)
>  create mode 100644 migration/block-dirty-bitmap.c

=46rom someone who doesn't know a thing about migration, a rather cursory=
:

Reviewed-by: Max Reitz <mreitz@redhat.com>

But at least that probably means the set of code covered by this R-b is
disjoint from the set of code covered by Juan's R-b. :-)

Max


--vGJ686kIF2V4acXlJpWWs6a3De0ak8WHw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliSaQ0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A3MIH90ckMzWw4x8/Vx2K9hN5LIhbU015Diz+
7W08/8vkzPmzf6EUFHxxg2CC//rrq0/oi8+kB2JGXYXVBkjsHGuBr+BbRhvtzKOa
JSSWgHDt/VwmRlP/UhTN0/P25hXrorBbQMPmopnJAKdAKnPk2SALcxE1cF1W0o2Q
2R8cc8Fq60vlr9dX1EtprIhnbK++GZwY16edmqEPaKx6+fXpZtCEMG6CdpQfMxtf
YYuPnB7PN+VzIvR2q0jcZmQCpvX7s1mfO+lUp/79QQxpInukkNUXRtx/lGVkc/Sh
Qnj8Wwj1TIczpf+/zunlTLKSyx1YlrQiSRSHOE4sJJEPo8DGLxMX7w==
=dQqS
-----END PGP SIGNATURE-----

--vGJ686kIF2V4acXlJpWWs6a3De0ak8WHw--
