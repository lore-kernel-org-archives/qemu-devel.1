Received: from eggs.gnu.org ([2001:4830:134:3::10]:51720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fNtfH-0000od-HO
	for qemu-devel@nongnu.org; Wed, 30 May 2018 01:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fNtfG-0007LE-Jd
	for qemu-devel@nongnu.org; Wed, 30 May 2018 01:28:51 -0400
References: <eeaf7d84-71d0-b720-89c4-ca3c9536a68e@amsat.org>
	<b19a920d-8c47-d018-6a2a-f2c43facd88e@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f7ae3b8e-c5ca-53b0-aef8-a4abdf58a29d@redhat.com>
Date: Wed, 30 May 2018 07:28:33 +0200
MIME-Version: 1.0
In-Reply-To: <b19a920d-8c47-d018-6a2a-f2c43facd88e@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="1wdwv3YOXX1C7e8dJ4Ra51hQuTLq9vJ1E"
Subject: Re: [Qemu-devel] cmdline: How to connect a SD card to a specific SD
 controller?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Alistair Francis <alistair@alistair23.me>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1wdwv3YOXX1C7e8dJ4Ra51hQuTLq9vJ1E
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Message-ID: <f7ae3b8e-c5ca-53b0-aef8-a4abdf58a29d@redhat.com>
Subject: Re: cmdline: How to connect a SD card to a specific SD controller?
References: <eeaf7d84-71d0-b720-89c4-ca3c9536a68e@amsat.org>
 <b19a920d-8c47-d018-6a2a-f2c43facd88e@amsat.org>
In-Reply-To: <b19a920d-8c47-d018-6a2a-f2c43facd88e@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30.05.2018 01:08, Philippe Mathieu-Daud=C3=A9 wrote:
> On 05/28/2018 01:30 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi,
>>
>> I'd like to connect a specific SD card to a specific SDHCI from comman=
d
>> line, and I'm getting a bit lost with command line options.
>>
>> I'm using an updated version of this patch, but this is not relevant t=
o
>> this thread:
>> http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg01914.html
>>
>> In the following example, I'd like to connect an UHS-I enabled SD card=

>> to the first SHDCI of the Exynos4210 board (Nuri).
>>
>> I tried:
>>
>> $ ./arm-softmmu/qemu-system-arm -M nuri \
>>   -device sd-card,id=3Dsd0,uhs=3D1 \
>>   -drive if=3Dsd,id=3Dsd0,driver=3Dnull-co,size=3D4G \
>>   -monitor stdio -S
>=20
> Peter suggested on IRC to use:
>=20
>   -drive if=3Dnone,id=3Dmydrive,... -device sd-card,...,drive=3Dmydrive=

>=20
> which indeed works enough for my tests:
>=20
>   $ ./arm-softmmu/qemu-system-arm -M nuri \
>     -drive if=3Dnone,id=3Dmydrive,driver=3Dnull-co,size=3D4G \
>     -device sd-card,id=3Dsd0,uhs=3D1,drive=3Dmydrive \
>     -monitor stdio -S
>=20
> The same issues are still here but don't bother:
>=20
> (qemu) info qtree
> bus: main-system-bus
>   type System
>   dev: generic-sdhci, id ""
>     gpio-out "sysbus-irq" 1
>     sd-spec-version =3D 2 (0x2)
>     uhs =3D 0 (0x0)
>     capareg =3D 99090560 (0x5e80080)
>     maxcurr =3D 0 (0x0)
>     pending-insert-quirk =3D false
>     dma =3D ""
>     mmio 0000000012540000/0000000000000100
>     bus: sd-bus
>       type sdhci-bus
>       dev: sd-card, id "sd0"
>         drive =3D "mydrive"
>         spi =3D false
>         uhs =3D 1 (0x1)
>       dev: sd-card, id ""
>         drive =3D ""
>         spi =3D false
>         uhs =3D 0 (0x0)
>=20
>         ^---- 2 cards

Looks like the nuri board always creates an sd-card by default? You
could try to change exynos4210_init() to only create it if
drive_get(IF_SD, ...) is not returning NULL - then it should be possible
to disable it with "-nodefaults".

 Thomas


--1wdwv3YOXX1C7e8dJ4Ra51hQuTLq9vJ1E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJbDjaGAAoJEC7Z13T+cC21ZbkP/RNgVNqds/ReasQp5sh0d9iy
T0R4DPk/gBXyfi4ftv1tXe9sQCp5L9cev9VyJuoYCo8B9RaAI1SjO5VfURKlI2i1
jCBFpBZvGlw9Fi3swfHbSmv/wqeG3wlN8tDhLVThSf7IksUB8mpuQhub5iNNyclB
nEPr1CyLyJG/UiwkbV4pGlixPE1PZEjWneT11tlY6mFWPekoyrKDMkIX7NY7YQ8x
r9OTykZP2UthRUCT02tSTq0DlnWdS4aw8M2D82XPPt1hRjJ53Wrn2piY+nifWQIy
xwS6SebQopQ/hafsRCyk6XC0wVM9PGNLp1QB2igYmS/mf5XcJicVEOdoICaDsm6e
kmlUZw8cibsrtFLMkGF2yw0YANe2lV1sWp5oeKJsRcKZ1L0D1/MM7j7LzUViAgsa
KKlKEudRa+HiTkjDBppCh0WIU1bgwupK74CdCnWUG5cPMLzVSs+BCpdMbQM3QDRE
ALwQzHHUWQMf5m4DbKRfqrBw81z4uUHYRS7BaNPxsBsJV69aSvY+IcNOWNXIWfGG
jZTL8Vs0xgAe5vxoyanBjTwkZQt4cxRlfwtARaL/5nLpL2EV/o+mqcPy0r4TzQk3
eLEkEm0HL05LZgje3RlpwxEDXpNzncxHygrs6zTHl0nIwUnjToMYVsCwOAVGzi/q
e/E63pQRWj4R8ebteA+9
=e+I6
-----END PGP SIGNATURE-----

--1wdwv3YOXX1C7e8dJ4Ra51hQuTLq9vJ1E--
