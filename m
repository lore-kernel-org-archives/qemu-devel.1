Received: from eggs.gnu.org ([2001:4830:134:3::10]:49085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ermAv-0005fK-My
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:00:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ermAq-0002vt-TQ
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:00:45 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60326 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ermAq-0002vh-Na
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:00:40 -0500
References: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
	<1519900415-30314-12-git-send-email-yi.l.liu@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a899b75f-5a0b-2a0f-f995-5a3c21eeab8c@redhat.com>
Date: Fri, 2 Mar 2018 16:00:23 +0100
MIME-Version: 1.0
In-Reply-To: <1519900415-30314-12-git-send-email-yi.l.liu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 11/12] intel_iommu: add framework for
 PASID AddressSpace management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@linux.intel.com>, qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au
Cc: alex.williamson@redhat.com, eric.auger.pro@gmail.com, yi.l.liu@intel.com, peterx@redhat.com, kevin.tian@intel.com, jasowang@redhat.com

On 01/03/2018 11:33, Liu, Yi L wrote:
> +struct VTDDeviceNode {
> +    PCIBus *bus;
> +    uint8_t devfn;
> +    QLIST_ENTRY(VTDDeviceNode) next;
> +};

Do you really need VTDDeviceNode?  I think can you simply put the
QLIST_ENTRY in VTDAddressSpace (named e.g. next_by_pasid), since
VTDAddressSpace already includes a (bus, devfn).

Thanks,

Paolo

> +struct VTDPASIDAddressSpace {
> +    AddressSpace as;
> +    IOMMUSVAContext sva_ctx;
> +    IntelIOMMUState *iommu_state;
> +    /* list of devices binded to a pasid tagged address space */
> +    QLIST_HEAD(, VTDDeviceNode) device_list;
> +};
> +
