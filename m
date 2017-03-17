Received: from eggs.gnu.org ([2001:4830:134:3::10]:59358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1coywF-0002QJ-2q
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 16:57:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1coywB-0003vz-W6
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 16:57:31 -0400
Received: from mail.kernel.org ([198.145.29.136]:50228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1coywB-0003vN-Q1
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 16:57:27 -0400
Date: Fri, 17 Mar 2017 13:57:22 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <1e1d1637-1cf8-2ad4-36e2-342aa21b100d@redhat.com>
Message-ID: <alpine.DEB.2.10.1703171356520.22036@sstabellini-ThinkPad-X260>
References: <1489750157-17401-1-git-send-email-tianyu.lan@intel.com>
	<1e1d1637-1cf8-2ad4-36e2-342aa21b100d@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [RFC PATCH 0/4] Qemu: Add Xen vIOMMU support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Lan Tianyu <tianyu.lan@intel.com>, qemu-devel@nongnu.org, xen-devel@lists.xensource.com, chao.gao@intel.com, kevin.tian@intel.com, anthony.perard@citrix.com, ehabkost@redhat.com, marcel@redhat.com, mst@redhat.com, rth@twiddle.net, sstabellini@kernel.organthony.perard@citrix.com

On Fri, 17 Mar 2017, Paolo Bonzini wrote:
> On 17/03/2017 12:29, Lan Tianyu wrote:
> > This patchset is to add Xen vIOMMU device model and handle
> > irq remapping stuffs. Xen vIOMMU emulation is in the Xen hypervisor
> > and the new device module in Qemu works as hypercall wrappers to
> > create and destroy vIOMMU in hypervisor.
> > 
> > Xen only supports emulated I440 and so we enable vIOMMU with emulated
> > I440 chipset. This works on Linux and Windows guest.
> 
> Any plans to change this?  Why is Xen not able to use Q35 with Intel
> IOMMU, with only special hooks for interrupt remapping?

CC'ing Anthony that worked on it in the past


> > Chao Gao (4):
> >   I440: Allow adding sysbus devices with -device on I440
> >   Xen: add a dummy vIOMMU to create/destroy vIOMMU in Xen
> >   xen-pt: bind/unbind interrupt remapping format MSI
> >   msi: taking interrupt format into consideration during judging a pirq
> >     is binded with a event channel
> 
