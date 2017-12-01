Received: from eggs.gnu.org ([2001:4830:134:3::10]:37218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eKqjC-0006Ag-Tt
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 14:12:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eKqjC-0007hI-3u
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 14:12:02 -0500
References: <20171109154049.42386-1-vsementsov@virtuozzo.com>
	<20171109154049.42386-2-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f6ca4eb8-45b7-9169-b98e-dbb2cc69209f@redhat.com>
Date: Fri, 1 Dec 2017 20:11:48 +0100
MIME-Version: 1.0
In-Reply-To: <20171109154049.42386-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="irjQMWRKlrDW6iGOU5HkpdxCxieLTLqDs"
Subject: Re: [Qemu-devel] [PATCH 1/2] nbd/server: add additional assert to
 nbd_export_put
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: eblake@redhat.com, pbonzini@redhat.com, kwolf@redhat.com, armbru@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--irjQMWRKlrDW6iGOU5HkpdxCxieLTLqDs
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: eblake@redhat.com, pbonzini@redhat.com, kwolf@redhat.com,
 armbru@redhat.com, den@openvz.org
Message-ID: <f6ca4eb8-45b7-9169-b98e-dbb2cc69209f@redhat.com>
Subject: Re: [PATCH 1/2] nbd/server: add additional assert to nbd_export_put
References: <20171109154049.42386-1-vsementsov@virtuozzo.com>
 <20171109154049.42386-2-vsementsov@virtuozzo.com>
In-Reply-To: <20171109154049.42386-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-09 16:40, Vladimir Sementsov-Ogievskiy wrote:
> This place is not obvious, nbd_export_close may theoretically reduce
> refcount to 0. It may happen if someone calls nbd_export_put on named
> export not through nbd_export_set_name when refcount is 1.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/server.c | 1 +
>  1 file changed, 1 insertion(+)
Reviewed-by: Max Reitz <mreitz@redhat.com>


--irjQMWRKlrDW6iGOU5HkpdxCxieLTLqDs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlohqXQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A9Z4H/1iwUav54BVTA93wip8/gGaCcH4l5tKb
Bk+OFs+GlyVcHj++GT8ZE5MAoP0EywNHczIJgMJrseqtEH6urNrK4uBjheKJqhpz
8hqpRuI8JenBNFz8KYq6qQvoGZjxhpeCsKVBoBi9oxrvydBVpbfJ1luidph535Ws
p+nvv+f575kbYEUqm2qbU1duCbvU8ANwbmNrcsYSiQH5kVBmCcuzaOSjYGyjci03
juN3qnXsTAHEzvpGEBaYRc3rhDzbDdt5wX+gAgP5C03ujPkpGUo2Jybvgi2DOA6W
PIrIsZB0dGhINFTvPImD7w11FVe/nKprhu4QC3zhhu8tZJZ9UsyZUgI=
=yfEz
-----END PGP SIGNATURE-----

--irjQMWRKlrDW6iGOU5HkpdxCxieLTLqDs--
