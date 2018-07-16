Received: from eggs.gnu.org ([2001:4830:134:3::10]:34470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ff4A3-0003VA-PQ
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:07:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ff4A2-0000Bt-Kz
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:07:35 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:34993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ff4A2-0000Bh-Du
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:07:34 -0400
Received: by mail-oi0-x243.google.com with SMTP id i12-v6so75023088oik.2
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 07:07:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e893ae38-9294-4b54-e950-6632b6b73532@roeck-us.net>
References: <1531692369-1511-1-git-send-email-linux@roeck-us.net>
	<CAFEAcA9W88G8rd4iMq7qsNd2C2fRiYJ32dVooZLyzY10__5piw@mail.gmail.com>
	<e893ae38-9294-4b54-e950-6632b6b73532@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jul 2018 15:07:13 +0100
Message-ID: <CAFEAcA_Vd46APz_czOP+OfB1nkGvGjuf=EPbB57TkkXKWkNxwQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH] hw: arm: Add basic support for cprman
 (clock subsystem)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guenter Roeck <linux@roeck-us.net>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Pekka Enberg <penberg@iki.fi>

On 16 July 2018 at 14:51, Guenter Roeck <linux@roeck-us.net> wrote:
> In this context, I can't get mmc to work with ToT Linux on raspi3.
>
> / # mount /dev/mmcblk0 /mnt
> [   47.099074] sdhost-bcm2835 3f202000.mmc: timeout waiting for hardware
> interrupt.
> [   57.339803] sdhost-bcm2835 3f202000.mmc: timeout waiting for hardware
> interrupt.
> [   57.390449] mmc0: Problem switching card into high-speed mode!
> [   67.581559] sdhost-bcm2835 3f202000.mmc: timeout waiting for hardware
> interrupt.
> [   67.587832] print_req_error: I/O error, dev mmcblk0, sector 2
> [   67.588908] Buffer I/O error on dev mmcblk0, logical block 1, lost sync
> page write
> [   67.610307] EXT4-fs (mmcblk0): I/O error while writing superblock
> [   67.620842] EXT4-fs (mmcblk0): mount failed
> [   77.819114] sdhost-bcm2835 3f202000.mmc: timeout waiting for hardware
> interrupt.
> [   88.058917] sdhost-bcm2835 3f202000.mmc: timeout waiting for hardware
> interrupt.
> [   98.298937] sdhost-bcm2835 3f202000.mmc: timeout waiting for hardware
> interrupt.
> [   98.303554] print_req_error: I/O error, dev mmcblk0, sector 2
> [   98.306044] Buffer I/O error on dev mmcblk0, logical block 1, lost sync
> page write
>
> Any idea what the problem might be ?

Same thing again -- no hardware documentation for that sd controller.
We took our best guess about what the behaviour is supposed to be
for raising hardware interrupts in commit f3d9fe8f959643 earlier
this year, but that was (as the commit message notes) pure guesswork
based largely on what the Linux driver was doing. Somebody would have
to look at what exactly this version of the kernel is expecting the
hardware to do and try to reverse-engineer what the model needs to do
that it isn't currently...

thanks
-- PMM
