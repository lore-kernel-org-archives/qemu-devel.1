Received: from eggs.gnu.org ([2001:4830:134:3::10]:38671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dlMoo-0004Mi-4T
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 18:11:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dlMon-0005AH-1K
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 18:11:10 -0400
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e5c7d780-739c-ebad-5807-a1127457456f@redhat.com>
Date: Fri, 25 Aug 2017 17:10:58 -0500
MIME-Version: 1.0
In-Reply-To: <20170804151440.320927-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="R3RD1p0nn9c55NssvQ6c0pwj39G2Ow4gI"
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
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--R3RD1p0nn9c55NssvQ6c0pwj39G2Ow4gI
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <e5c7d780-739c-ebad-5807-a1127457456f@redhat.com>
Subject: Re: [PATCH 00/17] nbd client refactoring and fixing
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
In-Reply-To: <20170804151440.320927-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/04/2017 10:14 AM, Vladimir Sementsov-Ogievskiy wrote:
> A bit more refactoring and fixing before BLOCK_STATUS series.
> I've tried to make individual patches simple enough, so there are
> a lot of them.
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

I've pushed 1-5 and 7-10 onto my NBD staging branch for 2.11:

  git://repo.or.cz/qemu/ericb.git nbd

with a couple of changes squashed in as mentioned in individual patches;
please double-check that it looks okay.  If so, then I will use that
branch as the starting point for all NBD commits destined for 2.11,
sending a pull request once the tree opens.

Patches 6 and 11 are somewhat subsumed by the work that went into 2.10,
and the remaining patches are starting to cause enough conflicts that
I'd prefer you complete the rebase of patches 12-17 and post a v2 on top
of my staging branch.

I'm also hoping that Stefan will rebase a v2 of his "nbd-client: enter
read_reply_co during init to avoid crash" on top of your preliminary
work, since Paolo had a good suggestion on improving the semantics in
the review of v1.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--R3RD1p0nn9c55NssvQ6c0pwj39G2Ow4gI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmgoHIACgkQp6FrSiUn
Q2pCeAf9H5FrM+nC9X8vX/Df2bCYxeTQQnTu5o22OhjMblAIInCrianmyy54VBAv
2lQ4KlChWCGC8v/fUSknqEzrESSkKI8ZO9UMyLjRO+lQ+WKtyLAHNe3XhHHPvdy4
LuG/uJjdeSfVAXNDqMu1bhFL/70XwBhSaQ0n1AOEcHV8/A/WyPJE1V7B1BUuzG7u
RX8MSO70+mPZczPXWIZGU+vmDlOolsCnxiRr/xhnphFAYcH3+GYmYs//5vtp3CsD
iFQCHd3ww2rahRAS5yk6gwSVQCiAH0rBnq3qHmNxrVdVBp7TgtTyVja2vs8kke1z
cKAOP4k5CAWOlB0FIGfIx2G8vm/R2w==
=jk87
-----END PGP SIGNATURE-----

--R3RD1p0nn9c55NssvQ6c0pwj39G2Ow4gI--
