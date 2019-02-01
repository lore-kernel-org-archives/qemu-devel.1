Received: from eggs.gnu.org ([209.51.188.92]:38034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpgRY-0000pb-Nx
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 16:33:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpgM7-0007LF-Dk
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 16:28:13 -0500
References: <20190201130138.94525-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fbe24288-f58d-e648-4a0e-c804b7168a3a@redhat.com>
Date: Fri, 1 Feb 2019 15:27:55 -0600
MIME-Version: 1.0
In-Reply-To: <20190201130138.94525-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cKFB3b2XH3iLnkOa6y7qnDtQVtHDTwnm4"
Subject: Re: [Qemu-devel] [PATCH v5 0/6] NBD reconnect: prep. refactoring
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
--cKFB3b2XH3iLnkOa6y7qnDtQVtHDTwnm4
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com
Message-ID: <fbe24288-f58d-e648-4a0e-c804b7168a3a@redhat.com>
Subject: Re: [PATCH v5 0/6] NBD reconnect: prep. refactoring
References: <20190201130138.94525-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190201130138.94525-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/1/19 7:01 AM, Vladimir Sementsov-Ogievskiy wrote:
> Hi all.
>=20
> Here is most of preparatory refactoring for NBD reconnect, rebased
> on master. Let's push it.

Thanks; queued for my next NBD pull request.

>=20
> Sorry for a long delay in answering on v4 review and for v4 which
> I pinged a lot can't be applied on master directly :(
>=20
> v5:
> 02: rebased on master, object_unref() moved to fail: block
> 05: tiny fixes in commit message [Eric]
>=20
> Vladimir Sementsov-Ogievskiy (6):
>   block/nbd-client: split channel errors from export errors
>   block/nbd: move connection code from block/nbd to block/nbd-client
>   block/nbd-client: split connection from initialization
>   block/nbd-client: fix nbd_reply_chunk_iter_receive
>   block/nbd-client: don't check ioc
>   block/nbd-client: rename read_reply_co to connection_co
>=20
>  block/nbd-client.h |   6 +-
>  block/nbd-client.c | 196 +++++++++++++++++++++++++++++----------------=

>  block/nbd.c        |  40 +--------
>  3 files changed, 131 insertions(+), 111 deletions(-)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--cKFB3b2XH3iLnkOa6y7qnDtQVtHDTwnm4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxUudsACgkQp6FrSiUn
Q2pIMwgAmjBuxiO1/HOiMcqF1JK6GNEy8zWWke5oat40i6I33yKM/0FEGJET/29z
7ZS+MGHRkEgHnPb2Rvt1EV6NXwm2GPYMPwxjJv6ktb9GkFy80baKpR+bQxQ2FrXx
HRIaR12maZcNJJAGea1U+O3nrH5Bkv/smVTYs3nqjRVsOdgmeC9RrmioceWrXL1t
NuQbebDpJc0+zrHMh4SJQ50Ui7nfOn88ngmxk6/12BPjjsLGB6OfKfX7BOG1IqcD
0s81kVb4fIEbBzn5/3UXlxNBmZmAFTFGEQNKf/kbD1RS58ElaQyLQYcxG1Mrwc6h
e6Z0K3TE7f95BPEIIxgR7aXzW7MiPg==
=BbDV
-----END PGP SIGNATURE-----

--cKFB3b2XH3iLnkOa6y7qnDtQVtHDTwnm4--
