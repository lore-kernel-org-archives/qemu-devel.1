Received: from eggs.gnu.org ([2001:4830:134:3::10]:51276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dJKqM-0003Ew-Gx
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 10:24:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dJKqL-0002Wc-Gc
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 10:24:54 -0400
Date: Fri, 9 Jun 2017 16:24:40 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170609142440.GE4462@noname.redhat.com>
References: <1497009003-25794-1-git-send-email-kwolf@redhat.com>
	<1497009003-25794-4-git-send-email-kwolf@redhat.com>
	<cca5d6f7-0747-5759-f940-1d8755b1a523@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Content-Disposition: inline
In-Reply-To: <cca5d6f7-0747-5759-f940-1d8755b1a523@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 3/3] qemu-iotests: Test
 exiting qemu with running job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 09.06.2017 um 16:10 hat Max Reitz geschrieben:
> On 2017-06-09 13:50, Kevin Wolf wrote:
> > When qemu is exited, all running jobs should be cancelled successfully.
> > This adds a test for this for all types of block jobs that currently
> > exist in qemu.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  tests/qemu-iotests/185     | 189 +++++++++++++++++++++++++++++++++++++=
++++++++
> >  tests/qemu-iotests/185.out |  59 ++++++++++++++
> >  tests/qemu-iotests/group   |   1 +
> >  3 files changed, 249 insertions(+)
> >  create mode 100755 tests/qemu-iotests/185
> >  create mode 100644 tests/qemu-iotests/185.out
> >=20
> > diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
> > new file mode 100755
> > index 0000000..645ec9a
> > --- /dev/null
> > +++ b/tests/qemu-iotests/185
>=20
> [...]
>=20
> > +_supported_fmt qcow2 raw
> > +_supported_proto file
> > +_supported_os Linux
>=20
> [...]
>=20
> > +echo
> > +echo =3D=3D=3D Creating backing chain =3D=3D=3D
> > +echo
> > +
> > +_send_qemu_cmd $h \
> > +    "{ 'execute': 'blockdev-snapshot-sync',
> > +       'arguments': { 'device': 'disk',
> > +                      'snapshot-file': '$TEST_IMG.mid',
> > +                      'format': '$IMGFMT',
>=20
> Not having looked at this series further yet (sorry...), I just noticed
> that this does not work very well with raw.

Good point... I'll make it qcow2 only.

Kevin

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZOq+oAAoJEH8JsnLIjy/WVDoP/iffULUghlWlAn7CYFkHA9Q2
toH11K4SO/eCn4QAJs4Voa5SauF2xkgiHyNmzGp7cdkRC7vwAwLSYM1PiZgUcl6V
oIYLUVW9i/KxmvMEgtoCF4u4Osk2kuenmX8gNrngPiMBpC4nZdeHBU9CD6HVNowm
+mzPgFVDnSXDbTL1DQ+ewq8Qi9cXlXNt6ZkkIlltBh4FTdI8LrpJQlje7imXGkjU
5Sm64QWOeRjuPChLbWNo9gY2hkm91VCjrjoNGiWdqK7iQtpwTw6qEAWw+CrDNlZH
cw4HJrj7xq/4FFeZ+sQlbY5hnFqFZiWiq3Upj7Q5KZSrvVJaup+fjfKhuxSDv0KA
3/kHJiipGBKJ0z3gSyGBZ/z1DI216CKMvAi8MEl4MpHxKDsiOukfabv7l6NFv8dR
wRvh2JVyIs9CiOfyjMFqtwvgXBQFhJzlwCCJS4OoQNd5pMTRjGHJLVEcJQfSgwN7
2nGZArRGeU92VZUBKMZt3aXoM+uIlI9UzjUY/7qH6g18RhPaH9s5ejhiP8gl/YBm
wCsbTfkoYyYp+h8hTMxPe0whzctrqHhQIyrJPrkPnAcAQP1NzO/wjtcbMnFb9T9V
YQfEEqGtxaRetrE5f+ZwgX18gOPSb9+6FOJSwesOiQoQTB5fC+TGSOckuJX7NrxL
5mqARisrh+etQoez9eoy
=7aAR
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
