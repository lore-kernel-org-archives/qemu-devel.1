Received: from eggs.gnu.org ([2001:4830:134:3::10]:59573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ce1zm-0006jo-V1
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:59:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ce1zm-0003sD-C2
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:59:55 -0500
References: <5fd09f2c-4201-1099-6d1b-a130e688e6eb@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1f44e5ee-27f4-7cf3-34d3-fa17049a1464@redhat.com>
Date: Wed, 15 Feb 2017 16:59:47 +0100
MIME-Version: 1.0
In-Reply-To: <5fd09f2c-4201-1099-6d1b-a130e688e6eb@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lcIPVLjIdHg2dbkdd8LkL40Pd3U1DHaru"
Subject: Re: [Qemu-devel] blockdev-add/del status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, "Denis V. Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lcIPVLjIdHg2dbkdd8LkL40Pd3U1DHaru
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <famz@redhat.com>, "Denis V. Lunev" <den@openvz.org>
Message-ID: <1f44e5ee-27f4-7cf3-34d3-fa17049a1464@redhat.com>
Subject: Re: blockdev-add/del status
References: <5fd09f2c-4201-1099-6d1b-a130e688e6eb@virtuozzo.com>
In-Reply-To: <5fd09f2c-4201-1099-6d1b-a130e688e6eb@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.02.2017 16:26, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
>=20
> What is the status of qmp commands blockdev-add and x-blockdev-del? Is
> blockdev-add stable (it never had x- prefix)? What should be done to ge=
t
> rid of "x-" for x-blockdev-del?

To add to what Eric said, we simply forgot the x- prefix for blockdev-add=
=2E

Max


--lcIPVLjIdHg2dbkdd8LkL40Pd3U1DHaru
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlikevMSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ACI4H/2LvA/bxvWs+NJYSJZr6kqf7U0foFkQW
bwM+tZrq8ud9PmBbSQnY/73K60VUOxTqV4XqRW8fqLPc6oNjXq+zV9n1rc2vgAOY
6Y4mMSGCwx2VD0AhwHywuQ4GImsuFnEJLWjOzwug6QbKjNLlpx7xomp/fLldppy/
LUh1QC9Y/A8uaQSRfNlDPT+gPU+4vWWfANB7mlm1fZcZEIA9XcTHIpGQP1ClFwFI
Hnm0HHIpreWbdQwdgOIyhlYsyE5cwSh8ElpBGG1ulxAY01nF+av+KGCkLyR77ycy
Pd/59zEfaAINmr+ob8ohQ+efzSgF4bFHlF16Xv2oJ4Rdk5qH9b6WoqU=
=EetF
-----END PGP SIGNATURE-----

--lcIPVLjIdHg2dbkdd8LkL40Pd3U1DHaru--
