Received: from eggs.gnu.org ([209.51.188.92]:48444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gmQYz-0001xE-N3
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 17:00:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gmQYy-0000F6-PH
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 17:00:01 -0500
MIME-Version: 1.0
References: <20190123065618.3520-1-yang.zhong@intel.com>
	<20190123065618.3520-15-yang.zhong@intel.com>
	<dcd4155e-0278-4fed-6808-84ed89bed65a@redhat.com>
In-Reply-To: <dcd4155e-0278-4fed-6808-84ed89bed65a@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 23 Jan 2019 13:59:30 -0800
Message-ID: <CAKmqyKNkAqqYhCCkzB_zZopG_KgZ6OjwVjWtWyxZTvPMMqqPPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH v4 14/44] hw/riscv/Makefile.objs:
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
Cc: Yang Zhong <yang.zhong@intel.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Paolo Bonzini <pbonzini@redhat.com>, sameo@linux.intel.com

On Wed, Jan 23, 2019 at 8:12 AM Thomas Huth <thuth@redhat.com> wrote:
>
> On 2019-01-23 07:55, Yang Zhong wrote:
> > Add the new configs to default-configs/riscv*-sofmmu.mak.
> >
> > Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> > ---
> >  default-configs/riscv32-softmmu.mak |  7 +++++++
> >  default-configs/riscv64-softmmu.mak |  7 +++++++
> >  hw/riscv/Makefile.objs              | 22 +++++++++++-----------
> >  3 files changed, 25 insertions(+), 11 deletions(-)
> >
> > diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-softmmu.mak
> > index fbfd1d4e4b..65337166e1 100644
> > --- a/default-configs/riscv32-softmmu.mak
> > +++ b/default-configs/riscv32-softmmu.mak
> > @@ -12,3 +12,10 @@ CONFIG_PCI_EXPRESS_GENERIC_BRIDGE=y
> >
> >  CONFIG_VGA=y
> >  CONFIG_VGA_PCI=y
> > +
> > +CONFIG_SPIKE=y
> > +CONFIG_HART=y
> > +CONFIG_SIFIVE_E=y
> > +CONFIG_SIFIVE=y
> > +CONFIG_SIFIVE_U=y
> > +CONFIG_RISCV_VIRT=y
> > diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-softmmu.mak
> > index fbfd1d4e4b..65337166e1 100644
> > --- a/default-configs/riscv64-softmmu.mak
> > +++ b/default-configs/riscv64-softmmu.mak
> > @@ -12,3 +12,10 @@ CONFIG_PCI_EXPRESS_GENERIC_BRIDGE=y
> >
> >  CONFIG_VGA=y
> >  CONFIG_VGA_PCI=y
> > +
> > +CONFIG_SPIKE=y
> > +CONFIG_HART=y
> > +CONFIG_SIFIVE_E=y
> > +CONFIG_SIFIVE=y
> > +CONFIG_SIFIVE_U=y
> > +CONFIG_RISCV_VIRT=y
> > diff --git a/hw/riscv/Makefile.objs b/hw/riscv/Makefile.objs
> > index 1dde01d39d..79bfb3abf9 100644
> > --- a/hw/riscv/Makefile.objs
> > +++ b/hw/riscv/Makefile.objs
> > @@ -1,11 +1,11 @@
> > -obj-y += riscv_htif.o
> > -obj-y += riscv_hart.o
> > -obj-y += sifive_e.o
> > -obj-y += sifive_clint.o
> > -obj-y += sifive_prci.o
> > -obj-y += sifive_plic.o
> > -obj-y += sifive_test.o
> > -obj-y += sifive_u.o
> > -obj-y += sifive_uart.o
> > -obj-y += spike.o
> > -obj-y += virt.o
> > +obj-$(CONFIG_SPIKE) += riscv_htif.o
> > +obj-$(CONFIG_HART) += riscv_hart.o
> > +obj-$(CONFIG_SIFIVE_E) += sifive_e.o
> > +obj-$(CONFIG_SIFIVE) += sifive_clint.o
> > +obj-$(CONFIG_SIFIVE) += sifive_prci.o
> > +obj-$(CONFIG_SIFIVE) += sifive_plic.o
> > +obj-$(CONFIG_SIFIVE) += sifive_test.o
> > +obj-$(CONFIG_SIFIVE_U) += sifive_u.o
> > +obj-$(CONFIG_SIFIVE) += sifive_uart.o
> > +obj-$(CONFIG_SPIKE) += spike.o
> > +obj-$(CONFIG_RISCV_VIRT) += virt.o
>
> Looks reasonable to me, so I dare to say:
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
> ... but I'm not an expert here, I hope some of the RISC-V maintainers
> could chime in?

Looks right to me

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
