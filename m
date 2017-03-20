Received: from eggs.gnu.org ([2001:4830:134:3::10]:54473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1cpnMC-0007J0-GL
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 22:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1cpnM8-0005kQ-JB
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 22:47:40 -0400
Received: from mga04.intel.com ([192.55.52.120]:25866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tianyu.lan@intel.com>)
	id 1cpnM8-0005jT-7q
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 22:47:36 -0400
References: <1489750157-17401-1-git-send-email-tianyu.lan@intel.com>
	<1e1d1637-1cf8-2ad4-36e2-342aa21b100d@redhat.com>
From: Lan Tianyu <tianyu.lan@intel.com>
Message-ID: <cf4a6b77-3265-c037-281b-941c4f55244f@intel.com>
Date: Mon, 20 Mar 2017 10:40:02 +0800
MIME-Version: 1.0
In-Reply-To: <1e1d1637-1cf8-2ad4-36e2-342aa21b100d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 0/4] Qemu: Add Xen vIOMMU support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, xen-devel@lists.xensource.com
Cc: chao.gao@intel.com, kevin.tian@intel.com, anthony.perard@citrix.com, ehabkost@redhat.com, marcel@redhat.com, mst@redhat.com, rth@twiddle.net, sstabellini@kernel.org

On 2017年03月17日 22:48, Paolo Bonzini wrote:
> 
> 
> On 17/03/2017 12:29, Lan Tianyu wrote:
>> This patchset is to add Xen vIOMMU device model and handle
>> irq remapping stuffs. Xen vIOMMU emulation is in the Xen hypervisor
>> and the new device module in Qemu works as hypercall wrappers to
>> create and destroy vIOMMU in hypervisor.
>>
>> Xen only supports emulated I440 and so we enable vIOMMU with emulated
>> I440 chipset. This works on Linux and Windows guest.
> 
> Any plans to change this?  Why is Xen not able to use Q35 with Intel
> IOMMU, with only special hooks for interrupt remapping?
> 
> Paolo
> 

Hi Paolo:
Thanks for review. For Xen side, we won't reuse Intel IOMMU device model
in Qemu and create counterpart in Xen hypervisor. The reasons are
 1) Avoid round trips between Qemu and Xen hypervisor
 2) Ease of integration with the rest part of the hypervisor(vIOAPIC,
vMSI and so on).

We don't have plan to enable Q35 for Xen now. There is no dependency
between Q35 emulation and vIOMMU implementation from our test. As
Stefano mentioned, Anthony worked on the Q35 support before. These two
tasks can be done in parallel.

-- 
Best regards
Tianyu Lan
