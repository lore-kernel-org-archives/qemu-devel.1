Received: from eggs.gnu.org ([2001:4830:134:3::10]:35872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f0WWX-0006dm-Gu
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 14:07:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f0WWW-0002dR-Hu
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 14:07:13 -0400
References: <20180320170521.32152-1-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <fce080fd-1970-b856-82e0-42c62306da6c@redhat.com>
Date: Mon, 26 Mar 2018 20:06:54 +0200
MIME-Version: 1.0
In-Reply-To: <20180320170521.32152-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JXoaQ41iBLdDcFliVqxVyuJUrbKSLZnxL"
Subject: Re: [Qemu-devel] [PATCH v4 for 2.12 0/3] fix bitmaps migration
 through shared storage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JXoaQ41iBLdDcFliVqxVyuJUrbKSLZnxL
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, den@openvz.org
Message-ID: <fce080fd-1970-b856-82e0-42c62306da6c@redhat.com>
Subject: Re: [PATCH v4 for 2.12 0/3] fix bitmaps migration through shared
 storage
References: <20180320170521.32152-1-vsementsov@virtuozzo.com>
In-Reply-To: <20180320170521.32152-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-20 18:05, Vladimir Sementsov-Ogievskiy wrote:
> Hi all.
>=20
> This fixes bitmaps migration through shared storage. Look at 02 for
> details.
>=20
> The bug introduced in 2.10 with the whole qcow2 bitmaps feature, so
> qemu-stable in CC. However I doubt that someone really suffered from th=
is.
>=20
> Do we need dirty bitmaps at all in inactive case? - that was a question=
 in v2.
> And, keeping in mind that we are going to use inactive mode not only fo=
r
> incoming migration, I'm not sure that answer is NO (but, it may be "NO"=
 for=20
> 2.10, 2.11), so let's fix it in proposed here manner at least for 2.12.=


For some reason, I can't get 169 to work now at all[1].  What's more,
whenever I run it, two (on current master, maybe more after this series)
"cat $TEST_DIR/mig_file" processes stay around.  That doesn't seem right.=


However, this series doesn't seem to make it worse[2]...  So I'm keeping
it.  I suppose it's just some issue with the test.

Max


[1] Sometimes there are migration even timeouts, sometimes just VM
launch timeouts (specifically when VM B is supposed to be re-launched
just after it has been shut down), and sometimes I get a dirty bitmap
hash mismatch.


[2] The whole timeline was:

- Apply this series, everything seems alright

(a couple of hours later)
- Test some other things, stumble over 169 once or so

- Focus on 169, fails a bit more often

(today)
- Can't get it to work at all

- Can't get it to work in any version, neither before nor after this patc=
h

- Lose my sanity

- Write this email

O:-)


--JXoaQ41iBLdDcFliVqxVyuJUrbKSLZnxL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlq5Nr4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Ai58IAIrKwAekcYRqzoQKuBfQ+BVxPKjna6po
a2NSeyCE9qZ5Yan2m2a9U2C4d4tQ4VAkSkBbl6UYr+h2bZ6Up7XzIFtj0uNCbHn9
vWTjSHPjjaz8ZG2knk0koVhhRMHtasWygHLrj+1zkz3K3G2a3Goim6JjL8rrEF9+
S8hLtWw0o3yJMF4+EUavECCE4pP/yZIQX2tt9CQWMvSaG6bV6qualR0xN6bWvPvc
iZXWQY+VEjz0abzBp0PqDeUwqzFFsxG2Nv3bsfDMTGfOstZw+i9VcHI9LzVyNG0/
vsj44UI/4SBmD98TxhkKMJ76/mEdhenJ/2jFzXbFuXg5l6tMfxjj/98=
=QJdy
-----END PGP SIGNATURE-----

--JXoaQ41iBLdDcFliVqxVyuJUrbKSLZnxL--
