Received: from eggs.gnu.org ([2001:4830:134:3::10]:52076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1fZMBz-0001aH-Tt
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 16:10:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1fZMBw-0001ei-NO
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 16:09:59 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1fZMBw-0001cl-G3
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 16:09:56 -0400
Received: by mail-wm0-f66.google.com with SMTP id p11-v6so5074426wmc.4
	for <qemu-devel@nongnu.org>; Sat, 30 Jun 2018 13:09:56 -0700 (PDT)
Date: Sat, 30 Jun 2018 22:09:52 +0200
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20180630220952.60cd6d26@thl530.multi.box>
In-Reply-To: <CAKbio+kqcmD9vba-67wbyPX2Er7=cUP-vH1+FYrFK4ToZf9hCw@mail.gmail.com>
References: <20180630083357.23489-1-huth@tuxfamily.org>
	<bb109e75-6c00-45b2-bb17-7d09ff3a8112@ilande.co.uk>
	<20180630151444.2f0b30cb@thl530.multi.box>
	<CAFEAcA_wo8t2CTRj4oizRPUbG7fa0MgdACpAnLvR53Pp+piLjQ@mail.gmail.com>
	<20180630153422.03f0146f@thl530.multi.box>
	<CAKbio+kqcmD9vba-67wbyPX2Er7=cUP-vH1+FYrFK4ToZf9hCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 0/4] m68k: Add basic support for the
 NeXTcube machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bryce Lanham <blanham@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Natalia Portillo <claunia@claunia.com>, QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

Am Sat, 30 Jun 2018 12:07:01 -0500
schrieb Bryce Lanham <blanham@gmail.com>:

> Oh hi!
>=20
> Luckily gmail brought this to the top since I don=E2=80=99t pay attention=
 to
> the list. I=E2=80=99m away from my computer at the moment, but I had more
> than this working, including interrupts, Ethernet, and SCSI for sure.
> ( https://i.imgur.com/Py0FO.png) I=E2=80=99d love to dive back into this =
now
> that 68040 support is complete and merged.

 Hi Bryce,

great to hear that you are still around! If you like to take care of
this again, that would be very welcome! So I'll keep my hands off these
patches for now, and let you handle this again :-)

For what it's worth, I've pushed my final state of the patches here:

 https://gitlab.com/huth/qemu/tree/next-cube

I've also managed to get the next-nic.c code compilable again, but as I
mentioned earlier, it's currently not working anymore. Not sure, but I
think there is some wrong overlap in the memory mapping of the 0x110 and
0x150 DMA registers between next-nic.c and next-cube.c in there.

Anyway, feel free to use my patches as a base for your new work, or
simply ignore them if you prefer to start with your old codebase again.
Either way I'm just glad if we finally get an additional 68k machine in
QEMU :-)

 Cheers,
  Thomas
