Received: from eggs.gnu.org ([2001:4830:134:3::10]:47127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cpyPl-0007rR-41
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:36:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cpyPh-0003RT-4v
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:36:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cpyPg-0003RF-Qz
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:36:01 -0400
References: <1489750157-17401-1-git-send-email-tianyu.lan@intel.com>
	<1e1d1637-1cf8-2ad4-36e2-342aa21b100d@redhat.com>
	<cf4a6b77-3265-c037-281b-941c4f55244f@intel.com>
	<0542a688-deaf-001b-9f64-9e8f30c4ead3@redhat.com>
	<20170320141727.un75xpn2i6g2iytv@dhcp-3-128.uk.xensource.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dae98073-44c1-88ce-e5a2-aaf69b39335b@redhat.com>
Date: Mon, 20 Mar 2017 15:35:55 +0100
MIME-Version: 1.0
In-Reply-To: <20170320141727.un75xpn2i6g2iytv@dhcp-3-128.uk.xensource.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc: Lan Tianyu <tianyu.lan@intel.com>, qemu-devel@nongnu.org, xen-devel@lists.xensource.com, kevin.tian@intel.com, sstabellini@kernel.org, ehabkost@redhat.com, mst@redhat.com, marcel@redhat.com, anthony.perard@citrix.com, rth@twiddle.net, chao.gao@intel.com



On 20/03/2017 15:17, Roger Pau Monn=E9 wrote:
>>> Hi Paolo:
>>> Thanks for review. For Xen side, we won't reuse Intel IOMMU device mo=
del
>>> in Qemu and create counterpart in Xen hypervisor. The reasons are
>>>  1) Avoid round trips between Qemu and Xen hypervisor
>>>  2) Ease of integration with the rest part of the hypervisor(vIOAPIC,
>>> vMSI and so on).
>> Fair enough, though I'd be worried about increasing the attack surface
>> of the hypervisor.  For KVM, for example, IOMMU emulation requires usi=
ng
>> the "split irqchip" feature to move the PIC and IOAPIC out of the kern=
el
>> and back to QEMU.
> Yes, that's right, we are increasing the surface of attack. But Xen als=
o needs
> it in order to support APIC IDs > 255 on PVH guests (that have a local =
APIC but
> no QEMU).

Not necessarily, you only need x2APIC support for that in the local APIC
emulation.  The MSI hypercalls (similar to KVM's MSI ioctls) can be
extended to accept x2APIC VCPU ids.

Paolo
