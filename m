Received: from eggs.gnu.org ([2001:4830:134:3::10]:56729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dTGDm-0004zp-08
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:30:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dTGDl-0003ZR-4w
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:30:06 -0400
Date: Fri, 7 Jul 2017 02:29:51 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170707022732-mutt-send-email-mst@kernel.org>
References: <6f22079e-4b4b-6476-77be-51ec83104c0d@redhat.com>
	<AM5PR0401MB25459FDAA8C9AFA52503AAE99AC40@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<c80977c4-1955-4e9d-3fc8-4d884562fd28@redhat.com>
	<HE1PR0401MB2556D19D91F25DCE96FE7B199AD40@HE1PR0401MB2556.eurprd04.prod.outlook.com>
	<8a7fb667-e6c0-2412-6dca-a8233dd27836@redhat.com>
	<HE1PR0401MB255696A487DFEB2B8972980F9AD40@HE1PR0401MB2556.eurprd04.prod.outlook.com>
	<e9ea564a-f02b-0ed5-e700-b7b1dfd89722@arm.com>
	<AM5PR0401MB25459345E9533FFC3BBE00289AD50@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<15b631c8-5708-1426-90a2-9be51a796614@redhat.com>
	<BN4PR07MB2161B5CCE84496804B848326E3D50@BN4PR07MB2161.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN4PR07MB2161B5CCE84496804B848326E3D50@BN4PR07MB2161.namprd07.prod.outlook.com>
Subject: Re: [Qemu-devel] [Qemu-arm]  [RFC v2 0/8] VIRTIO-IOMMU device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Kalra, Ashish" <Ashish.Kalra@cavium.com>
Cc: Auger Eric <eric.auger@redhat.com>, Bharat Bhushan <bharat.bhushan@nxp.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "tn@semihalf.com" <tn@semihalf.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "drjones@redhat.com" <drjones@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>

On Thu, Jul 06, 2017 at 11:23:41PM +0000, Kalra, Ashish wrote:
> I have a generic question on vIOMMU support, is there any proposal/plan to add ATS/PRI extension support to vIOMMUs and allow
> handling for end to end (v)IOMMU Page faults (w/t the device side implementation on Vhost) ?
> 
> Again, the motivation will be to do DMA on paged guest memory and potentially avoiding the requirement of pinned/locked
> guest physical memory for DMA.
> 
> Thanks,
> Ashish

If that's your goal, first step would be support in VFIO.
End to end would only be helpful when running userspace
drivers within guest, or nested virt.

-- 
MST
