Received: from eggs.gnu.org ([2001:4830:134:3::10]:40890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gNanD-0003mp-5O
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 04:52:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gNanC-0000SP-EA
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 04:52:03 -0500
From: Auger Eric <eric.auger@redhat.com>
References: <20181109112957.10067-1-eric.auger@redhat.com>
	<20181109112957.10067-16-eric.auger@redhat.com>
	<2d6c96ce-9eb5-9347-1a75-4e13c0cea0ec@arm.com>
	<8653586f-404f-5b03-30ba-a0eb3676c107@redhat.com>
Message-ID: <bd60d093-1669-50d2-c718-aa66a65bd358@redhat.com>
Date: Fri, 16 Nov 2018 10:51:45 +0100
MIME-Version: 1.0
In-Reply-To: <8653586f-404f-5b03-30ba-a0eb3676c107@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v8 15/18] hw/arm/virt: Add virtio-iommu to
 the virt board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "mst@redhat.com" <mst@redhat.com>
Cc: "tn@semihalf.com" <tn@semihalf.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>, "peterx@redhat.com" <peterx@redhat.com>

Hi Jean, Bharat,

On 11/14/18 5:41 PM, Auger Eric wrote:
> Hi Jean,
> 
> On 11/14/18 5:01 PM, Jean-Philippe Brucker wrote:
>> On 09/11/2018 11:29, Eric Auger wrote:
>>> +static void create_virtio_iommu(VirtMachineState *vms,
>>> +                                const char *pciehb_nodename, PCIBus *bus)
>>> +{
>>> +    const char compat[] = "virtio,pci-iommu";
>>> +    uint16_t bdf = 0x8; /* 00:01.0 */
>>> +    DeviceState *dev;
>>> +    char *node;
>>> +
>>> +    dev = qdev_create(BUS(bus), TYPE_VIRTIO_IOMMU_PCI);
>>> +    object_property_set_bool(OBJECT(dev), true, "realized", &error_fatal);
>>
>> For the Arm virt platform, should msi_bypass default to false? Otherwise
>> I don't think pass-through to guest userpace will work.
> That's correct. It's a regression compared to v7. I will fix this soon
> while doing the pc machine integration + resv regions flaws you reported
> in the meantime.

The reported issues related to probe requests are fixed in the following
branch:
https://github.com/eauger/qemu/tree/v3.1.0-rc1-virtio-iommu-v0.8.1

This branch was used to test [PATCH v4 0/7] Add virtio-iommu driver

Thanks

Eric

> 
> Thanks!
> 
> Eric
>>
>> Thanks,
>> Jean
>>
> 
