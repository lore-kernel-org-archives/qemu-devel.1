Received: from eggs.gnu.org ([2001:4830:134:3::10]:59869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDCga-00036A-NR
	for qemu-devel@nongnu.org; Tue, 23 May 2017 12:29:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDCgZ-0002Ft-P9
	for qemu-devel@nongnu.org; Tue, 23 May 2017 12:29:28 -0400
References: <1495548064-10926-1-git-send-email-kwolf@redhat.com>
	<1495548064-10926-5-git-send-email-kwolf@redhat.com>
	<b56cd2ae-8793-4b61-e867-73d66baba45b@redhat.com>
	<20170523161822.GB6791@noname.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6e53753c-f9c0-6d8c-24c9-7954da0dde68@redhat.com>
Date: Tue, 23 May 2017 11:29:13 -0500
MIME-Version: 1.0
In-Reply-To: <20170523161822.GB6791@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="h844T1W14JTtVkBDQAu7OqgFq5vQvBaAX"
Subject: Re: [Qemu-devel] [PATCH 4/4] qemu-iotests: Block migration test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, famz@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h844T1W14JTtVkBDQAu7OqgFq5vQvBaAX
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, famz@redhat.com, quintela@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, mreitz@redhat.com,
 stefanha@redhat.com
Message-ID: <6e53753c-f9c0-6d8c-24c9-7954da0dde68@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] qemu-iotests: Block migration test
References: <1495548064-10926-1-git-send-email-kwolf@redhat.com>
 <1495548064-10926-5-git-send-email-kwolf@redhat.com>
 <b56cd2ae-8793-4b61-e867-73d66baba45b@redhat.com>
 <20170523161822.GB6791@noname.redhat.com>
In-Reply-To: <20170523161822.GB6791@noname.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/23/2017 11:18 AM, Kevin Wolf wrote:
> Am 23.05.2017 um 17:46 hat Eric Blake geschrieben:
>> On 05/23/2017 09:01 AM, Kevin Wolf wrote:
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  tests/qemu-iotests/183     | 121 +++++++++++++++++++++++++++++++++++=
++++++++++
>>>  tests/qemu-iotests/183.out |  48 ++++++++++++++++++
>>>  tests/qemu-iotests/group   |   1 +
>>>  3 files changed, 170 insertions(+)
>>>  create mode 100755 tests/qemu-iotests/183
>>>  create mode 100644 tests/qemu-iotests/183.out
>>
>> Does this test gracefully skip when coupled with the efforts for a
>> configure option to disable block migration?
>> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg04398.html
>=20
> Obviously it doesn't. How would we even check? Just grep whether the
> magic error string turns up somewhere after doing 'migrate -b'?

I think the easiest way (once Juan's series lands) would be to try this
QMP on a standalone qemu execution prior to firing up the rest of the tes=
t:

 { "execute":"migrate-set-capabilities", "arguments":{
    "capabilities": [ { "capability":"block", "state":true } ] } }

If that command fails, block migration is not compiled in (or we're
talking to an older qemu that lacks the capability altogether, but we
don't have to worry about that in our iotests).  Of course, if we do
that, then we could use QMP 'migrate' with the capabilities rather than
HMP -b to drive the same aspect of the test.

>=20
> I don't think we have other test cases that don't skip immediately, but=

> only after doing half of the test, but I think it might work anyway.

That's an option too - grepping for the magic failure string and
gracefully exiting if we were unable to start migration.  I think we
have done something like that recently to grep whether we have
op-blocking support via fcntl OFD semantics, and exit early if it is an
older kernel that has less-sane locks based on the error message.


>> Should we also check the use of -i?
>=20
> Good point, though I don't even know how to use -i manually. :-)
>=20
> We can either have a follow-up patch extending this one or a completely=

> separate test case for it. I would have to try out -i before I could sa=
y
> which makes more sense.

An incremental patch to expand this test is fine.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--h844T1W14JTtVkBDQAu7OqgFq5vQvBaAX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJGNZAAoJEKeha0olJ0NqkqkH/0m9UXV6uTrabAcQIOiDG5Bg
8AvEKVWRu9eH06SGUXFZhllRdPpoQf2BOOgO72EmxK/8xb7dwkJz5ReXno+Ntf3o
N0XG+RPnvBeOXIgDZXz3nkHFdRdSZmcL7nC561iO40UjnYvxitQ3PBZSVZIsVFSD
d/m2kF41kOI6N+p3bAk4Z01eVb7pPa3qMfT1axlvXnbis776oA1Mj1CEpUOuXpdJ
axYHcEIGochiMMBYroxsS23CxKgAHiTgFhH0W+VTdAWFvdc4xkjzQXUo6v6Y3osu
DB2nX5IlobJDDxYNc5t/YUpbw58l/GGmHmlI3shBFjygT6DVw7kOxz8z0SloO3E=
=tLcv
-----END PGP SIGNATURE-----

--h844T1W14JTtVkBDQAu7OqgFq5vQvBaAX--
