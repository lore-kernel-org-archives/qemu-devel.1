Received: from eggs.gnu.org ([2001:4830:134:3::10]:60170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqLpl-00041W-Sg
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 11:36:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqLpf-0003R6-VR
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 11:36:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cqLpf-0003QA-NT
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 11:36:23 -0400
References: <20170321031705.22291-1-eblake@redhat.com>
	<20170321031705.22291-2-eblake@redhat.com>
	<fb42e59d-f196-84a3-420f-dc488ef62c53@redhat.com>
	<6cb7d791-8cf5-3a48-572e-30370b1bf608@redhat.com>
	<13797820-ea41-0991-7825-a8e32fa0932a@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c2a8ff05-e4c8-48d0-63c7-572ea06c1c23@redhat.com>
Date: Tue, 21 Mar 2017 10:36:20 -0500
MIME-Version: 1.0
In-Reply-To: <13797820-ea41-0991-7825-a8e32fa0932a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="r1eqJaB2dLm1uwWja02wN47VLebaHrCEi"
Subject: Re: [Qemu-devel] [PATCH 1/2] tests: Expose regression in QemuOpts
 visitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r1eqJaB2dLm1uwWja02wN47VLebaHrCEi
From: Eric Blake <eblake@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <c2a8ff05-e4c8-48d0-63c7-572ea06c1c23@redhat.com>
Subject: Re: [PATCH 1/2] tests: Expose regression in QemuOpts visitor
References: <20170321031705.22291-1-eblake@redhat.com>
 <20170321031705.22291-2-eblake@redhat.com>
 <fb42e59d-f196-84a3-420f-dc488ef62c53@redhat.com>
 <6cb7d791-8cf5-3a48-572e-30370b1bf608@redhat.com>
 <13797820-ea41-0991-7825-a8e32fa0932a@redhat.com>
In-Reply-To: <13797820-ea41-0991-7825-a8e32fa0932a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/21/2017 08:33 AM, Laurent Vivier wrote:
> On 21/03/2017 14:21, Eric Blake wrote:
>> On 03/21/2017 04:01 AM, Laurent Vivier wrote:
>>> On 21/03/2017 04:17, Eric Blake wrote:
>>>> Commit 15c2f669e broke the ability of the QemuOpts visitor to
>>>> flag extra input parameters, but the regression went unnoticed
>>>> because of missing testsuite coverage.  Add a test to cover this.
>>>
>>> I don't know where I'm wrong, but when I run this test without the fi=
x
>>> it never fails.
>>
>> Intentional:
>>
>>
>>>> +    v =3D opts_visitor_new(opts);
>>>> +    /* FIXME: bogus should be diagnosed */
>>>> +    visit_type_UserDefOptions(v, NULL, &userdef, &error_abort);
>>
>> The test is written with a FIXME here, then updated in the next patch =
to
>> remove the fixme and adjust the condition to what we really want, so
>> that 'make check-unit' is not broken in the meantime.
>=20
> OK.
>=20
> Why don't you reverse the patch order to have a commit to apply the fix=

> and a commit to apply the test (fully)?
>=20
> Like this, it easy to not apply the fix and only the test to check the
> test really detects the problem and the fix really fix it (it's what
> I've tried to do)... and the "make check" is never broken.

Applying just the one-liner fix to qapi/opts-visitor.c in isolation
already causes a 'make check' failure; a careful read of 2/2 shows that
I was adjusting the expected output of two separate tests, added over
two separate commits, but both with a BUG/FIXME tag.  I'm not opposed to
reworking the series to apply the testsuite coverage after the bug fix,
if that is deemed necessary, but would like an opinion from Markus which
way he would prefer (as this is the code he maintains) before causing
myself artificial churn.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--r1eqJaB2dLm1uwWja02wN47VLebaHrCEi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0Uh0AAoJEKeha0olJ0Nqd34H/2vC8kH1dhhui1fqW8eDNqIo
U1nmGdN6Du9TXjUUvCYeet+Cj6jL7NvMG7O7zvCTj5MRYdEtx5IGpG0fjbVPMwzE
tPJtD93C84BENZFbORpKxwVgOGDq2Nfl9zVkzZOf0ezpIlWWH3zXP+WMaNuV4KDT
e5wuOczzH/gWJrf75pHLJC139NYkWK1oI39z9ujhAinoQxAEzu6ZH22yQ6PaYZNQ
KMGz3W5ZFZQuvqlc+/MWq8Ufu3B6bwSmUNtBQdA2T8elxPmGPALOCg0F31KyYgEG
T4De33uV6Pgzv818/6AMdKpOh0grDFV/wr3LkKFzoVWayDbVKEAlhnsPcaoSm0g=
=CeVy
-----END PGP SIGNATURE-----

--r1eqJaB2dLm1uwWja02wN47VLebaHrCEi--
