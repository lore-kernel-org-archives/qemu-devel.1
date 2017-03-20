Received: from eggs.gnu.org ([2001:4830:134:3::10]:51419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=2453aa033=roger.pau@citrix.com>)
	id 1cpyd2-00055z-9V
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:49:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=2453aa033=roger.pau@citrix.com>)
	id 1cpycu-0007d3-SP
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:49:44 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:39218
	helo=SMTP.EU.CITRIX.COM)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=2453aa033=roger.pau@citrix.com>)
	id 1cpycu-0007ci-KB
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:49:40 -0400
Date: Mon, 20 Mar 2017 14:17:27 +0000
From: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Message-ID: <20170320141727.un75xpn2i6g2iytv@dhcp-3-128.uk.xensource.com>
References: <1489750157-17401-1-git-send-email-tianyu.lan@intel.com>
	<1e1d1637-1cf8-2ad4-36e2-342aa21b100d@redhat.com>
	<cf4a6b77-3265-c037-281b-941c4f55244f@intel.com>
	<0542a688-deaf-001b-9f64-9e8f30c4ead3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0542a688-deaf-001b-9f64-9e8f30c4ead3@redhat.com>
Subject: Re: [Qemu-devel] [Xen-devel] [RFC PATCH 0/4] Qemu: Add Xen vIOMMU
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Lan Tianyu <tianyu.lan@intel.com>, qemu-devel@nongnu.org, xen-devel@lists.xensource.com, kevin.tian@intel.com, sstabellini@kernel.org, ehabkost@redhat.com, mst@redhat.com, marcel@redhat.com, anthony.perard@citrix.com, rth@twiddle.net, chao.gao@intel.com

On Mon, Mar 20, 2017 at 12:38:41PM +0100, Paolo Bonzini wrote:
> 
> 
> On 20/03/2017 03:40, Lan Tianyu wrote:
> >>> Xen only supports emulated I440 and so we enable vIOMMU with emulated
> >>> I440 chipset. This works on Linux and Windows guest.
> >> Any plans to change this?  Why is Xen not able to use Q35 with Intel
> >> IOMMU, with only special hooks for interrupt remapping?
> >>
> >> Paolo
> >>
> > Hi Paolo:
> > Thanks for review. For Xen side, we won't reuse Intel IOMMU device model
> > in Qemu and create counterpart in Xen hypervisor. The reasons are
> >  1) Avoid round trips between Qemu and Xen hypervisor
> >  2) Ease of integration with the rest part of the hypervisor(vIOAPIC,
> > vMSI and so on).
> 
> Fair enough, though I'd be worried about increasing the attack surface
> of the hypervisor.  For KVM, for example, IOMMU emulation requires using
> the "split irqchip" feature to move the PIC and IOAPIC out of the kernel
> and back to QEMU.

Yes, that's right, we are increasing the surface of attack. But Xen also needs
it in order to support APIC IDs > 255 on PVH guests (that have a local APIC but
no QEMU).

Roger.
