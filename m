Received: from eggs.gnu.org ([2001:4830:134:3::10]:56447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOynM-0004D7-CQ
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 01:09:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOynI-0007le-Qn
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 01:09:40 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOynI-0007kT-IK
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 01:09:36 -0400
Received: by mail-qt0-x241.google.com with SMTP id d3-v6so298513qto.1
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 22:09:36 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1468840039-14576-1-git-send-email-dgilbert@redhat.com>
	<CAFEAcA9fuXSHrFGd8Ox6UKsHzqEsiG9aZW8FGYZ4vjn0ufDOSw@mail.gmail.com>
	<20160718170025.GB6470@work-vm>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d7ce76d8-479b-6876-ce0e-0e9a9f5f0dfb@amsat.org>
Date: Sat, 2 Jun 2018 02:09:25 -0300
MIME-Version: 1.0
In-Reply-To: <20160718170025.GB6470@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="VNMAqoZfEvRZszFvTHBbWTQH1UYnpUAVs"
Subject: Re: [Qemu-devel] [PATCH 0/1] vmstatification of 0323 [for 2.8?]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VNMAqoZfEvRZszFvTHBbWTQH1UYnpUAVs
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d7ce76d8-479b-6876-ce0e-0e9a9f5f0dfb@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 0/1] vmstatification of 0323 [for 2.8?]
References: <1468840039-14576-1-git-send-email-dgilbert@redhat.com>
 <CAFEAcA9fuXSHrFGd8Ox6UKsHzqEsiG9aZW8FGYZ4vjn0ufDOSw@mail.gmail.com>
 <20160718170025.GB6470@work-vm>
In-Reply-To: <20160718170025.GB6470@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/18/2016 02:00 PM, Dr. David Alan Gilbert wrote:
> * Peter Maydell (peter.maydell@linaro.org) wrote:
>> On 18 July 2016 at 12:07, Dr. David Alan Gilbert (git)
>> <dgilbert@redhat.com> wrote:
>>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>>
>>> Hi,
>>>   Chipping away at register_vmstate's I thought I'd tackle one of the=

>>> small devices;  does anyone care about the migration state of this?
>>>
>>>   Note I've bumped the version number on it and haven't got anything
>>> to test with;  Peter does the bump matter to you, and do you have
>>> a test for it?
>>
>> This is only used by the stellaris boards. I don't care about
>> migration compat on those, so version bump is fine.
>> http://people.linaro.org/~peter.maydell/stellaris.tgz is probably
>> a working test case for that board (64MB)

After about 4h reversing this this binary, and reading the SD spec:

    7.2.1 Mode Selection and Initialization (SPI mode)
    The SD Card is powered up in the SD mode. It will enter
    SPI mode if the CS signal is asserted (negative) during
    the reception of the reset command (CMD0). If the card
    recognizes that the SD mode is required it will not
    respond to the command and remain in the SD mode. If SPI
    mode is required, the card will switch to SPI and respond
    with the SPI mode R1 response.
    The only way to return to the SD mode is by entering the
    power cycle. In SPI mode, the SD Card protocol state
    machine in SD mode is not observed. All the SD Card
    commands supported in SPI mode are always available.
    [...]
    If the card indicates an illegal command, the card is
    legacy and does not support CMD8. If the card supports
    CMD8 and can operate on the supplied voltage, the response
    echoes back the supply voltage and the check pattern that
    were set in the command argument.

I realized the binary expect CMD8 to not return, to use the SD card
with Spec v1.x. Which is the very patch Paul Brook attached...
http://lists.nongnu.org/archive/html/qemu-devel/2012-04/msg03790.html

curl
http://lists.nongnu.org/archive/html/qemu-devel/2012-04/txtwo8B9rbn9w.txt=


     case 8:	/* CMD8:   SEND_IF_COND */
+        if (sd->spi) {
+            goto bad_cmd;
+        }
         /* Physical Layer Specification Version 2.00 command */
         switch (sd->state) {
         case sd_idle_state:

>=20
> <snip/paste>
>=20
>> ssi-sd is used by stellaris. rc4030 is only in the mips jazz
>> board, and I don't have a test image for that.
>>
>=20
> Thanks, the graphics version seems to work on that (the runme);
> the sd card demo, isn't as happy:
>=20
> ~/try/arm-softmmu/qemu-system-arm -M lm3s6965evb -serial stdio -kernel =
 ~/arm/stellaris-test/sd_card.bin -drive file=3D~/arm/stellaris-test/sdca=
rd.img,if=3Dsd,format=3Draw
>=20
>=20
> SD Card Example Program
> Type 'help' for help.
>=20
> /> ls
> Open
> Command returned error code FR_NOT_READY

I tried to bisect this trying every stable releases until v0.11.1 (no
need to share the details I went to...). I quit at v0.9.1 when I got:

    WARNING: "gcc-8" looks like gcc 4.x
    QEMU is known to have problems when compiled with gcc 4.x
    It is recommended that you use gcc 3.x to build QEMU
    To use this compiler anyway, configure with --disable-gcc-check

With the previous 3-lines patch applied (which never hit master, while
8120e7144b4 did...) it works:

$ qemu-system-arm -M lm3s6965evb -serial stdio \
  -kernel sd_card.bin -sd sdcard.img

SD Card Example Program
Type 'help' for help.

/> ls
Open
listing

----A 2012/04/25 17:44        12  README.TXT

   1 File(s),        12 bytes total
   0 Dir(s),      61182K bytes free

/> cat README.TXT
Hello World

$ git rev-list --oneline 8120e7144b4007d26531835c7b6bc2b40a736cd2~..
hw/sd/ssi-sd.c
c3abd91309 hw/sd/ssi-sd: use the SDBus API, connect the SDCard to the bus=

8046d44f3c hw/sd/ssi-sd: Reset SD card on controller reset
2ccfd336dc vmstateify ssi-sd
7673bb4cd3 ssi: change ssi_slave_init to be a realize ops
0430891ce1 hw: Clean up includes
8fd06719e7 ssi: Move ssi.h into a separate directory
e3382ef0ea sd.h: Move sd.h to include/hw/sd/
af9e40aa8f hw: Mark devices picking up block backends actively FIXME
4be746345f hw: Convert from BlockDriverState to BlockBackend, mostly
fa1d36df74 block: Eliminate DriveInfo member bdrv, use blk_by_legacy_dinf=
o()
a9c380db3b ssi-sd: fix buffer overrun on invalid state load
1a7d9ee6dd ssi: Convert legacy SSI_SLAVE -> DEVICE casts
4f8a066b5f blockdev: Remove IF_* check for read-only blockdev_init
6790f59da3 sd: pass bool parameter for sd_init
49ab747f66 hw: move target-independent files to subdirectories

At least 15 commits in 6 years to maintain a non working device :|

>=20
> Yep, and I've mailed the MIPS guys about the rc4030.
>=20
>>>   I also intend to look at hw/dma/rc4030, hw/input/tsc2005, hw/input/=
tsc210x and
>>> hw/sd/ssi-sd.c  that all look simple, although again I've got nothing=
 to test
>>> them with.
>>
>> http://people.linaro.org/~peter.maydell/n8x0-images.tgz (1.8GB)
>> should work as a test case for at least one of the tsc devices
>> (ignore all the chatter about read-only dma registers on stderr,
>> the image does boot.)
>=20
> Thanks, I'll give that a go when I attack the tsc's.
>=20
> Dave
>=20
>> thanks
>> -- PMM
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
>=20


--VNMAqoZfEvRZszFvTHBbWTQH1UYnpUAVs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlsSJokACgkQ4+MsLN6t
wN7JBRAAnd4KaNXtadGX4zxQoFy3yMytTjp53tH+rn0/86Sx3SgHvXmWZGel5JEm
oTvXV5JOBw+ul2EQLkK+rUoI7OkCK0hN1j1hIJ2zzkjBhCuWicCJP0Vm+y1H1QTZ
fcOevC70nYlJwW/N1w2LLuXoX8qlcQJlG3laZvCJFK36lFaydf8nPkVqKJxTxrwS
SO9nWdxsQyAT9QShBynpG48xZG4BvT+xflYR/lse0aaI+z5ZM1mcDWC/6Po2VFh7
3/ZA4jUeJtPHnTlS095QIJhb+h7q2YGCy/ffZZiXwC2gjBfnQpkjMGhMmoBbEUPc
d5yBDvl0HFTFXlFCa2yN+cZOkv1BQk3CHb5HpGSksWkTit0nrrFJ4Yuy+s1ejgeJ
GLfY5+tqdsk7O9x0FS07P0VRyq+ThC71qv339k0fxJjS3iQC9T13+cIA4ZtvLANm
tQ5gqLFqO/PQrEVe8UygLGWThr2+PRUWLkJcxxkQ6OqoGzN5JBYAccALnSbjNM1t
zGub7Tdp2cinebry/UKd3iI7NFLnaLyUpXzvOC8rrKjSWBkCaVKTFh63w1hOJvIi
2AgTQ3+H0BnvxW0AmRYp4Qqquq3O6VKpZ1NVW6gr4X1EYR/4Pq0IA4MEPDN7tId5
hfw81nMBY22zlhuB99XymHDEcFfodb3dPHbLimWEkANveAvHX+Y=
=tu/7
-----END PGP SIGNATURE-----

--VNMAqoZfEvRZszFvTHBbWTQH1UYnpUAVs--
