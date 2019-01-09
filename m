Received: from eggs.gnu.org ([209.51.188.92]:43192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghLRR-0008Gf-Eq
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 16:31:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghLRQ-0003uH-PH
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 16:31:13 -0500
References: <1547051976-13982-1-git-send-email-thuth@redhat.com>
	<1547051976-13982-2-git-send-email-thuth@redhat.com>
	<3316bf08-36c0-c3ce-4e4f-8244276c58d3@kaod.org>
	<20190109172801.GB3998@redhat.com>
	<d72673fa-52a5-a6ff-6aa8-34f2b4b6855f@redhat.com>
	<60b7e2bf-6822-6e0b-7184-b38594eb38ed@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <851c3bc6-8acd-f263-9b65-42942e144392@redhat.com>
Date: Wed, 9 Jan 2019 22:31:04 +0100
MIME-Version: 1.0
In-Reply-To: <60b7e2bf-6822-6e0b-7184-b38594eb38ed@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GTzjKIqyFSQJp1T0VXpwtiEzrWmRFvRsD"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/2] include/hw/ppc: Fix
 compilation with clang -std=gnu99
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Cc: peter.maydell@linaro.org, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GTzjKIqyFSQJp1T0VXpwtiEzrWmRFvRsD
From: Paolo Bonzini <pbonzini@redhat.com>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Cc: peter.maydell@linaro.org, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>
Message-ID: <851c3bc6-8acd-f263-9b65-42942e144392@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/2] include/hw/ppc: Fix
 compilation with clang -std=gnu99
References: <1547051976-13982-1-git-send-email-thuth@redhat.com>
 <1547051976-13982-2-git-send-email-thuth@redhat.com>
 <3316bf08-36c0-c3ce-4e4f-8244276c58d3@kaod.org>
 <20190109172801.GB3998@redhat.com>
 <d72673fa-52a5-a6ff-6aa8-34f2b4b6855f@redhat.com>
 <60b7e2bf-6822-6e0b-7184-b38594eb38ed@redhat.com>
In-Reply-To: <60b7e2bf-6822-6e0b-7184-b38594eb38ed@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/01/19 22:25, Eric Blake wrote:
> On 1/9/19 3:20 PM, Paolo Bonzini wrote:
>> On 09/01/19 18:28, Daniel P. Berrang=C3=A9 wrote:
>>>> so both files include each other, how nice ...
>>> If the header files are mutually dependent it makes me wonder what th=
e
>>> point of having them split up is ?
>>>
>>> Feels like either they need to be merged, or they need to be split up=

>>> and refactored even more to remove the mutual dependancy.
>>
>> If they include each other only for the typedefs, then prehaps the
>> solution is to change the coding style and allow using struct in
>> function prototypes.  I'm pretty sure there are several examples of th=
is
>> already.
>=20
> Or stick the typedef in <typedefs.h>, instead of trying to find (or
> create) some other common header.

Putting typedefs for a very specific machine or device in typedefs.h
doesn't seem too clean.  Usually typedefs.h is used when things are
shared by different subsystems (e.g. accelerator and device emulation,
or frontend and backend), and I'm pretty sure that it could be made even
smaller if someone was inclined to try.

Paolo


--GTzjKIqyFSQJp1T0VXpwtiEzrWmRFvRsD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlw2aBgACgkQv/vSX3jH
roPswgf/ZlWt7vHnkYuX5sfTrZ37N9CpVt1fL3KacbzEc/wdzy/7MBycL6mMLYMK
FHNdp0K51jrE7B/NNmi0z5wSEneMgaCf5+e2vEQXX2gn4pjfDkuvjhwKFeOeEJQh
A60N0zmbE3raUjbFMt6nrufjxY09T3a7MwHvcuOXqUoEIvF3ceFZV+uSTqBaw1op
MlJV1pYFF0JmsIZLDtmVH1qJbRpV/1sCXOx0gPCBzSC+mHqhG5qwUmz7IKg43UMn
h6nXFeB1/zCEAY/+uJ9Yzx0FCOBaOG53pFr2m0NeMHyepA1HyO3ky4un3bMMlCyI
C8rpEUFkY4ulIVqQObPll4hkA7zJ1w==
=D4WQ
-----END PGP SIGNATURE-----

--GTzjKIqyFSQJp1T0VXpwtiEzrWmRFvRsD--
