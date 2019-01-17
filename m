Received: from eggs.gnu.org ([209.51.188.92]:43470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gk6xv-0002VH-0f
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:40:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gk6xu-0000hJ-6k
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:40:10 -0500
Received: from mga04.intel.com ([192.55.52.120]:44570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gk6xt-0000Zs-Ja
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:40:10 -0500
Date: Thu, 17 Jan 2019 20:36:26 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20190117123626.GI11760@yangzhon-Virtual>
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-14-yang.zhong@intel.com>
	<a7abd300-9898-45cd-5e3d-9a8c79374ac7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7abd300-9898-45cd-5e3d-9a8c79374ac7@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 13/37] hw/riscv/Makefile.objs:
 Create CONFIG_* for riscv boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, sameo@linux.intel.com, =?iso-8859-1?Q?=E1kos_Kov=E1cs?= <akoskovacs@gmx.com>, pbonzini@redhat.com, ehabkost@redhat.com, Yang Zhong <yang.zhong@intel.com>

On Wed, Jan 16, 2019 at 10:46:45AM +0100, Thomas Huth wrote:
> > +obj-$(CONFIG_HTIF) += riscv_htif.o
> 
> riscv_htif.o seems to belong to the spike machine, so I think you don't
> need a separate config switch for that and could simply use CONFIG_SPIKE
> here.
> 
> > +obj-$(CONFIG_HART) += riscv_hart.o
> > +obj-$(CONFIG_SIFIVE) += sifive_e.o
> > +obj-$(CONFIG_SIFIVE) += sifive_clint.o
> > +obj-$(CONFIG_SIFIVE) += sifive_prci.o
> > +obj-$(CONFIG_SIFIVE) += sifive_plic.o
> > +obj-$(CONFIG_SIFIVE) += sifive_test.o
> > +obj-$(CONFIG_SIFIVE) += sifive_u.o
> 
> Looking at the output of "qemu-system-riscv64 -M help", sifive_e and
> sifive_u are two separate machines. So should we use two different
> config switches here?
> 
> > +obj-$(CONFIG_SIFIVE) += sifive_uart.o
> > +obj-$(CONFIG_SPIKE) += spike.o
> > +obj-$(CONFIG_RISCV_VIRTIO) += virt.o
> 
> The machine is only called "virt", so I'd suggest to call the config
> switch CONFIG_RISCV_VIRT only.
> 
>  Thomas

   Hello Thomas,

   Thanks, i did below changes

   +obj-$(CONFIG_SPIKE) += riscv_htif.o
   +obj-$(CONFIG_HART) += riscv_hart.o
   +obj-$(CONFIG_SIFIVE_E) += sifive_e.o
   +obj-$(CONFIG_SIFIVE) += sifive_clint.o
   +obj-$(CONFIG_SIFIVE) += sifive_prci.o
   +obj-$(CONFIG_SIFIVE) += sifive_plic.o
   +obj-$(CONFIG_SIFIVE) += sifive_test.o
   +obj-$(CONFIG_SIFIVE_U) += sifive_u.o
   +obj-$(CONFIG_SIFIVE) += sifive_uart.o
   +obj-$(CONFIG_SPIKE) += spike.o
   +obj-$(CONFIG_RISCV_VIRT) += virt.o

   Regards,

   Yang
