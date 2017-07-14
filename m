Received: from eggs.gnu.org ([2001:4830:134:3::10]:41240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVzIZ-00080B-Jm
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:02:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVzIV-0005cv-83
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:02:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dVzIU-0005cd-UT
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:02:15 -0400
References: <1500029117-6387-1-git-send-email-peter.maydell@linaro.org>
	<910a8148-915a-ab66-1c6c-f18145c13e37@gmx.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <64d381ca-ce9a-a19b-0e6f-8ad287d27361@redhat.com>
Date: Fri, 14 Jul 2017 07:02:10 -0500
MIME-Version: 1.0
In-Reply-To: <910a8148-915a-ab66-1c6c-f18145c13e37@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GPdNDHaAg08mHve0Dj4nh7ICbE9caXmRa"
Subject: Re: [Qemu-devel] [PATCH] tests: Handle $RANDOM not being supported
 by the shell
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GPdNDHaAg08mHve0Dj4nh7ICbE9caXmRa
From: Eric Blake <eblake@redhat.com>
To: Kamil Rytarowski <n54@gmx.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org
Cc: patches@linaro.org
Message-ID: <64d381ca-ce9a-a19b-0e6f-8ad287d27361@redhat.com>
Subject: Re: [PATCH] tests: Handle $RANDOM not being supported by the shell
References: <1500029117-6387-1-git-send-email-peter.maydell@linaro.org>
 <910a8148-915a-ab66-1c6c-f18145c13e37@gmx.com>
In-Reply-To: <910a8148-915a-ab66-1c6c-f18145c13e37@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/14/2017 06:27 AM, Kamil Rytarowski wrote:
> On 14.07.2017 12:45, Peter Maydell wrote:
>> In various places in our test makefiles and scripts we use the
>> shell $RANDOM to create a random number. This is a bash
>> specific extension, and doesn't work on other shells.
>=20
> This is supported on other shells like ksh (Korn Shell), but still as a=
n
> extension.
>=20
>> With dash the shell doesn't complain, it just effectively
>> always evaluates $RANDOM to 0:
>>   echo $((RANDOM + 32768))     =3D> 32768
>>
>> However, on NetBSD the shell will complain:
>>   "-sh: arith: syntax error: "RANDOM + 32768"
>>
>=20
> I will make sure whether this behavior is correct in our sh(1).

The question is what your shell does for:

unset foo
echo $(( foo % 255 ))

if it reliably prints 0, then it would do the same when RANDOM is an
undefined (and not a magic) variable.  Presumably, where sh is going
wrong is that it is treating an undefined variable not as 0, but as a
syntax error, and you'd get that behavior regardless of whether RANDOM
is in the mix.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--GPdNDHaAg08mHve0Dj4nh7ICbE9caXmRa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZaLLCAAoJEKeha0olJ0NqHcAIAI6xRFRBd6xfK7bSbUkay2Xu
OFELsydj5SjJRswUA/OTboPKcT+jS085i4uZQ23s405k5hMzHX5WavV70G+W8yOY
eOmaLAwph0eyutW6WhQrrYJd1qo2iWfS4nMlSKjfnCYmUQe9ofKBuiJd7JPMcHuO
IwcoMH0dk6gqEhf4gJpD34A6h2TjNivaA80VvlZP27gOAJoeDg1DfynuiW1VRVhy
S964exrSKQ2dpPAl5w/10ZXKBdx7jQaZdn0BUnP/p8pkU+BqhTnB82TNCrgjxX/A
B7zFbuzbLApQg8HJpIrVtZVb68eGao/5HX0TBNtAlyMt/ksiK6tB/GIhR6P3Nz0=
=V7O8
-----END PGP SIGNATURE-----

--GPdNDHaAg08mHve0Dj4nh7ICbE9caXmRa--
