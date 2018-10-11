Received: from eggs.gnu.org ([2001:4830:134:3::10]:57802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gAVuY-0000pO-JI
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 04:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gAVuR-0007op-4x
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 04:01:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1gAVuJ-0007hN-8i
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 04:01:21 -0400
Date: Thu, 11 Oct 2018 09:01:14 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20181011080114.GS27120@redhat.com>
References: <cover.1538683492.git.alistair.francis@wdc.com>
	<5dd21056229d12a1af8d65e9208f4de43ba4a2ae.camel@redhat.com>
	<892d54c5-2851-74ec-bdf2-286c1665c44f@gmail.com>
	<7d54ec114745b00b82601875416ccfe6a5f9fe6f.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d54ec114745b00b82601875416ccfe6a5f9fe6f.camel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 0/5] Connect a PCIe host and graphics
 support to RISC-V
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: Alistair <alistair23@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mjc@sifive.com" <mjc@sifive.com>, "palmer@sifive.com" <palmer@sifive.com>, "stephen@eideticom.com" <stephen@eideticom.com>

On Thu, Oct 11, 2018 at 07:59:59AM +0200, Andrea Bolognani wrote:
> On Wed, 2018-10-10 at 10:57 -0700, Alistair wrote:
> > I use this monolithic config: 
> > https://github.com/alistair23/meta-riscv/blob/7a950aa705b439b5ec19bb6f094930888335ba7b/recipes-kernel/linux/files/freedom-u540/defconfig
> > 
> > It has way too much enabled, but I think if you copy the PCIe part that 
> > should be enough.
> 
> Looks like there's quite a few CONFIG*PCI* options we're missing!

PCI settings in this file:

CONFIG_BLK_MQ_PCI=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_HOTPLUG_PCI=y
CONFIG_MEDIA_PCI_SUPPORT=y
CONFIG_PCI_ATS=y
CONFIG_PCI_BUS_ADDR_T_64BIT=y
CONFIG_PCI_DEBUG=y
CONFIG_PCI_DMA_32=y
CONFIG_PCI_DOMAINS_GENERIC=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEAER=y
CONFIG_PCIEASPM_DEFAULT=y
CONFIG_PCIEASPM=y
CONFIG_PCI_ECAM=y
CONFIG_PCIE_MICROSEMI=y
CONFIG_PCI_ENDPOINT=y
CONFIG_PCIEPORTBUS=y
CONFIG_PCIE_XILINX=y
CONFIG_PCI_HOST_COMMON=y
CONFIG_PCI_HOST_GENERIC=y
CONFIG_PCI_IOV=y
CONFIG_PCI_MSI=y
CONFIG_PCI_PASID=y
CONFIG_PCI_PRI=y
CONFIG_PCI_QUIRKS=y
CONFIG_PCI_SW_SWITCHTEC=y
CONFIG_PCI=y
CONFIG_USB_BDC_PCI=y
CONFIG_USB_EHCI_PCI=y
CONFIG_USB_OHCI_HCD_PCI=y
CONFIG_USB_PCI=y
CONFIG_USB_XHCI_PCI=y

Here are the settings we currently do NOT have in my RV kernel:

CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_HOTPLUG_PCI=y
CONFIG_MEDIA_PCI_SUPPORT=y
CONFIG_PCI_ATS=y
CONFIG_PCI_DEBUG=y
CONFIG_PCIEAER=y
CONFIG_PCIEASPM_DEFAULT=y
CONFIG_PCIEASPM=y
CONFIG_PCI_ECAM=y
CONFIG_PCIE_MICROSEMI=y
CONFIG_PCI_ENDPOINT=y
CONFIG_PCIEPORTBUS=y
CONFIG_PCI_HOST_COMMON=y
CONFIG_PCI_HOST_GENERIC=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PASID=y
CONFIG_PCI_PRI=y
CONFIG_PCI_SW_SWITCHTEC=y
CONFIG_USB_BDC_PCI=y

If you're happy with it, I can add all of those.  If there are any
which shouldn't be added let me know.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top
