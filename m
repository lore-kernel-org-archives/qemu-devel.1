Received: from eggs.gnu.org ([2001:4830:134:3::10]:51763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGnMK-0001Xv-46
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:15:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGnMH-0005jB-UH
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:15:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dGnMH-0005iU-LX
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:15:21 -0400
References: <20170531165541.47338-1-vsementsov@virtuozzo.com>
	<20170531165541.47338-2-vsementsov@virtuozzo.com>
	<70aa332e-c868-15ac-0c4c-23d41a777b6c@redhat.com>
	<76a74826-f9ed-825e-0d3d-3043943d636c@virtuozzo.com>
	<8e900b35-65a9-789f-2cf4-9de6d16460a3@virtuozzo.com>
	<40ed0b31-84b7-380f-65ce-bc79de780c04@redhat.com>
	<ec8e6b9b-29e5-dc07-17cb-bdcd2ad8fc14@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0eaa8f22-e16f-8701-cf55-992b7116c80f@redhat.com>
Date: Fri, 2 Jun 2017 09:15:18 -0500
MIME-Version: 1.0
In-Reply-To: <ec8e6b9b-29e5-dc07-17cb-bdcd2ad8fc14@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WrtgqPrDk0Ufvf1XBvJgRiGnXfkjej9If"
Subject: Re: [Qemu-devel] [PATCH 01/12] nbd: rename read_sync and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WrtgqPrDk0Ufvf1XBvJgRiGnXfkjej9If
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org
Message-ID: <0eaa8f22-e16f-8701-cf55-992b7116c80f@redhat.com>
Subject: Re: [PATCH 01/12] nbd: rename read_sync and friends
References: <20170531165541.47338-1-vsementsov@virtuozzo.com>
 <20170531165541.47338-2-vsementsov@virtuozzo.com>
 <70aa332e-c868-15ac-0c4c-23d41a777b6c@redhat.com>
 <76a74826-f9ed-825e-0d3d-3043943d636c@virtuozzo.com>
 <8e900b35-65a9-789f-2cf4-9de6d16460a3@virtuozzo.com>
 <40ed0b31-84b7-380f-65ce-bc79de780c04@redhat.com>
 <ec8e6b9b-29e5-dc07-17cb-bdcd2ad8fc14@virtuozzo.com>
In-Reply-To: <ec8e6b9b-29e5-dc07-17cb-bdcd2ad8fc14@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/02/2017 08:54 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Finally, are you OK with my wording? If I reroll, can I add your r-b?=

>> What final wording are you proposing (full paragraph, not a snippet)?
>=20
> 2. _sync suffix
>    _sync is related to the fact that nbd_wr_syncv doesn't return if

s/if/if a/

>    write to socket returns EAGAIN. In first implementation nbd_wr_syncv=


s/In first implementation/The first implementation of/

>    (was wr_sync in 7a5ca8648b) just loops while getting EAGAIN, current=


s/current/the current/

>    implementation yields in this case.
>    Why to get rid of it:

maybe: s/Why/Why we want/

>    - it is normal for r/w functions to be synchronous, so having

s/having/having an/

>      additional suffix for it looks redundant (contrariwise, we have
>      _aio suffix for async functions)
>    - _sync suffix in block layer is used when function does flush (so
>      using it for other thing is confusing a bit)
>    - keep function names short after adding nbd_ prefix

Thanks for bearing with me, and letting me help on the grammar subtleties=
=2E

>>
>>>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> At any rate, I already gave R-b for the code, so finessing the commit
>> message doesn't change that if the code remains unchanged.
>>
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--WrtgqPrDk0Ufvf1XBvJgRiGnXfkjej9If
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZMXL2AAoJEKeha0olJ0NqgpUH/2RoFdnxlw+MulsEIa3xFblm
J1TQKEuVlSKYQU2dm36xpDLjUY4Qw5n/p9MQExRmyw1REzKmQdpq/jVy15uyNa2A
Si9p1Xw9Wz8qEXmuOPsLmpeP8ZZkkvhxw69yysVUIPKtbimnDyJI/xbblOMq3Fsx
c4gR0J/lwBSBpaiZhuIX3aVXr35tnYpZLiY8Bp1iNhA4m7wXAlgHjYw7UTGlRE6l
WyRnG2e6pGJPckqvyJLepoF0efch3Hjpd+eztBQxu76K4TXkSgkdbbpdUGPhgNvQ
BGpj1lH6wlS50+r7Y3ZgjYddWsUQ6jXf+ajTEGNekumUqGLaL2un8I59SWwSnDs=
=aWYu
-----END PGP SIGNATURE-----

--WrtgqPrDk0Ufvf1XBvJgRiGnXfkjej9If--
