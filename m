Received: from eggs.gnu.org ([2001:4830:134:3::10]:55986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fC5JF-0005e8-OM
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 11:29:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fC5JC-0007SQ-Fi
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 11:29:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41246 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fC5JC-0007SD-8Y
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 11:29:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 006CF40201DF
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 15:29:10 +0000 (UTC)
References: <20180419150145.24795-1-marcandre.lureau@redhat.com>
	<20180419150145.24795-3-marcandre.lureau@redhat.com>
	<87po2lqcpj.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0f19c575-9dce-5ebe-0511-0060f01a60d1@redhat.com>
Date: Fri, 27 Apr 2018 10:29:05 -0500
MIME-Version: 1.0
In-Reply-To: <87po2lqcpj.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dGmo2ElHvnIHI0gQVzz39Lk0KZ0pywvQ7"
Subject: Re: [Qemu-devel] [PATCH v6 2/5] qobject: use a QObjectBase_ struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dGmo2ElHvnIHI0gQVzz39Lk0KZ0pywvQ7
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org
Message-ID: <0f19c575-9dce-5ebe-0511-0060f01a60d1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 2/5] qobject: use a QObjectBase_ struct
References: <20180419150145.24795-1-marcandre.lureau@redhat.com>
 <20180419150145.24795-3-marcandre.lureau@redhat.com>
 <87po2lqcpj.fsf@dusky.pond.sub.org>
In-Reply-To: <87po2lqcpj.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/27/2018 03:24 AM, Markus Armbruster wrote:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>=20
>> By moving the base fields to a QObjectBase_, QObject can be a type
>> which also has a 'base' field. This allows writing a generic QOBJECT()=

>> macro that will work with any QObject type, including QObject
>> itself. The container_of() macro ensures that the object to cast has a=

>> QObjectBase_ base field, giving some type safety guarantees. QObject
>> must have no members but QObjectBase_ base, or else QOBJECT() breaks.
>>
>> QObjectBase_ is not a typedef and uses a trailing underscore to make
>> it obvious it is not for normal use and to avoid potential abuse.
>=20
> The omission of typedef to signal "internal use" is unusual in QEMU.
> Doesn't bother *me*, but then I wouldn't typedef any struct or union if=

> consistency with the bulk of QEMU's code didn't demand it.
>=20
> I can add the typedef and update the commit message if desired.

I'm fine if you leave the typedef out, without modifying anything.

>=20
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> I would've been tempted to try an unnamed field, but (1) that might've
> been too clever, and (2) this patch exists and works.
>=20
> With or without the typedef:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--dGmo2ElHvnIHI0gQVzz39Lk0KZ0pywvQ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrjQcEACgkQp6FrSiUn
Q2qXKAf/QSEA9ac6wq+XXHpaU5odhQjyWPws1Tzhp4MwlnVyWlr0gO2kjFCxMu9S
j8+q67zCccyhodJ+T83gpi3ZLE5Bud9/XCCCpjGG3xgO3goTgpCLoo2OQ53ad0se
HWLDcHQ7GbCM4Ea4h+HyK/MFG5huCukJhy7YVfggbuTE5bEX0X3s4ZgzxqHpJyEg
Z3wuNZYwRu1ua/BR7i6NRZaf+KQN0exIAXNTfuQYgJRnLo2ER+gDYKtbtRwYA7MX
gFaq5lv3NJsnqaUaur/Jp8t07qvYLg5cJF4MimqwtlsF6Qv0bPVwWIpM2ibrYN+9
vh159IMkVHXKQH/HJEC3xbbsC4KXQw==
=c3C6
-----END PGP SIGNATURE-----

--dGmo2ElHvnIHI0gQVzz39Lk0KZ0pywvQ7--
