Received: from eggs.gnu.org ([2001:4830:134:3::10]:56406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gAVp3-0006lz-A8
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 03:55:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gAVp0-0004RQ-4i
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 03:55:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1gAVoz-0004Qo-RR
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 03:55:50 -0400
Date: Thu, 11 Oct 2018 08:55:44 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20181011075544.GR27120@redhat.com>
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
> > On 10/10/2018 05:26 AM, Andrea Bolognani wrote:
> > > * what should libvirt look for to figure out whether or not a RISC-V
> > >    guest will have PCI support? For aarch64 we look for the presence
> > >    of the 'gpex-pcihost' device, but of course that won't work for
> > >    RISC-V so we need something else;
> > 
> > I'm not sure what you mean here. Why can we not do the same thing with 
> > RISC-V?
> 
> The gpex-pcihost device was introduced at the same time as
> aarch64/virt gained PCI support, so we can probe the binary[1] and,
> if the device is present, we know that aarch64/virt guests will be
> able to use PCI. We cannot do the same for RISC-V for obvious
> reasons: the device is already there :)
> 
> Is there any RISC-V device / property that was introduced along
> with PCI support and we can use as a witness?

Can we ignore non-PCIe guests?  virtio-mmio should die.

Also if we ever get to the stage where (real) RISC-V servers are
shipping that don't have PCIe, then I'm afraid I will have lost a
critical battle :-( Non-PCI might be OK for tiny embedded stuff, but
for proper machines - real and virtual - we should require PCIe.

> > > * I have succesfully started a RISC-V guest with virtio-pci devices
> > >    attached but, while they show up in 'info qtree' and friends, the
> > >    guest OS itself doesn't seem to recognize any of them - not even
> > >    pcie.0! I'm using the guest images listed at [1] and following the
> > >    corresponding instructions, but I think the BBL build (config at
> > >    [2]) is missing some feature... Any ideas what we would need to
> > >    add there?
> > 
> > I use this monolithic config: 
> > https://github.com/alistair23/meta-riscv/blob/7a950aa705b439b5ec19bb6f094930888335ba7b/recipes-kernel/linux/files/freedom-u540/defconfig
> > 
> > It has way too much enabled, but I think if you copy the PCIe part that 
> > should be enough.
> 
> Looks like there's quite a few CONFIG*PCI* options we're missing!
> 
> Rich, can you try incorporating those and kicking off a BBL build?
> If I remember correctly you might also have to backport a commit or
> two to make some of the options available on RISC-V, but it should
> be very feasible.

I'll have a look.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html
