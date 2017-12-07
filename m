Received: from eggs.gnu.org ([2001:4830:134:3::10]:43944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN3h8-0002tC-Jk
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:27:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN3h5-0007mL-Ds
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:27:02 -0500
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:34058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1eN3h5-0007m9-7D
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:26:59 -0500
Received: by mail-pg0-x235.google.com with SMTP id j4so5363499pgp.1
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 13:26:59 -0800 (PST)
Received: from [192.168.27.3] ([47.184.168.85])
	by smtp.gmail.com with ESMTPSA id
	w184sm8922158pgb.36.2017.12.07.13.26.55 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 07 Dec 2017 13:26:56 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Reply-To: minyard@acm.org
From: Corey Minyard <minyard@acm.org>
Message-ID: <8346e247-3512-e0c9-a5aa-5b3475f36d39@acm.org>
Date: Thu, 7 Dec 2017 15:26:54 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: [Qemu-devel] IPMI and I2C changes coming up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

I've been carrying around a lot of changes for IPMI and I2C for a while,
and I'd like to get at least some of these into mainstream qemu in the
release after the one about to release.

For the SMBus changes, I've noticed that nobody is a maintainer for
the I2C code.  I could take that job.  I'd be especially happy to do that
if it came with an easier way to get patches into qemu.

I use a lot of this for my testing, so I don't know if anyone will use
much of this

Anyway, I'm going to split this up into sets to make things easier, so
you can ignore what you don't care about.  These are:

Small IPMI (and other) fixes

These are various small IPMI fixes.  It would be really nice to get at
least some of these into the upcoming release.  Most of these have
been submitted a few times, but I haven't been able to get someone
to pick them up.


Add PCI IPMI interfaces

I had to do some testing, so I went ahead and did this.  Most of the
changes are re-arranging and splitting up code to separate out the
KCS/BT code from the ISA-specific code.

There are also some migration fixes here.


pm_smbus fixes and and IPMI SMBus device

the pm_smbus code has a few issues, and it's missing a lot of the
device capabilities required by IPMI.  This has been submitted
before, but it has some new things, like vmstate handling for the
smbus devices.


I also have a few things that are probably not ready for mainstream,
but people may be interested.  They are in my git tree:

Support for an SMBus alert device.  Part of this adds an abstract
interrupt device, which lets you advertise interrupts in a way that
the user doesn't have to know anything about the interrupt.  So
A device (like an SMBus alert device) could use an ISA interrupt,
or a PCI interrupt, or a GPIO line.  I'm not sure about that the
interrupt device, but without it you would have to create a separate
SMBus alert device for every type of interrupt that used it.

A PCA9540 bus bridge and PCI9541 multi-master bus controller.
I needed to do some testing with these.  It requires some creative
changes to the I2C code and the qdev bus code.  But if anyone
wants a bus bridge, it's available.

Sorry for the long email.

Thanks,

-corey
