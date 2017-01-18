Received: from eggs.gnu.org ([2001:4830:134:3::10]:42136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTpbM-0002tb-JO
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 07:44:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTpbH-0005Qn-Ch
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 07:44:32 -0500
References: <20170103182801.9638-1-berrange@redhat.com>
	<20170103182801.9638-8-berrange@redhat.com>
	<d3f1e931-cecf-71b2-db82-f43c51361599@redhat.com>
	<20170117095911.GB27235@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3e1a4a9a-7811-050c-3818-216b534f984a@redhat.com>
Date: Wed, 18 Jan 2017 13:44:08 +0100
MIME-Version: 1.0
In-Reply-To: <20170117095911.GB27235@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kBdVAL8cTa2nkE8IERRKbBx5p76oSRnP8"
Subject: Re: [Qemu-devel] [PATCH v1 07/15] iotests: fix 097 when run with
 qcow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kBdVAL8cTa2nkE8IERRKbBx5p76oSRnP8
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <3e1a4a9a-7811-050c-3818-216b534f984a@redhat.com>
Subject: Re: [PATCH v1 07/15] iotests: fix 097 when run with qcow
References: <20170103182801.9638-1-berrange@redhat.com>
 <20170103182801.9638-8-berrange@redhat.com>
 <d3f1e931-cecf-71b2-db82-f43c51361599@redhat.com>
 <20170117095911.GB27235@redhat.com>
In-Reply-To: <20170117095911.GB27235@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17.01.2017 10:59, Daniel P. Berrange wrote:
> On Mon, Jan 16, 2017 at 09:04:31PM +0100, Max Reitz wrote:
>> On 03.01.2017 19:27, Daniel P. Berrange wrote:
>>> The previous commit:
>>>
>>>   commit a3e1505daec31ef56f0489f8c8fff1b8e4ca92bd
>>>   Author: Eric Blake <eblake@redhat.com>
>>>   Date:   Mon Dec 5 09:49:34 2016 -0600
>>>
>>>     qcow2: Don't strand clusters near 2G intervals during commit
>>>
>>> extended the 097 test case so that it did two passes, once
>>> with an internal snapshot, once without.
>>>
>>> qcow (v1) does not support internal snapshots, so this change
>>> broke test 097 when run against qcow.
>>>
>>> This splits 097 in two, creating a new 173 that tests the
>>> internal snapshot codepath, effectively putting 097 back
>>> to its content before the above commit.
>>>
>>> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
>>> ---
>>>  tests/qemu-iotests/097     |  10 +---
>>>  tests/qemu-iotests/097.out | 125 ++---------------------------------=
---------
>>>  tests/qemu-iotests/173     | 126 +++++++++++++++++++++++++++++++++++=
++++++++++
>>>  tests/qemu-iotests/173.out | 119 +++++++++++++++++++++++++++++++++++=
+++++++
>>>  tests/qemu-iotests/group   |   1 +
>>>  5 files changed, 251 insertions(+), 130 deletions(-)
>>>  create mode 100755 tests/qemu-iotests/173
>>>  create mode 100644 tests/qemu-iotests/173.out
>>
>> I don't think the effort is worth it, considering that probably
>> literally nobody is still using qcow -- or so I hope, at least.
>=20
> The reason I fixed this was because I wanted to be able to verify my
> refactoring to qcow didn't break anything else. It is much easier if
> I can just run "check -qcow" and not have to worry about which failures=

> are just test bugs, vs genuine code bugs I've created. IOW, as long as
> qcow.c exists in the code base, IMHO, we should make sure the iotests
> continue to pass

Right, what I meant is that I don't think it's worth fixing tests for
qcow. If they don't work and it isn't qcow that's broken (but just the
test requiring something that qcow does not have), just removing it from
the _supported_fmt list is usually sufficient in my opinion.

> On that point, IMHO, it would be beneficial if we had some CI system
> that was setup to run the iotests on all new changes, across all the
> different disk formats we expect the iotests to work on. We get far
> too many regressions with iotests breaking and no one noticing right
> now :-(

Indeed, but that would require all of the iotests consistently passing
first...

Max


--kBdVAL8cTa2nkE8IERRKbBx5p76oSRnP8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlh/YyMSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A9QoH/ibds/dN3zcitR+AvpNQKgaIivslqRPZ
UJ3fzqGqGaNQ4jB8iFSSeLXCmN470y5EBH8rSBHp9IOs/7o2Rm+SnkyVTK+fqY01
8aCRDsnRyLHDSsOe4FiJUDRUdOQwh+v4Y4biMu1LHgY29QyFS2BXUFJHchMFHFL9
Gxj2lEQ8bDVhJUDZyhTJkMW7YMKsbu9q3UcNpEE3mFk8KME/OAIDlibj1waCYduz
4T4uJvdSuzpt0y8hi0L3o/g6nNB0kLiyR8ydbJCoVYv920eiG5yUbjbe5dHel9gX
MnpLik7pkRuGhZvQTOltQulf2yDipCfTFol2/itqTal3Zninv5f0VlM=
=fTTi
-----END PGP SIGNATURE-----

--kBdVAL8cTa2nkE8IERRKbBx5p76oSRnP8--
