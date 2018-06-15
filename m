Received: from eggs.gnu.org ([2001:4830:134:3::10]:36858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fTrM5-0001Uj-FD
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 12:13:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fTrM4-0002C2-K0
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 12:13:41 -0400
References: <20180516152026.2920-1-shameerali.kolothum.thodi@huawei.com>
	<20180516152026.2920-7-shameerali.kolothum.thodi@huawei.com>
	<bd67ed40-81d6-58dc-ccaf-efd8a40ca96f@redhat.com>
	<5FC3163CFD30C246ABAA99954A238FA8386F6E04@FRAEML521-MBX.china.huawei.com>
	<20180615154441.4rr5mtcnran5cf3s@kamzik.brq.redhat.com>
	<CAFEAcA-nG4Xv=PmxzW3tzs-TStziMDHMFxYi6_teSe1GhLH=hw@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <333cd485-dc75-d295-16fd-98a1108e1e15@redhat.com>
Date: Fri, 15 Jun 2018 18:13:28 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-nG4Xv=PmxzW3tzs-TStziMDHMFxYi6_teSe1GhLH=hw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 6/6] hw/arm: Populate non-contiguous
 memory regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Jonathan Cameron <jonathan.cameron@huawei.com>, Linuxarm <linuxarm@huawei.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, Zhaoshenglong <zhaoshenglong@huawei.com>, "imammedo@redhat.com" <imammedo@redhat.com>

Hi,

On 06/15/2018 05:54 PM, Peter Maydell wrote:
> Why should the VM ever care about where the address regions in the
> host happen to be when it comes to where it's putting its RAM
> in the VM's address layout? I feel like I'm missing something here...
> 
> thanks

The VM cannot use RAM GPA that matches assigned device reserved IOVA
regions. When you assign a device, the whole VM RAM is mapped in the
physical IOMMU and IOVA corresponds to GPA. but sometimes some IOVA
cannot be used due to the host specificities and especially iommu
peculiarities. Some IOVAs may be simply "bypassed" by the iommu, like on
x86 and also with some ARM SMMU integration. In such a case the DMA
accesses have no chance to reach the guest RAM as expected. Hope it
clarifies.

Thanks

Eric
