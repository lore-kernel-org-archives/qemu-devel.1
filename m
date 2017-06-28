Received: from eggs.gnu.org ([2001:4830:134:3::10]:33839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dQDFA-0005Nz-5Z
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:42:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dQDF9-0001A2-Fb
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:42:56 -0400
Date: Wed, 28 Jun 2017 16:42:08 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170628134208.uhubbif5larichod@postretch>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-6-el13635@mail.ntua.gr>
	<w51h8z01bgr.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ydd3zsva6dx5kcu7"
Content-Disposition: inline
In-Reply-To: <w51h8z01bgr.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 5/8] block: add
 BlockDevOptionsThrottle to QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>


--ydd3zsva6dx5kcu7
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2017 at 03:35:48PM +0200, Alberto Garcia wrote:
>On Fri 23 Jun 2017 02:46:57 PM CEST, Manos Pitsidianakis wrote:
>
>> +# @BlockdevOptionsThrottle:
>> +#
>> +# Driver specific block device options for Throttle
>> +#
>
>I would put this earlier in the json file, together with the rest of the
>BlockdevOptions* structs.
>
>> +# @throttling-group: the name of the throttling group to use
>
>Why not call it simply "group" ?

Sure! :)
>
>> +#
>> +# @options:        BlockIOThrottle options
>> +# Since: 2.9
>> +##
>> +{ 'struct': 'BlockdevOptionsThrottle',
>> +  'data': { 'throttling-group': 'str',
>> +            'file' : 'BlockdevRef',
>> +            '*options' : 'BlockIOThrottle'
>> +             } }
>
>Not sure if 'file' is the best name for the field ("child"?), but I'm
>fine with it.

There doesn't seem to be a consistent naming scheme in block-core.json=20
("file", "image" are candidates) so I put it file after bs->file.=20

--ydd3zsva6dx5kcu7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAllTsjAACgkQc2J8L2kN
9xBr8Q/+MMrVdChezNexqwfJKphTXaBFPj5RhDky0oldfB51ieqfOWaCdWtCyHeK
U3OAPmaPAOJVCgORjMZcfzxaEZ7BaDbZVbyfCy9X/5OrAK5HnpmxxljOeydnTPnQ
vsyIc3l55kD2A4no3pojUR0+snDr7bYARcztfYrzjdGkuhxhFerf0aZwZcszFChG
9y4ZcOl4Cui4wCIUFzKbybUbno5/bVxXlahZwMnCqL0WihrgeL1ZsYx8cOD9DPVD
74A5iFtxxVScFjzbqTAp7L6BX4FvU4gnqvs/muSWsW1pM3di3UScUZa2AtKNSZ4k
0eqbSRWHhvqp0Ta64hLweD4Hm6dvBCVq7DgYAZeny8nCdefp+s8dlN/eyp3STQXF
roxsqBSvzL9aOXONjSCB3L4I+w9yG0RLbIsIvvtnbFatZBtyNFfBvkQz3kY+EvXF
GgzL7BwCJq2sMdyUfDevKK3FTr7tZ2a82EA0a9/X6YdiF5oeoQyXZM9BKS//l9+U
exYINcX4/jcHyjf6Z8IkN/4BsbdHprnx/AaLtcgdQogyx/C/VTK0xQgVrLugNdmg
iG6tzyPifHZnTx49Xdi2m+cvv1XF9dbnvnS1vdCOP9uXwg3thB6+OxIS6vy+MSsX
Sr5qdZHLyEunHM0KYY1Ui9oFYVg+SSxZWStxt0+xGlFzWIWpreg=
=x3TQ
-----END PGP SIGNATURE-----

--ydd3zsva6dx5kcu7--
