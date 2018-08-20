Received: from eggs.gnu.org ([2001:4830:134:3::10]:48426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1fraFT-0007K0-Vs
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 22:48:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1fra7I-0006Ry-6u
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 22:40:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:44083)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jing2.liu@linux.intel.com>)
	id 1fra7H-0006R1-F6
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 22:40:27 -0400
References: <1534411696-6454-1-git-send-email-jing2.liu@linux.intel.com>
	<1d4e89eb-073e-2883-aa65-6f379627694f@gmail.com>
From: "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <f54ef501-d8d9-3d86-c49f-62985cf4165e@linux.intel.com>
Date: Mon, 20 Aug 2018 10:39:59 +0800
MIME-Version: 1.0
In-Reply-To: <1d4e89eb-073e-2883-aa65-6f379627694f@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Cc: anthony.xu@intel.com, mst@redhat.com, lersek@redhat.com, pbonzini@redhat.com

Hi Marcel,

On 8/18/2018 12:18 AM, Marcel Apfelbaum wrote:
> Hi Jing,
> 
> On 08/16/2018 12:28 PM, Jing Liu wrote:
>> This patch serial is about PCI resource reserve capability.
>>
>> First patch refactors the resource reserve fields in GenPCIERoorPort
>> structure out to another new structure, called "PCIResReserve". Modify
>> the parameter list of pci_bridge_qemu_reserve_cap_init().
>>
>> Then we add the teardown function called 
>> pci_bridge_qemu_reserve_cap_uninit().
>>
>> Last we enable the resource reserve capability for legacy PCI bridge
>> so that firmware can reserve additional resources for the bridge.
> 
> The series looks good to me, please see some minor comments
> in the patches.
> 
Thanks very much for your reviewing. I will improve the
codes and send new version then.

> Can you please point me to the SeaBIOS / OVMF counterpart?
> 
Sure. SeaBIOS patch serial is here:
https://patchew.org/Seabios/1534386737-8131-1-git-send-email-jing2.liu@linux.intel.com/

Thanks,
Jing

> Thanks,
> Marcel
> 
> 
>> Change Log:
>> v2 -> v1
>> * add refactoring patch
>> * add teardown function
>> * some other fixes
>>
>> Jing Liu (3):
>>    hw/pci: factor PCI reserve resources to a separate structure
>>    hw/pci: add teardown function for PCI resource reserve capability
>>    hw/pci: add PCI resource reserve capability to legacy PCI bridge
>>
>>   hw/pci-bridge/gen_pcie_root_port.c | 32 +++++++++++++-------------
>>   hw/pci-bridge/pci_bridge_dev.c     | 25 ++++++++++++++++++++
>>   hw/pci/pci_bridge.c                | 47 
>> +++++++++++++++++++++-----------------
>>   include/hw/pci/pci_bridge.h        | 18 +++++++++++----
>>   4 files changed, 80 insertions(+), 42 deletions(-)
>>
> 
