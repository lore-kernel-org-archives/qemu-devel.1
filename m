Received: from eggs.gnu.org ([2001:4830:134:3::10]:38516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d0oUY-0005XM-Oa
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 08:13:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d0oUX-0005dk-M0
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 08:13:50 -0400
References: <815765cfcea726c7a4cc619c4f6c3bedb47f16b9.1492537347.git.jcody@redhat.com>
	<e649d1d3-6310-6607-22fe-82fc961d53c4@redhat.com>
	<20170418193129.GJ5704@localhost.localdomain>
	<c0a0816b-9ff9-a285-dbe1-c5b4f78e6ee4@redhat.com>
	<20170418194223.GK5704@localhost.localdomain>
	<20170419103635.GB14508@lemon.lan>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <63eb8549-dea7-ba35-021c-78697aa5f099@redhat.com>
Date: Wed, 19 Apr 2017 14:13:35 +0200
MIME-Version: 1.0
In-Reply-To: <20170419103635.GB14508@lemon.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="i1MBWBE2Uuk4MAHI0s1M6wcltvFjL2p4V"
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 1/1] qemu-iotests:
 _cleanup_qemu must be called on exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Jeff Cody <jcody@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i1MBWBE2Uuk4MAHI0s1M6wcltvFjL2p4V
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, Jeff Cody <jcody@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, kwolf@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Message-ID: <63eb8549-dea7-ba35-021c-78697aa5f099@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 1/1] qemu-iotests: _cleanup_qemu
 must be called on exit
References: <815765cfcea726c7a4cc619c4f6c3bedb47f16b9.1492537347.git.jcody@redhat.com>
 <e649d1d3-6310-6607-22fe-82fc961d53c4@redhat.com>
 <20170418193129.GJ5704@localhost.localdomain>
 <c0a0816b-9ff9-a285-dbe1-c5b4f78e6ee4@redhat.com>
 <20170418194223.GK5704@localhost.localdomain>
 <20170419103635.GB14508@lemon.lan>
In-Reply-To: <20170419103635.GB14508@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.04.2017 12:36, Fam Zheng wrote:
> On Tue, 04/18 15:42, Jeff Cody wrote:
>>> One idea presented in an earlier thread was that common.rc should cre=
ate
>>> a subdirectory per test (rather than all tests sharing scratch/), and=

>>> then common.rc itself install the cleanup hook that wipes out the ent=
ire
>>> subdirectory (or maybe even add a command-line option to ./check to
>>> suppress wiping when it is desirable to debug a test failure by seein=
g
>>> the droppings left behind).
>>>
>>
>> Yep, good ideas.  I'll leave that for another series though; there are=
 a few
>> other changes based on some suggestions from Daniel that I'd like to
>> implement as well, and I can fold your suggestions above into a new se=
ries
>> (unless someone else does it first).
>=20
> Sounds good, I was thinking about making ./check run tests in parallel.=
 If each
> test has its own tmpdir, it will be much easier.

In case you were not yet aware: you can manually set TEST_DIR, this is
what I do.

(I have a script that basically does TEST_DIR=3D/tmp/test-$1 ./check -$1)=


Max


--i1MBWBE2Uuk4MAHI0s1M6wcltvFjL2p4V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlj3VG8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AdF4H/1WdrAjm8OuNdUaeXB0VxTwcjatU1IGc
A980lgujDHZd8vAaJUkA3rjh+8KU1coVwqp3V8txsbV2HRGGxY1lAcb5gvxcL9P8
gmAMqQD/UsueExh8OkcnRBSe6Yl4MFkieQ/7vzcEF/gxPMJyrnl9m+U8FWm/9t89
OvBIsQqFfAOEydLFGjnkIgsJPPzvpGahSeCJDOj0tb/4hQmhuvbGpof185tjUC5b
4nQdZ01SO/YBrhi8CXVvs6R94tuwwpZtdnzail0VTe7QmIhXUrl2p0HxkXTiK/V3
I47hEpjjoULED+KLJvg5Sgu9yMNRlL5DGkQLx7uxVBULxcPWUZG2xuc=
=svyG
-----END PGP SIGNATURE-----

--i1MBWBE2Uuk4MAHI0s1M6wcltvFjL2p4V--
