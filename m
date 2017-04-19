Received: from eggs.gnu.org ([2001:4830:134:3::10]:50755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d0ozq-0001Dw-Sr
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 08:46:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d0ozp-0006Z7-Rl
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 08:46:10 -0400
References: <815765cfcea726c7a4cc619c4f6c3bedb47f16b9.1492537347.git.jcody@redhat.com>
	<e649d1d3-6310-6607-22fe-82fc961d53c4@redhat.com>
	<20170418193129.GJ5704@localhost.localdomain>
	<c0a0816b-9ff9-a285-dbe1-c5b4f78e6ee4@redhat.com>
	<20170418194223.GK5704@localhost.localdomain>
	<20170419103635.GB14508@lemon.lan>
	<63eb8549-dea7-ba35-021c-78697aa5f099@redhat.com>
	<20170419123647.GL5704@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5da01fb0-eb55-c5f8-9abe-280613444c84@redhat.com>
Date: Wed, 19 Apr 2017 14:45:56 +0200
MIME-Version: 1.0
In-Reply-To: <20170419123647.GL5704@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WJ2sFs68FGtE1v4r0RxBLOOabIkQ78Bgq"
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
To: Jeff Cody <jcody@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Eric Blake <eblake@redhat.com>, kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WJ2sFs68FGtE1v4r0RxBLOOabIkQ78Bgq
From: Max Reitz <mreitz@redhat.com>
To: Jeff Cody <jcody@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Eric Blake <eblake@redhat.com>,
 kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Message-ID: <5da01fb0-eb55-c5f8-9abe-280613444c84@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 1/1] qemu-iotests: _cleanup_qemu
 must be called on exit
References: <815765cfcea726c7a4cc619c4f6c3bedb47f16b9.1492537347.git.jcody@redhat.com>
 <e649d1d3-6310-6607-22fe-82fc961d53c4@redhat.com>
 <20170418193129.GJ5704@localhost.localdomain>
 <c0a0816b-9ff9-a285-dbe1-c5b4f78e6ee4@redhat.com>
 <20170418194223.GK5704@localhost.localdomain>
 <20170419103635.GB14508@lemon.lan>
 <63eb8549-dea7-ba35-021c-78697aa5f099@redhat.com>
 <20170419123647.GL5704@localhost.localdomain>
In-Reply-To: <20170419123647.GL5704@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.04.2017 14:36, Jeff Cody wrote:
> On Wed, Apr 19, 2017 at 02:13:35PM +0200, Max Reitz wrote:
>> On 19.04.2017 12:36, Fam Zheng wrote:
>>> On Tue, 04/18 15:42, Jeff Cody wrote:
>>>>> One idea presented in an earlier thread was that common.rc should c=
reate
>>>>> a subdirectory per test (rather than all tests sharing scratch/), a=
nd
>>>>> then common.rc itself install the cleanup hook that wipes out the e=
ntire
>>>>> subdirectory (or maybe even add a command-line option to ./check to=

>>>>> suppress wiping when it is desirable to debug a test failure by see=
ing
>>>>> the droppings left behind).
>>>>>
>>>>
>>>> Yep, good ideas.  I'll leave that for another series though; there a=
re a few
>>>> other changes based on some suggestions from Daniel that I'd like to=

>>>> implement as well, and I can fold your suggestions above into a new =
series
>>>> (unless someone else does it first).
>>>
>>> Sounds good, I was thinking about making ./check run tests in paralle=
l. If each
>>> test has its own tmpdir, it will be much easier.
>>
>=20
> Neat - it'd be cool to be able to use the same options as for 'make', e=
=2Eg.
> ./check -j5.
>=20
>=20
>> In case you were not yet aware: you can manually set TEST_DIR, this is=

>> what I do.
>>
>> (I have a script that basically does TEST_DIR=3D/tmp/test-$1 ./check -=
$1)
>>
>=20
> Baking it into common without relying on external env variables adds ex=
tra
> niceties, because as Eric mentioned cleanup is not left up to the scrip=
t
> then, and the subdir can be nuked (or kept, via an option to 'check').
>=20
> This would make the scripts simpler to read and implement, and less pro=
ne to
> do Bad Things. (I keep waiting for some iotest script to misquote a var=

> during cleanup and do an rm -f ~/* or something...  it'd be nice to not=
 have
> to worry about that).

Sure, I agree. I just wanted to throw in that it isn't completely
impossible to run iotests in parallel, at least for different formats.

(Baking it in would also mean that we could automatically distribute
test invocations for a single format to multiple instances, yes (as in
your ./check -j5 proposal). But that's work to do. :-))

Max


--WJ2sFs68FGtE1v4r0RxBLOOabIkQ78Bgq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlj3XAQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A20sH/0ChiiH0WwcAAbFuHZbkzDaeayDRKU3G
vA6Aaf4tnV8X3Sq/jVPyBPrfypOBjbAgk/GkDnWJSssV06TvMvhVlDqY/A/QdTUm
FeAuZu737ewqjj/8eu7krr/hm6Gip1iv6jugYY1UQsJAiL98DF64Ob40FLahUT6y
7GVDN2mtD+/sfuW9Nv4LGowH8H1p7vJx0oGuWrj5clOR+YlxkBQXcDe3JmyVYwfO
nciDo9X3xeXDPbUpFqzZNbyzl/QUTk9R0FBAMXguOSZRYxBBVifl0+iJC3S0rQg7
ro9aQrbgc4D3LyZulDJiweB5qBekNH6NXO2h0ruMDbTgJ7LROm+1Dt8=
=jrU7
-----END PGP SIGNATURE-----

--WJ2sFs68FGtE1v4r0RxBLOOabIkQ78Bgq--
