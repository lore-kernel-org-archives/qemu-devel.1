Received: from eggs.gnu.org ([2001:4830:134:3::10]:57864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fazAJ-0005ka-NZ
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 03:59:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fazAF-0004CC-En
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 03:58:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35710 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1fazAF-00048X-90
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 03:58:55 -0400
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
	<1530270944-11351-25-git-send-email-suzuki.poulose@arm.com>
	<20180704142241.GG4828@arm.com> <8636wzysfl.wl-marc.zyngier@arm.com>
	<20180704155123.GO4828@arm.com>
	<CAFEAcA9wgnbK8PHMvksezHqgN1BQZd_+sxXCe85AW+E+cfrcXg@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <c04ac446-ec16-6ec9-383a-e93f0e2d7275@redhat.com>
Date: Thu, 5 Jul 2018 09:58:50 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9wgnbK8PHMvksezHqgN1BQZd_+sxXCe85AW+E+cfrcXg@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [kvmtool test PATCH 24/24] kvmtool: arm: Add
 support for creating VM with PA size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Will Deacon <will.deacon@arm.com>
Cc: Christoffer Dall <cdall@kernel.org>, kvm-devel <kvm@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Punit Agrawal <punit.agrawal@arm.com>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>, kvmarm@lists.cs.columbia.edu, arm-mail-list <linux-arm-kernel@lists.infradead.org>

Hi,

On 07/05/2018 09:51 AM, Peter Maydell wrote:
> On 4 July 2018 at 16:51, Will Deacon <will.deacon@arm.com> wrote:
>> On Wed, Jul 04, 2018 at 03:41:18PM +0100, Marc Zyngier wrote:
>>> Not really. Let's say I want my IPA space split in two: memory covers
>>> the low 47 bit, and I want MMIO spanning the top 47 bit. With your
>>> scheme, you'd end-up with a 47bit IPA space, while you really want 48
>>> bits (MMIO space implemented by userspace isn't registered to the
>>> kernel).
>>
>> That still sounds quite niche for a VM. Does QEMU do that?
> 
> Not at 47 bits, but we have RAM up to the 256GB mark, and
> MMIO above that (including a large PCI window), so the general
> arrangement of having the top end of the IPA space not
> necessarily be things we've told the kernel about definitely
> exists.

Is this document (2012) still a reference document?
http://infocenter.arm.com/help/topic/com.arm.doc.den0001c/DEN0001C_principles_of_arm_memory_maps.pdf
(especially Fig 5?)

Peter, comments in QEMU hw/arm/virt.c suggested next RAM chunk should be
added at 2TB. This doc suggests to put it at 8TB. I understand the PA
memory map only is suggested but shouldn't we align?

Thanks

Eric


> 
> thanks
> -- PMM
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
> 
