Received: from eggs.gnu.org ([2001:4830:134:3::10]:35269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1gMxcR-0004bP-Nd
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:02:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1gMxcJ-0006Ur-N4
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:02:18 -0500
References: <20181109112957.10067-1-eric.auger@redhat.com>
	<20181109112957.10067-16-eric.auger@redhat.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <2d6c96ce-9eb5-9347-1a75-4e13c0cea0ec@arm.com>
Date: Wed, 14 Nov 2018 16:01:28 +0000
MIME-Version: 1.0
In-Reply-To: <20181109112957.10067-16-eric.auger@redhat.com>
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
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "mst@redhat.com" <mst@redhat.com>
Cc: "kevin.tian@intel.com" <kevin.tian@intel.com>, "tn@semihalf.com" <tn@semihalf.com>, "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>, "peterx@redhat.com" <peterx@redhat.com>

On 09/11/2018 11:29, Eric Auger wrote:
> +static void create_virtio_iommu(VirtMachineState *vms,
> +                                const char *pciehb_nodename, PCIBus *bus)
> +{
> +    const char compat[] = "virtio,pci-iommu";
> +    uint16_t bdf = 0x8; /* 00:01.0 */
> +    DeviceState *dev;
> +    char *node;
> +
> +    dev = qdev_create(BUS(bus), TYPE_VIRTIO_IOMMU_PCI);
> +    object_property_set_bool(OBJECT(dev), true, "realized", &error_fatal);

For the Arm virt platform, should msi_bypass default to false? Otherwise
I don't think pass-through to guest userpace will work.

Thanks,
Jean
