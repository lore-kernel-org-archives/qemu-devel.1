Received: from eggs.gnu.org ([209.51.188.92]:51376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gtGJb-0002Vc-7Z
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 13:28:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gtGJZ-0000z0-CZ
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 13:28:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gtGJZ-0000yA-3V
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 13:28:21 -0500
References: <20181220141553.24098-1-marcandre.lureau@redhat.com>
	<20181220141553.24098-11-marcandre.lureau@redhat.com>
	<461252a9-b095-9441-054c-bb9dd00f8cf5@redhat.com>
	<20190107094555.es7xunsor2aud3k7@sirius.home.kraxel.org>
	<CAJ+F1CKxmZdycF8q83ziSUB5Bnwk=NFASgfjJkEDsjuQ7vcSww@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2384878a-e9a2-ac4b-372d-9fdd493db5a1@redhat.com>
Date: Mon, 11 Feb 2019 12:28:12 -0600
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKxmZdycF8q83ziSUB5Bnwk=NFASgfjJkEDsjuQ7vcSww@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5OoZBO13BqbAqZus8yT6LWbp2wRtJ5PJl"
Subject: Re: [Qemu-devel] [PATCH v2 10/12] qapi: document DisplayType enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5OoZBO13BqbAqZus8yT6LWbp2wRtJ5PJl
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>
Message-ID: <2384878a-e9a2-ac4b-372d-9fdd493db5a1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 10/12] qapi: document DisplayType enum
References: <20181220141553.24098-1-marcandre.lureau@redhat.com>
 <20181220141553.24098-11-marcandre.lureau@redhat.com>
 <461252a9-b095-9441-054c-bb9dd00f8cf5@redhat.com>
 <20190107094555.es7xunsor2aud3k7@sirius.home.kraxel.org>
 <CAJ+F1CKxmZdycF8q83ziSUB5Bnwk=NFASgfjJkEDsjuQ7vcSww@mail.gmail.com>
In-Reply-To: <CAJ+F1CKxmZdycF8q83ziSUB5Bnwk=NFASgfjJkEDsjuQ7vcSww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/9/19 7:15 AM, Marc-Andr=C3=A9 Lureau wrote:

>>>>   # Display (user interface) type.
>>>>   #
>>>> +# @default: The default user interface.
>>>
>>> Any more hints on how this default is determined?  Is it a compile-ti=
me
>>> decision, based on what libraries were linked in?
>>
>> Basically yes.  A bit more complicated due to modules.  gtk, sdl and
>> cocoa are checked, in that order.  And if none of them is available th=
e
>> vnc server is enabled.
>=20
>=20
> Eric, should I cram this comment there?: "(gtk, sdl and
> cocoa are checked, in that order.  And if none of them is available the=

> vnc server is enabled)"

If you think the end user will benefit from reading that, then it is
worth adding.  Wordsmithing a bit:

@default: The default user interface, selecting from the first available
of gtk, sdl, cocoa, and vnc.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--5OoZBO13BqbAqZus8yT6LWbp2wRtJ5PJl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxhvr0ACgkQp6FrSiUn
Q2r2HwgAlumD8+CSGYuBWpR/VjGnMF5qOTiFw7mbwn1wXMku0i8rK2e839Ad9FcV
3xp3asZWEPXr2iJ6RrOZMrZame/G0RO+n0dkIqUxrVycs99NeDvBhxxaD2h3wBRs
dEF6HmSrn0QQJdjXlh67KYG5c6UC7CoXgd5a4/3JZRvxYJJJIp6XwBR3mUqZI/IW
GmJ8tJoDgKi09sz7GxsyZw4mwdFdrRxnLiejkL7LbZNegoqIKTHBiV2oVyQAgms8
LLnT6uIoQJq2iPKGpyLXG9oF3qp+SkLbze7UbXScniK5R8STvKCBJ144yPVnQ742
ylZWOqSNYkO2p/dNLQi8yp6DvsLz1Q==
=9oLa
-----END PGP SIGNATURE-----

--5OoZBO13BqbAqZus8yT6LWbp2wRtJ5PJl--
