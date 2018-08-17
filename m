Received: from eggs.gnu.org ([2001:4830:134:3::10]:43265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fqhRz-00050I-2s
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:18:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fqhRu-0001PV-IJ
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:18:10 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:51302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fqhRu-0001Nq-9m
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:18:06 -0400
Received: by mail-wm0-x242.google.com with SMTP id y2-v6so8100933wma.1
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 09:18:06 -0700 (PDT)
References: <1534411696-6454-1-git-send-email-jing2.liu@linux.intel.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <1d4e89eb-073e-2883-aa65-6f379627694f@gmail.com>
Date: Fri, 17 Aug 2018 19:18:03 +0300
MIME-Version: 1.0
In-Reply-To: <1534411696-6454-1-git-send-email-jing2.liu@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 0/3] hw/pci: PCI resource reserve
 capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jing Liu <jing2.liu@linux.intel.com>, qemu-devel@nongnu.org
Cc: anthony.xu@intel.com, mst@redhat.com, lersek@redhat.com, pbonzini@redhat.com

Hi Jing,

On 08/16/2018 12:28 PM, Jing Liu wrote:
> This patch serial is about PCI resource reserve capability.
>
> First patch refactors the resource reserve fields in GenPCIERoorPort
> structure out to another new structure, called "PCIResReserve". Modify
> the parameter list of pci_bridge_qemu_reserve_cap_init().
>
> Then we add the teardown function called pci_bridge_qemu_reserve_cap_uninit().
>
> Last we enable the resource reserve capability for legacy PCI bridge
> so that firmware can reserve additional resources for the bridge.

The series looks good to me, please see some minor comments
in the patches.

Can you please point me to the SeaBIOS / OVMF counterpart?

Thanks,
Marcel


> Change Log:
> v2 -> v1
> * add refactoring patch
> * add teardown function
> * some other fixes
>
> Jing Liu (3):
>    hw/pci: factor PCI reserve resources to a separate structure
>    hw/pci: add teardown function for PCI resource reserve capability
>    hw/pci: add PCI resource reserve capability to legacy PCI bridge
>
>   hw/pci-bridge/gen_pcie_root_port.c | 32 +++++++++++++-------------
>   hw/pci-bridge/pci_bridge_dev.c     | 25 ++++++++++++++++++++
>   hw/pci/pci_bridge.c                | 47 +++++++++++++++++++++-----------------
>   include/hw/pci/pci_bridge.h        | 18 +++++++++++----
>   4 files changed, 80 insertions(+), 42 deletions(-)
>
