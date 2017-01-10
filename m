Received: from eggs.gnu.org ([2001:4830:134:3::10]:48574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cQneM-0002ry-59
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 23:03:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cQneJ-00041W-1v
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 23:03:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cQneI-00041O-S9
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 23:03:02 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 88FF421722
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 04:03:02 +0000 (UTC)
Date: Tue, 10 Jan 2017 06:03:00 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170110060216-mutt-send-email-mst@kernel.org>
References: <1479902569-5548-1-git-send-email-marcel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1479902569-5548-1-git-send-email-marcel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 0/3] hw/pcie: Introduce Generic PCI
 Express Root Port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, laine@redhat.com, drjones@redhat.com, abologna@redhat.com

On Wed, Nov 23, 2016 at 02:02:46PM +0200, Marcel Apfelbaum wrote:
> The Generic Root Port behaves the same as the
> Intel's IOH device with id 3420, without having
> Intel specific attributes.
> 
> The device has two purposes:
>  (1) Can be used on both X86 and ARM machines.
>  (2) It will allow us to tweak the behaviour
>     (e.g add vendor-specific PCI capabilities)
>      - something that obviously cannot be done
>        on a known device.

I don't see any issues but the patches don't apply anymore.
If you still want this in, pls rebase and repost.


> Patch 1/3: Introduce a base class for Root Ports - most of the code
>            is migrated from IOH3420 implementation.
> Patch 2/3: Derives the IOH3420 from the new base class
> Patch 3/3: Introduces the generic Root Port.
> 
> Tested with Linux and Windows guests only on x86 hosts.
> 
> Marcel Apfelbaum (3):
>   hw/pcie: Introduce a base class for PCI Express Root Ports
>   hw/ioh3420: derive from PCI Express Root Port base class
>   hw/pcie: Introduce Generic PCI Express Root Port
> 
>  default-configs/arm-softmmu.mak    |   1 +
>  default-configs/i386-softmmu.mak   |   1 +
>  default-configs/x86_64-softmmu.mak |   1 +
>  hw/pci-bridge/Makefile.objs        |   1 +
>  hw/pci-bridge/ioh3420.c            | 150 ++----------------------
>  hw/pci-bridge/pcie_root_port.c     | 227 +++++++++++++++++++++++++++++++++++++
>  include/hw/pci/pci.h               |   1 +
>  include/hw/pci/pcie_port.h         |  18 +++
>  8 files changed, 257 insertions(+), 143 deletions(-)
>  create mode 100644 hw/pci-bridge/pcie_root_port.c
> 
> -- 
> 2.5.5
