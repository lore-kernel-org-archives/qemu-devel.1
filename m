Received: from eggs.gnu.org ([2001:4830:134:3::10]:56940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fda4V-0006jY-JP
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:47:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fda4U-0006CK-Ro
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:47:43 -0400
Date: Thu, 12 Jul 2018 13:47:33 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180712114733.GE4541@localhost.localdomain>
References: <20180622112237.2131-1-gersner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622112237.2131-1-gersner@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] nvme: PCI/e configuration from
 specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shimi Gersner <gersner@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Keith Busch <keith.busch@intel.com>, Max Reitz <mreitz@redhat.com>, David Sariel <davidsa@openu.ac.il>

Am 22.06.2018 um 13:22 hat Shimi Gersner geschrieben:
> PCI/e configuration currently does not meets specifications.
> 
> Patch includes various configuration changes to support specifications
> - BAR2 to return zero when read and CMD.IOSE is not set.
> - Expose NVME configuration through IO space (Optional).
> - PCI Power Management v1.2.
> - PCIe Function Level Reset.
> - Disable QEMUs default use of PCIe Link Status (DLLLA).
> - PCIe missing AOC compliance flag.
> - Mask PCIe End-to-End TLP as RO (Unspecified by specification).
> 
> Change-Id: I9057f56266db16b013fa194730c998d4779cede3

What is the meaning of this Change-Id tag?

> Signed-off-by: Shimi Gersner <gersner@gmail.com>

Keith, can you have a look at this series?

Kevin
