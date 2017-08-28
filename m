Received: from eggs.gnu.org ([2001:4830:134:3::10]:34207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dmSzZ-0005ea-3I
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 18:58:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dmSzW-0004b7-NG
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 18:58:47 -0400
References: <20170823221445.15243-1-ehabkost@redhat.com>
	<20170823221445.15243-5-ehabkost@redhat.com>
	<20170825193922.GN27715@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <8ad06170-3409-f9aa-dbaf-380c2ca35fd9@redhat.com>
Date: Mon, 28 Aug 2017 18:58:37 -0400
MIME-Version: 1.0
In-Reply-To: <20170825193922.GN27715@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/5] pci: Add INTERFACE_LEGACY_PCI_DEVICE
 to legacy PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org



On 08/25/2017 03:39 PM, Eduardo Habkost wrote:
> CCing maintainers of affected devices (sorry for not CCing you
> before).
> 
> On Wed, Aug 23, 2017 at 07:14:44PM -0300, Eduardo Habkost wrote:
>> Add INTERFACE_LEGACY_PCI_DEVICE to all direct subtypes of
>> TYPE_PCI_DEVICE, except:
>>
>> 1) The ones that already have INTERFACE_PCIE_DEVICE set:
>>
>> * base-xhci
>> * e1000e
>> * nvme
>> * pvscsi
>> * vfio-pci
>> * virtio-pci
>> * vmxnet3
>>
>> 2) base-pci-bridge
>>
>> Not all PCI bridges are legacy PCI devices, so
>> INTERFACE_LEGACY_PCI_DEVICE is added only to the subtypes that
>> are actually legacy PCI devices:
>>
>> * dec-21154-p2p-bridge
>> * i82801b11-bridge
>> * pbm-bridge
>> * pci-bridge
>>
>> The direct subtypes of base-pci-bridge not touched by this patch
>> are:
>>
>> * xilinx-pcie-root: Already marked as PCIe-only device.
>> * pcie-port: all non-abstract subtypes of pcie-port are already
>>   marked as PCIe-only devices.
>>
>> 3) megasas-base
>>
>> Not all megasas devices are legacy PCI devices, so the interface
>> names are added to the subclasses registered by
>> megasas_register_types(), according to information in the
>> megasas_devices[] array.
>>
>> "megasas-gen2" already implements INTERFACE_PCIE_DEVICE, so add
>> INTERFACE_LEGACY_PCI_DEVICE only to "megasas".
>>
>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>> ---

[...]

>>  hw/ide/ich.c                        |  4 ++++
>>  hw/ide/pci.c                        |  4 ++++

Acked-by: John Snow <jsnow@redhat.com>


(Random fly-by comment without looking at the other patches: I assume
there are reasons it's not appropriate or good to add a legacy PCI
device parent that we inherit from, and it's instead better to manually
add the property to all children?)
