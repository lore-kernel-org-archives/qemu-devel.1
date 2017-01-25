Received: from eggs.gnu.org ([2001:4830:134:3::10]:42425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cWT2Z-00010J-Mv
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 14:15:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cWT2U-00030j-HR
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 14:15:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cWT2U-00030Z-B9
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 14:15:26 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 593B23D952
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 19:15:26 +0000 (UTC)
Date: Wed, 25 Jan 2017 21:15:25 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170125211506-mutt-send-email-mst@kernel.org>
References: <1485371038-737-1-git-send-email-marcel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1485371038-737-1-git-send-email-marcel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V4 0/3] hw/pcie: Introduce Generic PCI
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
Cc: qemu-devel@nongnu.org, abologna@redhat.com

On Wed, Jan 25, 2017 at 09:03:55PM +0200, Marcel Apfelbaum wrote:
> v3 -> v4:
>   - Rebased on master.


No need for this. Pls check that my pci branch is ok.


> v2 -> v3:
>  - Keep only the root port base class code in pcie_root_port.c (Michael)
>  - Use msix for the generic root port implementation (Michael and Gerd)
>    - The task required some refactoring like having some common
>      init/uninit interrupts functions to be implemented by both
>      generic and Intel Root Ports.
> 
> v1 -> v2:
>  - Rebased on master.
> 
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
> 
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
>  hw/pci-bridge/gen_pcie_root_port.c |  88 +++++++++++++++++++
>  hw/pci-bridge/ioh3420.c            | 121 ++++----------------------
>  hw/pci-bridge/pcie_root_port.c     | 171 +++++++++++++++++++++++++++++++++++++
>  include/hw/pci/pci.h               |   1 +
>  include/hw/pci/pcie_port.h         |  19 +++++
>  9 files changed, 298 insertions(+), 106 deletions(-)
>  create mode 100644 hw/pci-bridge/gen_pcie_root_port.c
>  create mode 100644 hw/pci-bridge/pcie_root_port.c
> 
> -- 
> 2.5.5
