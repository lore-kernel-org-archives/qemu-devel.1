Received: from eggs.gnu.org ([2001:4830:134:3::10]:41327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dXRmC-00064g-23
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 08:38:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dXRmB-0003Ob-AJ
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 08:38:56 -0400
Date: Tue, 18 Jul 2017 14:38:45 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170718123845.c2g3t4m4pyqofk2l@kamzik.brq.redhat.com>
References: <1498927637-14496-1-git-send-email-drjones@redhat.com>
	<1498927637-14496-3-git-send-email-drjones@redhat.com>
	<CAFEAcA-CQm1FuF7eyveSbSchRD1PkB-PDVNyMQhVny+bmWWAvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-CQm1FuF7eyveSbSchRD1PkB-PDVNyMQhVny+bmWWAvg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] target/arm/kvm: split pmu init from
 creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>

On Mon, Jul 10, 2017 at 04:27:35PM +0100, Peter Maydell wrote:
> On 1 July 2017 at 17:47, Andrew Jones <drjones@redhat.com> wrote:
> > When adding a PMU with a userspace irqchip we only do the INIT
> > stage of the device creation.
> 
> Can you explain why? My assumption would be that either
> (a) we don't need the kernel's PMU, in which case don't
> create it at all, or
> (b) we do need the kernel's PMU, so we should both create
> and INIT it.
> 
> If we do one but not the other then we've left a half
> created and unusable PMU device in the kernel, haven't we?
>

I should have renamed the 'create' function to 'set_irq', then
it would make sense, because after the split done by this patch
'create' only sets the irq, which can only be done with an
in-kernel irqchip. Both irqchip types still require INIT though,
see kernel doc Documentation/virtual/kvm/devices/vcpu.txt.

I'll send a v2 that renames the create function. But, before I do,
assuming the rename, do you have another comments on this or the
next patch? We might as well batch all the changes :-)

Thanks,
drew
