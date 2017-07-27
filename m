Received: from eggs.gnu.org ([2001:4830:134:3::10]:56725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1db5Lc-0004eG-KC
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1db5LZ-0005P3-K6
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:30:32 -0400
References: <20170727120210.6943-1-crosa@redhat.com>
	<20170727120210.6943-2-crosa@redhat.com>
	<CAFEAcA-CzG=JYjajJqMRL+pcMC2_06HTm1_xhD=ca=AReXHmTA@mail.gmail.com>
	<e6978405-6492-1124-d6e4-4a6a5b124c48@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <3367822b-da85-7032-f7c0-c488153a6e07@redhat.com>
Date: Thu, 27 Jul 2017 09:47:11 -0400
MIME-Version: 1.0
In-Reply-To: <e6978405-6492-1124-d6e4-4a6a5b124c48@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6KVaNAhSlT2DIIDCsX26UTIaQuxdrSg6i"
Subject: Re: [Qemu-devel] [PATCH 1/5] configure: remove duplicate single
 quotes on config.log header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6KVaNAhSlT2DIIDCsX26UTIaQuxdrSg6i
From: Cleber Rosa <crosa@redhat.com>
To: Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <3367822b-da85-7032-f7c0-c488153a6e07@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] configure: remove duplicate single
 quotes on config.log header
References: <20170727120210.6943-1-crosa@redhat.com>
 <20170727120210.6943-2-crosa@redhat.com>
 <CAFEAcA-CzG=JYjajJqMRL+pcMC2_06HTm1_xhD=ca=AReXHmTA@mail.gmail.com>
 <e6978405-6492-1124-d6e4-4a6a5b124c48@redhat.com>
In-Reply-To: <e6978405-6492-1124-d6e4-4a6a5b124c48@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 07/27/2017 08:24 AM, Eric Blake wrote:
> On 07/27/2017 07:15 AM, Peter Maydell wrote:
>> On 27 July 2017 at 13:02, Cleber Rosa <crosa@redhat.com> wrote:
>>> The generation of the informational header on config.log contains two=

>>> pairs of single quotes, which seems unintentional, and looks like
>>> this:
>>>
>>>   # QEMU configure log Thu Jul 26 08:17:15 EDT 2017
>>>   # Configured with: './configure' '--target-list=3Dx86_64-softmmu'
>>
>> I think this is deliberate. The idea is that the string is a
>> validly shell-quoted string that you can cut and paste
>> into a shell prompt if you want to.
>=20
> It IS deliberate.  If you want, you could improve the code to only emit=

> '' around arguments that require it rather than all arguments, but that=

> requires more shell code (it's easier to quote everywhere, even when it=

> looks strange because the quotes weren't necessary).
>=20
>> ...and note in particular how the '--cc=3Dccache gcc' argument
>> is printed.
>=20
> Yes, that's a case where the quotes are necessary.
>=20

Right, now I can see why.  Thanks for the review!

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]


--6KVaNAhSlT2DIIDCsX26UTIaQuxdrSg6i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZee7iAAoJEGV+jTOl8gnz/84P/A5BOim4htHWgCTenPoQkvfE
3Nqw258/JOCFQBWZUiynid4PvkBORz7KS0wECIkW1BYpGZ4cA6xKoZVK6UFcOMhg
PzdtKo4SmvmuUQT2CUSz+UWHJsWCequFzrooKZon1scItBTaxo3CExidVBqmSFts
nmt2cDo/N7hqsot3Bj9cc1vzp29lex1nadlADbaBr9Xy6/E5qPbCnLcdzxJrUem4
9dbzl0sK04RV3PghA756FcAhN+mV7ZPvIcz8pcorgauYIMHSYzowBiK8bvu8SlyK
YraEflIWFmdQMwa70AkgdYm8wgjYkDuAlAKhoInvYrDmJ7ywOQ9K3QOp/JKZ6GHy
zb5DDtip8KbMwoVMl0FxUBNZyE6f70aRQ3L3zBeirgElPauNdwPUD0fSgfoUCugf
W8eKlM7ZtcqcPtfpCKNh4wLBIMVO5iyBFk2LJnum0TwUGwc+1P0Hcu3FsJWyeAhF
eQ1D7cz2NOtbgXeEsOwkjqBlRMZzzpeRHExjv0s/d5aLg5nFv8X6IOIsd1XTbUc9
XSXbkEu1ee697OuaCaFkXxmCmGpfizJNYxBLhe/HRRl4RKyAJ3OhR3k5GQEj0Fgv
s4xG6nbK6kprLwzNE/LnaMDAyvad5iYOvvFTVx7RP8n0q+kVWMaOznxQeyFPZGls
9uoOd39w7ezlnYKkP+6N
=WWRg
-----END PGP SIGNATURE-----

--6KVaNAhSlT2DIIDCsX26UTIaQuxdrSg6i--
