Received: from eggs.gnu.org ([2001:4830:134:3::10]:44579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eydfg-0007pJ-DR
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:20:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eydfa-0002aF-Fg
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:20:52 -0400
References: <20180320170521.32152-1-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a4c5e82c-b5c7-f5ba-111b-9a6a3f8a7b5a@redhat.com>
Date: Wed, 21 Mar 2018 14:20:31 +0100
MIME-Version: 1.0
In-Reply-To: <20180320170521.32152-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TaDVrVIJQOBHzVudjII0w02IUUbID3xKb"
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
--TaDVrVIJQOBHzVudjII0w02IUUbID3xKb
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, den@openvz.org
Message-ID: <a4c5e82c-b5c7-f5ba-111b-9a6a3f8a7b5a@redhat.com>
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


Thanks, applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--TaDVrVIJQOBHzVudjII0w02IUUbID3xKb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqyXB8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AwHUH/jgaW+8AXeM0fMlagV28laNh8bWO4Goc
UAx7Hg+H2p2ZYEzFSFGCOD4MIwuQ91Oxjjn68cSSjAvb3OSKSlTi+VWgvWtFyeOa
BIphzxf43JZ+edoIpEW7MkE8Pcp6QEZ3NsVOqpSwOPnzosbJTI5/jWVP4QOENIAa
cmJSkp6NsWZAOg8DxzkWc+5lt4+Nai4GhASa4VWlchB8foMYY4KHZcLJtqzTnALB
UFgx603op/We7k3u525OJUXULAlbLlpmqNzG2xOed1RX7b42ywOmK9wjDuhVioG2
0fh1leoQosTzZIfRZiigldHTaGWFFolnxgtfL/Me/iOYkn3svwnps/8=
=t7IN
-----END PGP SIGNATURE-----

--TaDVrVIJQOBHzVudjII0w02IUUbID3xKb--
