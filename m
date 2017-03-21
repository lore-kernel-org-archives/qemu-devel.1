Received: from eggs.gnu.org ([2001:4830:134:3::10]:43305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1cq8Ti-0004NJ-Ug
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 21:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1cq8Tf-00026M-19
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 21:20:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:57476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tianyu.lan@intel.com>)
	id 1cq8Te-00025K-Mx
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 21:20:46 -0400
References: <1489750157-17401-1-git-send-email-tianyu.lan@intel.com>
	<1e1d1637-1cf8-2ad4-36e2-342aa21b100d@redhat.com>
	<cf4a6b77-3265-c037-281b-941c4f55244f@intel.com>
	<0542a688-deaf-001b-9f64-9e8f30c4ead3@redhat.com>
From: Lan Tianyu <tianyu.lan@intel.com>
Message-ID: <fbeeaf60-d19e-26ce-a119-b9b84b96fd47@intel.com>
Date: Tue, 21 Mar 2017 09:13:11 +0800
MIME-Version: 1.0
In-Reply-To: <0542a688-deaf-001b-9f64-9e8f30c4ead3@redhat.com>
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

On 2017年03月20日 19:38, Paolo Bonzini wrote:
> Fair enough, though I'd be worried about increasing the attack surface
> of the hypervisor.  For KVM, for example, IOMMU emulation requires using
> the "split irqchip" feature to move the PIC and IOAPIC out of the kernel
> and back to QEMU.

Yes, just like Roger mentioned we also need to support no-qemu mode on
Xen and this is tradeoff result.

> 
> Also, I think this series is missing changes to support IOMMU
> translation in the vIOMMU device model.

Yes, this series just enabled vIOMMU's irq remapping function and we
need to pass virtual device's DMA request to Xen hypervisor for
translation when enable DMA translation.

-- 
Best regards
Tianyu Lan
