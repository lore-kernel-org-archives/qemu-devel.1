Received: from eggs.gnu.org ([2001:4830:134:3::10]:36521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPqqY-00015M-Gl
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 10:24:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPqqX-0001FR-DI
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 10:24:50 -0500
Date: Thu, 22 Nov 2018 16:24:40 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181122152440.GE31879@linux.fritz.box>
References: <20181121181013.4983-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121181013.4983-1-logang@deltatee.com>
Subject: Re: [Qemu-devel] [PATCH] hw/block/nvme: fix bug with PCI IRQ pins
 on teardown
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: qemu-block@nongnu.org, Keith Busch <keith.busch@intel.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stephen Bates <stephen@eideticom.com>

Am 21.11.2018 um 19:10 hat Logan Gunthorpe geschrieben:
> When the submission and completion queues are being torn down
> the IRQ will be asserted for the completion queue when the
> submsission queue is deleted. Then when the completion queue
> is deleted it stays asserted. Thus, on systems that do
> not use MSI, no further interrupts can be triggered on the host.
> 
> Linux sees this as a long delay when unbinding the nvme device.
> Eventually the interrupt timeout occurs and it continues.
> 
> To fix this we ensure we deassert the IRQ for a CQ when it is
> deleted.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Thanks, applied to the block branch.

Kevin
