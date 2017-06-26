Received: from eggs.gnu.org ([2001:4830:134:3::10]:33503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dPVxl-0006nH-3Q
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 11:30:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dPVxk-0002hg-1U
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 11:30:05 -0400
References: <20170613140358.81651-1-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0765c70e-1c57-1360-0ffa-b3932f431f91@redhat.com>
Date: Mon, 26 Jun 2017 17:29:45 +0200
MIME-Version: 1.0
In-Reply-To: <20170613140358.81651-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ds3f2cb5GKF0vU9M77qLW9gRrf8u9cLkh"
Subject: Re: [Qemu-devel] [PATCH v21 00/30] qcow2: persistent dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ds3f2cb5GKF0vU9M77qLW9gRrf8u9cLkh
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <0765c70e-1c57-1360-0ffa-b3932f431f91@redhat.com>
Subject: Re: [PATCH v21 00/30] qcow2: persistent dirty bitmaps
References: <20170613140358.81651-1-vsementsov@virtuozzo.com>
In-Reply-To: <20170613140358.81651-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-13 16:03, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
>=20
> There is a new update of qcow2-bitmap series - v21.
>=20
> web: https://src.openvz.org/users/vsementsov/repos/qemu/browse?at=3Dqco=
w2-bitmap-v21
> git: https://src.openvz.org/scm/~vsementsov/qemu.git (tag qcow2-bitmap-=
v21)

Unfortunately, several conflicts with Paolo's "Block layer thread
safety, part 1" series (from June 5th, applied only on June 20th due to
some OS X build failures) -- mostly because it adds a mutex for
accessing dirty bitmaps -- prevent me from applying this series.

There are some other conflicts as well (like qcow2.txt being moved to
docs/interop), but I would have been fine with fixing them myself -- but
the bitmap lock thing affects at least half of this series and often in
a non-trivial way, too (I didn't feel comfortable to quickly make the
decision whether some bitmap accessing function should use locks or not).=


Max


--Ds3f2cb5GKF0vU9M77qLW9gRrf8u9cLkh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZUShpEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQNkm
B/9vwB3Bk7QyxTIqaIG9gnKtyz3ZqFcgXnsgdjxWqj0wBoDmbBUi/5uEM4oTGULV
CfWcPHYOQcQ164dsgBi5QPEhh6karhUEXiza+t96y0E8zW20TbViaFdZkRIfMQfS
dvOfz88Hi+cyiCPBSOI8w74fGadr46zekpXeQ9qyWUlwLcbMNNU5yMzGTU/WnWYF
AAbqA7AyaG0Xtn22ABCJA8UeK0RH6qWY7DLf47Vmu/dmg3oMZn27trl/URZBxty2
4gfm7P0MZquslmXPYVsklZJN0qZvbKwqsOjUmPWsXrOQgqegAVvORDH0U+eU05dS
yBlZ1p0cfO5SQ8kixQesQxlz
=kxd4
-----END PGP SIGNATURE-----

--Ds3f2cb5GKF0vU9M77qLW9gRrf8u9cLkh--
