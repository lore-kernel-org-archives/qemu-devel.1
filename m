Received: from eggs.gnu.org ([2001:4830:134:3::10]:46957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ce2yn-0006T0-PG
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 12:02:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ce2ym-0003tt-Sd
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 12:02:57 -0500
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
	<20170203154757.36140-18-vsementsov@virtuozzo.com>
	<119ea962-4746-6563-5133-e2063bc34567@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <07f319cf-dee4-8d6e-83bf-d53c6a4564ae@redhat.com>
Date: Wed, 15 Feb 2017 18:02:49 +0100
MIME-Version: 1.0
In-Reply-To: <119ea962-4746-6563-5133-e2063bc34567@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8S5OiLpc02d6mhAB9EA4CelkE1BbRUGfU"
Subject: Re: [Qemu-devel] [PATCH 17/18] nbd: BLOCK_STATUS for standard
 get_block_status function: server part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, den@virtuozzo.com, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8S5OiLpc02d6mhAB9EA4CelkE1BbRUGfU
From: Paolo Bonzini <pbonzini@redhat.com>
To: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 armbru@redhat.com, den@virtuozzo.com, stefanha@redhat.com
Message-ID: <07f319cf-dee4-8d6e-83bf-d53c6a4564ae@redhat.com>
Subject: Re: [PATCH 17/18] nbd: BLOCK_STATUS for standard get_block_status
 function: server part
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
 <20170203154757.36140-18-vsementsov@virtuozzo.com>
 <119ea962-4746-6563-5133-e2063bc34567@redhat.com>
In-Reply-To: <119ea962-4746-6563-5133-e2063bc34567@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 09/02/2017 16:38, Eric Blake wrote:
> Umm, why are we sending only one status? If the client requests two ids=

> during NBD_OPT_SET_META_CONTEXT, we should be able to provide both
> pieces of information at once.  For a minimal implementation, it works
> for proof of concept, but it is pretty restrictive to tell clients that=

> they can only request a single status context.  I'm fine if we add that=

> functionality in a later patch, but we'd better have the implementation=

> ready for the same release as this patch (I still think 2.9 is a
> reasonable goal).

Agreed on this too.

Paolo


--8S5OiLpc02d6mhAB9EA4CelkE1BbRUGfU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYpIm5AAoJEL/70l94x66Dg+cH/RP6hlXPDQyqtt1aDfZzSY5W
pbB3/vXCGYCvGl+BksG4IkXe6k4gfET2/a+EweGwHYZvsUu7RzzOQIrxTwdIRvpz
KVQLoagwBdr7ssBmWf+trWnZO7GDZGkGh3U0m+gODCEyDK2pOuyTXmobhUsLqen/
18stuXUqOgmc+mpLU/NGFNm4PxXnHQoinU6dzIghgnrcp9C5BaLmGghJqeMI0Jfj
rpCJmzKikCHbwYHedkv43LMs8T9TEE4AjWDrz/PIYTiNXKYXhEfrA9oindX0fjeV
7Y+WWsntM/Cj8p6qTFGH7JiIKcPDRot1T0tWSivZE90xJ5bTJNGuZFbnPvCE3iQ=
=/1S/
-----END PGP SIGNATURE-----

--8S5OiLpc02d6mhAB9EA4CelkE1BbRUGfU--
