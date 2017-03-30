Received: from eggs.gnu.org ([2001:4830:134:3::10]:39778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jhanley@dgtlrift.com>) id 1ctcvm-0007rf-H4
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:28:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jhanley@dgtlrift.com>) id 1ctcvl-0001F8-6O
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:28:14 -0400
Received: from mail-vk0-x22d.google.com ([2607:f8b0:400c:c05::22d]:34235)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jhanley@dgtlrift.com>)
	id 1ctcvl-0001EK-1d
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:28:13 -0400
Received: by mail-vk0-x22d.google.com with SMTP id z204so61081736vkd.1
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 09:28:12 -0700 (PDT)
MIME-Version: 1.0
From: James Hanley <jhanley@dgtlrift.com>
Date: Thu, 30 Mar 2017 12:28:11 -0400
Message-ID: <CAF++6ANmUc8GxjJqZ01ow=VBeEh2q1pXk+NSe71WJy=+bu5T4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] Loading microcode to ROM for new Arm based CPU type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, qemu-discuss@nongnu.org, qemu-devel <qemu-devel@nongnu.org>

I've been trying to develop a Atmel SAM4 series support for CPU support as
an MCU, mimicking implementation layout of the STM support.   Part of the
ATSAM4 die series is ROM microcode used for referencing details such as NMI
located at 0x00800000.   I've loaded our own application at 0x00400000,
which is the reset vector for the chip... when I try to add it via

qemu-system-arm -M ourBoard ... \
-device loader,addr=0x00400000,file=${imageApplication} \
-kernel ${imageApplication} \
-device loader,addr=0x00800000,file=ATSAM4_ROM.img \
...

It loads the imageApplication at the proper address location, mindful that
in order for the to work I needed to specify the kernel option as well for
the same file. For the microcode file ATSAM4_ROM.img, it does not show any
data at that address location (0x00800000) even when I specify a second
-kernel option specifying the ATSAM_ROM.img...  is there something I'm
doing wrong with the command line to make it available?

Thanks in advance,
-Jim
