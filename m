Received: from eggs.gnu.org ([2001:4830:134:3::10]:36667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dYabk-0008RF-4H
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 12:16:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dYabg-0003Lk-VT
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 12:16:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1dYabg-0003KF-LF
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 12:16:48 -0400
References: <87o9so1hl7.fsf@dusky.pond.sub.org>
	<20170717103308.GI7163@stefanha-x1.localdomain>
	<8760epr9vw.fsf@dusky.pond.sub.org>
	<20170721153331.GL18014@stefanha-x1.localdomain>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <026a093f-1f79-4af9-a5c9-d540342b472e@redhat.com>
Date: Fri, 21 Jul 2017 12:16:30 -0400
MIME-Version: 1.0
In-Reply-To: <20170721153331.GL18014@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Q1m8eXVr8AXtpXqXeBIi8lJ0FQkec75lV"
Subject: Re: [Qemu-devel] Improving QMP test coverage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Amador Pahim <apahim@redhat.com>, qemu-devel@nongnu.org, Cleber Rosa <cleber@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q1m8eXVr8AXtpXqXeBIi8lJ0FQkec75lV
From: Cleber Rosa <crosa@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 Amador Pahim <apahim@redhat.com>, qemu-devel@nongnu.org,
 Cleber Rosa <cleber@redhat.com>
Message-ID: <026a093f-1f79-4af9-a5c9-d540342b472e@redhat.com>
Subject: Re: [Qemu-devel] Improving QMP test coverage
References: <87o9so1hl7.fsf@dusky.pond.sub.org>
 <20170717103308.GI7163@stefanha-x1.localdomain>
 <8760epr9vw.fsf@dusky.pond.sub.org>
 <20170721153331.GL18014@stefanha-x1.localdomain>
In-Reply-To: <20170721153331.GL18014@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable


On 07/21/2017 11:33 AM, Stefan Hajnoczi wrote:
>> Output testing style delegates checking ouput to diff.  I rather like =
it
>> when text output is readily available.  It is when testing QMP.  A
>> non-trivial example using this style could be useful, as discussing
>> ideas tends to be more productive when they come with patches.
>=20
> Yes, I was considering how many of the Python iotests could be rewritte=
n
> comfortably in shell.  It is nice when the test simply executes command=
s
> and the output file shows the entire history of what happened.  Great
> for debugging.
>=20
> Stefan
>=20
I'd like to have a better understanding of the major pain points here.

Although this can be seen as a matter of taste, style preferences and
even religion, I guess it's safe to say that Python can scale better
than shell.  The upside of shell based tests is the "automatic" and
complete logging, right?  Running "bash -x /path/to/test.sh" will give
much more *useful* information than "python -v /path/to/test.py" will, fa=
ct.

I believe this has to do with how *generic* Python code is written, and
how builtin functions and most of the standard Python libraries work as
they do.  Now, when writing code aimed at testing, making use of testing
oriented libraries and tools, one would expect much more useful and
readily available debug information.

I'm biased, for sure, but that's what you get when you write basic tests
using the Avocado libraries.  For instance, when using process.run()[1]
within a test, you can choose to see its command output quite easily
with a command such as "avocado --show=3Davocado.test.stdout run test.py"=
=2E

Using other custom logging channels is also trivial (for instance for
specific QMP communication)[2][3].

I wonder if such logging capabilities fill in the gap of what you
describe as "[when the] output file shows the entire history of what
happened".

BTW, I'll defer the discussion of using an external tool to check the
output and determine test success/failure, because it is IMO a
complementary topic, and I believe I understand its use cases.

Regards,
- Cleber.

[1] -
http://avocado-framework.readthedocs.io/en/52.0/api/utils/avocado.utils.h=
tml#avocado.utils.process.run
[2] -
http://avocado-framework.readthedocs.io/en/52.0/WritingTests.html#advance=
d-logging-capabilities
[3] - https://www.youtube.com/watch?v=3DhtUbOsh8MZI

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]


--Q1m8eXVr8AXtpXqXeBIi8lJ0FQkec75lV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZcijeAAoJEGV+jTOl8gnzZ9cP/2PGoJvdO8z7/A4TiD9kEqur
rRecfEw8cB8op1iW2Vb531IwswwdoFviuXtNfcmj+Ml5DxG7mAEirtlZAlOYViw3
7BSGakVz2g+nTkVE+5ChWzMb2IOVsyeJlhY3gz1J7YkkR1oDG/6+1yL4caIonWcO
MC6AzdzNx9cWvQTuIa3DAZmsCy5X3FQ+LwpAW9NXE2MBSqI2kncqmIxaVoj32Ayh
hjKUCD8/l9u6JuwKBXHUs6dCJ/WfCOMYPMmUzZ9TXp6+v496aQubvokWsi8peGeP
NYyYHktGx/BnZj6jIwPnrS2h2ucKuECsFK5XXbFjlWgbvjE4QdlfPBWjH3oFYYwl
yGjq62QAR5ERsnTe9VX4Qq++1znKweQmmRbXkWsa24esgItF2FKJ+kF/fIFUZv69
JGYJl50YqVjEDyAcwxrDOycNxuWg3/g1Islqt3yrwsfYXgRYCB9UUFvMyr54VH5m
szVBf+NmKYrY/9jTV75XwGRxSWuArFOkysNai4TqQNsUzsJS7Jc7dN3lbKPlzZAA
xumqqfNmtlILUcOipS75BAFjP/vrPVD7Ivr4/vsr1Iup4PgQevkbU1Kl+ZdixxqZ
ZJ6S9Q6gaMSWJfCVGcGM86GK70mebYrdxe9oLUbbRHjwMtgUZGmQxoLSBbwHov/4
JRlrieyxRIqiOF5LZIvC
=CPxq
-----END PGP SIGNATURE-----

--Q1m8eXVr8AXtpXqXeBIi8lJ0FQkec75lV--
