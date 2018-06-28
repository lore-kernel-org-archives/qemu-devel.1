Received: from eggs.gnu.org ([2001:4830:134:3::10]:38755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYU4I-00044r-Nx
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 06:22:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYU4H-0007n8-Ft
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 06:22:26 -0400
Date: Thu, 28 Jun 2018 11:22:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180628102216.GC3513@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1530094388-607-1-git-send-email-hongbo.zhang@linaro.org>
	<20180627123116.GB2424@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180627123116.GB2424@work-vm>
Subject: Re: [Qemu-devel] [PATCH] hw/arm: Add SBSA machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Hongbo Zhang <hongbo.zhang@linaro.org>, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On Wed, Jun 27, 2018 at 01:31:17PM +0100, Dr. David Alan Gilbert wrote:
> * Hongbo Zhang (hongbo.zhang@linaro.org) wrote:
> > This patch introduces a new Arm machine type 'SBSA' with features:
> >  - Based on legacy 'virt' machine type.

The 'virt' machine type is absolutely *not* legacy. It is the preferred
modern, legacy-free machine type when running virtual machines. Since
aarch64 is greenfield, there is no compelling reason to emulate a
specific physical machine for VMs, hence the 'virt' machine type.

> >  - Newly designed memory map.
> >  - EL2 and EL3 are enabled by default.
> >  - AHCI controller attached to system bus, and then CDROM and hard disc
> >    can be added to it.
> >  - EHCI controller attached to system bus, with USB mouse and key board
> >    installed by default.
> >  - E1000 ethernet card on PCIE bus.

> >  - VGA display adaptor on PCIE bus.
> >  - Default CPU type cortex-a57, 4 cores, and 1G bytes memory.
> >  - No virtio functions enabled, since this is to emulate real hardware.
> 
> I'm a bit confused; do you have real modern ARM hardware that has an
> e1000 on it?  If I understand correctly, e1000 is the old PCI version
> and the e1000e is at least the more modern PCIe version which makes
> more sense if you're building on PCIe.

Indeed, it makes little sense to default to e1000 if the goal is to make
it legacy-free

> However, if you:
>   a) Don't have real hardware with the e1000 on
>   b) Do have PCIe
> 
> then to my mind it makes sense to use virtio-net-pci rather than
> an e1000e.

If it does down the virtio-* route though, I fail to see any point in
adding the new machine type at all -  'virt' machine type is intended
to be used for guests where everything is paravirtualized, ignoring
physical hardware constraints.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
