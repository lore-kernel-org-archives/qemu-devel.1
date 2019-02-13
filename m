Received: from eggs.gnu.org ([209.51.188.92]:60599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gtt5X-0001bu-HZ
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 06:52:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gtt5W-0000Sy-LU
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 06:52:27 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:65210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gtt5W-0000Nt-Ek
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 06:52:26 -0500
Date: Wed, 13 Feb 2019 12:52:15 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <4d82a8a2-8737-8e53-9959-cc31cd79f3e7@ilande.co.uk>
Message-ID: <alpine.BSF.2.21.9999.1902131242590.34637@zero.eik.bme.hu>
References: <20190211040434.1C98674569F@zero.eik.bme.hu>
	<8962bd1d-267d-2edf-b5ce-9b67896a2b2e@redhat.com>
	<alpine.BSF.2.21.9999.1902122354210.68636@zero.eik.bme.hu>
	<4d82a8a2-8737-8e53-9959-cc31cd79f3e7@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH] hw/display: Add basic ATI VGA emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

Hello,

On Wed, 13 Feb 2019, Mark Cave-Ayland wrote:
> On 12/02/2019 23:59, BALATON Zoltan wrote:
> This looks interesting, however I never received the original via the mailing list.
> Did it get held somewhere because its size?

It appears in the list archives:
http://lists.nongnu.org/archive/html/qemu-devel/2019-02/msg02471.html
so I think it reached the list. If it's held for you it may be your 
systems.

> Also it's probably worth pushing it to a suitable git repo since then it's easier for
> people to pull and update as required.

Yes, I though the qemu git repo would be suitable for that that's why I've 
submitted it. For testing it's just a single patch so git am should not be 
too difficult.

For mac99 you can try with -vga none -device ati-vga and it gives you 
console under Linux but not much more at the moment. MacOS can't find it 
presumably because the info and driver it needs is missing from the device 
tree. I think these should be set up by the card ROM but even if I add a 
Mac card ROM with -device ati-vga,romfile=rom_from_an_ati_card.bin 
OpenBIOS does not seem to be able to run FCode roms so currently could not 
test with MacOS.

Regards,
BALATON Zoltan
