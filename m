Received: from eggs.gnu.org ([2001:4830:134:3::10]:46502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cdGox-0002Zw-9A
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 08:37:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cdGot-0000DE-2D
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 08:37:35 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cdGos-0000Cp-S5
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 08:37:30 -0500
Received: by mail-wm0-x241.google.com with SMTP id c85so19564079wmi.1
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 05:37:29 -0800 (PST)
Date: Mon, 13 Feb 2017 13:37:25 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170213133725.GA10361@stefanha-x1.localdomain>
References: <1478566785-4002-1-git-send-email-ashish.mittal@veritas.com>
	<1478566785-4002-3-git-send-email-ashish.mittal@veritas.com>
	<20161108204413.GA6353@localhost.localdomain>
	<CAAo6VWMyTjV1Fn8-BSex7Fx8OcEcuEyK2rQJ6L=wZZXDiB5A4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <CAAo6VWMyTjV1Fn8-BSex7Fx8OcEcuEyK2rQJ6L=wZZXDiB5A4w@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v6 2/2] block/vxhs.c: Add qemu-iotests for
 new block device type "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ashish mittal <ashmit602@gmail.com>
Cc: Jeff Cody <jcody@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <ashish.mittal@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, Abhijit Dey <Abhijit.Dey@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2017 at 03:12:36PM -0800, ashish mittal wrote:
> On Tue, Nov 8, 2016 at 12:44 PM, Jeff Cody <jcody@redhat.com> wrote:
> > On Mon, Nov 07, 2016 at 04:59:45PM -0800, Ashish Mittal wrote:
> >> These changes use a vxhs test server that is a part of the following
> >> repository:
> >> https://github.com/MittalAshish/libqnio.git
> >>
> >> Signed-off-by: Ashish Mittal <ashish.mittal@veritas.com>
> >> ---
> >> v6 changelog:
> >> (1) Added iotests for VxHS block device.
> >>
> >>  tests/qemu-iotests/common        |  6 ++++++
> >>  tests/qemu-iotests/common.config | 13 +++++++++++++
> >>  tests/qemu-iotests/common.filter |  1 +
> >>  tests/qemu-iotests/common.rc     | 19 +++++++++++++++++++
> >>  4 files changed, 39 insertions(+)
> >>
> >> diff --git a/tests/qemu-iotests/common b/tests/qemu-iotests/common
> >> index d60ea2c..41430d8 100644
> >> --- a/tests/qemu-iotests/common
> >> +++ b/tests/qemu-iotests/common
> >
> > When using raw format, I was able to run the test successfully for all
> > supported test cases (26 of them).
> >
> > With qcow2, they fail - but not the fault of this patch, I think; but
> > rather, the fault of the test server.  Can qnio_server be modified so t=
hat
> > it does not work on just raw files?
> >
> >
>=20
> VxHS supports and uses only the raw format.

That's like saying only ext4 guest file systems are supported on VxHS
and not ZFS.  The VxHS driver should not care what file system is used,
it just does block I/O without interpreting the data.

It must be possible to use any format on top of the VxHS protocol.
After all, the image format drivers just do block I/O.  If there is a
case where qcow2 on VxHS fails then it needs to be investigated.

The VxHS driver can't be merged until we at least understand the cause
of the qcow2 test failures.

Stefan

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYobaVAAoJEJykq7OBq3PIlxAH/RC2KfapNrIuBxpz+i6yVKBB
jSkkZInfqRZWaO8mF/QLx8+bXddsdOXZ+AlfOLeaEQM8+D0WWsbfpYjeExzrUX7z
F/SyOiwPJyUDlCBV/3ck20AfrtPhOtwyqX1OXxb1ddYhs5BM2+4DoOxH7MPG2+fB
pwpuRzgVUkKHLy2d6WRYV3NFbR/vDonnI4WAp2995djch9gNz8IEczHtRzDIiMM1
s7gN0qjSeKUXXVSAr9VINMq+oaave/P3TNINFFOzjZnPqsCjbyModbQqfGJZ7lbH
IdHIfDfirZjUg6HI+TZTzQH4eMTwzWYEhAtTldf8037zqIvhy7KOAwkHgHsK+uM=
=02C6
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
