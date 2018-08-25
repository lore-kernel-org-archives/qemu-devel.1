Received: from eggs.gnu.org ([2001:4830:134:3::10]:40229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ftYQH-0001En-4l
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 09:16:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ftYQG-0007lC-F7
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 09:16:13 -0400
References: <20180817190457.8292-1-jsnow@redhat.com>
	<20180817190457.8292-3-jsnow@redhat.com>
	<332129bf-2c69-8ad2-ca0c-c95322639f7c@redhat.com>
	<c63c5a3b-9168-a502-453f-3ccabc2ff747@redhat.com>
	<92b5c1a6-1434-3ef6-50a8-aa77cf1e6167@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <87834da2-4ce4-2495-89f2-8b9a133eb91b@redhat.com>
Date: Sat, 25 Aug 2018 15:15:57 +0200
MIME-Version: 1.0
In-Reply-To: <92b5c1a6-1434-3ef6-50a8-aa77cf1e6167@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1CgAcO9fh4FDF3mni7CtssaQGaT39s55K"
Subject: Re: [Qemu-devel] [PATCH 2/7] jobs: canonize Error object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, jtc@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1CgAcO9fh4FDF3mni7CtssaQGaT39s55K
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, jtc@redhat.com
Message-ID: <87834da2-4ce4-2495-89f2-8b9a133eb91b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/7] jobs: canonize Error object
References: <20180817190457.8292-1-jsnow@redhat.com>
 <20180817190457.8292-3-jsnow@redhat.com>
 <332129bf-2c69-8ad2-ca0c-c95322639f7c@redhat.com>
 <c63c5a3b-9168-a502-453f-3ccabc2ff747@redhat.com>
 <92b5c1a6-1434-3ef6-50a8-aa77cf1e6167@redhat.com>
In-Reply-To: <92b5c1a6-1434-3ef6-50a8-aa77cf1e6167@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-23 00:50, John Snow wrote:
>=20
>=20
> On 08/22/2018 06:59 AM, Max Reitz wrote:
>> On 2018-08-21 02:10, John Snow wrote:
>>>
>>>
>>> On 08/17/2018 03:04 PM, John Snow wrote:
>>>> +            error_setg_errno(&job->err, -job->ret, "job failed");
>>>
>>> Kevin specifically asked for me to change this, and I lost it in the
>>> shuffle. I'll send a v3 now, since there are enough nits to warrant i=
t,
>>> and I think I want to adjust a few things to set up the "part II"
>>> portion of this changeset a little more nicely.
>>
>> But error_setg_errno() uses either strerror() or
>> g_win32_error_message(), depending on the host OS.  I prefer that over=
 a
>> blind strerror(), to be honest.
>>
>=20
> uhh, does it...?
>=20
> it looks like error_setg_errno is always error_setg_errno_internal,
> which always uses strerror... am I misreading?

Ah, right, I was...  I thought the #ifdef below somehow was referring to
the same function, so it resolved to something else.  Yeah, sure,
usually the errno values comes from something we set ourselves and not
even the real OS API, so we need to always use strerror().

Sorry.

Max


--1CgAcO9fh4FDF3mni7CtssaQGaT39s55K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluBVo0ACgkQ9AfbAGHV
z0Br6Af/ek7XLOdZ2Ob4EmWT7iJnAStI6sO7wi6XEdFOchUzB7W094GLicZxoRJK
E1fQCrQtMGwEvmYcjSTqv+ij5Tw9K9DAPg4JoaC1Rr6WnZFJ4xLIvs5B2am5nsTZ
1lRJn50dKVTGccaCS7pHGpEqXdP2LEtVrwFlbT3m8SiNqM3rhzCC6ssXR1TNogEz
jXMwivQQKQ6cNcBddgO8MoE5HlX4Y3TC6UlJ4oZLnAGe/noOkorMZ9lcAXoKwwgk
Oslc/qsG+VlKNZlcdLfXOXjM06Dz8scSf808Q6cqrI+oVvewPH53X9PDhVemKFCV
o3pwnHQPPJtuBznzQE0/JZCf2E6oGw==
=76UW
-----END PGP SIGNATURE-----

--1CgAcO9fh4FDF3mni7CtssaQGaT39s55K--
