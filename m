Received: from eggs.gnu.org ([209.51.188.92]:51792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gmjPz-0007De-3V
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 13:08:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gmjPy-0000Fq-Ab
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 13:07:59 -0500
References: <271482fe-741a-6a15-15fd-181d4e55a8c4@redhat.com>
	<w51bm469xhh.fsf@maestria.local.igalia.com>
	<w518szam8em.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4236ceac-fd50-ad04-811a-0be7b3dbd667@redhat.com>
Date: Thu, 24 Jan 2019 12:07:47 -0600
MIME-Version: 1.0
In-Reply-To: <w518szam8em.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QZ7N2qTYjJHUZUNLF9Q8NUB9EEBaashor"
Subject: Re: [Qemu-devel] Consistency of iotests 093 and 136
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QZ7N2qTYjJHUZUNLF9Q8NUB9EEBaashor
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, Max Reitz <mreitz@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <4236ceac-fd50-ad04-811a-0be7b3dbd667@redhat.com>
Subject: Re: [Qemu-devel] Consistency of iotests 093 and 136
References: <271482fe-741a-6a15-15fd-181d4e55a8c4@redhat.com>
 <w51bm469xhh.fsf@maestria.local.igalia.com>
 <w518szam8em.fsf@maestria.local.igalia.com>
In-Reply-To: <w518szam8em.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/24/19 8:34 AM, Alberto Garcia wrote:
> On Thu 24 Jan 2019 11:11:06 AM CET, Alberto Garcia wrote:
>> On Wed 23 Jan 2019 06:00:49 PM CET, Max Reitz wrote:
>>> Hi,
>>>
>>> 093 and 136 seem really flaky to me.  I can reproduce that by running=
:
>>
>> That's interesting, I can make 093 fail quite easily now (I haven't
>> tested the other one yet), but I don't think this happened
>> earlier. I'll try to figure out what's going on.
>=20
> I bisected this and it seems that 093 started to fail after this:
>=20
> 8258292e monitor: Remove "x-oob", offer capability "oob" unconditionall=
y
>=20
> I'm not familiar with that option so I need to investigate.

We've got several tests failing after making x-oob unconditional; here's
another thread:

https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg05587.html

Could it be that the test was using some sort of QMP command as an
attempt to synchronize state, but the OOB handling is now making it not
a reliable sync point?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--QZ7N2qTYjJHUZUNLF9Q8NUB9EEBaashor
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxJ/vMACgkQp6FrSiUn
Q2pJcwf/RLnlledXuDiFzuSIHIvnU/e0nxY33OYJQX15kYIeoVJ+hL+vkz7pgu8h
6l1BybYAY2eOa5HDpzjwIVzyBkMkM1XsEA/pUed8hmcQB3fuENCLapJc7M4a+nks
sGYwsWMB+jBa3pdZFWO8u93A4DEqYtfMIw2VtZypwA2X8if0nbdZDWv7Jcx16jkZ
ZZOiFGUQ1/2tMmpKgRv5z+Bn603kWxCAdacwRvH2+Hh01jdu0HQtYMpJnDSFMxcP
5OM2LB70U63+7crBPtLrfYKSJFTmieU2bv8I7qSZRvX0rUO1qSESUpKp96BBx3ot
WaR9qN+dVOLDb3YJv6SsZqmJdjkECQ==
=JjTG
-----END PGP SIGNATURE-----

--QZ7N2qTYjJHUZUNLF9Q8NUB9EEBaashor--
