Received: from eggs.gnu.org ([209.51.188.92]:44558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gheyD-0005J0-Ai
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 13:22:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gheyB-0006Rr-6T
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 13:22:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gheyA-0006Rd-Tr
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 13:22:19 -0500
References: <a030d899-5a1a-b8b9-4c59-cca4bc304c1d@gmail.com>
	<200ecea3-1ef4-3ecf-6b37-f6e45fef3849@redhat.com>
	<20190109172023.GK4867@localhost.localdomain>
	<be8ac551-4cfd-db62-aa3d-0ca9b79e3e4f@redhat.com>
	<40ef0a8d-3a25-4cc3-95f8-82bc4513776c@redhat.com>
	<20190109185154.GL4867@localhost.localdomain>
	<56880d06-a214-2486-2e80-c565b33461b3@redhat.com>
	<20190110112508.GA6361@linux.fritz.box> <20190110114113.GC2589@work-vm>
	<20190110151101.GB6361@linux.fritz.box> <20190110170626.GH2589@work-vm>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6ebd4d4b-c515-fbcb-0af4-a085d5f735bd@redhat.com>
Date: Thu, 10 Jan 2019 12:22:16 -0600
MIME-Version: 1.0
In-Reply-To: <20190110170626.GH2589@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="W5MWQU0oRuzU6fNUmeDDFy2BU79fXzb6j"
Subject: Re: [Qemu-devel] [PATCH v2 0/3] HMP/snapshot changes - do not use
 ID anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, armbru@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org, muriloo@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--W5MWQU0oRuzU6fNUmeDDFy2BU79fXzb6j
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, armbru@redhat.com,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org,
 muriloo@linux.ibm.com
Message-ID: <6ebd4d4b-c515-fbcb-0af4-a085d5f735bd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] HMP/snapshot changes - do not use ID
 anymore
References: <a030d899-5a1a-b8b9-4c59-cca4bc304c1d@gmail.com>
 <200ecea3-1ef4-3ecf-6b37-f6e45fef3849@redhat.com>
 <20190109172023.GK4867@localhost.localdomain>
 <be8ac551-4cfd-db62-aa3d-0ca9b79e3e4f@redhat.com>
 <40ef0a8d-3a25-4cc3-95f8-82bc4513776c@redhat.com>
 <20190109185154.GL4867@localhost.localdomain>
 <56880d06-a214-2486-2e80-c565b33461b3@redhat.com>
 <20190110112508.GA6361@linux.fritz.box> <20190110114113.GC2589@work-vm>
 <20190110151101.GB6361@linux.fritz.box> <20190110170626.GH2589@work-vm>
In-Reply-To: <20190110170626.GH2589@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/10/19 11:06 AM, Dr. David Alan Gilbert wrote:

>>> savevm [-t] [-i] [tag|id]
>>>
>>> then:
>>>   a) with neither -t or -i  it would behave in the same roulette way
>>>      as it does in the moment, and it might be a tag or id
>>>
>>>   b) with -t we'd explicitly treat the parameter as a tag and it
>>>      would error if it wasn't found
>>>
>>>   c) With -i we'd explicitly treat the parameter as an id and
>>>      it would error if it wasn't found
>>>
>>> Since we still allow (a) it doesn't break any existing code.
>>
>> If you can explain why we need both tag and id?
>>
>> And by keeping the current behaviour, we might not break hypotheticall=
y
>> existing correct code, but we leave currently actually existing broken=

>> code like libvirt broken.
>=20
> My only reason for leaving both tag & id was for the hypothetical
> existing current code; my assumption adding the above would be that we
> would then fix libvirt never to use (a),  probably always (b).

How? HMP is not introspectible, so libvirt can't know if 'savevm -t'
works without trying it.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--W5MWQU0oRuzU6fNUmeDDFy2BU79fXzb6j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw3jVgACgkQp6FrSiUn
Q2oERgf+I1SDKMBEFow81d+qMZjniB1AtjbNRL4z2a6EjU1kG1q1YN0zzJVuIzfc
7BM+L3IWu2bKd7/CprwJt7fRx9Oy9xra1ZnHzn9LIUdtfuKlKI+XQsqq743B+MFA
Fxh+4gPodQSolg+6/guTwKfVKBCMiRm4vyXte0jDANR91s/J/OcJHbweXZwCJDlu
0n0nBcTG4HnYa2MmsSn/PFLL6qutU16pcbbIGzFv61Td7vM6b9pWFWwqKMnKlhEI
wQgUj+wCpoXcewJI1dpujEPeBfsS/NjOELnNY7yeB6sa3OBG0mqg8F9Pg8giyFA9
uLPcE+ifr3e1GqFyoPgs6qmObT58kA==
=a5GI
-----END PGP SIGNATURE-----

--W5MWQU0oRuzU6fNUmeDDFy2BU79fXzb6j--
