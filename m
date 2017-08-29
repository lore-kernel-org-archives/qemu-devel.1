Received: from eggs.gnu.org ([2001:4830:134:3::10]:42067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmok9-00048c-NM
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 18:12:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmok8-0006EC-CU
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 18:12:21 -0400
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
	<e5c7d780-739c-ebad-5807-a1127457456f@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9502f5bb-2c3e-2540-856b-e72aa0c127a1@redhat.com>
Date: Tue, 29 Aug 2017 17:12:08 -0500
MIME-Version: 1.0
In-Reply-To: <e5c7d780-739c-ebad-5807-a1127457456f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kTM18Mex5c3g4rnADDMkmU6dtl7wxQslP"
Subject: Re: [Qemu-devel] [PATCH 00/17] nbd client refactoring and fixing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, Stefan Hajnoczi <stefanha@redhat.com>, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kTM18Mex5c3g4rnADDMkmU6dtl7wxQslP
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org,
 Stefan Hajnoczi <stefanha@redhat.com>, mreitz@redhat.com
Message-ID: <9502f5bb-2c3e-2540-856b-e72aa0c127a1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/17] nbd client refactoring and fixing
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
 <e5c7d780-739c-ebad-5807-a1127457456f@redhat.com>
In-Reply-To: <e5c7d780-739c-ebad-5807-a1127457456f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/25/2017 05:10 PM, Eric Blake wrote:
> On 08/04/2017 10:14 AM, Vladimir Sementsov-Ogievskiy wrote:
>> A bit more refactoring and fixing before BLOCK_STATUS series.
>> I've tried to make individual patches simple enough, so there are
>> a lot of them.
>>
>> Vladimir Sementsov-Ogievskiy (17):
>>   nbd/client: fix nbd_opt_go
>>   nbd/client: refactor nbd_read_eof
>>   nbd/client: refactor nbd_receive_reply
>>   nbd/client: fix nbd_send_request to return int
>>   block/nbd-client: get rid of ssize_t
>>   block/nbd-client: fix nbd_read_reply_entry
>>   block/nbd-client: refactor request send/receive
>>   block/nbd-client: rename nbd_recv_coroutines_enter_all
>>   block/nbd-client: move nbd_co_receive_reply content into
>>     nbd_co_request
>>   block/nbd-client: move nbd_coroutine_end content into nbd_co_request=

>>   block/nbd-client: fix nbd_co_request: set s->reply.handle to 0 on
>>     error
>>   block/nbd-client: refactor nbd_co_request
>>   block/nbd-client: refactor NBDClientSession.recv_coroutine
>>   block/nbd-client: exit reply-reading coroutine on incorrect handle
>>   block/nbd-client: refactor reading reply
>>   block/nbd-client: drop reply field from NBDClientSession
>>   block/nbd-client: always return EIO on and after the first io channe=
l
>>     error
>=20
> I've pushed 1-5 and 7-10 onto my NBD staging branch for 2.11:
>=20
>   git://repo.or.cz/qemu/ericb.git nbd

Correction - I've decided to take Stefan's patches first (since his
patch 1/3 was a bit more elegant at doing the same thing as your patch
10); that caused rebase conflicts for your patch 7 (which I simplified
by creating nbd_co_request as a wrapper rather than trying to inline its
parts), and my change to your patch 7 obsoletes the need for 9 or 10.  I
also placed your patch 8 before your patch 7 (if you don't like what I
changed on patch 7, it is now last in my NBD staging area, so I can more
easily drop it from my tree if you'd prefer to respin it differently).

> with a couple of changes squashed in as mentioned in individual patches=
;
> please double-check that it looks okay.  If so, then I will use that
> branch as the starting point for all NBD commits destined for 2.11,
> sending a pull request once the tree opens.
>=20
> Patches 6 and 11 are somewhat subsumed by the work that went into 2.10,=

> and the remaining patches are starting to cause enough conflicts that
> I'd prefer you complete the rebase of patches 12-17 and post a v2 on to=
p
> of my staging branch.

These statements still hold; you'll need to rebase the rest of your
series on top of my tree.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--kTM18Mex5c3g4rnADDMkmU6dtl7wxQslP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlml5rgACgkQp6FrSiUn
Q2r3fQgAmEnvpSW+yeC9e2ufR0ITKFQvrm1b5Jvl/tlIQXedurrzRYfRZ8fc44q0
cnPIsNgTrOa1QukFBq3SPtSujfN1BOYo99thw+ZeQEZamb0FdHsatfp4VcA8RwhM
l32vywlORD8pM5kVxNlfmk8626FFwXo9iZ6MK4+uXfkRde6xk8K53brbn1R+QLYi
p6P1vmM9m/ksncRFvUwcaAVFZ2LS/YgMqvKWNaMl9i8gCKuyHr6EbtrSqcGOC6rM
KJuvOGiNU0ME211P/F+/eLzRZe2iV/AxyUocBf6vs25sFhhZCFGWbMQJXiB5Vfve
Pa2rACYslpkOXeM+oUQdegHVs5lyQg==
=DTzC
-----END PGP SIGNATURE-----

--kTM18Mex5c3g4rnADDMkmU6dtl7wxQslP--
