Received: from eggs.gnu.org ([208.118.235.92]:41381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gezwW-0007C9-V9
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 05:09:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gezwU-0006yW-Qk
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 05:09:36 -0500
Date: Thu, 3 Jan 2019 10:09:23 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190103100923.GC7733@stefanha-x1.localdomain>
References: <20181223025939.15775-1-npes87184@gmail.com>
	<20181223025939.15775-2-npes87184@gmail.com>
	<20190102114919.GJ24009@stefanha-x1.localdomain>
	<CAPTqjH1K3RYH1A2Q8Fhkh5x6hOE5CU9qTqRtjFC8WLk3UBNFOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
Content-Disposition: inline
In-Reply-To: <CAPTqjH1K3RYH1A2Q8Fhkh5x6hOE5CU9qTqRtjFC8WLk3UBNFOA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] dmg: fix binary search
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?5p6X6IKy6L6w?= <npes87184@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2019 at 08:20:54PM +0800, =E6=9E=97=E8=82=B2=E8=BE=B0 wrote:
> This series is focus on fixing bug #1809304 (see:
> https://bugs.launchpad.net/qemu/+bug/1809304).
> There is an example dmg file in #1809304 which will trigger this bug.

Thanks.  It would be great to include a tiny dmg file in
tests/qemu-iotests/sample_images/ and add a test case for it.

The file should be small (kilobytes, not megabytes) and must be
redistributable (no proprietary content or even GPL software, which
requires distributing source code).

Do you have time to do that?

> About your case, I think we can simply check whether chunk3 is zero before
> we decrease it.
> if s->sectors[chunk3] > sector_num and chunk3 is zero (i.e. s->sectors[0]=
 >
> sector_num), it means we cannot find the table contains sector_num.
> We can return s->n_chunks (error) directly.
>=20
> What do you think?

Sounds good.  We have to assume that the file contents are invalid and
handle all cases.

I'll review the next revision of your patch.  Thanks!

Stefan

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcLd9TAAoJEJykq7OBq3PIcucH/AjgEFRUj35gmDhLZuj5qMl8
pBYx+Hin9DW/VfBach7c7s4F4E5BBzROJUBaMEDBhjJCzPh2wpJi/NQwBcOvRU98
bcmgQTMp3t9GZd/DABKrgK84EgEpR5DcE+I4GBtziOXk7hmT2l89BVqk2iWOV+JR
rgHF99RYh37d3wyjKv7x5wLC+9116NQfsKSrvmJaZsgRWJhZnpFKb83uySlAWDIO
LG8OLKtrS/Cxh5SoMfll87N8AOZ+j/b8+4VchwNlaLeDoDu8Y59KsBzGJt05aIst
bJew9qF27hGjVb6ywWDwQ0XU/2r5gf8X4QeKjsRvguap/w5XN+z9HXIJHYbUWpc=
=LdzW
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--
