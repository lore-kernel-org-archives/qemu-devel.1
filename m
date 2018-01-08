Received: from eggs.gnu.org ([2001:4830:134:3::10]:35603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eYZM6-00018E-Ha
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:28:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eYZM5-0005aP-Pz
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:28:54 -0500
Date: Mon, 8 Jan 2018 16:28:44 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180108152844.GH8052@localhost.localdomain>
References: <1513573243-29022-1-git-send-email-hikarupsp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1513573243-29022-1-git-send-email-hikarupsp@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] hw/block: Fix pin-based interrupt
 behaviour of NVMe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hikaru Nishida <hikarupsp@gmail.com>
Cc: qemu-devel@nongnu.org, Keith Busch <keith.busch@intel.com>, Max Reitz <mreitz@redhat.com>, "open list:nvme" <qemu-block@nongnu.org>

Am 18.12.2017 um 06:00 hat Hikaru Nishida geschrieben:
> Pin-based interrupt of NVMe controller did not work properly
> because using an obsolated function pci_irq_pulse().
> To fix this, change to use pci_irq_assert() / pci_irq_deassert()
> instead of pci_irq_pulse().
> 
> Signed-off-by: Hikaru Nishida <hikarupsp@gmail.com>

Thanks, applied to the block branch.

I had to resolve conflicts with the tracing patches and chose to keep
the trace points from pci_irq_pulse() for pci_irq_assert(), but didn't
add them to pci_irq_deassert(). Please check if this makes sense to you.
Here is the commit after my conflict resolution:

http://repo.or.cz/qemu/kevin.git/commitdiff/44c55a9159f2048a26c07e50dbc21c934917b82c

Kevin
