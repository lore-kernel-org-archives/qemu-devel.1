Received: from eggs.gnu.org ([209.51.188.92]:48454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1ggowG-0004JW-RK
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 05:48:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1ggowG-0001M6-1h
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 05:48:52 -0500
Received: from mga03.intel.com ([134.134.136.65]:34328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1ggowF-0001Fc-OG
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 05:48:51 -0500
Date: Tue, 8 Jan 2019 18:45:14 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20190108104514.GG27840@yangzhon-Virtual>
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-22-yang.zhong@intel.com>
	<71bf251a-461e-8967-8b92-1bbca638f6a9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71bf251a-461e-8967-8b92-1bbca638f6a9@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 21/25] virtio: make virtio dependencies
 with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, sameo@linux.intel.com, pbonzini@redhat.com, ehabkost@redhat.com, yang.zhong@intel.com

On Fri, Jan 04, 2019 at 08:54:54PM +0100, Thomas Huth wrote:
> On 2018-12-27 07:34, Yang Zhong wrote:
> > Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> > ---
> >  default-configs/i386-softmmu.mak |  1 -
> >  hw/9pfs/Kconfig                  |  2 ++
> >  hw/block/Kconfig                 |  2 ++
> >  hw/char/Kconfig                  |  2 ++
> >  hw/display/Kconfig               |  5 +++++
> >  hw/input/Kconfig                 |  2 ++
> >  hw/net/Kconfig                   |  2 ++
> >  hw/pci-host/Kconfig              |  2 ++
> >  hw/virtio/Kconfig                | 10 +++++++++-
> >  9 files changed, 26 insertions(+), 2 deletions(-)
> 
> Shouldn't this patch also get rid of default-configs/virtio.mak ?
> 
  Thanks for reminder, i omitted this file and should remove it. thanks!

  Regards,

  Yang

> [...]
> > diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
> > index aabd6d4d96..9127daed5e 100644
> > --- a/hw/virtio/Kconfig
> > +++ b/hw/virtio/Kconfig
> > @@ -3,18 +3,26 @@ config VIRTIO
> >  
> >  config VIRTIO_RNG
> >      bool
> > +    default y
> > +    depends on VIRTIO
> >  
> >  config VIRTIO_PCI
> >      bool
> >      default y
> >      depends on PCI
> > -    select VIRTIO
> > +    depends on VIRTIO
> >  
> >  config VIRTIO_MMIO
> >      bool
> > +    default y
> > +    depends on VIRTIO
> 
> I don't think we should enable VIRTIO_MMIO by default - it's only used
> on arm and riscv, but not on x86 and the other architectures.
>
  Yes, the VIRTIO_MMIO is only used in arm and risc arch, i will change
  this. thanks for Thomas's comments

  Regards,

  Yang
 
> >  config VIRTIO_BALLOON
> >      bool
> > +    default y
> > +    depends on VIRTIO
> >  
> >  config VIRTIO_CRYPTO
> >      bool
> > +    default y
> > +    depends on VIRTIO
> > 
> 
>  Thomas
