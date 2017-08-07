Received: from eggs.gnu.org ([2001:4830:134:3::10]:41510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1degdd-0005aF-Oc
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 07:56:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1degdY-0001Op-RV
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 07:56:01 -0400
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
	<20170804151440.320927-12-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5b1406d2-603e-9862-197a-20f5e1eedd84@redhat.com>
Date: Mon, 7 Aug 2017 06:55:43 -0500
MIME-Version: 1.0
In-Reply-To: <20170804151440.320927-12-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="l6Ma8BGC0sPvWBOVu7qHkpBLRmE1GgKHs"
Subject: Re: [Qemu-devel] [PATCH 11/17] block/nbd-client: fix
 nbd_co_request: set s->reply.handle to 0 on error
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
--l6Ma8BGC0sPvWBOVu7qHkpBLRmE1GgKHs
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <5b1406d2-603e-9862-197a-20f5e1eedd84@redhat.com>
Subject: Re: [PATCH 11/17] block/nbd-client: fix nbd_co_request: set
 s->reply.handle to 0 on error
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
 <20170804151440.320927-12-vsementsov@virtuozzo.com>
In-Reply-To: <20170804151440.320927-12-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/04/2017 10:14 AM, Vladimir Sementsov-Ogievskiy wrote:
> We set s->reply.handle to 0 on one error path and don't set on another.=

> For consistancy and to avoid assert in nbd_read_reply_entry let's
> set s->reply.handle to 0 in case of wrong handle too.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/nbd-client.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Can this assertion be triggered now (presumably, with a broken server)?
I'm trying to figure out if this is 2.10 material.

[Urgh. If a broken server is able to cause an assertion failure that
causes a client to abort on an assertion failure, that probably deserves
a CVE]

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--l6Ma8BGC0sPvWBOVu7qHkpBLRmE1GgKHs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmIVT8ACgkQp6FrSiUn
Q2p7iQgAklQD7vk169W+LLCNSD38oi/C9a/dfVexxZba4w1K+RTQ2Kn8k+2864bL
XZtDC1tnZWOePfeTAbwE2b7w5r5Pr8+Zfg5bS2Zu65pyYUPI4WBcoXkQGbldHH2b
QtLCEmstCmUus0dA8SIZJfvAQUxyiTYS+5702ZeCbUZwFYcZSIfOZ+r3yvQvwjqa
UUp7a1BEruAyzTkBbQ2S9dVjjSHoieKCrWnELCkwDz6OsCafasRlNzDmlhV/LFNd
tLieeWHVV9SYZ6sTVbJ7D2RL3VEt2c6QahaGS9A6dUwiGyOKwGtG5owJEhqyBvPd
cZ2uMZcGcrcYcdkU9tUCPP820MT3DA==
=z3eP
-----END PGP SIGNATURE-----

--l6Ma8BGC0sPvWBOVu7qHkpBLRmE1GgKHs--
