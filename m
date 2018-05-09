Received: from eggs.gnu.org ([2001:4830:134:3::10]:59183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG81-0007xm-6E
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:50:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG80-0001RJ-75
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:50:57 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180415203106.24333-1-f4bug@amsat.org>
	<5b3b6d5a-865c-0d41-368b-33fc7ec35baf@gmail.com>
	<CAKmqyKPNwNPr0ADAVmpn9JUJ0Wszc5OgVdUju7qZso=atmrX3A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7925ba7d-3cd8-7775-73a1-a2cb38adb4a5@amsat.org>
Date: Wed, 9 May 2018 00:50:42 -0300
MIME-Version: 1.0
In-Reply-To: <CAKmqyKPNwNPr0ADAVmpn9JUJ0Wszc5OgVdUju7qZso=atmrX3A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="E2AzOeXZJXAO5IeLK5imJLoOrOZb7k0Qg"
Subject: Re: [Qemu-devel] [PATCH for-2.12?] m25p80: Correct the
 at25128a/at25256a eeproms size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>, "mar.krzeminski" <mar.krzeminski@gmail.com>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E2AzOeXZJXAO5IeLK5imJLoOrOZb7k0Qg
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Alistair Francis <alistair23@gmail.com>,
 "mar.krzeminski" <mar.krzeminski@gmail.com>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Message-ID: <7925ba7d-3cd8-7775-73a1-a2cb38adb4a5@amsat.org>
Subject: Re: [Qemu-devel] [PATCH for-2.12?] m25p80: Correct the
 at25128a/at25256a eeproms size
References: <20180415203106.24333-1-f4bug@amsat.org>
 <5b3b6d5a-865c-0d41-368b-33fc7ec35baf@gmail.com>
 <CAKmqyKPNwNPr0ADAVmpn9JUJ0Wszc5OgVdUju7qZso=atmrX3A@mail.gmail.com>
In-Reply-To: <CAKmqyKPNwNPr0ADAVmpn9JUJ0Wszc5OgVdUju7qZso=atmrX3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Peter, Kevin,

On 04/16/2018 05:52 PM, Alistair Francis wrote:
> On Mon, Apr 16, 2018 at 9:05 AM, mar.krzeminski
> <mar.krzeminski@gmail.com> wrote:
>> W dniu 15.04.2018 o 22:31, Philippe Mathieu-Daud=C3=A9 pisze:
>>>
>>> >From the datasheet (3368J=E2=80=93SEEPR) description:
>>>      The AT25128A/256A provides 131,072/262,144 bits of serial
>>>      electrically-erasable programmable read only memory (EEPROM)
>>>      organized as 16,384/32,768 words of 8 bits each.
>>>
>>> However QEMU models the flash size in bytes.
>>> Correct the at25128a/at25256a entries to reflect the datasheet size.
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>
>> Reviewed-by: Marcin Krzeminski <mar.krzeminski@gmail.com>
>=20
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>=20
> Alistair
>=20
>>>
>>> ---
>>> This is not a regression, so can now wait for 2.13.
>>>
>>>   hw/block/m25p80.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
>>> index b49c8e9caa..d0b9fbfc50 100644
>>> --- a/hw/block/m25p80.c
>>> +++ b/hw/block/m25p80.c
>>> @@ -196,8 +196,8 @@ static const FlashPartInfo known_devices[] =3D {
>>>       /* Atmel EEPROMS - it is assumed, that don't care bit in comman=
d
>>>        * is set to 0. Block protection is not supported.
>>>        */
>>> -    { INFO("at25128a-nonjedec", 0x0,     0,         1, 131072, EEPRO=
M) },
>>> -    { INFO("at25256a-nonjedec", 0x0,     0,         1, 262144, EEPRO=
M) },
>>> +    { INFO("at25128a-nonjedec", 0x0,     0,         1, 16384, EEPROM=
) },
>>> +    { INFO("at25256a-nonjedec", 0x0,     0,         1, 32768, EEPROM=
) },
>>
>> Thanks!
>> Marcin
>>
>>>         /* EON -- en25xxx */
>>>       { INFO("en25f32",     0x1c3116,      0,  64 << 10,  64, ER_4K) =
},
>>
>>
>>

Can this patch goes via the ARM or Block tree?

Thanks,

Phil.


--E2AzOeXZJXAO5IeLK5imJLoOrOZb7k0Qg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlrycBIACgkQ4+MsLN6t
wN5RNg//fycZZDgiD2EmMdnK9L4x2N0AyuqvemV45flYb80nWfGpn5opuGIdNNti
hBASAGeMpjflrGrXJW9lzBDWKozKTOr7NreafG46pY48dHPUbFdOF2Xk3B57Qz8T
HjHzE/jSj00IuriNfPFxmDSKsyI5lu9oeHA0f0mmSYYbhJ6mpQgwJvRzwuz6ll81
+441MFTE1BOxToo1Rv789jjGKzeLilSaYBIXCm/npYiqqghsTh3ExyiIBREBw/wd
WYVQGyJX8YmY7k3dzRWGtdQubrZwmeMBcZOF5aeorl3kcUPeUgC+4J8DuEwuFaIy
4uPaAa/J07Wv1ZfAHmZjpKY2dJlbxgd8K3VGa677STDr9y/6q0DCPztHHjVDrUDq
qlRaPcJujwi8W4pOmoJlOWIj8mLE0X4ekFNh1WUCFZe6Proh/xIxd/w+e4uOZIke
+A+qIjzpwJX1u7TaDsnzLfovtHCJt0iYplHbkUHLtmIm6dPydc6NvvGmMF4Cuaj4
/InOVD7yGwSAh+qKngW2wgDjCJnqkxL8OHss+5FkcxYJ+FtEPaKlU47qimNGqQMV
yiXWeZKIV7PnvKx8gv7bdldvblFHqWHZfuYQdxJqulZGjgRN0BU44yfCOW/bP02B
OqZZ3gK3KwT/a6+mcLROTaIzEuTJfQS1mUHDgFiR/2TGNit8DR0=
=j1Fu
-----END PGP SIGNATURE-----

--E2AzOeXZJXAO5IeLK5imJLoOrOZb7k0Qg--
