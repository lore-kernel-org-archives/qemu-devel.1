Received: from eggs.gnu.org ([2001:4830:134:3::10]:36472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1da2Vh-0004FZ-86
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 12:16:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1da2Vg-0004Oo-6n
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 12:16:37 -0400
References: <20170721034730.25612-1-crosa@redhat.com>
	<20170721123325.GC18014@stefanha-x1.localdomain>
	<20170721140155.GQ17693@redhat.com>
	<bcf52c05-1d73-a56f-98ae-7029a924786b@redhat.com>
	<20170725154921.GS23343@stefanha-x1.localdomain>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <547d0cd0-052c-a1e5-e116-483d2a176ab8@redhat.com>
Date: Tue, 25 Jul 2017 12:16:13 -0400
MIME-Version: 1.0
In-Reply-To: <20170725154921.GS23343@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="41wxxoi5r60WuoiSOWtBnE6l9q6j1G4Pe"
Subject: Re: [Qemu-devel] [PATCH 0/3] build configuration query tool and
 conditional (qemu-io)test skip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Jing Liu <liujbjl@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--41wxxoi5r60WuoiSOWtBnE6l9q6j1G4Pe
From: Cleber Rosa <crosa@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, qemu-block@nongnu.org,
 Jing Liu <liujbjl@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Message-ID: <547d0cd0-052c-a1e5-e116-483d2a176ab8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] build configuration query tool and
 conditional (qemu-io)test skip
References: <20170721034730.25612-1-crosa@redhat.com>
 <20170721123325.GC18014@stefanha-x1.localdomain>
 <20170721140155.GQ17693@redhat.com>
 <bcf52c05-1d73-a56f-98ae-7029a924786b@redhat.com>
 <20170725154921.GS23343@stefanha-x1.localdomain>
In-Reply-To: <20170725154921.GS23343@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 07/25/2017 11:49 AM, Stefan Hajnoczi wrote:
> On Fri, Jul 21, 2017 at 10:21:24AM -0400, Cleber Rosa wrote:
>> On 07/21/2017 10:01 AM, Daniel P. Berrange wrote:
>>> On Fri, Jul 21, 2017 at 01:33:25PM +0100, Stefan Hajnoczi wrote:
>>>> On Thu, Jul 20, 2017 at 11:47:27PM -0400, Cleber Rosa wrote:
>> Without the static capabilities defined, the dynamic check would be
>> influenced by the run time environment.  It would really mean "qemu-io=

>> running on this environment (filesystem?) can do native aio".  Again,
>> that's not the best type of information to depend on when writing test=
s.
>=20
> Can you explain this more?
>=20
> It seems logical to me that if qemu-io in this environment cannot do
> aio=3Dnative then we must skip those tests.
>=20
> Stefan
>=20

OK, let's abstract a bit more.  Let's take this part of your statement:

 "if qemu-io in this environment cannot do aio=3Dnative"

Let's call that a feature check.  Depending on how the *feature check*
is written, a negative result may hide a test failure, because it would
now be skipped.

Suppose that a feature check for "SDL display" is such that you run
"qemu -display sdl".  A *feature failure* here (SDL init is broken), or
an environment issue (DISPLAY=3D), will cause a SDL test skip.

If you base the test skip decision to a simple lookup on a list of
features (not calling them build configuration anymore, as this is clear
not attractive), this won't happen.  A "feature statement check" will
make the test proceed, and the *failure* will be presented.

I hope the pattern is visible.

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]


--41wxxoi5r60WuoiSOWtBnE6l9q6j1G4Pe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZd27NAAoJEGV+jTOl8gnzucoP+gNwF+14NMRDbltc7UVebX/+
6wXeSUfWK0lQ6shCHr+Hp+9M2/fmVFsXT1gtOuSm3Qmqdjz4iIQCMbeTUlPW+vi/
Yj3LPsvy/Vhn0AV0sVaXS/Lbdkd//yJkaQb2zwhS4CUpXpR29qJpXwdjuvdxOQAX
PGeqri36lX9s3IQ8CTb47nXuncaGiAAbFdLesnylydVNngrGT5RxT1YEA+PqXv5Y
1R6K29qkRhQUzy+IjRLdVukvkPXdXfo3XfaAqDZYfW4LzyAUKVyWBMdoSfx8bgY7
0phuCbdgl6jlOPSta4F9q2nN9lGdMdy0gs05Z2dKqx03fxXCtbL1yurBTVC+M2Sx
S1guD3uZ3p33twzcgVdkgGMzZDr2yzMUk7Vl62MAsDfebT6Bk7BV/iHxh5CdGV3l
OldHz+ns+Ki/7pgdBUZPz4wSqe7FSxT+91xMo58NSRsFV5l++uI5ltE1oCJ6mu80
ikzLtKPO+VU3Bwehw+vEb2M6wKBfa/J8Hi9VfHy8uxboPSO3KkaXkpbWWw4qDgvd
B15ifwylOiX9JbFhl6TNTFsc09MGtAMqP2zdvjhAqJYn8xhiXedM4/HqyLfWBOvx
c7otH7oJzKGrqKe9mVOX4hk95E9Y5m0uX1NeaKHoB68caQu36MHDLJ2c2vxrH9pf
rvQIjcCJBJeb8B2DGwSG
=XGUx
-----END PGP SIGNATURE-----

--41wxxoi5r60WuoiSOWtBnE6l9q6j1G4Pe--
