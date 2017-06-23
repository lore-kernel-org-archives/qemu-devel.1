Received: from eggs.gnu.org ([2001:4830:134:3::10]:49829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dOQvk-0001av-A6
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 11:55:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dOQvj-0003ky-E1
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 11:55:32 -0400
References: <20170621134744.8047-1-mreitz@redhat.com>
	<20170621134744.8047-2-mreitz@redhat.com>
	<87d19xwbpj.fsf@dusky.pond.sub.org>
	<4afa1020-22a7-c07e-3f73-36746644c77a@redhat.com>
	<87o9tggk4r.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <bb33e7a6-4055-fc31-fbb5-5759a02eea8d@redhat.com>
Date: Fri, 23 Jun 2017 17:55:22 +0200
MIME-Version: 1.0
In-Reply-To: <87o9tggk4r.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uH54MK9VgFpF53f3m8buJhDSGTOsuOUEA"
Subject: Re: [Qemu-devel] [PATCH v2 1/4] qapi/qnull: Add own header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uH54MK9VgFpF53f3m8buJhDSGTOsuOUEA
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Message-ID: <bb33e7a6-4055-fc31-fbb5-5759a02eea8d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/4] qapi/qnull: Add own header
References: <20170621134744.8047-1-mreitz@redhat.com>
 <20170621134744.8047-2-mreitz@redhat.com> <87d19xwbpj.fsf@dusky.pond.sub.org>
 <4afa1020-22a7-c07e-3f73-36746644c77a@redhat.com>
 <87o9tggk4r.fsf@dusky.pond.sub.org>
In-Reply-To: <87o9tggk4r.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-22 16:41, Markus Armbruster wrote:
> Max Reitz <mreitz@redhat.com> writes:
>=20
>> On 2017-06-21 18:24, Markus Armbruster wrote:
>>> Max Reitz <mreitz@redhat.com> writes:
>>>
>>>> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>>  include/qapi/qmp/qnull.h   | 26 ++++++++++++++++++++++++++
>>>>  include/qapi/qmp/qobject.h |  8 --------
>>>>  include/qapi/qmp/types.h   |  1 +
>>>>  qobject/qnull.c            |  1 +
>>>>  target/i386/cpu.c          |  6 +-----
>>>>  tests/check-qnull.c        |  2 +-
>>>>  6 files changed, 30 insertions(+), 14 deletions(-)
>>>>  create mode 100644 include/qapi/qmp/qnull.h
>>>>
>>>> diff --git a/include/qapi/qmp/qnull.h b/include/qapi/qmp/qnull.h
>>>> new file mode 100644
>>>> index 0000000..69555ac
>>>> --- /dev/null
>>>> +++ b/include/qapi/qmp/qnull.h
>>>> @@ -0,0 +1,26 @@
>>>> +/*
>>>> + * QNull Module
>>>> + *
>>>> + * Copyright (C) 2009, 2017 Red Hat Inc.
>>>> + *
>>>> + * Authors:
>>>> + *  Luiz Capitulino <lcapitulino@redhat.com>
>>>> + *
>>>> + * This work is licensed under the terms of the GNU LGPL, version 2=
=2E1 or later.
>>>> + * See the COPYING.LIB file in the top-level directory.
>>>
>>> Copy the boilerplate from qnull.c instead, factual correctness.
>>
>> Sorry, will do.
>=20
> No need to be sorry!

I was when I noticed that it was your authorship I failed to announce. :-=
)

Max


--uH54MK9VgFpF53f3m8buJhDSGTOsuOUEA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZTTnqEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQBui
B/0d+obBOySCVgf3jqWGA0e/ElHCa/L40cU2zqHuhiKCpaTSpBnu3jsDqfL4Bveb
fOavk/M27PfMitVHM4mpRsQYO7qnqNKNG/q0k82+9yk2ls3wytDLt9cD4aCXiFFy
p97oW6hhYliOCAcuk9vJ4zU4gCwGM8BoEuJ+DrUHrjCzX3JAPy2RCKkhqcXs/LyQ
w0uAeId50gmuQSy5yDoT1w52HCxlBVOtBRh+ET673A9stZEkSZrKIT8IEf3l4kOq
9gUwGqrshLtNN/jlfDBWZPYCxz8pPDowUNJqPVpJ5QxQY1TpBYv8wfgiuQRFX4Wg
YHwpRvGon4Ztph0ospaYQWO0
=XBmn
-----END PGP SIGNATURE-----

--uH54MK9VgFpF53f3m8buJhDSGTOsuOUEA--
