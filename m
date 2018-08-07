Received: from eggs.gnu.org ([2001:4830:134:3::10]:42800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fmxc0-0002hV-Ak
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 04:45:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fmxbz-0001Ew-FM
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 04:45:04 -0400
Date: Tue, 7 Aug 2018 10:44:51 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180807084451.fxwlvwxfk3tdtm2k@sirius.home.kraxel.org>
References: <20180627232951.14725-1-laurent@vivier.eu>
	<20180627232951.14725-5-laurent@vivier.eu>
	<8d1c30eb-1dc7-4ea9-08ea-660991044e5c@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d1c30eb-1dc7-4ea9-08ea-660991044e5c@tuxfamily.org>
Subject: Re: [Qemu-devel] [RFC v3 04/10] hw/m68k: add video card
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <huth@tuxfamily.org>
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Aurelien Jarno <aurelien@aurel32.net>

> > +#define WRITE_BITS 8
> > +#include "macfb-template.h"
> > +
> > +#define WRITE_BITS 16
> > +#include "macfb-template.h"
> > +
> > +#define WRITE_BITS 24
> > +#include "macfb-template.h"
> > +
> > +#define WRITE_BITS 32
> > +#include "macfb-template.h"
> 
> Not sure, but do we still need all these "destination" bit depth
> nowadays? I thought QEMU only supports 32 bit depths these days?

Well, qemu UI code can handle non-32 bit depths too (pretty much
anything pixman supports to be exact).

But, yes, qemu hands out 32bit DisplaySurfaces by default, i.e. when
using qemu_console_resize() or qemu_create_displaysurface() in display
device emulation.

You can ask for something else, using qemu_create_displaysurface_from(),
which is typically used in case the backing storage for the
DisplaySurface is guest memory, to avoid copying/converting display
data.  The code above probably doesn't look like it is doing that though.

HTH,
  Gerd
