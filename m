Received: from eggs.gnu.org ([2001:4830:134:3::10]:38430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <superfassl@gmail.com>) id 1cUmAL-0004RY-LX
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 22:16:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <superfassl@gmail.com>) id 1cUmAI-00070X-HM
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 22:16:33 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <superfassl@gmail.com>)
	id 1cUmAI-0006yt-94
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 22:16:30 -0500
Received: by mail-wm0-x241.google.com with SMTP id r144so11023848wme.0
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 19:16:28 -0800 (PST)
Received: from fassl-pc (194-96-125-31.adsl.highway.telekom.at.
	[194.96.125.31]) by smtp.gmail.com with ESMTPSA id
	c202sm8822984wmd.10.2017.01.20.19.16.26 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 20 Jan 2017 19:16:26 -0800 (PST)
Message-ID: <1484968585.26205.2.camel@gmail.com>
From: fassl <superfassl@gmail.com>
Date: Sat, 21 Jan 2017 04:16:25 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Nested PCI passthrough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello,

i am trying to pass through a graphic card to a guest within a guest.
So far i can see a text console within the target vm which says
"radeon: ring 0 test failed", so it times out in radeon_vce_ring_test
function. I am using qemu 2.8.50 at revision
0f6bcf68a99efdc531b209551f2b760b0bdcc554.

The relevant lowermost host arguments are:
-machine pc-q35-2.8,accel=kvm,kernel-irqchip=split
-device intel-iommu,intremap=on,eim=on

If i dont set the x-vga flag for the passed through device in the
lowermost host the VM within the VM does not reset(?) the device during
shutdown and the screen freezes. If i do, the screen goes black and no
signal is going to the screen anymore and i can restart the target VM
without the whole machine freezing. (one has to set
CONFIG_VFIO_PCI_VGA=y in the kernel of the first VM, or call
pci_register_vga to get this)

Also with irqchip=split the first vm cannot shutdown gracefully and
crashes during shutdown.

I also can see some IRTE vector and trigger mode inconsistencies, can
they cause this?

Or are there some quirks to be done to get this going?

If anybody could lead me into the right direction or if there is work
going on in this field i would be more than glad to help testing.

Thank you in advance
