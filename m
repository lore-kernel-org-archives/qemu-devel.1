Received: from eggs.gnu.org ([2001:4830:134:3::10]:54992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dZK2e-0007JA-Cz
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 12:47:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dZK2d-0004Gl-9w
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 12:47:40 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:33113)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dZK2d-0004GR-0y
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 12:47:39 -0400
Received: by mail-pf0-x241.google.com with SMTP id k72so5313726pfj.0
	for <qemu-devel@nongnu.org>; Sun, 23 Jul 2017 09:47:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170723163033.GB28883@morn.lan>
References: <1500761510-1556-1-git-send-email-zuban32s@gmail.com>
	<1500761510-1556-4-git-send-email-zuban32s@gmail.com>
	<20170723163033.GB28883@morn.lan>
From: Alexander Bezzubikov <zuban32s@gmail.com>
Date: Sun, 23 Jul 2017 19:47:37 +0300
Message-ID: <CAKSfGUDG2xMiSjO=h8Z8PgyJ7FfCV63ZbfgKCDt9XYP6h6hadQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH v2 3/4] pci: add QEMU-specific PCI
 capability structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin O'Connor <kevin@koconnor.net>
Cc: seabios@seabios.org, Marcel Apfelbaum <marcel@redhat.com>, kraxel@redhat.com, lersek@redhat.com, qemu-devel@nongnu.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>

2017-07-23 19:30 GMT+03:00 Kevin O'Connor <kevin@koconnor.net>:

> On Sun, Jul 23, 2017 at 01:11:49AM +0300, Aleksandr Bezzubikov wrote:
> > On PCI init PCI bridge devices may need some
> > extra info about bus number to reserve, IO, memory and
> > prefetchable memory limits. QEMU can provide this
> > with special vendor-specific PCI capability.
> >
> > This capability is intended to be used only
> > for Red Hat PCI bridges, i.e. QEMU cooperation.
> >
> > Sizes of limits match ones from
> > PCI Type 1 Configuration Space Header,
> > number of buses to reserve occupies only 1 byte
> > since it is the size of Subordinate Bus Number register.
> >
> > Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
> > ---
> >  src/hw/pci_cap.h | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >  create mode 100644 src/hw/pci_cap.h
> >
> > diff --git a/src/hw/pci_cap.h b/src/hw/pci_cap.h
> > new file mode 100644
> > index 0000000..1382b0b
> > --- /dev/null
> > +++ b/src/hw/pci_cap.h
> > @@ -0,0 +1,23 @@
> > +#ifndef _PCI_CAP_H
> > +#define _PCI_CAP_H
> > +
> > +#include "types.h"
> > +
> > +struct vendor_pci_cap {
> > +    u8 id;
> > +    u8 next;
> > +    u8 len;
> > +};
>
> Thanks.

Thanks for the review.


> If you respin this series, please add this header to the
> src/fw/ directory instead of src/hw/.  Also, I'd prefer to avoid a
> "pci_" prefix on the header as it makes it seem similar to the
> existing pci_regs.h and pci_ids.h headers which are a bit different -
> how about src/fw/dev-pci.h instead?
>
> -Kevin
>

No objections, Will do that in v3.
Except 'pci_' prefix - it's still a PCI capability, isn't it?


-- 
Alexander Bezzubikov
