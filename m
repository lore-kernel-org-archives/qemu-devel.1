Received: from eggs.gnu.org ([2001:4830:134:3::10]:45681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dQCLB-0008AJ-Kv
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:45:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dQCLA-0007KV-MI
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:45:05 -0400
Date: Wed, 28 Jun 2017 14:44:54 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170628124454.GE5378@noname.redhat.com>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-3-el13635@mail.ntua.gr>
	<20170628112736.GD5378@noname.redhat.com>
	<20170628121530.zdhob4iq37x3qv4i@postretch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <20170628121530.zdhob4iq37x3qv4i@postretch>
Subject: Re: [Qemu-devel] [PATCH RFC v3 2/8] block: Add aio_context field in
 ThrottleGroupMember
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 28.06.2017 um 14:15 hat Manos Pitsidianakis geschrieben:
> On Wed, Jun 28, 2017 at 01:27:36PM +0200, Kevin Wolf wrote:
> >Am 23.06.2017 um 14:46 hat Manos Pitsidianakis geschrieben:
> >>timer_cb() needs to know about the current Aio context of the throttle
> >>request that is woken up. In order to make ThrottleGroupMember backend
> >>agnostic, this information is stored in an aio_context field instead of
> >>accessing it from BlockBackend.
> >>
> >>Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> >
> >You're copying the AioContext when the BlockBackend is registered for
> >the throttle group, but what keeps both sides in sync when the context
> >is changed later on? Don't we need to update the ThrottleGroupMember in
> >blk_set_aio_context?
>=20
> blk_set_aio_context calls throttle_timers_attach_aio_context which
> updates this. Though as Alberto said util/throttle.c should not know
> about ThrottleGroupMember. This is not needed in the later patches
> because the ThrottleGroupMember's aio_context gets updated as a node
> in the driver's bdrv_attach_aio_context
>=20
> We can add a new function in block/throttle.c that updates a
> member's aio context but I'm not sure if it's really needed if
> members are only used in throttle nodes.

Oh, I looked at the final state after the series instead of this very
commit, so I missed the existing calls in blk_set_aio_context().

My bad, sorry for the noise.

Kevin

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZU6TGAAoJEH8JsnLIjy/WYnQQAL/HMWkPcoRkicQaMCZ/ZXcF
Hr6VZbn/NFdM8/wmw22Dne1e7qbRlYip6RffBcE0pW61dG4ggP1TI0sbmUJX09Hf
lmW0KI719GvQN/PZaBkwZd1/RvM/ORMCJsZfVKWF5r/9CrQe4o3myE6pagRmt4PU
s+IUGGE2ETcHo703thIub+6GTKCDaUOVCq5o0ATfz6xcho0/3J90L3+BiEPyPpSj
7FMFl/IyO66bJ364ruQwqMjaoQaClVr7agJupioIiMtwDejTIB7L/8EqIEPGf9oY
hFj3r+CmDwlMEP6OYWmPWK0VFgDiD+r38Qyzi2XikchiN5Qw10j+4QuekJhnDoVR
Cw5sJ3xzOZ0Bp+YqFUGlXm5gPUKTLwzFhCs4m3xTqnVyU8saQ+Sue9/wgcWAsOn9
0c125JR1gnLQh2bAFRTLNghKTeyUwIRud+Tv4/goEk5AtX4uyrZFpZEltg8igdqS
yLfJaabU0SawJ+jzKrtQJ0brqG98wAoER2a73imE2zhZAt3ZqMryp+g9wQgJaWUp
zWnPh6WELEDlfvByYJv6s/kNTS3dyDyQKytXn0w2oGRiw16BVvvuTfWRfqUsQm1F
WuS277heU2l6awm31OGiGCJBs005l5AgrA654k5FrlktbuP8aHvSGnrsYTnpmktO
KsAEZsxPXO1SzxKKXcAM
=uTDa
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
