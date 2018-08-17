Received: from eggs.gnu.org ([2001:4830:134:3::10]:52582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1fqVcd-0002j7-LV
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 23:40:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1fqVca-0005Jz-HI
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 23:40:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:21102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jing2.liu@linux.intel.com>)
	id 1fqVca-0005JH-89
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 23:40:20 -0400
References: <1534411696-6454-1-git-send-email-jing2.liu@linux.intel.com>
	<24b8defb-ea03-2fe8-6a54-c9fe43255591@redhat.com>
From: "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <81a732f2-dcc5-c529-d274-45394c7787dd@linux.intel.com>
Date: Fri, 17 Aug 2018 11:39:47 +0800
MIME-Version: 1.0
In-Reply-To: <24b8defb-ea03-2fe8-6a54-c9fe43255591@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Laszlo Ersek <lersek@redhat.com>
Cc: mst@redhat.com, SeaBIOS devel list <SeaBIOS@seabios.org>, qemu-devel@nongnu.org, anthony.xu@intel.com, pbonzini@redhat.com, "Marcel Apfelbaum (GMail address)" <marcel.apfelbaum@gmail.com>

Hi Laszlo,
Thanks very much for your reminder.
Looking forward to comments from all!

Thanks,
Jing

On 8/17/2018 12:17 AM, Laszlo Ersek wrote:
> Hi,
> 
> On 08/16/18 11:28, Jing Liu wrote:
>> This patch serial is about PCI resource reserve capability.
>>
>> First patch refactors the resource reserve fields in GenPCIERoorPort
>> structure out to another new structure, called "PCIResReserve". Modify
>> the parameter list of pci_bridge_qemu_reserve_cap_init().
>>
>> Then we add the teardown function called pci_bridge_qemu_reserve_cap_uninit().
>>
>> Last we enable the resource reserve capability for legacy PCI bridge
>> so that firmware can reserve additional resources for the bridge.
>>
>> Change Log:
>> v2 -> v1
>> * add refactoring patch
>> * add teardown function
>> * some other fixes
>>
>> Jing Liu (3):
>>    hw/pci: factor PCI reserve resources to a separate structure
>>    hw/pci: add teardown function for PCI resource reserve capability
>>    hw/pci: add PCI resource reserve capability to legacy PCI bridge
>>
>>   hw/pci-bridge/gen_pcie_root_port.c | 32 +++++++++++++-------------
>>   hw/pci-bridge/pci_bridge_dev.c     | 25 ++++++++++++++++++++
>>   hw/pci/pci_bridge.c                | 47 +++++++++++++++++++++-----------------
>>   include/hw/pci/pci_bridge.h        | 18 +++++++++++----
>>   4 files changed, 80 insertions(+), 42 deletions(-)
>>
> 
> just some meta comments for now:
> 
> - I've added Marcel; please keep him CC'd on this set (and the SeaBIOS
> counterpart, [SeaBIOS] [PATCH v2 0/3] pci: resource reserve capability
> found)
> 
> - my task queue has blown up and I'm unsure when I'll get to reviewing
> this set. The same applies to the SeaBIOS counterpart.
> 
> This is just to say that you should feel free to go ahead and work with
> the (sub)maintainers; I'll try to get back to this as time allows, but
> don't wait for me.
> 
> If further versions are necessary, I'd appreciate being CC'd on those,
> just so I know what to look at when I find the time again.
> 
> Thanks!
> Laszlo
> 
