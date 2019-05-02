Received: from eggs.gnu.org ([209.51.188.92]:41633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hMCay-0001P2-RG
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:21:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hMCay-0008Dw-06
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:21:56 -0400
References: <20190502085029.30776-1-shmuel.eiderman@oracle.com>
	<20190502135828.42797-1-shmuel.eiderman@oracle.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3a211c90-f031-07ea-0833-35efcff5f6cb@redhat.com>
Date: Thu, 2 May 2019 09:21:50 -0500
MIME-Version: 1.0
In-Reply-To: <20190502135828.42797-1-shmuel.eiderman@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TMdW8fGMu5nzVn3zjv1319eeodRFnlUb0"
Subject: Re: [Qemu-devel] [PATCH v2 0/3] qemu-img: rebase: Improve/optimize
 rebase operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Eiderman <shmuel.eiderman@oracle.com>, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: eyal.moscovici@oracle.com, arbel.moshe@oracle.com, liran.alon@oracle.com, sagi.amit@oracle.com, karl.heubaum@oracle.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TMdW8fGMu5nzVn3zjv1319eeodRFnlUb0
From: Eric Blake <eblake@redhat.com>
To: Sam Eiderman <shmuel.eiderman@oracle.com>, kwolf@redhat.com,
 mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: eyal.moscovici@oracle.com, arbel.moshe@oracle.com, liran.alon@oracle.com,
 sagi.amit@oracle.com, karl.heubaum@oracle.com
Message-ID: <3a211c90-f031-07ea-0833-35efcff5f6cb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] qemu-img: rebase: Improve/optimize
 rebase operation
References: <20190502085029.30776-1-shmuel.eiderman@oracle.com>
 <20190502135828.42797-1-shmuel.eiderman@oracle.com>
In-Reply-To: <20190502135828.42797-1-shmuel.eiderman@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/2/19 8:58 AM, Sam Eiderman wrote:
> This patch series aims to improve the speed of qemu-img rebase.
>=20
> 1. Mainly by removing unnecessary reads when rebasing on the same
>    chain.
> 2. But also by minimizing the number of bdrv_open calls rebase
>    requires.
>=20

When sending a v2 series, it's best to do so as a new top-level thread
rather than in-reply-to the v1 series, as our CI tools are more likely
to spot it that way.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--TMdW8fGMu5nzVn3zjv1319eeodRFnlUb0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzK/P4ACgkQp6FrSiUn
Q2qF2ggAnetVLCLTObEcAy/naivXf55IXOvOQjzd+/9GfUqwvZinfIaeCJZZjInQ
7aKXrlBQJdlQAIyMjN9zfTJ9YODONFnGEIWV2vuBnKaHqiI4kKn4Ms1TsodRZZGl
g1tHs/WqdFqe8k5RLJuXejkx2w6ovmOrkHclTrXCfZGrPTe6z16M074dJKbY/Bng
HZf+Y+I3HAp3jUIQBNb4yzaILNX2aMehxoWUZNdzmy1jCs4XfITnFBHQwx19JjZq
tC4m5PxG94bd3+q59lh9XIEF4hO1UudBVAuXdtWVzoFQxVtu9rZ1U5mjlXdSTDcB
/Me6ksR3ooOT9AI5fxu9RA5pCzXkCw==
=au1U
-----END PGP SIGNATURE-----

--TMdW8fGMu5nzVn3zjv1319eeodRFnlUb0--
