Received: from eggs.gnu.org ([2001:4830:134:3::10]:56842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dDCW6-0007gg-BX
	for qemu-devel@nongnu.org; Tue, 23 May 2017 12:18:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dDCW5-0006Ul-AT
	for qemu-devel@nongnu.org; Tue, 23 May 2017 12:18:38 -0400
Date: Tue, 23 May 2017 18:18:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170523161822.GB6791@noname.redhat.com>
References: <1495548064-10926-1-git-send-email-kwolf@redhat.com>
	<1495548064-10926-5-git-send-email-kwolf@redhat.com>
	<b56cd2ae-8793-4b61-e867-73d66baba45b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Content-Disposition: inline
In-Reply-To: <b56cd2ae-8793-4b61-e867-73d66baba45b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] qemu-iotests: Block migration test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, famz@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 23.05.2017 um 17:46 hat Eric Blake geschrieben:
> On 05/23/2017 09:01 AM, Kevin Wolf wrote:
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  tests/qemu-iotests/183     | 121 +++++++++++++++++++++++++++++++++++++=
++++++++
> >  tests/qemu-iotests/183.out |  48 ++++++++++++++++++
> >  tests/qemu-iotests/group   |   1 +
> >  3 files changed, 170 insertions(+)
> >  create mode 100755 tests/qemu-iotests/183
> >  create mode 100644 tests/qemu-iotests/183.out
>=20
> Does this test gracefully skip when coupled with the efforts for a
> configure option to disable block migration?
> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg04398.html

Obviously it doesn't. How would we even check? Just grep whether the
magic error string turns up somewhere after doing 'migrate -b'?

I don't think we have other test cases that don't skip immediately, but
only after doing half of the test, but I think it might work anyway.

> > +echo
> > +echo =3D=3D=3D Do block migration to destination =3D=3D=3D
> > +echo
> > +
> > +_send_qemu_cmd $src "migrate -b unix:${MIG_SOCKET}" "(qemu)"
>=20
> I don't see any earlier checks, so it looks like you'd choke here if -b
> is not compiled in.
>=20
> Should we also check the use of -i?

Good point, though I don't even know how to use -i manually. :-)

We can either have a follow-up patch extending this one or a completely
separate test case for it. I would have to try out -i before I could say
which makes more sense.

Kevin

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZJGDOAAoJEH8JsnLIjy/WEPwP/27/ecn84VdLaahUy4zfR/eo
WyrWink7sq2aP25CMicyff3jBeopl4aGypgW0vDN5GaGHYe+paSQYZbqdI9g4pP0
oyihR3I2xp2yhM/5hwBN5rc5ULVd+EcdyI/k0wLlt3oSjfxQ3mw82IUesxx7traf
0kn/XvQuQqSfPkwzewuRLFlhciu5DbMPA3LjYSWSo/bTtq+ik2tgu8HyRbrUapPr
BRujlgBviSx4mMmsIRimqLYDvK4yV3hAy/iUb8okjnt3QwvY8HX82rNi2PM//zvf
n0oZifaVVQqavC60WPrgzVPCbl/ff+C0wyaObsWXXXcUiB8z2irOsNIXGKHf0CEE
fIQ7OcuziOJgYSPZUZ4K3rMdzTQrhrhifLW8VO/GmOePU1/eFXHwCPbw+TEUpOms
nrtgX4g3Y6rr6VJcSDXvemYMwGTscx0BRPBosd3csvi4+HRJlorb62FyjJwgV6hZ
n9OSyhF9+b1WK4Rd0eCqRaQ5o/4I5Fz1iLFEEPaLTGdKeWbdWhaTJylDssBVMWnt
qtRqxlRTOSZ3/cxue1Cy3S/AMOxndZsFP3P2++5rVXrx/XPvOK36aJ4BUrA9jD2L
TRzxynVetC4u9D4/OJQSam9Tdr/leUK0Gu2XFmsvk81SbJTipgwH3YJlkGEsu4+V
soqZfFy4IDyYglgtQE+u
=3R2A
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--
