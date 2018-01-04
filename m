Received: from eggs.gnu.org ([2001:4830:134:3::10]:57366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eXBJx-00083g-LT
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 14:36:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eXBJt-0002Cl-LH
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 14:36:57 -0500
Received: from mail-io0-x22b.google.com ([2607:f8b0:4001:c06::22b]:33996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1eXBJt-0002Ca-GB
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 14:36:53 -0500
Received: by mail-io0-x22b.google.com with SMTP id q188so3374673iod.1
	for <qemu-devel@nongnu.org>; Thu, 04 Jan 2018 11:36:53 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <CAAdtpL69Nw_a0x=mg53N7E8bXJGfNgMQUfqA1GGxLEOvVBuinw@mail.gmail.com>
Date: Thu, 4 Jan 2018 14:36:51 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <ED3931A7-D021-4952-A487-D25B80E2B038@gmail.com>
References: <mailman.15762.1515014732.27992.qemu-devel@nongnu.org>
	<34798C74-612D-4484-9781-A3CFB261C383@gmail.com>
	<CAAdtpL69Nw_a0x=mg53N7E8bXJGfNgMQUfqA1GGxLEOvVBuinw@mail.gmail.com>
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
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Kevin O'Connor <kevin@koconnor.net>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, m.olbrich@pengutronix.de, Andrzej Zaborowski <balrogg@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paul Brook <paul@codesourcery.com>, Marc-Andr? Lureau <marcandre.lureau@redhat.com>


> On Jan 4, 2018, at 12:57 PM, Philippe Mathieu-Daud=C3=A9 =
<f4bug@amsat.org> wrote:
>=20
> Hi John,
>=20
>> Is there a way to make this SD card reader work with Mac OS X or =
Windows guests?
>=20
> As noted by Kevin here:
> http://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg02765.html
>=20
> If your machine has a PCI bus you can plug it there:
> http://pcidb.net/view/1b36/0007
>=20
> Linux kmod 'sdhci-pci' recognize it well.
>=20
> I don't know if OSX/Win guests have a such driver.
>=20
> If no, we could model the PCI7612:
> https://pci-ids.ucw.cz/read/PC/104c/803b
>=20
> Regards,
>=20
> Phil.

Thanks for the reply. Using this command "-device sdhci-pci -device =
sd-card,drive=3Ddrive0 -drive id=3Ddrive0,if=3Dnone,file=3D<image file>" =
I was able to make the sd card reader work in Windows XP. I tried =
ejecting the image file and trying to mount another image file. This did
not work. The device was not recognized in Mac OS 9 or Mac OS X guests.=
