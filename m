Received: from eggs.gnu.org ([209.51.188.92]:45467)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1gmHuB-00071k-Tw
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 07:45:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1gmHuA-0001o5-0I
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 07:45:19 -0500
Received: from mout.gmx.net ([212.227.15.18]:43985)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1gmHu6-0001k4-7k
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 07:45:16 -0500
References: <20190123080005.31078-1-kraxel@redhat.com>
	<20190123080005.31078-5-kraxel@redhat.com>
	<484e921f-7cee-755d-12a9-02e8bf182fa4@redhat.com>
	<20190123093657.GC27270@redhat.com>
	<d7c274a7-00ac-d767-69fc-238b88cfd61b@redhat.com>
	<20190123101238.GD27270@redhat.com>
	<379cce5d-71e1-b210-c0de-c0b8a478de3a@gmx.com>
	<CAFEAcA-HOjPGz2U4wXJ_ujbUmHn1V2PohiL8wPkPz8iV6TPSig@mail.gmail.com>
	<52937a07-9462-6910-610c-5b1ee5d2541a@gmx.com>
	<20190123122015.uvyqe4vsxhhgugz7@sirius.home.kraxel.org>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <da0587e0-44a2-a0f8-3df4-628973db42fd@gmx.com>
Date: Wed, 23 Jan 2019 13:45:58 +0100
MIME-Version: 1.0
In-Reply-To: <20190123122015.uvyqe4vsxhhgugz7@sirius.home.kraxel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gEOF8QdlbrLeBFsj9V6HGYlWeE5bUZN7D"
Subject: Re: [Qemu-devel] [PATCH 4/4] [RfC] audio: probe audio drivers by
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Kamil Rytarowski <kamil@netbsd.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Brad Smith <brad@comstyle.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gEOF8QdlbrLeBFsj9V6HGYlWeE5bUZN7D
From: Kamil Rytarowski <n54@gmx.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Kamil Rytarowski
 <kamil@netbsd.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>, Brad Smith <brad@comstyle.com>
Message-ID: <da0587e0-44a2-a0f8-3df4-628973db42fd@gmx.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] [RfC] audio: probe audio drivers by
 default
References: <20190123080005.31078-1-kraxel@redhat.com>
 <20190123080005.31078-5-kraxel@redhat.com>
 <484e921f-7cee-755d-12a9-02e8bf182fa4@redhat.com>
 <20190123093657.GC27270@redhat.com>
 <d7c274a7-00ac-d767-69fc-238b88cfd61b@redhat.com>
 <20190123101238.GD27270@redhat.com>
 <379cce5d-71e1-b210-c0de-c0b8a478de3a@gmx.com>
 <CAFEAcA-HOjPGz2U4wXJ_ujbUmHn1V2PohiL8wPkPz8iV6TPSig@mail.gmail.com>
 <52937a07-9462-6910-610c-5b1ee5d2541a@gmx.com>
 <20190123122015.uvyqe4vsxhhgugz7@sirius.home.kraxel.org>
In-Reply-To: <20190123122015.uvyqe4vsxhhgugz7@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23.01.2019 13:20, Gerd Hoffmann wrote:
>   Hi,
>=20
>> Pulseaudio uses OSS backend on NetBSD anyway and we keep an in-kernel
>> mixer. So it adds nothing except additional intermediate layer.
>>
>> For non-professional audio purposes OSS is good enough for such
>> applications.
>=20
> What happens if pulseaudio is running and using the sound device?  Can
> qemu open and use the device in parallel?  "in-kernel mixer" sounds lik=
e
> this is works and the kernel mixes the streams from all applications
> before sending it to the sound device.  Or will qemu get a -EBUSY?

Multiple applications can use the OSS/native kernel API device nodes
concurrently and the in-kernel mixer will take care of mixing.

This approach has some cons, but it's practical in the current state of
affairs.

As far as I'm aware FreeBSD uses a similar approach.

>=20
> If parallel usage works we can default to oss I think.  Otherwise we
> should try pulse first, and in case it is not available (daemon not
> running) try oss next.
>=20
> What about sdl?  Prefer oss over sdl I guess?  Or the other way around?=

>=20
> What is the native sound interface for openbsd btw?  oss doesn't
> compile (missing sys/soundcard.h header).
>=20

OpenBSD uses sndio, a similar audio daemon to pulseaudio and it's
enforced for all [well integrated] audio applications.

SDL is an optional intermediate layer kept for practical/compatibility
purposes, but all software shall use sndio natively.

> cheers,
>   Gerd
>=20
>=20



--gEOF8QdlbrLeBFsj9V6HGYlWeE5bUZN7D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlxIYgYMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZs404P/02BPDWP+TMnbEDKbBEv0miMkxe+B9tNI4Wjifwn
hIyMP+wMxS+D4yHV9+GPpriCNqPvDoqF1nIVYfWpJbbKxhLsJdoh8wUSJXTT9FN6
OAPQRxMOSOUs6uHJ1d1Lnk/Qn25H+96GBJMxPp3tkfYaWfUnJA3/F9NGH0A2mcot
qusZWpZtYuk4DS3cVnVGb2W4McRNhW1OwzsHzDYuTwO/ybhb1GMcA1pUG562W9lp
6X5GruuiGX2hS2euH90JQIO11ZJJrIEHYmMdd0kPAIicmLX2dwf5uYCV+wD+k2ED
42skKqGjtGb4EIEr3rxjcMI5XOabpkjMs0FPjPlbm4dhjMKkZctcvlyENN69iXhG
0JuknHCFytScu/A+CM/zW8rBalBQbXTebbjRkPqGvGOin8nVCIL2QmQ5zr9PSYQu
/uwz2N40VK9Pe+FE22KOQhqLbt2mryfE6PJbjGsPDfepCKnuYhQnAusWLlOYD9Ux
4BTdHm6BQvaIR31xGO/za9dp7LfOR/3x2tPG01inzd3vdWU3cfEawT9qurQ5UdCT
NCGfEd8WJXhed2gSxVy0mLRpQJAORptIreTNRec9bh9uXaNgGTt2dZY5Z7Bj53cf
v7okOh0GTbY1zMe1ry6UefJ9QeV7eaPtqS5hiOp3UAgTqs6eDv1Dii4Puwj7X37C
bQlE
=+UUp
-----END PGP SIGNATURE-----

--gEOF8QdlbrLeBFsj9V6HGYlWeE5bUZN7D--
