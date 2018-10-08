Received: from eggs.gnu.org ([2001:4830:134:3::10]:33006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1g9bc0-0001Gc-CL
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:54:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1g9bbw-00019e-M6
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:54:38 -0400
Date: Mon, 8 Oct 2018 21:54:02 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20181008195402.GA4229@toto>
References: <1538579266-8389-1-git-send-email-edgar.iglesias@gmail.com>
	<1538579266-8389-7-git-send-email-edgar.iglesias@gmail.com>
	<CAFEAcA-tC0wHgkh+CA2s+G015kvdd47h-R+VCbjCRRZVTsUghA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-tC0wHgkh+CA2s+G015kvdd47h-R+VCbjCRRZVTsUghA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v1 06/12] net: cadence_gem: Add support for
 selecting the DMA MemoryRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, KONRAD Frederic <frederic.konrad@adacore.com>, Alistair Francis <alistair@alistair23.me>, Francisco Iglesias <frasse.iglesias@gmail.com>, figlesia@xilinx.com, Stefano Stabellini <sstabellini@kernel.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>

On Mon, Oct 08, 2018 at 01:24:51PM +0100, Peter Maydell wrote:
> On 3 October 2018 at 16:07, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> > From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> >
> > Add support for selecting the Memory Region that the GEM
> > will do DMA to.
> >
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> > ---
> 
> 
> > @@ -1500,6 +1506,13 @@ static void gem_realize(DeviceState *dev, Error **errp)
> >      CadenceGEMState *s = CADENCE_GEM(dev);
> >      int i;
> >
> > +    if (s->dma_mr) {
> > +        s->dma_as = g_malloc0(sizeof(AddressSpace));
> > +        address_space_init(s->dma_as, s->dma_mr, NULL);
> 
> Why not just have the CadenceGEMState embed the AddressSpace
> 
>     AddressSpace dma_as;
> 
> rather than doing a separate memory allocation here?

No reason not to, I copied this from a pattern in our code and didn't reflect too much about the allocation.
I'll change it for next version.

Cheers,
Edgar


> 
> > +    } else {
> > +        s->dma_as = &address_space_memory;
> > +    }
> 
> thanks
> -- PMM
