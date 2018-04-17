Received: from eggs.gnu.org ([2001:4830:134:3::10]:40247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=63880a4e9=anthony.perard@citrix.com>)
	id 1f8ROK-0006KA-PB
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:15:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=63880a4e9=anthony.perard@citrix.com>)
	id 1f8ROE-0007lA-Ux
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:15:28 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:11272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=63880a4e9=anthony.perard@citrix.com>)
	id 1f8ROE-0007jM-9P
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:15:22 -0400
Date: Tue, 17 Apr 2018 15:15:18 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180417141518.GM2208@perard>
References: <1523049683-11782-1-git-send-email-igor.druzhinin@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1523049683-11782-1-git-send-email-igor.druzhinin@citrix.com>
Subject: Re: [Qemu-devel] [PATCH] xen/pt: use address_space_memory object
 for memory region hooks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Druzhinin <igor.druzhinin@citrix.com>
Cc: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, sstabellini@kernel.org, ross.lagerwall@citrix.com

On Fri, Apr 06, 2018 at 10:21:23PM +0100, Igor Druzhinin wrote:
> Commit 99605175c (xen-pt: Fix PCI devices re-attach failed) introduced
> a subtle bug. As soon as the guest switches off Bus Mastering on the
> device it immediately causes all the BARs be unmapped due to the DMA
> address space of the device being changed. This is undesired behavior
> because the guest may try to communicate with the device after that
> which triggers the following errors in the logs:
> 
> [00:05.0] xen_pt_bar_read: Error: Should not read BAR through QEMU. @0x0000000000000200
> [00:05.0] xen_pt_bar_write: Error: Should not write BAR through QEMU. @0x0000000000000200
> 
> The issue that the original patch tried to workaround (uneven number of
> region_add/del calls on device attach/detach) was fixed in later QEMU
> versions.

Do you know when the issue was fixed?

-- 
Anthony PERARD
