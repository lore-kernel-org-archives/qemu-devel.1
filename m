Received: from eggs.gnu.org ([2001:4830:134:3::10]:46005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eQ2us-0000uY-LU
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 22:13:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eQ2un-00016W-Mk
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 22:13:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eQ2un-00015L-Fx
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 22:13:29 -0500
Date: Sat, 16 Dec 2017 11:13:21 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171216031321.GR7780@xz-mi>
References: <20171210063819.14892-1-peterx@redhat.com>
	<20171210063819.14892-4-peterx@redhat.com>
	<d2582a0b-be52-37ea-b0d3-16215acae5cf@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d2582a0b-be52-37ea-b0d3-16215acae5cf@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/5] i8259: generalize statistics into
 common code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On Fri, Dec 15, 2017 at 08:28:07AM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:

[...]

> > diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_i=
nternal.h
> > index 6954b6ec5f..f742c2a726 100644
> > --- a/include/hw/isa/i8259_internal.h
> > +++ b/include/hw/isa/i8259_internal.h
> > @@ -28,6 +28,7 @@
> >  #include "hw/hw.h"
> >  #include "hw/i386/pc.h"
> >  #include "hw/isa/isa.h"
> > +#include "hw/intc/intc.h"
> > =20
> >  typedef struct PICCommonState PICCommonState;
> > =20
> > @@ -76,8 +77,10 @@ struct PICCommonState {
> >  };
> > =20
> >  void pic_reset_common(PICCommonState *s);
> > -
> >  ISADevice *i8259_init_chip(const char *name, ISABus *bus, bool maste=
r);
> > -
> > +void pic_stat_update_irq(int irq, int level);
> > +bool pic_get_statistics(InterruptStatsProvider *obj,
> > +                        uint64_t **irq_counts, unsigned int *nb_irqs=
);
> > +void pic_print_info(InterruptStatsProvider *obj, Monitor *mon);
>=20
> can you rename pic -> i8259?
>=20
> i8259_get_statistics() or i8259pic_get_statistics()

Yes I can.

But AFAICT it does not really matter now since at least we are still
mostly using pic_* in intc/i8259.c and kvm_pic_* in kvm/i8259.c for
namings.  So IMHO it's even more consistent to still use pci_* prefix
for them.

We can have another single patch to convert all of them to i8259
prefix if you wish to, as a work upon.

Just let me know if you still insist. :-)

Thanks for reviewing!

--=20
Peter Xu
