Received: from eggs.gnu.org ([209.51.188.92]:41533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghLMY-0005yl-DY
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 16:26:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghLMX-0000pI-IV
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 16:26:10 -0500
References: <1547051976-13982-1-git-send-email-thuth@redhat.com>
	<1547051976-13982-2-git-send-email-thuth@redhat.com>
	<3316bf08-36c0-c3ce-4e4f-8244276c58d3@kaod.org>
	<20190109172801.GB3998@redhat.com>
	<d72673fa-52a5-a6ff-6aa8-34f2b4b6855f@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <60b7e2bf-6822-6e0b-7184-b38594eb38ed@redhat.com>
Date: Wed, 9 Jan 2019 15:25:53 -0600
MIME-Version: 1.0
In-Reply-To: <d72673fa-52a5-a6ff-6aa8-34f2b4b6855f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HuUskZ5kI2UkblS6Knv6YMA4SccCucItV"
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
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Cc: peter.maydell@linaro.org, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HuUskZ5kI2UkblS6Knv6YMA4SccCucItV
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Cc: peter.maydell@linaro.org, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>
Message-ID: <60b7e2bf-6822-6e0b-7184-b38594eb38ed@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/2] include/hw/ppc: Fix
 compilation with clang -std=gnu99
References: <1547051976-13982-1-git-send-email-thuth@redhat.com>
 <1547051976-13982-2-git-send-email-thuth@redhat.com>
 <3316bf08-36c0-c3ce-4e4f-8244276c58d3@kaod.org>
 <20190109172801.GB3998@redhat.com>
 <d72673fa-52a5-a6ff-6aa8-34f2b4b6855f@redhat.com>
In-Reply-To: <d72673fa-52a5-a6ff-6aa8-34f2b4b6855f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/9/19 3:20 PM, Paolo Bonzini wrote:
> On 09/01/19 18:28, Daniel P. Berrang=C3=A9 wrote:
>>> so both files include each other, how nice ...
>> If the header files are mutually dependent it makes me wonder what the=

>> point of having them split up is ?
>>
>> Feels like either they need to be merged, or they need to be split up
>> and refactored even more to remove the mutual dependancy.
>=20
> If they include each other only for the typedefs, then prehaps the
> solution is to change the coding style and allow using struct in
> function prototypes.  I'm pretty sure there are several examples of thi=
s
> already.

Or stick the typedef in <typedefs.h>, instead of trying to find (or
create) some other common header.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--HuUskZ5kI2UkblS6Knv6YMA4SccCucItV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlw2ZuIACgkQ3g5py3or
ov2A6ggAkqToCFFOjlOWNfirHjZXbyPImh25ILz4PMkzjJjdG1RQgqjLoAl82xzR
xfCFE+r5CnSijrwfkvFLa85jvqX3FrMmzNiBkdb+UFmfGjdW2a5YslA+fJdEepUV
XP6p/XGpoKc0GEVAN/vl7A4VLXa9M+f/3/ADz3t+JaZAQTTZxWn3DY3m+1w/jXAS
hyyLaITYxCyDsGXaMpr3nR49bPxEFGTIYM806sUMMei+EV1/8plLz/tQO90187SV
hf1rq5iz9+crrD8rxV+ERfeoHgy9G9UO1AMtyctzYTGZkieKtdgF1/xq4ycPZfXV
W4cf7MarFHScYCKixbsEeR5IEw1qHw==
=trAQ
-----END PGP SIGNATURE-----

--HuUskZ5kI2UkblS6Knv6YMA4SccCucItV--
