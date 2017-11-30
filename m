Received: from eggs.gnu.org ([2001:4830:134:3::10]:57124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eKIXJ-0007DH-7d
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 01:41:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eKIXG-0001IP-68
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 01:41:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eKIXG-0001Hu-0L
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 01:41:26 -0500
Date: Thu, 30 Nov 2017 14:41:14 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171130064114.GF22901@xz-mi>
References: <20171129084628.12336-1-david@gibson.dropbear.id.au>
	<20171129084628.12336-3-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171129084628.12336-3-david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [for-2.12 2/7] pci: Move bridge data structures
 from pci_bus.h to pci_bridge.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org

On Wed, Nov 29, 2017 at 07:46:23PM +1100, David Gibson wrote:
> include/hw/pci/pci_bus.h contains several data structures related to PCI
> bridges that aren't needed by most users of pci_bus.h.  We already have
> a pci_bridge.h, so move them there.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
