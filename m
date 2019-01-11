Received: from eggs.gnu.org ([209.51.188.92]:40789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gi0pL-0001dY-S5
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 12:42:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gi0pK-00057H-VM
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 12:42:39 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40780)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gi0pK-00056n-Qp
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 12:42:38 -0500
Received: by mail-oi1-f195.google.com with SMTP id t204so12843509oie.7
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 09:42:37 -0800 (PST)
MIME-Version: 1.0
References: <20190111131836.107549-1-sgarzare@redhat.com>
	<20190111131836.107549-3-sgarzare@redhat.com>
	<20190111162649.GC14776@stefanha-x1.localdomain>
In-Reply-To: <20190111162649.GC14776@stefanha-x1.localdomain>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri, 11 Jan 2019 18:42:25 +0100
Message-ID: <CAGxU2F6mpxE7-xw1LWS3Q6R+NSPMnkrqo8mdhhgn-SfARN3XKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/4] linuxboot_dma: move common functions
 in a new header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, George Kennedy <george.kennedy@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Maran Wilson <maran.wilson@oracle.com>, Richard Henderson <rth@twiddle.net>

On Fri, Jan 11, 2019 at 5:27 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Fri, Jan 11, 2019 at 02:18:34PM +0100, Stefano Garzarella wrote:
> > In order to allow other option roms to use these common
> > useful functions and definitions, this patch put them
> > in a new C header file called optrom.h, and also add
> > useful out*() in*() functions for different size.
>
> It's usually helpful to modify code in a one patch and move it in a
> separate patch.  This patch does both, so it's a harder to review.
> Don't worry about changing it now, but something to try in the future.

Thanks for the tip!

>
> > +#include <stdint.h>
> > +#include "optrom.h"
> > +#include "optrom_fw_cfg.h"
>
> Can these be moved to the top of the file like a regular C source file?

Yes, I'll move them to the top.

>
> > diff --git a/pc-bios/optionrom/optrom.h b/pc-bios/optionrom/optrom.h
> > new file mode 100644
> > index 0000000000..36f43b43fd
> > --- /dev/null
> > +++ b/pc-bios/optionrom/optrom.h
> > @@ -0,0 +1,109 @@
> > +/*
> > + * Common Option ROM Functions for C code
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License as published b=
y
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, see <http://www.gnu.org/licenses/>=
.
> > + *
> > + * Copyright (c) 2015-2019 Red Hat Inc.
> > + *   Authors:
> > + *     Marc Mar=C3=AD <marc.mari.barcelo@gmail.com>
> > + *     Richard W.M. Jones <rjones@redhat.com>
> > + *     Stefano Garzarella <sgarzare@redhat.com>
> > + */
> > +
> > +#ifndef OPTROM_H
> > +#define OPTROM_H
> > +
> > +#include "../../include/standard-headers/linux/qemu_fw_cfg.h"
>
> This depends on <stdint.h>, please include it first.

Sure.


Thanks,
Stefano


--=20
Stefano Garzarella
Red Hat
