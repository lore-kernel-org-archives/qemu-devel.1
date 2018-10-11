Received: from eggs.gnu.org ([2001:4830:134:3::10]:58942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gAZPL-000677-VI
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:45:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gAZPH-00012o-Ty
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:45:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1gAZPG-00010l-7E
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:45:30 -0400
Date: Thu, 11 Oct 2018 12:45:22 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20181011114522.GB8125@redhat.com>
References: <cover.1538683492.git.alistair.francis@wdc.com>
	<5dd21056229d12a1af8d65e9208f4de43ba4a2ae.camel@redhat.com>
	<892d54c5-2851-74ec-bdf2-286c1665c44f@gmail.com>
	<7d54ec114745b00b82601875416ccfe6a5f9fe6f.camel@redhat.com>
	<20181011080114.GS27120@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011080114.GS27120@redhat.com>
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

On Thu, Oct 11, 2018 at 09:01:14AM +0100, Richard W.M. Jones wrote:
> Here are the settings we currently do NOT have in my RV kernel:
> 
> CONFIG_HOTPLUG_PCI_PCIE=y
> CONFIG_HOTPLUG_PCI=y
> CONFIG_MEDIA_PCI_SUPPORT=y
> CONFIG_PCI_ATS=y
> CONFIG_PCI_DEBUG=y
> CONFIG_PCIEAER=y
> CONFIG_PCIEASPM_DEFAULT=y
> CONFIG_PCIEASPM=y
> CONFIG_PCI_ECAM=y
> CONFIG_PCIE_MICROSEMI=y
> CONFIG_PCI_ENDPOINT=y
> CONFIG_PCIEPORTBUS=y
> CONFIG_PCI_HOST_COMMON=y
> CONFIG_PCI_HOST_GENERIC=y
> CONFIG_PCI_IOV=y
> CONFIG_PCI_PASID=y
> CONFIG_PCI_PRI=y
> CONFIG_PCI_SW_SWITCHTEC=y
> CONFIG_USB_BDC_PCI=y
> 
> If you're happy with it, I can add all of those.  If there are any
> which shouldn't be added let me know.

I didn't see an answer but in any case I have tried to enable all of
these.  The only settings which could not be enabled were:

CONFIG_MEDIA_PCI_SUPPORT=y
CONFIG_PCI_ECAM=y
CONFIG_PCI_HOST_COMMON=y
CONFIG_PCI_HOST_GENERIC=y
CONFIG_USB_BDC_PCI=y

Probably missing deps or missing arch support.  I didn't track them
down yet, but note I'm still using kernel 4.15.

  https://github.com/rwmjones/fedora-riscv-kernel/commits/master

In any case a new kernel/bbl has been built, available in the usual
place:

  https://fedorapeople.org/groups/risc-v/disk-images/

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html
