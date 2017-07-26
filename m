Received: from eggs.gnu.org ([2001:4830:134:3::10]:58410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1daR9V-0003Iv-FN
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:35:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1daR9S-0002fv-Bu
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:35:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1daR9S-0002fM-30
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:35:18 -0400
References: <20170724124438.27344-1-apahim@redhat.com>
	<20170724124438.27344-2-apahim@redhat.com>
	<20170725133708.GE23343@stefanha-x1.localdomain>
	<fe45a297-3f65-e212-90fc-33dd6d48a2f0@redhat.com>
	<20170726173543.GC3600@stefanha-x1.localdomain>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <7cb20b6a-2ff7-715f-7f8c-3da84a55bf98@redhat.com>
Date: Wed, 26 Jul 2017 14:34:58 -0400
MIME-Version: 1.0
In-Reply-To: <20170726173543.GC3600@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NPvaQS7VDtgs4jnUDLPSjSoKJ4BtsDnv1"
Subject: Re: [Qemu-devel] [PATCH v4 1/2] qemu.py: make 'args' public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Amador Pahim <apahim@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com, ldoktor@redhat.com, ehabkost@redhat.com, armbru@redhat.com, mreitz@redhat.com, famz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NPvaQS7VDtgs4jnUDLPSjSoKJ4BtsDnv1
From: Cleber Rosa <crosa@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Amador Pahim <apahim@redhat.com>, qemu-devel@nongnu.org,
 kwolf@redhat.com, ldoktor@redhat.com, ehabkost@redhat.com,
 armbru@redhat.com, mreitz@redhat.com, famz@redhat.com
Message-ID: <7cb20b6a-2ff7-715f-7f8c-3da84a55bf98@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/2] qemu.py: make 'args' public
References: <20170724124438.27344-1-apahim@redhat.com>
 <20170724124438.27344-2-apahim@redhat.com>
 <20170725133708.GE23343@stefanha-x1.localdomain>
 <fe45a297-3f65-e212-90fc-33dd6d48a2f0@redhat.com>
 <20170726173543.GC3600@stefanha-x1.localdomain>
In-Reply-To: <20170726173543.GC3600@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 07/26/2017 01:35 PM, Stefan Hajnoczi wrote:
> On Tue, Jul 25, 2017 at 11:30:16AM -0400, Cleber Rosa wrote:
>> On 07/25/2017 09:37 AM, Stefan Hajnoczi wrote:
>>> On Mon, Jul 24, 2017 at 02:44:37PM +0200, Amador Pahim wrote:
>>>> Signed-off-by: Amador Pahim <apahim@redhat.com>
>>>> Reviewed-by: Fam Zheng <famz@redhat.com>
>>>> ---
>>>>  scripts/qemu.py               | 10 +++++-----
>>>>  tests/qemu-iotests/iotests.py | 18 +++++++++---------
>>>>  2 files changed, 14 insertions(+), 14 deletions(-)
>>>
>>> Please don't do this, it encourages code duplication.  Now arbitrary
>>> users can start accessing the public field directly instead of adding=
 a
>>> reusable interfaces like add_monitor_telnet(), add_fd(), etc.
>>>
>>
>> Judging from tests/qemu-iotests/iotests.py:VM and your comment above, =
I
>> assume you see value in simple wrappers such as:
>>
>>    def add_device(self, opts):
>>         self._args.append('-device')
>>         self._args.append(opts)
>>         return self
>>
>> I honestly do not see any value here.  I do see value in other wrapper=
s,
>> such as add_drive(), in which default values are there for convenience=
,
>> and a drive count is kept.  In the end, my point is that the there are=

>> cases when a wrapper is just an annoyance and provides nothing more th=
an
>>  the illusion of a better design.
>=20
> I don't see much value in simple wrappers either besides method chainin=
g
> (more on that below).
>=20
> Getting back to this patch, I can only review patches in the context of=

> the current code base.  I don't know future plans you may have.  The
> change may make sense together with other new changes that use a public=

> args field in a useful way - it just doesn't make sense the way it has
> been presented in isolation.
>=20

I think I described what the intention is: support tests that use
instances directly.  But yes, I think it can be better backed by real
code making use of it.

> About method chaining, the current code seems to be written with method=

> chaining in mind:
>=20
> https://en.wikipedia.org/wiki/Method_chaining#Python
>=20
> If all arguments are methods then everything can be chained:
>=20
>   (vm.add_fd(fd.fileno(), 1, 'image0')
>      .add_drive('fd:image0', interface=3D'none')
>      .add_device('virtio-blk-pci,drive=3Ddrive0'))
>=20
> So I guess there is a small value in having add_device().  That said,
> tests don't take advantage of method chaining much.
>=20

Right, just about the same amount of value of a more generic
"add_arg(option, arguments=3D[])".  IMO not even worth its maintenance co=
sts.

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]


--NPvaQS7VDtgs4jnUDLPSjSoKJ4BtsDnv1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZeODSAAoJEGV+jTOl8gnzsT4QAInd9W2fyQJFIRXtbvimIdAC
VG+Tiimy6OMtyOgi3RIWRLE5FfrSce/QYpbZHXzmDRhJ7n1MS4asPxV0o6gOrDyc
SL9pQqmKrXpT+IJcEYpmz6C0DHx+OU5B8YUYVGusFvJatzAI1R3qe2e5maxwQLvN
7sAM0ljg7yV7zARs3qmfZqH9FtkgPRF9VX1QCdICk8CTre1vPdUEV3NQazSTmRC3
Qlf4AAxKak8GLkfHvQFFk0fTtwfCP+1s8S+XfxCxjwrcn0em5esZX5EB16utf10O
FPmFLXIzA3ke8f1cRNlgWMgl6b5xQTLr/P6JfQ+lHo1CN/6fvzSRl9ze6SRi22wF
cSyVKo7dQuzDAVT8GJEpYJ6KMpkz3uAuSDH32ZcuonE18bwRj5VuNr9SLLrpxObZ
FMk9i25eraEtvKnn7Y2AQBBktg6N5icLWACoGOSsnEgJw8G/kkt+mCFtCYRHluuV
nx08qYVesgZa5Jk0iWz2hmb+n3MpTlnPc659CYpDZ5ohaXdXcvrOyepxwffnvEfs
BjCiJN0IXJonvKNtkx6aUEoiOo+8kg7xGVj6hl7ImipT14LRjGQEkOPweCfXSd/9
Aq++BDdfb6G22bf7Pdq1hnJCsEkXE1bxpnxgdZTlLkRvwns2CZI0ZPjlq4JV5wHf
CQTmhOodR6mBSCdJGEI3
=AMaE
-----END PGP SIGNATURE-----

--NPvaQS7VDtgs4jnUDLPSjSoKJ4BtsDnv1--
