Received: from eggs.gnu.org ([2001:4830:134:3::10]:54967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d7koq-0004TB-Nx
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:43:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d7kop-0001jq-Sp
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:43:28 -0400
References: <20170507000552.20847-1-eblake@redhat.com>
	<20170507000552.20847-6-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <54dddadc-42a3-0256-09ee-03e8d4d5d0bc@redhat.com>
Date: Mon, 8 May 2017 17:43:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170507000552.20847-6-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GEJTTb6gqV7jNuMAlvJ4mVt2Xs82rHUOF"
Subject: Re: [Qemu-devel] [PATCH v13 05/12] qcow2: Name typedef for cluster
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GEJTTb6gqV7jNuMAlvJ4mVt2Xs82rHUOF
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <54dddadc-42a3-0256-09ee-03e8d4d5d0bc@redhat.com>
Subject: Re: [PATCH v13 05/12] qcow2: Name typedef for cluster type
References: <20170507000552.20847-1-eblake@redhat.com>
 <20170507000552.20847-6-eblake@redhat.com>
In-Reply-To: <20170507000552.20847-6-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07.05.2017 02:05, Eric Blake wrote:
> Although it doesn't add all that much type safety (this is C, after
> all), it does add a bit of legibility to use the name QCow2ClusterType
> instead of a plain int.
>=20
> In particular, qcow2_get_cluster_offset() has an overloaded return
> type; a QCow2ClusterType on success, and -errno on failure; keeping
> the cluster type in a separate variable makes it slightly easier for
> the next patch to make further computations based on the type.
>=20
> Suggested-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v13: new patch
> ---
>  block/qcow2.h          |  6 +++---
>  block/qcow2-cluster.c  | 17 +++++++++--------
>  block/qcow2-refcount.c |  2 +-
>  3 files changed, 13 insertions(+), 12 deletions(-)

[...]

> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index f3bfce6..ed78a30 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c

Above this hunk, there is count_contiguous_clusters() with a variable
"first_cluster_type" that could be a QCow2ClusterType as well.

> @@ -340,7 +340,7 @@ static int count_contiguous_clusters(int nb_cluster=
s, int cluster_size,
>   */
>  static int count_contiguous_clusters_unallocated(int nb_clusters,
>                                                   uint64_t *l2_table,
> -                                                 int wanted_type)
> +                                                 QCow2ClusterType want=
ed_type)
>  {
>      int i;
>=20

And some lines below this (in this function), there is a "type" variable
that (c|sh)ould be a QCow2ClusterType, too.

Although it's quite a functional change, I would be willing to change
both when applying, if you allowed me to.

(Once again, "no good deed shall go unpunished", as Markus likes to say :=
-))

Max


--GEJTTb6gqV7jNuMAlvJ4mVt2Xs82rHUOF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkQkhcSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AOqAH/2dpiN/nmC3/8LU48FO6lKEeaKBMBWiv
lg6WM7MJWonbFjGn1mHdVQFfaL2r315vf4JLMnziS82/GHKFz8Hvcmj1U+Ww3Mzk
GD5dd+M5fOF4Lld0TrbWpD2dbsdp/acGQKog4jdTDxoR/0mQ46nVoG4XwXQfcMir
Rt2qrVj7yzsQjdNMRRVTbE5wYLaGoB84Qh3DJHPdn0M61LmiyS6IyvaYp+rrxaKL
ibDcxb0W5Wos+Ueiw04Rd2U3fioQPGxVDTmAp6ZyVz1JYzoHVPWhXDDm/gpyMq1v
+gIa6Sty8+BGPo/Lrn8hUh7QsM44kuvrHVCNDTYYdybZhaeoEYG6cgc=
=/irm
-----END PGP SIGNATURE-----

--GEJTTb6gqV7jNuMAlvJ4mVt2Xs82rHUOF--
