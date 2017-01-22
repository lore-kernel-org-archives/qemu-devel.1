Received: from eggs.gnu.org ([2001:4830:134:3::10]:47754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cV8YV-0000PX-4Q
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 22:11:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cV8YR-0004PO-Up
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 22:10:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cV8YR-0004PI-Oy
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 22:10:55 -0500
Date: Sun, 22 Jan 2017 11:10:51 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170122031051.GE13810@pxdev.xzpeter.org>
References: <1484968585.26205.2.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1484968585.26205.2.camel@gmail.com>
Subject: Re: [Qemu-devel] Nested PCI passthrough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: fassl <superfassl@gmail.com>
Cc: qemu-devel@nongnu.org

On Sat, Jan 21, 2017 at 04:16:25AM +0100, fassl wrote:
> Hello,
> 
> i am trying to pass through a graphic card to a guest within a guest.
> So far i can see a text console within the target vm which says
> "radeon: ring 0 test failed", so it times out in radeon_vce_ring_test
> function. I am using qemu 2.8.50 at revision
> 0f6bcf68a99efdc531b209551f2b760b0bdcc554.
> 
> The relevant lowermost host arguments are:
> -machine pc-q35-2.8,accel=kvm,kernel-irqchip=split
> -device intel-iommu,intremap=on,eim=on
> 
> If i dont set the x-vga flag for the passed through device in the
> lowermost host the VM within the VM does not reset(?) the device during
> shutdown and the screen freezes. If i do, the screen goes black and no
> signal is going to the screen anymore and i can restart the target VM
> without the whole machine freezing. (one has to set
> CONFIG_VFIO_PCI_VGA=y in the kernel of the first VM, or call
> pci_register_vga to get this)
> 
> Also with irqchip=split the first vm cannot shutdown gracefully and
> crashes during shutdown.
> 
> I also can see some IRTE vector and trigger mode inconsistencies, can
> they cause this?

This should not be related. Even you don't passthrough devices, they
should be possibly there as well as long as you are running Linux
inside guest (of course, you should have enabled IOMMU_DEBUG).

-- peterx
