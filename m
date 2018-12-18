Received: from eggs.gnu.org ([2001:4830:134:3::10]:57715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gZKq7-00046D-CY
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 14:15:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gZKh9-0003F7-Un
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 14:06:23 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:27846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gZKh8-0002Io-1a
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 14:06:19 -0500
Date: Tue, 18 Dec 2018 20:05:59 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20181218132722.GF22638@redhat.com>
Message-ID: <alpine.BSF.2.21.9999.1812182000520.1576@zero.eik.bme.hu>
References: <alpine.BSF.2.21.1803202324320.13789@zero.eik.bme.hu>
	<20180321140654.7h3nkkdlztu6mtrq@sirius.home.kraxel.org>
	<alpine.BSF.2.21.1803211803590.78606@zero.eik.bme.hu>
	<alpine.BSF.2.21.9999.1812171549220.8888@zero.eik.bme.hu>
	<f3d7a0ed-785d-4176-147d-26a4d58d1a36@ilande.co.uk>
	<20181218111603.GE22638@redhat.com>
	<alpine.BSF.2.21.9999.1812181242560.99784@zero.eik.bme.hu>
	<20181218132722.GF22638@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Monitor and serial output window broken with SDL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On Tue, 18 Dec 2018, Daniel P. Berrang=C3=A9 wrote:
> I don't see any difference depending on whether I use Ctrl-Alt-3 before
> or after the yellow screen - both work as expected. The fact that you
> see a difference though does suggest that there's something odd being
> done in the ppc emulation that is in turn doing something bad to SDLs
> rendering with your graphics setup. I don't know what it could be thoug=
h.

OK thanks for checking this, at least it seems this is something that not=
=20
reproduces elsewhere so it's probably something specific to my setup. I=20
may try to debug this further when I'll have time.

Regards,
BALATON Zoltan
