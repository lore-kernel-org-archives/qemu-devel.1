Received: from eggs.gnu.org ([2001:4830:134:3::10]:46198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpABa-0008G2-JV
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:30:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpABT-0007oF-1j
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:30:22 -0400
Date: Tue, 5 Sep 2017 11:29:52 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170905092952.GD4633@localhost.localdomain>
References: <20170901105434.3288-1-berrange@redhat.com>
	<20170901105434.3288-2-berrange@redhat.com>
	<cf614cf9-598b-a306-4656-1b6d740e1706@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <cf614cf9-598b-a306-4656-1b6d740e1706@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] iotests: rewrite 192 to use
 _launch_qemu to fix LUKS support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 01.09.2017 um 16:22 hat Eric Blake geschrieben:
> On 09/01/2017 05:54 AM, Daniel P. Berrange wrote:
> > The LUKS driver requires extra args to QEMU to setup passwords.
> > The _launch_qemu function takes care of this, so convert the
> > test to use this function and use correct -drive syntax
> >=20
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  tests/qemu-iotests/192 | 23 ++++++++++++++++-------
> >  1 file changed, 16 insertions(+), 7 deletions(-)
> >=20
>=20
> > =20
> > -{
> > -echo "nbd_server_start unix:$TEST_DIR/nbd"
> > -echo "nbd_server_add -w drive0"
> > -echo "q"
> > -} | $QEMU -nodefaults -display none -monitor stdio \
> > -    -drive format=3D$IMGFMT,file=3D$TEST_IMG,if=3Dide,id=3Ddrive0 \
> > -    -incoming defer 2>&1 | _filter_testdir | _filter_qemu | _filter_hmp
>=20
> Can this test use QMP instead of HMP? But that's an independent question.

As far as I am concerned, there is nothing wrong with having HMP tests.
HMP commands already call QMP internally (except for the generic QMP
code path below the command handlers), so using HMP actually increases
the test coverage in most cases. We should try to have a good mix of
test cases using QMP and test cases using HMP.

Kevin

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZrm6QAAoJEH8JsnLIjy/WyLUP/1pTfSblCkIbWsyrjVSV0r7u
pjsRr6BUqN9dnZT9yLzSssDL47Jyl4G6bZyXVAaWcwjqXCiN2wZguYYpdJ9WeAqC
TCe+FuzpxWj05Kg7y55lUD4AmimGhKCWXxZx5Z427HA6Ntq0JHsKOga2rKHL4b5L
fcaWrdXoCHk45O2aN/EmQRAqL/JfaIlvB8OEdtIh08hwUJyT+wm5O60D1sXcIdtS
KwKcESQyFtzjy264HHP1CSNyi8kzhhE4F4BvtNaAfmgQacNCJGVrmMTjBLPMETSW
Maossco74r3x6YPSxEU6EnK1cydEtAj9rx2IL7q26ij4PU7rHDz9p4+5Vw2TPQuC
TKCOXCZd3n3uaFh1kr7gap8MMw7T88/OROciWDDLStmGYt5jAXef5N62jtn84XR2
tr6hr+HtnMicDm/3qL2L9FiEsDyn3uTzPKFdcRSD5MZ3ry3x8ka7TaNg+9AKdYrf
CHtY0PTl9zDDAwCJonHcR8gwuwSVouLsvur9Hp3aBpKZHpH44jO0PUjqFSUusqlX
s4QGxtZ1E37wblwAQyVd4cf18UYNiRc7Pu4RtooEuvErFFnKvgnLMiZnPU5PbiVE
Gqe8jTpNuPu34S1IweBgCSmXsRwLSAxHaNns+ldlNLvcQuV3DTOpoCyaZdly3abf
/dKH2mk6NetM75cpOhMF
=Q6ui
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
