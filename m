Received: from eggs.gnu.org ([2001:4830:134:3::10]:35119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d5v1a-00070e-V0
	for qemu-devel@nongnu.org; Wed, 03 May 2017 10:13:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d5v1a-0005wS-4Q
	for qemu-devel@nongnu.org; Wed, 03 May 2017 10:13:02 -0400
Date: Wed, 3 May 2017 16:12:54 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170503141254.GA4191@noname.redhat.com>
References: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
	<1493411622-5343-15-git-send-email-kwolf@redhat.com>
	<972a9484-fa2e-620f-35b3-de3919b587d4@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <972a9484-fa2e-620f-35b3-de3919b587d4@redhat.com>
Subject: Re: [Qemu-devel] [PULL 14/34] iotests: Launch qemu-nbd with -e 42
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 29.04.2017 um 00:08 hat Eric Blake geschrieben:
> On 04/28/2017 03:33 PM, Kevin Wolf wrote:
> > From: Max Reitz <mreitz@redhat.com>
> >=20
> > There is no reason for the qemu-nbd server used for tests not to accept
> > an arbitrary number of clients. In fact, test 181 will require it to
> > accept two clients at the same time (and thus it fails before this
> > patch).
>=20
> Quick question:
>=20
> Is this mention of test 181 the same test that occurs earlier in the
> pull request as 8/34?  If so, should the series have been reordered for
> bisectability?  If not, should the commit message be touched up?
>=20
> At any rate, bisectability of qemu-iotests is less of a concern than
> bisectability of 'make check' success, so I don't think your answer
> invalidates the pull request.

Yes, it's the same test 181 and if someone had noticed before I sent the
pull request, I might have reordered the patches, but I don't think
there's any practical bisectability problem with introducing a
qemu-iotests case that fails on NBD. If you bisect, you typically bisect
for a specific setup and test case rather than running the full set of
qemu-iotests.

Kevin

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZCeVmAAoJEH8JsnLIjy/WzJMQAKK58ETR650Rz5bCxQ1jjqKT
yIEg2Tt5BAzLoC+cPbH4OOZgYTuTccwnNktyhaGPwpnFITIBvco53NlZOyw9ormF
Tl9+7LOoyfuL15ZU5XCm688/H3EVpf0h5HzOBm+V8doWIviLBT2lnOJUENc/1G3S
3wiViOCuOXOYwBx84WOxn78o1gJU2cEAdihQvci3Mu6LsjsUF4+J0kSwDQTmCVm4
kPrR+F27KSrAMZkfMzugoNmyu//sFJ1tQz/68/Hpc74GKiPGymEOBcazuyHGlIrp
2Z8Y/Vi/EJOveIdZGTbxCdvXkHnbKvSkFaVIj986nI0Vc68KDcPVJ2nzl1p/P1o7
SQ6gj2IsTe0ZRaztXW3Fpwxm11Ce8f5apHpmdOeLEE45FOHljpes0hyXZ/QgKtEd
YBMPU4U7+2S9goxJ34vLrKT/DtV2YhoKZKau/TamG6y9YlHjt2BcTxRX5dk6v8MU
wZIyCImNSJWrMSfqkJV26HFIpzoM6dveoAE2jOiZrYY+HgwpeyYIqERw6/JKqnxX
oSXWZtozKL5QwR4wogKLu8edEDmReV0dSM1lifRNOjSSde3T4x2/maVWM/FGb1Mv
C/dTA2tqQnS5tnDCxBt40XDnw+giQn8OmdtDYS9AVobGgpeikCtCGlh71hVEap2S
jDxb0MQwDEslOk0+VUMZ
=3p0a
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
