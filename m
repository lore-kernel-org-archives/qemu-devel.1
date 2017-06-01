Received: from eggs.gnu.org ([2001:4830:134:3::10]:44454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dGLxX-0003CK-6Q
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 04:59:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dGLxW-0006FG-F6
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 04:59:59 -0400
Date: Thu, 1 Jun 2017 10:59:50 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170601085950.GA4987@noname.redhat.com>
References: <1496224367-24935-1-git-send-email-kwolf@redhat.com>
	<1496224367-24935-5-git-send-email-kwolf@redhat.com>
	<b50b7d41-684a-023d-e1f2-d25233140d9f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <b50b7d41-684a-023d-e1f2-d25233140d9f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 4/4] qemu-iotests: Block migration test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, jcody@redhat.com, qemu-devel@nongnu.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 31.05.2017 um 19:03 hat Eric Blake geschrieben:
> On 05/31/2017 04:52 AM, Kevin Wolf wrote:
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  tests/qemu-iotests/183     | 140 +++++++++++++++++++++++++++++++++++++=
++++++++
> >  tests/qemu-iotests/183.out |  46 +++++++++++++++
> >  tests/qemu-iotests/group   |   1 +
> >  3 files changed, 187 insertions(+)
> >  create mode 100755 tests/qemu-iotests/183
> >  create mode 100644 tests/qemu-iotests/183.out
>=20
> > +qemu_comm_method=3D"qmp"
> > +
> > +_launch_qemu \
> > +    -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},driver=3D$IMGFMT,=
id=3Ddisk
>=20
> Inconsistent use of ${CACHEMODE} vs. $IMGFMT (I prefer the version with
> less typing, but others prefer always using ${}).  In both _launch_qemu
> lines.  Up to you if you want to tweak it, but either way,

That's what you get for copying the line and then appending one more
option... I'll remove the extra {} for $CACHEMODE.

Kevin

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZL9eGAAoJEH8JsnLIjy/WROMQAL6J5k8Date1JMIOA6F08pqk
CQ2e3nDEbfz8yS8EHwm8USFGt//WgudQLme4hySpwMZXym4Kdn7j+fH1OlAIsHLn
fJxoWWFRDg1HtZfR3ECcZi6YZlBawuatdcx5fH1x5tOPVx7uLTAwFWc9ghtfMu7H
9Xu1bP/zHDFHKghddX5vHYz9jXSmxTfKDja25IzsWUOaOK/4NC79ya2MdcrTDJRE
55O8y8EG7XJEEYqL6ZF8ck6UqK45HOPT8xhWKNFF5jvKNbM47lq5AoewquSW7qAU
12R3c0jGjgoN7uhJq28pgOXNKVmlnzGS2nFKS4qh9WLdy0H9ZYkDoSvZszNha0Ke
1a7jhcQGdMkUtoJ/rn28KNcDYKp+Wx5eC/fGv8vQGyM6Ow34jgmgOoi5okWTv5ZH
sDvaV1VLZtGyUGzPWKRLKUXM4YeuVFTpgVRBT6qhwcbWWX3C/iSpdNY+YPiL3ze+
oB8SQV1Hsdoqdn/IoWS9zjOXyMsP26VgpREPv2Dx6k2idPfy9jk3uYjAorF+x40u
iwx1/IWmy3njsI32QdowAoKoSLd7EyyhjJqSj/Q33gGf+qncC/uGc8ddkIHkKVJZ
E+K6Z/G75f0rWGUkmv+uYIKCthzpOF/ZSRrdRobSIGVP1TZB79x0iFTxsiJzh2GK
Qp9yCosandNHzePJ3TJ0
=sACx
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
