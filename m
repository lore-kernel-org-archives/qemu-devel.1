Received: from eggs.gnu.org ([209.51.188.92]:41871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gi0vL-000391-4j
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 12:48:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gi0vK-00082J-Ae
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 12:48:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gi0vK-00081r-2F
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 12:48:50 -0500
Date: Fri, 11 Jan 2019 12:48:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190111124742-mutt-send-email-mst@kernel.org>
References: <20190111131836.107549-1-sgarzare@redhat.com>
	<20190111131836.107549-3-sgarzare@redhat.com>
	<20190111162649.GC14776@stefanha-x1.localdomain>
	<CAGxU2F6mpxE7-xw1LWS3Q6R+NSPMnkrqo8mdhhgn-SfARN3XKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAGxU2F6mpxE7-xw1LWS3Q6R+NSPMnkrqo8mdhhgn-SfARN3XKQ@mail.gmail.com>
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
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, George Kennedy <george.kennedy@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Maran Wilson <maran.wilson@oracle.com>, Richard Henderson <rth@twiddle.net>

On Fri, Jan 11, 2019 at 06:42:25PM +0100, Stefano Garzarella wrote:
> On Fri, Jan 11, 2019 at 5:27 PM Stefan Hajnoczi <stefanha@gmail.com> wr=
ote:
> >
> > On Fri, Jan 11, 2019 at 02:18:34PM +0100, Stefano Garzarella wrote:
> > > In order to allow other option roms to use these common
> > > useful functions and definitions, this patch put them
> > > in a new C header file called optrom.h, and also add
> > > useful out*() in*() functions for different size.
> >
> > It's usually helpful to modify code in a one patch and move it in a
> > separate patch.  This patch does both, so it's a harder to review.
> > Don't worry about changing it now, but something to try in the future=
.
>=20
> Thanks for the tip!
>=20
> >
> > > +#include <stdint.h>
> > > +#include "optrom.h"
> > > +#include "optrom_fw_cfg.h"
> >
> > Can these be moved to the top of the file like a regular C source fil=
e?
>=20
> Yes, I'll move them to the top.
>=20
> >
> > > diff --git a/pc-bios/optionrom/optrom.h b/pc-bios/optionrom/optrom.=
h
> > > new file mode 100644
> > > index 0000000000..36f43b43fd
> > > --- /dev/null
> > > +++ b/pc-bios/optionrom/optrom.h
> > > @@ -0,0 +1,109 @@
> > > +/*
> > > + * Common Option ROM Functions for C code
> > > + *
> > > + * This program is free software; you can redistribute it and/or m=
odify
> > > + * it under the terms of the GNU General Public License as publish=
ed by
> > > + * the Free Software Foundation; either version 2 of the License, =
or
> > > + * (at your option) any later version.
> > > + *
> > > + * This program is distributed in the hope that it will be useful,
> > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> > > + * GNU General Public License for more details.
> > > + *
> > > + * You should have received a copy of the GNU General Public Licen=
se
> > > + * along with this program; if not, see <http://www.gnu.org/licens=
es/>.
> > > + *
> > > + * Copyright (c) 2015-2019 Red Hat Inc.
> > > + *   Authors:
> > > + *     Marc Mar=ED <marc.mari.barcelo@gmail.com>
> > > + *     Richard W.M. Jones <rjones@redhat.com>
> > > + *     Stefano Garzarella <sgarzare@redhat.com>
> > > + */
> > > +
> > > +#ifndef OPTROM_H
> > > +#define OPTROM_H
> > > +
> > > +#include "../../include/standard-headers/linux/qemu_fw_cfg.h"
> >
> > This depends on <stdint.h>, please include it first.
>=20
> Sure.
>=20
>=20
> Thanks,
> Stefano

Better to just pull in qemu/osdep.h

>=20
> --=20
> Stefano Garzarella
> Red Hat
