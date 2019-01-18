Received: from eggs.gnu.org ([209.51.188.92]:54599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gkZhQ-000175-Nw
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 14:21:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gkZhP-0007qz-Vf
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 14:21:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gkZhP-0007o8-OX
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 14:21:03 -0500
Date: Fri, 18 Jan 2019 14:21:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190118141519-mutt-send-email-mst@kernel.org>
References: <20190118112410.3010-1-yang.zhong@intel.com>
	<20190118112410.3010-30-yang.zhong@intel.com>
	<20190118113317-mutt-send-email-mst@kernel.org>
	<033a0646-955f-8888-381c-fa4656a2d849@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <033a0646-955f-8888-381c-fa4656a2d849@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH v3 29/43] build: convert pci.mak to
 Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, thuth@redhat.com, sameo@linux.intel.com, ehabkost@redhat.com

On Fri, Jan 18, 2019 at 06:03:46PM +0100, Paolo Bonzini wrote:
> On 18/01/19 17:36, Michael S. Tsirkin wrote:
> >>  config PCI_GENERIC
> >>      bool
> >> +    select PCIE
> >>
> > 
> > why is this?
> >   
> 
> PCI_GENERIC is hw/pci-host/gpex.c, the "QEMU Generic PCI Express Bridge
> Emulation".

Oh. Not really descriptive.
I guess we should rename it to PCI_EXPRESS_GENERIC_BRIDGE or something?

> >>  config PCI_XILINX
> >>      bool
> >> +    select PCIE
> >>  
> >>  config PCI_DESIGNWARE
> >>      bool
> >> +    select PCIE
> > 
> > 
> > sure about the above?
> 
> The comments at the top of the two files say they are PCIe.
> 
> Paolo


So I guess the part that I find confusing is which module
it is. Module should be a prefix. So if module is PCI
then everything should be PCI_ and PCIE should be
PCI_EXPRESS. If PCIE is the module then all these guys
should be renamed.

-- 
MST
