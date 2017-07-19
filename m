Received: from eggs.gnu.org ([2001:4830:134:3::10]:44997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXpLM-00029x-32
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXpLI-0008Hw-PD
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:48:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dXpLI-0008HZ-Ey
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:48:44 -0400
References: <1500448182-21376-1-git-send-email-armbru@redhat.com>
	<CAJ+F1C+tNiGEkzC3aBf=_92oxb7NvG+UeYaUPLy9vKY8ym936g@mail.gmail.com>
	<87h8y8iq4o.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d5698179-cd49-143c-fc73-7c4528bb0cb6@redhat.com>
Date: Wed, 19 Jul 2017 08:48:38 -0500
MIME-Version: 1.0
In-Reply-To: <87h8y8iq4o.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JebCpQn6VjPpISQ0XeCa7OOAJ004QQux9"
Subject: Re: [Qemu-devel] [PATCH] vnc: Clarify documentation of QMP command
 change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JebCpQn6VjPpISQ0XeCa7OOAJ004QQux9
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <d5698179-cd49-143c-fc73-7c4528bb0cb6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] vnc: Clarify documentation of QMP command
 change
References: <1500448182-21376-1-git-send-email-armbru@redhat.com>
 <CAJ+F1C+tNiGEkzC3aBf=_92oxb7NvG+UeYaUPLy9vKY8ym936g@mail.gmail.com>
 <87h8y8iq4o.fsf@dusky.pond.sub.org>
In-Reply-To: <87h8y8iq4o.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/19/2017 07:10 AM, Markus Armbruster wrote:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>=20
>> Hi
>>
>> On Wed, Jul 19, 2017 at 9:09 AM, Markus Armbruster <armbru@redhat.com>=
 wrote:
>>> QMP command
>>>
>>>     { "execute": "change",
>>>       "arguments": { "device": "vnc", "target": "password", "arg": PW=
D } }
>>>
>>> behaves just like
>>>
>>>     { "execute": "change-vnc-password",
>>>       "arguments": { "password", "arg": PWD } }
>>>
>>> Their documentation differs, however.  According to
>>> change-vnc-password's documentation, "an empty password [...] will se=
t
>>> the password to the empty string", while change's documentation claim=
s
>>> "no future logins will be allowed".  The former is actually correct.
>>> Replace the incorrect claim by a reference to change-vnc-password.
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>
>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>>
>> The password would have to be NULL to disallow further login, is that
>> what your other series will allow to do?
>=20
> I guess it could be applied to change-vnc-password that way.

Ideally, 'change' will be deprecated (and certainly we shouldn't add
anything further to it), but yes, 'change-vnc-password' could be
enhanced in 2.11 to use the StrOrNull alternate to use null as the
request for no password (since the empty string "" _is_ hashable as a
password, whether or not we currently allow it to be one).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--JebCpQn6VjPpISQ0XeCa7OOAJ004QQux9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllvYzYACgkQp6FrSiUn
Q2o8wwf/U5rY3DfKaK6FbDSrHvt6lBM+n4+hZP2StsYeaPgKRuNm8sYnLWKQ9P/G
zGVXvSfCQ1yrY+XW89JW5ycz/XZg8uCk9NNGUmyHvuzcw6BzNLXDzhaF5oEz55nQ
OIK4ONA4w7d4HqyyDn9l0XfOOBFaoQvw9wsbnkIQgnASrODFCtSoZ9wdrxNNoJBa
0OQlTHw8q/5qOVeBvROZ/VtY43y6zVydntizSwTYNQIh7YUSz+fQAOD+Hn3Am4Hw
qyyviMPvQ878BrPL/gLFcRM0IXCq0xiP8mG8OIR8tNhFA7/2rxqbUsEx61TOK7Y7
FgMKn3P5xgjxuqb5G5+rPuAtV58jOA==
=chHM
-----END PGP SIGNATURE-----

--JebCpQn6VjPpISQ0XeCa7OOAJ004QQux9--
