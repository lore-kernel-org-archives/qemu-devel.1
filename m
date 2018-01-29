Received: from eggs.gnu.org ([2001:4830:134:3::10]:46042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egAYT-0001yG-Rq
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 09:37:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egAYQ-0007Of-ON
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 09:37:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1egAYQ-0007Mn-FZ
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 09:37:02 -0500
References: <20180129033133.31288-1-famz@redhat.com>
	<f090e697-424b-6ce6-4517-3e16c728958f@redhat.com>
	<CAK1Eb9mjV4KV2N8=yOdUVeg+P0sHnqER0BUYg5kb_FjVcmzXnQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ae6cb50d-28d8-da44-e57b-6170dd60fafc@redhat.com>
Date: Mon, 29 Jan 2018 08:36:51 -0600
MIME-Version: 1.0
In-Reply-To: <CAK1Eb9mjV4KV2N8=yOdUVeg+P0sHnqER0BUYg5kb_FjVcmzXnQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="E3J800Zpzdq8IqpGg1HgbobfMPHuPVZpw"
Subject: Re: [Qemu-devel] [PATCH] docs: Add docs/devel/testing.rst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E3J800Zpzdq8IqpGg1HgbobfMPHuPVZpw
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ae6cb50d-28d8-da44-e57b-6170dd60fafc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] docs: Add docs/devel/testing.rst
References: <20180129033133.31288-1-famz@redhat.com>
 <f090e697-424b-6ce6-4517-3e16c728958f@redhat.com>
 <CAK1Eb9mjV4KV2N8=yOdUVeg+P0sHnqER0BUYg5kb_FjVcmzXnQ@mail.gmail.com>
In-Reply-To: <CAK1Eb9mjV4KV2N8=yOdUVeg+P0sHnqER0BUYg5kb_FjVcmzXnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/29/2018 01:42 AM, Fam Zheng wrote:
> On Mon, Jan 29, 2018 at 2:56 PM, Thomas Huth <thuth@redhat.com> wrote:
>> On 29.01.2018 04:31, Fam Zheng wrote:
>> [...]
>>> +1. Create a new source file. For example, ``tests/test-foo.c``.
>> [...]
>>> +1. Create a new source file for the test. (More than one file can be=
 added as
>>> +   necessary.) For example, ``tests/test-foo-device.c``.  2. Write t=
he test
>>> +   code with the glib and libqtest/libqos API. See also existing tes=
ts and the
>>> +   library headers for reference.
>>
>> Can you please name the examples tests/foo-test.c and
>> tests/foo-device-test.c instead? Then the binaries will be covered by
>> the wildcard in tests/.gitignore automatically. Otherwise the list in
>> that gitignore file will grow and grow... Maybe it's also worth to
>> mention the naming scheme in this doc file?
>=20
> Yeah, I can do it. It's just I fail to find a definitive guideline on
> test-* vs *-test for the names, and the numbers are neck-and-neck:
>=20
> fam@lemon:~/work/qemu [master]$ ls tests/*test.c | wc -l
> 67
> fam@lemon:~/work/qemu [master]$ ls tests/test-*.c | wc -l
> 68

I'm all for a mass rename to the suffix style (as it is easier to write
a gitignore suffix), if no one can provide a good reason for the naming
difference.  (At one point, the difference was based on whether the test
was standalone or run as part of 'make check-qtest' - but I don't think
even that rule applies very well to the current state).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--E3J800Zpzdq8IqpGg1HgbobfMPHuPVZpw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpvMYMACgkQp6FrSiUn
Q2pyEggAoBtGqYc/gNkmXWRAAKMg57P9e7F0orQX9IFEs7IXNDHlOR8Wiya3bHsw
DEH5FoK/ScR2GK+M/1vv8uFHBGsY6dokVyUsuzE926g2Lt0cTSk8hOSnLd470B1X
y2eXVJJpALBvwDAv6m5gfi75As73ri2iyy4Z7T6a6l9wMrcrAKo6J2+rbgyosLaF
h7OSrxApUJqIK07ThgPlPobPzUJ4GKFRQ5kXFG5oQaPAD4YXw9sNxfFq19+FXwdQ
xiDKxSTuDOSJ2zp4esKTtwyDAnnsTiZILkyA3VjruV2A/aKeoji4BS16YSe6pW/0
tOf5CoIR2wfGoXrdPwHYOJeoAIyQDQ==
=qOEN
-----END PGP SIGNATURE-----

--E3J800Zpzdq8IqpGg1HgbobfMPHuPVZpw--
