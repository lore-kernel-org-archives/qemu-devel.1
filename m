Received: from eggs.gnu.org ([2001:4830:134:3::10]:38046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eXBR5-0005yg-4F
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 14:44:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eXBR3-0000sc-6o
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 14:44:19 -0500
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:34111)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eXBR2-0000ru-Qg
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 14:44:17 -0500
Received: by mail-io0-x242.google.com with SMTP id q188so3395142iod.1
	for <qemu-devel@nongnu.org>; Thu, 04 Jan 2018 11:44:16 -0800 (PST)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <ED3931A7-D021-4952-A487-D25B80E2B038@gmail.com>
References: <mailman.15762.1515014732.27992.qemu-devel@nongnu.org>
	<34798C74-612D-4484-9781-A3CFB261C383@gmail.com>
	<CAAdtpL69Nw_a0x=mg53N7E8bXJGfNgMQUfqA1GGxLEOvVBuinw@mail.gmail.com>
	<ED3931A7-D021-4952-A487-D25B80E2B038@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 4 Jan 2018 16:44:15 -0300
Message-ID: <CAAdtpL4e4sfUVoCPJf3Ydot9_O9ET4WZuFD55Snodq02HBKNSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: Programmingkid <programmingkidx@gmail.com>
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Alistair Francis <alistair.francis@xilinx.com>, Kevin O'Connor <kevin@koconnor.net>, Paul Brook <paul@codesourcery.com>, Marc-Andr? Lureau <marcandre.lureau@redhat.com>, Olbrich <m.olbrich@pengutronix.de>

>> As noted by Kevin here:
>> http://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg02765.html
>>
>> If your machine has a PCI bus you can plug it there:
>> http://pcidb.net/view/1b36/0007
>>
>> Linux kmod 'sdhci-pci' recognize it well.
>>
>> I don't know if OSX/Win guests have a such driver.
>>
>> If no, we could model the PCI7612:
>> https://pci-ids.ucw.cz/read/PC/104c/803b
>>
>> Regards,
>>
>> Phil.
>
> Thanks for the reply. Using this command "-device sdhci-pci -device sd-ca=
rd,drive=3Ddrive0 -drive id=3Ddrive0,if=3Dnone,file=3D<image file>" I was a=
ble to make the sd card reader work in Windows XP. I tried ejecting the ima=
ge file and trying to mount another image file. This did
> not work. The device was not recognized in Mac OS 9 or Mac OS X guests.

After spending 2 months in this code, I could expect a such problem,
but I don't have all the images to test all machines matrix.

Are you motivated in writing a simple eject/reinsert qtest? :)
