Received: from eggs.gnu.org ([2001:4830:134:3::10]:52525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1cE9sl-0007QE-Ho
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 02:09:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1cE9si-0002PK-Bc
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 02:09:43 -0500
Received: from mga05.intel.com ([192.55.52.43]:63854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tianyu.lan@intel.com>)
	id 1cE9si-0002Ls-3I
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 02:09:40 -0500
References: <1480348315-13332-1-git-send-email-bd.aviv@gmail.com>
	<8188dd5e-2c71-dbd0-9a1a-9c8af6f74b96@intel.com>
	<20161202065214.GF21601@pxdev.xzpeter.org>
	<088c2afd-575e-99af-1686-023c116352ab@intel.com>
	<20161206065155.GB4344@pxdev.xzpeter.org>
From: Lan Tianyu <tianyu.lan@intel.com>
Message-ID: <6d37d046-8e5a-7662-baa6-445d3985fde7@intel.com>
Date: Tue, 6 Dec 2016 15:06:20 +0800
MIME-Version: 1.0
In-Reply-To: <20161206065155.GB4344@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 0/5] IOMMU: intel_iommu support map and
 unmap notifications
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: "Aviv B.D" <bd.aviv@gmail.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Alex Williamson <alex.williamson@redhat.com>, Jason Wang <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Wu, Fengguang" <fengguang.wu@intel.com>

On 2016年12月06日 14:51, Peter Xu wrote:
> On Tue, Dec 06, 2016 at 02:30:24PM +0800, Lan Tianyu wrote:
> 
> [...]
> 
>>>> 2. How to restore GPA->HPA mapping when IOVA is disabled by guest.
>>>> When guest enables IOVA for device, vIOMMU will invalidate all previous
>>>> GPA->HPA mapping and update IOVA->HPA mapping to pIOMMU via iommu
>>>> notifier. But if IOVA is disabled, I think we should restore GPA->HPA
>>>> mapping for the device otherwise the device won't work again in the VM.
>>>
>>> If we can have a workable replay mechanism, this problem will be
>>> solved IMHO.
>>
>> Basic idea is to replay related memory regions to restore GPA->HPA
>> mapping when guest disables IOVA.
> 
> Btw, could you help elaborate in what case we will trigger such a
> condition? Or, can we dynamically enable/disable an IOMMU?

First case I think of is nest virtualization and we assign physical
device to l2 guest. User space driver(E.G DPDK) also can enable/disable
IOVA for device dynamically.

-- 
Best regards
Tianyu Lan
