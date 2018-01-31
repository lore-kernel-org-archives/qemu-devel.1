Received: from eggs.gnu.org ([2001:4830:134:3::10]:48334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egy5p-0005pe-0M
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:30:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egy5o-0007cp-6L
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:30:49 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<97a2e764d1fb53ce7a25e1d0699114c01d8042d2.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4965f4ed-151c-5471-cddd-a46ef06b38c3@redhat.com>
Date: Wed, 31 Jan 2018 20:30:38 +0100
MIME-Version: 1.0
In-Reply-To: <97a2e764d1fb53ce7a25e1d0699114c01d8042d2.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GrBtki2RCPABhbIbCyGDNDrOt9mXIBqsm"
Subject: Re: [Qemu-devel] [PATCH v3 06/39] qcow2: Remove BDS parameter from
 qcow2_cache_entry_mark_dirty()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GrBtki2RCPABhbIbCyGDNDrOt9mXIBqsm
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <4965f4ed-151c-5471-cddd-a46ef06b38c3@redhat.com>
Subject: Re: [PATCH v3 06/39] qcow2: Remove BDS parameter from
 qcow2_cache_entry_mark_dirty()
References: <cover.1516978645.git.berto@igalia.com>
 <97a2e764d1fb53ce7a25e1d0699114c01d8042d2.1516978645.git.berto@igalia.com>
In-Reply-To: <97a2e764d1fb53ce7a25e1d0699114c01d8042d2.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 15:59, Alberto Garcia wrote:
> This function was only using the BlockDriverState parameter to pass it
> to qcow2_cache_get_table_idx(). This is no longer necessary so this
> parameter can be removed.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2-cache.c    |  3 +--
>  block/qcow2-cluster.c  | 12 ++++++------
>  block/qcow2-refcount.c | 14 ++++++--------
>  block/qcow2.h          |  3 +--
>  4 files changed, 14 insertions(+), 18 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--GrBtki2RCPABhbIbCyGDNDrOt9mXIBqsm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpyGV4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AlO8IAMR5dbA2vpqJYjNn10eIBDX514KWAXD5
pVpug1F1vqZf87e/oQa3LrkNjLFwSPWbuwcFdjIchKg6uZBfnvKgAmjm9eBiSVmD
ElQgK5/aWh1w0ayY6Lyy/0aQDPJ3Nm5sagbTEqIjoHnFgYk1gvEd0lGGIXo8pNUG
4VAfQz3ZQEpAuP7cbYkGlvcW9DmumVo4AF93sDoC3nPbY9LDRcPO8RvQ+T4jCX2e
l/WV+irVwsfn+AQfmNZg1ziIPOhVrlv4pNkBQBGskW/bXPxyRMqZKV98Q1ywmaog
x2JSrbPrzTGdVpBh/+SpuEARxctGjCKtdDukye5KsHHqICRzgngzJ6Q=
=gitk
-----END PGP SIGNATURE-----

--GrBtki2RCPABhbIbCyGDNDrOt9mXIBqsm--
