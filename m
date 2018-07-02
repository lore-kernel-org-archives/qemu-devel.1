Received: from eggs.gnu.org ([2001:4830:134:3::10]:33724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fa15h-0002Pg-GC
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:50:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fa15e-0001qp-CR
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:50:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fa15e-0001o7-7I
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:50:10 -0400
Date: Mon, 2 Jul 2018 17:50:07 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180702155006.2zcmoejbrosmakbh@sirius.home.kraxel.org>
References: <20180702145513.11481-1-kraxel@redhat.com>
	<20180702145513.11481-3-kraxel@redhat.com>
	<e83c7cab-3f87-5ff8-76b6-c7928437e9ed@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <e83c7cab-3f87-5ff8-76b6-c7928437e9ed@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] audio: add audio timer trace points
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org

On Mon, Jul 02, 2018 at 12:25:37PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Hi Gerd,
>=20
> On 07/02/2018 11:55 AM, Gerd Hoffmann wrote:
> > Track audio timer starts and stops.  Also trace delayed audio timer c=
alls.
> >=20
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  audio/audio.c      | 28 +++++++++++++++++++++++++---
> >  audio/trace-events |  5 +++++
> >  2 files changed, 30 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/audio/audio.c b/audio/audio.c
> > index d6e91901aa..d055b2236c 100644
> > --- a/audio/audio.c
> > +++ b/audio/audio.c
> > @@ -29,6 +29,7 @@
> >  #include "sysemu/sysemu.h"
> >  #include "qemu/cutils.h"
> >  #include "sysemu/replay.h"
> > +#include "audio/trace.h"
>=20
> Can you simply use "trace.h" like in the rest of the codebase?

Why?  I need the audio trace points only, and including only those
avoids object rebuilds in case some unrelated trace points are updated.

I'm pretty sure this is the reason we have splitted files now instead of
one huge trace.h

> > +            trace_audio_timer_start(conf.period.ticks / 1000000);
>=20
> Can you use SCALE_MS?

Will do.

cheers,
  Gerd
