Received: from eggs.gnu.org ([2001:4830:134:3::10]:50919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cpveF-0006WK-2O
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:38:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cpveB-0006X0-QO
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:38:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cpveB-0006WO-KY
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:38:47 -0400
References: <1489750157-17401-1-git-send-email-tianyu.lan@intel.com>
	<1e1d1637-1cf8-2ad4-36e2-342aa21b100d@redhat.com>
	<cf4a6b77-3265-c037-281b-941c4f55244f@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0542a688-deaf-001b-9f64-9e8f30c4ead3@redhat.com>
Date: Mon, 20 Mar 2017 12:38:41 +0100
MIME-Version: 1.0
In-Reply-To: <cf4a6b77-3265-c037-281b-941c4f55244f@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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



On 20/03/2017 03:40, Lan Tianyu wrote:
>>> Xen only supports emulated I440 and so we enable vIOMMU with emulated
>>> I440 chipset. This works on Linux and Windows guest.
>> Any plans to change this?  Why is Xen not able to use Q35 with Intel
>> IOMMU, with only special hooks for interrupt remapping?
>>
>> Paolo
>>
> Hi Paolo:
> Thanks for review. For Xen side, we won't reuse Intel IOMMU device mode=
l
> in Qemu and create counterpart in Xen hypervisor. The reasons are
>  1) Avoid round trips between Qemu and Xen hypervisor
>  2) Ease of integration with the rest part of the hypervisor(vIOAPIC,
> vMSI and so on).

Fair enough, though I'd be worried about increasing the attack surface
of the hypervisor.  For KVM, for example, IOMMU emulation requires using
the "split irqchip" feature to move the PIC and IOAPIC out of the kernel
and back to QEMU.

Also, I think this series is missing changes to support IOMMU
translation in the vIOMMU device model.

Paolo

> We don't have plan to enable Q35 for Xen now. There is no dependency
> between Q35 emulation and vIOMMU implementation from our test. As
> Stefano mentioned, Anthony worked on the Q35 support before. These two
> tasks can be done in parallel.
