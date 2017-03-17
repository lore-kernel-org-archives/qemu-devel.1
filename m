Received: from eggs.gnu.org ([2001:4830:134:3::10]:50675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cotBf-0005To-7j
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 10:49:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cotBb-0001Fv-BT
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 10:49:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cotBb-0001Fl-5G
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 10:48:59 -0400
References: <1489750157-17401-1-git-send-email-tianyu.lan@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1e1d1637-1cf8-2ad4-36e2-342aa21b100d@redhat.com>
Date: Fri, 17 Mar 2017 15:48:53 +0100
MIME-Version: 1.0
In-Reply-To: <1489750157-17401-1-git-send-email-tianyu.lan@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 0/4] Qemu: Add Xen vIOMMU support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lan Tianyu <tianyu.lan@intel.com>, qemu-devel@nongnu.org, xen-devel@lists.xensource.com
Cc: chao.gao@intel.com, kevin.tian@intel.com, anthony.perard@citrix.com, ehabkost@redhat.com, marcel@redhat.com, mst@redhat.com, rth@twiddle.net, sstabellini@kernel.org



On 17/03/2017 12:29, Lan Tianyu wrote:
> This patchset is to add Xen vIOMMU device model and handle
> irq remapping stuffs. Xen vIOMMU emulation is in the Xen hypervisor
> and the new device module in Qemu works as hypercall wrappers to
> create and destroy vIOMMU in hypervisor.
> 
> Xen only supports emulated I440 and so we enable vIOMMU with emulated
> I440 chipset. This works on Linux and Windows guest.

Any plans to change this?  Why is Xen not able to use Q35 with Intel
IOMMU, with only special hooks for interrupt remapping?

Paolo

> Chao Gao (4):
>   I440: Allow adding sysbus devices with -device on I440
>   Xen: add a dummy vIOMMU to create/destroy vIOMMU in Xen
>   xen-pt: bind/unbind interrupt remapping format MSI
>   msi: taking interrupt format into consideration during judging a pirq
>     is binded with a event channel
