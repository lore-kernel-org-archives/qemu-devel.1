Received: from eggs.gnu.org ([2001:4830:134:3::10]:46732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d2gJ3-0000mC-VR
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 11:53:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d2gJ2-00072Z-Qg
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 11:53:42 -0400
References: <1492957997-28587-1-git-send-email-lidongchen@tencent.com>
	<1492957997-28587-2-git-send-email-lidongchen@tencent.com>
	<7c616dbd-f83f-1643-d211-f5be8d8b2dc4@redhat.com>
	<7bb35794-6a50-c92f-fee7-e8f9cc55a1d0@amsat.org>
	<f9ce81bc-72d5-d436-5cb6-58c9dbb10aa4@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1cdac8de-6340-ac1a-9d2b-3546a4c7ffd3@redhat.com>
Date: Mon, 24 Apr 2017 10:53:32 -0500
MIME-Version: 1.0
In-Reply-To: <f9ce81bc-72d5-d436-5cb6-58c9dbb10aa4@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KjODp3Pcet28ofaEpBUwmNE55MQqgCtWK"
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-img: fix some spelling errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, jemmy858585@gmail.com, Lidong Chen <lidongchen@tencent.com>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KjODp3Pcet28ofaEpBUwmNE55MQqgCtWK
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 jemmy858585@gmail.com, Lidong Chen <lidongchen@tencent.com>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Message-ID: <1cdac8de-6340-ac1a-9d2b-3546a4c7ffd3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-img: fix some spelling errors
References: <1492957997-28587-1-git-send-email-lidongchen@tencent.com>
 <1492957997-28587-2-git-send-email-lidongchen@tencent.com>
 <7c616dbd-f83f-1643-d211-f5be8d8b2dc4@redhat.com>
 <7bb35794-6a50-c92f-fee7-e8f9cc55a1d0@amsat.org>
 <f9ce81bc-72d5-d436-5cb6-58c9dbb10aa4@redhat.com>
In-Reply-To: <f9ce81bc-72d5-d436-5cb6-58c9dbb10aa4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/24/2017 10:47 AM, Eric Blake wrote:
> On 04/24/2017 10:37 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>=20
>>>>  /*
>>>> - * Returns true iff the first sector pointed to by 'buf' contains a=
t
>>>> least
>>>> - * a non-NUL byte.
>>>> + * Returns true if the first sector pointed to by 'buf' contains at=

>>>> least
>>>> + * a non-NULL byte.
>>>
>>> NACK to both changes.  'iff' is an English word that is shorthand for=

>>> "if and only if".  "NUL" means the one-byte character, while "NULL"
>>> means the 8-byte (or 4-byte, on 32-bit platform) pointer value.
>>
>> I agree with Lidong shorthands are not obvious from non-native speaker=
=2E
>>
>> What about this?
>>
>>  * Returns true if (and only if) the first sector pointed to by 'buf'
>> contains
>=20
> That might be okay.
>=20
>>  * at least a non-null character.
>=20
> But that still doesn't make sense.  The character name is NUL, and
> non-NULL refers to something that is a pointer, not a character.

What's more, the NUL character can actually occupy more than one byte
(think UTF-16, where it is the two-byte 0 value).  Referring to NUL byte
rather than NUL character (or even the 'zero byte') makes it obvious
that this function is NOT encoding-sensitive, and doesn't start
mis-behaving just because the data picks a multi-byte character encoding.=


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--KjODp3Pcet28ofaEpBUwmNE55MQqgCtWK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY/h98AAoJEKeha0olJ0NqI2cIAJycr8lJdP0ktm/Y1q3Yt3OB
UroVOz4c58iViXHed4o1XBVAPJOw5CYvu/uze45wYvtamYq7lVEYyQraxUNcaOv9
x8mEQ0e6sfYu+GisrALDXzAYFi+8oBNpPfuZ5R9zBwa+57T3p0w6jIL+ZqvrhlQO
DRkt5hvsmmsuzSKUsTDMqq3C65jlpvCpbhgMRHexlQyg/QJhE5Y5OsVU3bU7Xki7
UKy/lEal5Ox0sPww9ynQQOCEfaMLHSk9GEnbWQBlgYtZbIiDzZ42IeqfhxDsJbN2
AalgoJQqu9LHi9ku/tZ4/vGeseM8KhtivKbkJ4ROicrX5Awnvpzevvt2Lz5lW4k=
=fJ6j
-----END PGP SIGNATURE-----

--KjODp3Pcet28ofaEpBUwmNE55MQqgCtWK--
