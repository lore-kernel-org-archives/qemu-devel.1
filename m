Received: from eggs.gnu.org ([2001:4830:134:3::10]:46371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keith.busch@intel.com>) id 1eXA5L-0000PN-OW
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 13:17:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keith.busch@intel.com>) id 1eXA5D-0002JZ-RM
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 13:17:47 -0500
Date: Thu, 4 Jan 2018 11:20:48 -0700
From: Keith Busch <keith.busch@intel.com>
Message-ID: <20180104182048.GA7169@localhost.localdomain>
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
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:nvme" <qemu-block@nongnu.org>

On Mon, Dec 18, 2017 at 02:00:43PM +0900, Hikaru Nishida wrote:
> Pin-based interrupt of NVMe controller did not work properly
> because using an obsolated function pci_irq_pulse().
> To fix this, change to use pci_irq_assert() / pci_irq_deassert()
> instead of pci_irq_pulse().

Looks good. Thanks for the patch, and sorry for the delay.

Reviewed-by: Keith Busch <keith.busch@intel.com>
