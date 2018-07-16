Received: from eggs.gnu.org ([2001:4830:134:3::10]:36528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1ffBtT-0002ql-Hh
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 18:23:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1ffBtS-0005nH-KS
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 18:22:59 -0400
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 16 Jul 2018 15:22:50 -0700
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20180716222250.GA20320@roeck-us.net>
References: <1531692369-1511-1-git-send-email-linux@roeck-us.net>
	<CAFEAcA9W88G8rd4iMq7qsNd2C2fRiYJ32dVooZLyzY10__5piw@mail.gmail.com>
	<e893ae38-9294-4b54-e950-6632b6b73532@roeck-us.net>
	<CAFEAcA_Vd46APz_czOP+OfB1nkGvGjuf=EPbB57TkkXKWkNxwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_Vd46APz_czOP+OfB1nkGvGjuf=EPbB57TkkXKWkNxwQ@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Pekka Enberg <penberg@iki.fi>

On Mon, Jul 16, 2018 at 03:07:13PM +0100, Peter Maydell wrote:
> On 16 July 2018 at 14:51, Guenter Roeck <linux@roeck-us.net> wrote:
> > In this context, I can't get mmc to work with ToT Linux on raspi3.
> >
> > / # mount /dev/mmcblk0 /mnt
> > [   47.099074] sdhost-bcm2835 3f202000.mmc: timeout waiting for hardware
> > interrupt.
> > [   57.339803] sdhost-bcm2835 3f202000.mmc: timeout waiting for hardware
> > interrupt.
> > [   57.390449] mmc0: Problem switching card into high-speed mode!
> > [   67.581559] sdhost-bcm2835 3f202000.mmc: timeout waiting for hardware
> > interrupt.
> > [   67.587832] print_req_error: I/O error, dev mmcblk0, sector 2
> > [   67.588908] Buffer I/O error on dev mmcblk0, logical block 1, lost sync
> > page write
> > [   67.610307] EXT4-fs (mmcblk0): I/O error while writing superblock
> > [   67.620842] EXT4-fs (mmcblk0): mount failed
> > [   77.819114] sdhost-bcm2835 3f202000.mmc: timeout waiting for hardware
> > interrupt.
> > [   88.058917] sdhost-bcm2835 3f202000.mmc: timeout waiting for hardware
> > interrupt.
> > [   98.298937] sdhost-bcm2835 3f202000.mmc: timeout waiting for hardware
> > interrupt.
> > [   98.303554] print_req_error: I/O error, dev mmcblk0, sector 2
> > [   98.306044] Buffer I/O error on dev mmcblk0, logical block 1, lost sync
> > page write
> >
> > Any idea what the problem might be ?
> 
> Same thing again -- no hardware documentation for that sd controller.
> We took our best guess about what the behaviour is supposed to be
> for raising hardware interrupts in commit f3d9fe8f959643 earlier
> this year, but that was (as the commit message notes) pure guesswork
> based largely on what the Linux driver was doing. Somebody would have
> to look at what exactly this version of the kernel is expecting the
> hardware to do and try to reverse-engineer what the model needs to do
> that it isn't currently...
> 

This failed for me with all kernel versions I tried, starting with 4.14.y.

I'll send a patch in a minute. It is just as much guesswork as before,
but AFAICS it does work.

Guenter
