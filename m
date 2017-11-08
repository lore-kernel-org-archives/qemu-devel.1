Received: from eggs.gnu.org ([2001:4830:134:3::10]:37035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eCUAw-0007dg-6Q
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 12:30:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eCUAs-00068K-91
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 12:30:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eCUAs-00067z-2Z
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 12:30:02 -0500
Date: Wed, 8 Nov 2017 18:29:55 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171108182955.20875b2c.cohuck@redhat.com>
In-Reply-To: <6722cc03-9311-c19b-3f26-4f0cc41a1770@redhat.com>
References: <20171108152023.80780-1-marcel@redhat.com>
	<3722f599-31b4-adb6-270b-aff5819f1bd3@redhat.com>
	<6722cc03-9311-c19b-3f26-4f0cc41a1770@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/pcie-pci-bridge: restrict to X86 and ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com, zuban32s@gmail.com

On Wed, 8 Nov 2017 19:02:35 +0200
Marcel Apfelbaum <marcel@redhat.com> wrote:

> On 08/11/2017 18:52, Thomas Huth wrote:
> > On 08.11.2017 16:20, Marcel Apfelbaum wrote:  
> >> The PCIE-PCI bridge is specific to "pure" PCI systems  
> >  
> 
> Hi Thomas,
> 
> > s/PCI/PCIe/ ?
> >   
> 
> In this context maybe it doesn't really matter,
> but if I'll send a v2 I'll make the change, sure.
> 
> >> (on QEMU we have X86 and ARM), it does not make sense to
> >> have if in other archs.

If you do a v2 anyway, s/if/it/

> >>
> >> Reported-by: Thomas Huth <thuth@redhat.com>
> >> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
> >> ---
> >>   default-configs/arm-softmmu.mak    | 1 +
> >>   default-configs/i386-softmmu.mak   | 1 +
> >>   default-configs/x86_64-softmmu.mak | 1 +
> >>   hw/pci-bridge/Makefile.objs        | 3 ++-
> >>   4 files changed, 5 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> >> index 5059d134c8..33934b1dc4 100644
> >> --- a/default-configs/arm-softmmu.mak
> >> +++ b/default-configs/arm-softmmu.mak
> >> @@ -122,6 +122,7 @@ CONFIG_FSL_IMX25=y
> >>   CONFIG_IMX_I2C=y
> >>   
> >>   CONFIG_PCIE_PORT=y
> >> +CONFIG_PCIE_PCI_BRIDGE=y  
> > 
> > Actually, why not simply use CONFIG_PCIE_PORT instead to determine
> > whether the PCIe-to-PCI bridge should be included? The device only makes
> > sense if there is a PCIe root port available on the system...
> >   
> 
> I thought about it, but then we should also change all the devices
> that makes sense only if connected to PCIe Root Ports, like Intel
> Upstream Ports (Switches) and maybe more. (otherwise people will
> start asking why it is different.)
> 
> We could use CONFIG_PCIE_PCI_BRIDGE=CONFIG_PCIE_PORT or something
> but it looks weird.

I actually like that one.

> 
> This is why I've chosen the "independent" config option.
> But, to be fair, I have nothing against your suggestion,
> let's see what others think.
> 
> Thanks for the review,
> Marcel
> 
> >   Thomas
> >   
> 
