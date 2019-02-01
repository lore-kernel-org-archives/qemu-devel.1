Received: from eggs.gnu.org ([209.51.188.92]:57394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpg42-0005DZ-1P
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 16:09:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpg3x-0004c2-H6
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 16:09:28 -0500
References: <20190201130138.94525-1-vsementsov@virtuozzo.com>
	<20190201130138.94525-7-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6ab00cab-cad7-e707-4c77-d93d201c9042@redhat.com>
Date: Fri, 1 Feb 2019 15:08:58 -0600
MIME-Version: 1.0
In-Reply-To: <20190201130138.94525-7-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NcsdokbeOccd1GARFzWNrRiXyNkLbqKhd"
Subject: Re: [Qemu-devel] [PATCH v5 6/6] block/nbd-client: rename
 read_reply_co to connection_co
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NcsdokbeOccd1GARFzWNrRiXyNkLbqKhd
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com
Message-ID: <6ab00cab-cad7-e707-4c77-d93d201c9042@redhat.com>
Subject: Re: [PATCH v5 6/6] block/nbd-client: rename read_reply_co to
 connection_co
References: <20190201130138.94525-1-vsementsov@virtuozzo.com>
 <20190201130138.94525-7-vsementsov@virtuozzo.com>
In-Reply-To: <20190201130138.94525-7-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/1/19 7:01 AM, Vladimir Sementsov-Ogievskiy wrote:
> This coroutine will serve nbd reconnects, so, rename it to be something=

> more generic.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/nbd-client.h |  4 ++--
>  block/nbd-client.c | 24 ++++++++++++------------
>  2 files changed, 14 insertions(+), 14 deletions(-)

Trivial merge conflict with patches that recently landed; I can fix that.=


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--NcsdokbeOccd1GARFzWNrRiXyNkLbqKhd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxUtWoACgkQp6FrSiUn
Q2oigwgAk7TYItPAIiuAIqfJ55thESn9Vn2MYQAv37bYUIKwIhuCVQbkmPILqlvV
SQiZH538RQKqkv/SnDh6nxd7i4/1gvnKGEtKAvgcPrYuD/7ast7Kvck4MQYsGcSC
1UPb5ZS9QnlMBLKaBJU1QrQPcbib1qpJcgjAqVY7+ePddeXgknpSkxPdF3ybnNuK
zoei0BCk71atd8v12HYscOE6YKuDxC1Ehq36q9qwv6z2mtrYCTCmHevcBn6maCyx
KmOJOPpk0tZvRk4FcTCfQUFUcdbR3OjtxLnvVmvke6En0Nfth/9SBhgw+3jrpuBB
juzG+wJBEIdWCeA9Ah1XPsrJuNcaFQ==
=eVbP
-----END PGP SIGNATURE-----

--NcsdokbeOccd1GARFzWNrRiXyNkLbqKhd--
