Received: from eggs.gnu.org ([209.51.188.92]:37118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hIZFw-00062f-9O
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 09:45:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hIZFv-0001Jo-C6
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 09:45:12 -0400
References: <20190419140557.102725-1-vsementsov@virtuozzo.com>
	<20190419140557.102725-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9065c20c-d9bb-d84f-b5ca-16e929ca4d3a@redhat.com>
Date: Mon, 22 Apr 2019 08:39:58 -0500
MIME-Version: 1.0
In-Reply-To: <20190419140557.102725-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FPOw857kGdLrocd9cZ1H1E2jYmPRj4kuw"
Subject: Re: [Qemu-devel] [PATCH v3 2/3] block/io: bdrv_pdiscard: support
 int64_t bytes parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, fam@euphon.net, stefanha@redhat.com, den@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FPOw857kGdLrocd9cZ1H1E2jYmPRj4kuw
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, fam@euphon.net, stefanha@redhat.com,
 den@virtuozzo.com
Message-ID: <9065c20c-d9bb-d84f-b5ca-16e929ca4d3a@redhat.com>
Subject: Re: [PATCH v3 2/3] block/io: bdrv_pdiscard: support int64_t bytes
 parameter
References: <20190419140557.102725-1-vsementsov@virtuozzo.com>
 <20190419140557.102725-3-vsementsov@virtuozzo.com>
In-Reply-To: <20190419140557.102725-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/19/19 9:05 AM, Vladimir Sementsov-Ogievskiy wrote:
> This fixes at least one overflow in qcow2_process_discards, which
> passes 64bit region length to bdrv_pdiscard which bytes (or sectors in

s/which/where/

> the past) parameter is int since it's introduction in 0b919fae.

s/it's/its/

>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/block.h |  4 ++--
>  block/io.c            | 16 ++++++++--------
>  2 files changed, 10 insertions(+), 10 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--FPOw857kGdLrocd9cZ1H1E2jYmPRj4kuw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAly9xC4ACgkQp6FrSiUn
Q2rCKQf8CTj0kTk+LK6zavtyGvXLbOH0OlhaEe93ptRrcgD2TdLHsQpczwhpZ3Dw
B5pejDggFQYHkgW11v67O/NH1YstYkRVsOBd9uphhjCkGUYayFvRHHC0egjGGEB+
3NaXH1MIVGMMfu99VD7WeSR+gStsYj8MGCRNx98xyDFvsbdYanKrID6ahS8UuyuX
otiszxOi/HUL23WFdSmPdegVWxv7nfmzdSlPuA0g+/JjXmMwjOv+jmWdR5LdfUf1
KmFjEGoH226p/NQsxCh0puI1JwquNJmTBYB5cbWA49lySLNsUQcFq5R9Xha0CBcc
kr7x94RQ4wxdP98mW+E7DnMo02RxRA==
=4lXO
-----END PGP SIGNATURE-----

--FPOw857kGdLrocd9cZ1H1E2jYmPRj4kuw--
