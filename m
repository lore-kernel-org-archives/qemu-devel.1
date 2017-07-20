Received: from eggs.gnu.org ([2001:4830:134:3::10]:52753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYGkO-00038X-5o
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:04:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYGkK-0002l9-WF
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:04:28 -0400
References: <1500568290-7966-1-git-send-email-peter.maydell@linaro.org>
	<d4b6f6a0-3479-795a-97b2-68c98a6b0c24@twiddle.net>
	<c1526558-db87-734b-c1dd-7601ceaa682c@redhat.com>
	<06919388-6794-d0a0-f014-b95a9cc68460@twiddle.net>
From: Eric Blake <eblake@redhat.com>
Message-ID: <10223971-6e02-fe3f-337f-de9c14081582@redhat.com>
Date: Thu, 20 Jul 2017 14:04:20 -0500
MIME-Version: 1.0
In-Reply-To: <06919388-6794-d0a0-f014-b95a9cc68460@twiddle.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XDcaAcknROkKp4V1nnXkWgRpVFj0iK6mc"
Subject: Re: [Qemu-devel] [PATCH for-2.10] Use qemu_tolower() and
 qemu_toupper(), not tolower() and toupper()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Kamil Rytarowski <kamil@netbsd.org>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XDcaAcknROkKp4V1nnXkWgRpVFj0iK6mc
From: Eric Blake <eblake@redhat.com>
To: Richard Henderson <rth@twiddle.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Cc: patches@linaro.org, Cornelia Huck <cohuck@redhat.com>,
 Alexander Graf <agraf@suse.de>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Kamil Rytarowski <kamil@netbsd.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Message-ID: <10223971-6e02-fe3f-337f-de9c14081582@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10] Use qemu_tolower() and
 qemu_toupper(), not tolower() and toupper()
References: <1500568290-7966-1-git-send-email-peter.maydell@linaro.org>
 <d4b6f6a0-3479-795a-97b2-68c98a6b0c24@twiddle.net>
 <c1526558-db87-734b-c1dd-7601ceaa682c@redhat.com>
 <06919388-6794-d0a0-f014-b95a9cc68460@twiddle.net>
In-Reply-To: <06919388-6794-d0a0-f014-b95a9cc68460@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/20/2017 01:57 PM, Richard Henderson wrote:
> On 07/20/2017 08:48 AM, Eric Blake wrote:
>> On 07/20/2017 01:26 PM, Richard Henderson wrote:
>>> On 07/20/2017 06:31 AM, Peter Maydell wrote:
>>>> gdbstub.c:914:13: warning: array subscript has type 'char'
>>>>
>>>> This reflects the fact that toupper() and tolower() give
>>>> undefined behaviour if they are passed a value that isn't
>>>> a valid 'unsigned char' or EOF.
>>>
>>> Not saying we shouldn't use qemu_tolower etc, but this statement is n=
ot
>>> true at all.  Officially, the argument to toupper and tolower is type=

>>> int.
>>
>> Correct. Officially, the argument to toupper is an int, but
>> range-constrained to the set of ints that represent either EOF or an
>> unsigned char value.
>=20
> Please show me that language in C11 (or any other version).

POSIX:
http://pubs.opengroup.org/onlinepubs/9699919799/functions/toupper.html

> For toupper(): [CX] [Option Start]  The functionality described on this=
 reference page is aligned with the ISO C standard. Any conflict between =
the requirements described here and the ISO C standard is unintentional. =
This volume of POSIX.1-2008 defers to the ISO C standard. [Option End]
>=20
> The toupper() [CX] [Option Start]  and toupper_l() [Option End]  functi=
ons have as a domain a type int, the value of which is representable as a=
n unsigned char or the value of EOF. If the argument has any other value,=
 the behavior is undefined.

So POSIX is claiming it is a C99 requirement.

And I found this in C11:

7.4 Character handling <ctype.h>
1 The header <ctype.h> declares several functions useful for classifying
and mapping
characters. 198) In all cases the argument is an int, the value of which
shall be
representable as an unsigned char or shall equal the value of the macro
EOF. If the
argument has any other value, the behavior is undefined.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--XDcaAcknROkKp4V1nnXkWgRpVFj0iK6mc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllw/rQACgkQp6FrSiUn
Q2pYAQgAhZCq/f3XEuKR6gyHIN4klKXhXjqPopDI0j8P6od2LQoFFSYlgyzFT51/
JVhinewpWm1DkEwsLyMPBgNg22wKPH6LVfAJstWSSQOR0/nbw6VdTWejnjX/a4CI
BTeQNCqDNtE/iqnuOFzKBG1/gKlg/83txRQUnZD4cSA8xRsQUPq1ulAhXnfFakOa
m92vhe7B2Nb98MrNAuJatn55flCWhlvFZV1T2Z6Lsr4ZX1Ovm6+7hokroEYXSuOB
CRpCTSN6XCrolrly4xphcZenvDkNOXjoOvJTWl/3moEiL2x2IwSwiNXdSGkWUBJp
SafLjkpcX+kvdJbFA4SQehtd+tjJ2w==
=QrOi
-----END PGP SIGNATURE-----

--XDcaAcknROkKp4V1nnXkWgRpVFj0iK6mc--
