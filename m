Received: from eggs.gnu.org ([2001:4830:134:3::10]:53409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1coW8h-0000Dp-Hw
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:12:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1coW8d-00069x-Io
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:12:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1coW8d-000695-Dj
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:12:23 -0400
Message-ID: <1489673540.15659.93.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 16 Mar 2017 15:12:20 +0100
In-Reply-To: <CAFEAcA8ZBAAqYNbh_3J69W5SMXRsbW4S367Xe8ceF1C0M-RNnA@mail.gmail.com>
References: <20170316120110.11677-1-iwona260909@gmail.com>
	<20170316120110.11677-2-iwona260909@gmail.com>
	<CAFEAcA8ZBAAqYNbh_3J69W5SMXRsbW4S367Xe8ceF1C0M-RNnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] Dead code removal: removing code for
 unsupported DEPTH.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: iwona260909@gmail.com, QEMU Developers <qemu-devel@nongnu.org>

  Hi,

> > -#define DEPTH 8
> > -#include "cirrus_vga_rop2.h"
> > -
> > -#define DEPTH 16
> > -#include "cirrus_vga_rop2.h"
> > -
> > -#define DEPTH 24
> > -#include "cirrus_vga_rop2.h"
> > -
> >  #define DEPTH 32
> >  #include "cirrus_vga_rop2.h"

No.  It isn't *that* simple.  The cirrus blitter operates on the guest
framebuffer, which can have any format the guest wishes it to have.
This is *not* about rendering into a 32bpp DisplaySurface.

cheers,
  Gerd
