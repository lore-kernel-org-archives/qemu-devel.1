Received: from eggs.gnu.org ([2001:4830:134:3::10]:53523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3Uma-0001li-KY
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 17:47:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3UmZ-0003OM-NO
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 17:47:32 -0400
References: <20170418013356.3578-1-eblake@redhat.com>
	<20170418013356.3578-3-eblake@redhat.com>
	<8f65f4aa-c5a2-bad9-404f-0d72961d3cc6@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ee675116-5c29-b5d0-9c56-514daf81d9ae@redhat.com>
Date: Wed, 26 Apr 2017 16:47:18 -0500
MIME-Version: 1.0
In-Reply-To: <8f65f4aa-c5a2-bad9-404f-0d72961d3cc6@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GLpMBReSamGC5jLTPkNPGSJLi5pD1OG0O"
Subject: Re: [Qemu-devel] [PATCH 02/31] block: Make bdrv_round_to_clusters()
 signature more useful
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, kwolf@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GLpMBReSamGC5jLTPkNPGSJLi5pD1OG0O
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>,
 qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kwolf@nongnu.org
Message-ID: <ee675116-5c29-b5d0-9c56-514daf81d9ae@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/31] block: Make bdrv_round_to_clusters()
 signature more useful
References: <20170418013356.3578-1-eblake@redhat.com>
 <20170418013356.3578-3-eblake@redhat.com>
 <8f65f4aa-c5a2-bad9-404f-0d72961d3cc6@redhat.com>
In-Reply-To: <8f65f4aa-c5a2-bad9-404f-0d72961d3cc6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2017 04:41 PM, John Snow wrote:
>=20
>=20
> On 04/17/2017 09:33 PM, Eric Blake wrote:
>> In the process of converting sector-based interfaces to bytes,
>> I'm finding it easier to represent a byte count as a 64-bit
>> integer at the block layer (even if we are internally capped
>> by SIZE_MAX or even INT_MAX for individual transactions, it's
>> still nicer to not have to worry about truncation/overflow
>> issues on as many variables).  Update the signature of
>> bdrv_round_to_clusters() to uniformly use uint64_t, matching
>                                             ^^^^^^^^
>=20
> While we're here, since you went with int64_t in the end, what steered
> you away from uint64_t, or was that just a thinko?

Later patches were made easier with signed (the compiler complained when
I mixed signed and unsigned pointers).

>=20
> (AFAICT: off_t is usually something like int64_t, so your choice makes
> sense to me, generally.)

Indeed, and that's something I should update my commit message to mention=
=2E

>=20
> --js
>=20
>> the signature already chosen for bdrv_is_allocated, and
>> adjust clients according to the required fallout.

If you want me to try and use uint64_t *pnum instead of int64_t *pnum
throughout both my series 1  (the changes to bdrv_is_allocated) and this
one, it will take more effort.  I'll do it if there's a reason, but I'd
rather not if the signed version is good enough.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--GLpMBReSamGC5jLTPkNPGSJLi5pD1OG0O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZARVmAAoJEKeha0olJ0NqW7IH/28LE9oXXeT8UceZYRs91eR6
FEy5dJqDASZH5i7+6Rqw1O1BMVXNR78h8/b1Ed8pe0YKVoveMjJJHfSqkSEJPvYJ
zt0H9DaYzRhsruzuoTpy4iUZ1j3hgz+bLeBKnsB0tGyf3JRABeQnMAiNxGKNgJx7
w3W3Lf4rH5IL6OVFiUssYFLfK8/K+KpYM+DLBrf06Y9d+EQWh6F0Owt1Ucb+Yv/l
C+RiA0YX6MaDJ1YqqCxOHcOOuP6TzXEIJsoR2t77qrAhSj/EGPVqO7KzYnI7PJoe
54J7cQmOk6Cx5JpWTF/C+ua4Ndz3gDAOagLa8JI7dlTwbYnpYUh9RsaKMAXyjpA=
=qxEj
-----END PGP SIGNATURE-----

--GLpMBReSamGC5jLTPkNPGSJLi5pD1OG0O--
