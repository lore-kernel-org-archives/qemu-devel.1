Received: from eggs.gnu.org ([2001:4830:134:3::10]:47279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1egGrD-0005Pm-Ip
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 16:20:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1egGrA-0006DJ-9p
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 16:20:51 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:42738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1egGrA-0006Cq-23
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 16:20:48 -0500
Received: by mail-wr0-x241.google.com with SMTP id 41so7415897wrc.9
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 13:20:47 -0800 (PST)
Date: Mon, 29 Jan 2018 21:20:45 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180129212045.GB1640@stefanha-x1.localdomain>
References: <151675071042.29381.16225631028845063799.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline
In-Reply-To: <151675071042.29381.16225631028845063799.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 0/7] tests: virtio-9p: test request
 cancellation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2018 at 12:38:30AM +0100, Greg Kurz wrote:
> This series does several changes to virtio-9p-test in order to be able
> to test request cancellation (flush in 9p wording):
>=20
> patches 1-2: preparatory work, basically doing things in the test code,
>              rather that in the common code for flexibility and clarity
>=20
> patch 3: the cornerstone of the series, switch to using the synth fsdev
>          backend, which allows to associate specific write/read ops to
>          a given file. Since this backend never got used since it was
>          merged, it looks like an ideal vehicle to add QTEST aware code
>          in QEMU
>=20
> patches 4-5: trivial open & write tests, since the flush test will need
>              to open a file and write to it
>=20
> patch 6: another important patch that allows to know the length written
>          by the guest into a used buffer=20
>=20
> patch 7: the goal of this series, two request cancellation tests
>=20
> This series depends on the following patch:
>=20
> https://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg05604.html
>=20
> Please comment.
>=20
> Cheers,
>=20
> --
> Greg
>=20
> ---
>=20
> Greg Kurz (7):
>       tests: virtio-9p: move request tag to the test functions
>       tests: virtio-9p: wait for completion in the test code
>       tests: virtio-9p: use the synth backend
>       tests: virtio-9p: add LOPEN operation test
>       tests: virtio-9p: add WRITE operation test
>       libqos/virtio: return length written into used descriptor
>       tests: virtio-9p: add FLUSH operation test
>=20
>=20
>  hw/9pfs/9p-synth.c       |   56 ++++++++++
>  hw/9pfs/9p-synth.h       |   11 ++
>  hw/9pfs/9p.c             |    1=20
>  tests/libqos/virtio.c    |   25 +++-
>  tests/libqos/virtio.h    |    3 -
>  tests/virtio-9p-test.c   |  263 ++++++++++++++++++++++++++++++++++++++++=
------
>  tests/virtio-blk-test.c  |   24 ++--
>  tests/virtio-net-test.c  |    6 +
>  tests/virtio-scsi-test.c |    3 -
>  9 files changed, 335 insertions(+), 57 deletions(-)
>=20
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJab5AtAAoJEJykq7OBq3PIQ90IAKqiqcrhG4GqyDJzRnNODsV7
YlgDM7CEWhtVFdbYhuQQ7ZdujH6tyKs60W5bbeTExTKXiPiqhoE0PRq5m9zDUd0o
1m4g7lojQsOk8HZBX8yndF43SDas3yOwoSsc6SaE9BeZffBAy9rIQd4WumBdXEPF
mcwjGpuF2hPSRKJLYW3rMES4k3uiQqUpUYzz4ULo/C6wchHXG+Sovkr9fNSeMJeq
5L3ZQhFLFxG8dQ7/Tstoqa6JyxGA5FJWjeU74iolwR+ZG50elKe6m7TtiedWYrfT
v7/y2fVKAEdCIZCrJD+Z0jSqh1Ct4L9qjLh+B31julP0lbmrkR0K2YPsO1D94wo=
=oeQ5
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--
