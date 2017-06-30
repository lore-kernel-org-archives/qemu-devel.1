Received: from eggs.gnu.org ([2001:4830:134:3::10]:54532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dQwQQ-000078-Ui
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:57:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dQwQN-0007UF-SP
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:57:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1dQwQN-0007SQ-K7
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:57:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7C088DAD11
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 13:57:30 +0000 (UTC)
References: <1498536619-14548-1-git-send-email-peterx@redhat.com>
	<1498536619-14548-5-git-send-email-peterx@redhat.com>
	<139475df-a7d8-80c6-ce21-a9a896e642ff@redhat.com>
	<20170630030321.GA24859@pxdev.xzpeter.org>
	<20170630071123.GE24859@pxdev.xzpeter.org>
	<c616d603-a744-dd6b-1f8b-91f0a7614436@redhat.com>
	<42c0ecd8-01b5-6965-2f62-4275af7825d9@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <75c4314e-869f-38f3-3470-b1c8e94493b8@redhat.com>
Date: Fri, 30 Jun 2017 15:57:23 +0200
MIME-Version: 1.0
In-Reply-To: <42c0ecd8-01b5-6965-2f62-4275af7825d9@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ISGUQxg8geOegNLULEL8w97BBrk3bHNww"
Subject: Re: [Qemu-devel] [PATCH v6 04/10] migration: let MigrationState be
 a qdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ISGUQxg8geOegNLULEL8w97BBrk3bHNww
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost
 <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <75c4314e-869f-38f3-3470-b1c8e94493b8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 04/10] migration: let MigrationState be a
 qdev
References: <1498536619-14548-1-git-send-email-peterx@redhat.com>
 <1498536619-14548-5-git-send-email-peterx@redhat.com>
 <139475df-a7d8-80c6-ce21-a9a896e642ff@redhat.com>
 <20170630030321.GA24859@pxdev.xzpeter.org>
 <20170630071123.GE24859@pxdev.xzpeter.org>
 <c616d603-a744-dd6b-1f8b-91f0a7614436@redhat.com>
 <42c0ecd8-01b5-6965-2f62-4275af7825d9@redhat.com>
In-Reply-To: <42c0ecd8-01b5-6965-2f62-4275af7825d9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-30 15:05, Eric Blake wrote:
> On 06/30/2017 07:33 AM, Max Reitz wrote:
>=20
>>> The assertion is caused by migrate_add_blocker() called before
>>> initialization of migration object. I'll fix it.
>>
>> Thanks!
>>
>>> But even with a fix (so I can pass 055 now), I still cannot pass some=

>>> of the other tests. Errors I got:
>>>
>>>   https://pastebin.com/ACqbXAYd
>>>
>>> I am not familiar with iotests. Is above usual? Looks like it still
>>> includes 3 failures, and some output mismatch.
>>
>> Well, not usual. But 068 just is broken on master currently (Stefan ha=
s
>> sent "virtio: use ioeventfd in TCG and qtest mode" to fix it, and it's=

>> part of his latest pull request). The failure in test 087 is because y=
ou
>> don't have aio=3Dnative enabled in your build, as the message says. :-=
)
>=20
> We could obviously patch 087 to gracefully skip instead of fail when th=
e
> build doesn't support running it.
>=20
>>
>> I'm not sure about 118. Maybe the os.chmod() doesn't work as intended =
on
>> your machine...? Because it tries to open a read-only image as
>> read/write and wants to see it fail (which it doesn't in your case).
>=20
> Maybe a run-as-root issue, where root can write to the file in spite of=

> permissions?

That's what I had in mind, too.

>               Ideally, I'm reluctant to run testsuites as root without
> good reason (or at least a good sandbox), for fear that a bug in the
> testsuite will hose my system.

I never do. :-)

There is one test which requires it, but well, that just never gets run
on my machine (and I don't feel very sorry about it).

Max


--ISGUQxg8geOegNLULEL8w97BBrk3bHNww
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZVljEEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQCnw
B/4kQohec9mNZcZM6WRJ1/YSg53edr71tLSUgJ7+HFTVZiX6cXYtf5Br2CGblJtU
9uEGXo8Fi8UXt15N5OtZY8Qy363bvswzsO7S2DLqBOXdfowUGVqxBrfQTjgnUPzc
qKskvTHXmYsvYU18LlGEkR0MoFaa4NYZvnYBYnGKVHPVOk62758uiKA0rvkAp3V7
hq7iFdKxhAsn3e/zgJrCcT2RlzBnxEURAEdf4cvymfOyqC6uQu3F29OKhGcKb7YG
yumoWY1nvqzUGJTpNlEBPtReG0pSR7bfmNMIib0imep+TIys/lCE0hTrRb7rrLEW
dyysYErryTdc66ghTgBbWXU+
=G9Gh
-----END PGP SIGNATURE-----

--ISGUQxg8geOegNLULEL8w97BBrk3bHNww--
