Received: from eggs.gnu.org ([2001:4830:134:3::10]:38195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1di5ka-0008GC-4r
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 17:21:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1di5kW-0001Un-5R
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 17:21:13 -0400
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3f9ef2bf-bd52-b2ef-4051-bea6c06d24ce@redhat.com>
Date: Wed, 16 Aug 2017 16:21:01 -0500
MIME-Version: 1.0
In-Reply-To: <20170804151440.320927-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="u5WT7TpxFsruQaXe6Hl8Jho0hOpQpH1wT"
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
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u5WT7TpxFsruQaXe6Hl8Jho0hOpQpH1wT
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <3f9ef2bf-bd52-b2ef-4051-bea6c06d24ce@redhat.com>
Subject: Re: [PATCH 00/17] nbd client refactoring and fixing
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
In-Reply-To: <20170804151440.320927-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/04/2017 10:14 AM, Vladimir Sementsov-Ogievskiy wrote:
> A bit more refactoring and fixing before BLOCK_STATUS series.
> I've tried to make individual patches simple enough, so there are
> a lot of them.

Is your BLOCK_STATUS series something that is in good enough shape to
post a preliminary version of it (the version you posted back in
February is now horribly out-of-date, with all the good cleanups you
have been doing in the meantime).  I want to get a running start at
reviewing what I can to make sure we get improved NBD functionality into
2.11.

Also, please feel free to offer your Reviewed-by on other patches
(whether NBD-related or not).  Speaking as the NBD maintainer, I welcome
any help I can get.  And from personal experience, reviews tend to be
one of the largest bottlenecks in open source software - if you are
writing patches but not offering reviews, then you are adding to the
bottleneck so reviewers tend to set your patches aside for when they
have more time; while if you are actively offering reviews, then it is
obvious that you care about the project and your patch contributions
tend to have an easier time getting in.  My personal rule of thumb is to
try and review at least 2 other patches for every one that I send,
although that is a rather ambitious goal and there's nothing wrong if
you can't commit to theh same level of effort.

>=20
> Vladimir Sementsov-Ogievskiy (17):
>   nbd/client: fix nbd_opt_go
>   nbd/client: refactor nbd_read_eof
>   nbd/client: refactor nbd_receive_reply
>   nbd/client: fix nbd_send_request to return int
>   block/nbd-client: get rid of ssize_t
>   block/nbd-client: fix nbd_read_reply_entry
>   block/nbd-client: refactor request send/receive
>   block/nbd-client: rename nbd_recv_coroutines_enter_all
>   block/nbd-client: move nbd_co_receive_reply content into
>     nbd_co_request
>   block/nbd-client: move nbd_coroutine_end content into nbd_co_request
>   block/nbd-client: fix nbd_co_request: set s->reply.handle to 0 on
>     error
>   block/nbd-client: refactor nbd_co_request
>   block/nbd-client: refactor NBDClientSession.recv_coroutine
>   block/nbd-client: exit reply-reading coroutine on incorrect handle
>   block/nbd-client: refactor reading reply
>   block/nbd-client: drop reply field from NBDClientSession
>   block/nbd-client: always return EIO on and after the first io channel=

>     error

Of course, parts of this will need rebasing based on what finally landed
in 2.10, but I can start reviewing what I can for this round.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--u5WT7TpxFsruQaXe6Hl8Jho0hOpQpH1wT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmUtz0ACgkQp6FrSiUn
Q2oVbwf+LwLZxm/LFBtzYGOqzoY/L3gdZ1frvSgd45Z7KkpCFcqvQ5hBC1idrJgQ
rUVv+xeCF3aE57EY33Yh16TM/AYw3iRPdSdEWbX4cnWZTNb5LeWuWSxrH4P5I9zi
XiEJK7WVdFG+v0E1oU3O+mPGGa8FmtyvshLRSddtke3NcpqYqeNkJoaHb6x/LJQt
yxIm0gMcfp6hMGMSVO587o/1X5mwniYh5hWzKeP/kwO1Lk6TcaD53/0nx3TxXMJU
cnFhx4BV+TiuwLJuD+XFyPsyNbcgBAIdSqnZWIYVOXzuFrOEQ2gcEVQqZtB9Hey7
zbP5pNxJp+XL3Zt43NBzxMJUcoGobw==
=Haoo
-----END PGP SIGNATURE-----

--u5WT7TpxFsruQaXe6Hl8Jho0hOpQpH1wT--
