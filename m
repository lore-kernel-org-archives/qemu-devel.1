Received: from eggs.gnu.org ([2001:4830:134:3::10]:48846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eX9m6-0005Xw-Ty
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:57:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eX9m6-00071o-22
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:57:55 -0500
Received: from mail-io0-x232.google.com ([2607:f8b0:4001:c06::232]:42984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eX9m5-00070m-QT
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:57:53 -0500
Received: by mail-io0-x232.google.com with SMTP id x67so3062518ioi.9
	for <qemu-devel@nongnu.org>; Thu, 04 Jan 2018 09:57:53 -0800 (PST)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <34798C74-612D-4484-9781-A3CFB261C383@gmail.com>
References: <mailman.15762.1515014732.27992.qemu-devel@nongnu.org>
	<34798C74-612D-4484-9781-A3CFB261C383@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 4 Jan 2018 14:57:52 -0300
Message-ID: <CAAdtpL69Nw_a0x=mg53N7E8bXJGfNgMQUfqA1GGxLEOvVBuinw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 00/25] SDCard: housekeeping, improve SPI,
 introduce new Specs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>, Kevin O'Connor <kevin@koconnor.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, m.olbrich@pengutronix.de, Andrzej Zaborowski <balrogg@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paul Brook <paul@codesourcery.com>, Marc-Andr? Lureau <marcandre.lureau@redhat.com>

Hi John,

> Is there a way to make this SD card reader work with Mac OS X or Windows guests?

As noted by Kevin here:
http://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg02765.html

If your machine has a PCI bus you can plug it there:
http://pcidb.net/view/1b36/0007

Linux kmod 'sdhci-pci' recognize it well.

I don't know if OSX/Win guests have a such driver.

If no, we could model the PCI7612:
https://pci-ids.ucw.cz/read/PC/104c/803b

Regards,

Phil.
