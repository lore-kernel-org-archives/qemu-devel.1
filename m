Received: from eggs.gnu.org ([2001:4830:134:3::10]:35637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fa1CQ-0007aP-RK
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:57:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fa1CM-00072Q-Uh
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:57:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42038 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fa1CM-00071x-P9
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:57:06 -0400
Date: Mon, 2 Jul 2018 16:57:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180702155701.GD6438@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180702145513.11481-1-kraxel@redhat.com>
	<20180702145513.11481-3-kraxel@redhat.com>
	<e83c7cab-3f87-5ff8-76b6-c7928437e9ed@amsat.org>
	<20180702155006.2zcmoejbrosmakbh@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180702155006.2zcmoejbrosmakbh@sirius.home.kraxel.org>
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

On Mon, Jul 02, 2018 at 05:50:07PM +0200, Gerd Hoffmann wrote:
> On Mon, Jul 02, 2018 at 12:25:37PM -0300, Philippe Mathieu-Daud=C3=A9 w=
rote:
> > Hi Gerd,
> >=20
> > On 07/02/2018 11:55 AM, Gerd Hoffmann wrote:
> > > Track audio timer starts and stops.  Also trace delayed audio timer=
 calls.
> > >=20
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > > ---
> > >  audio/audio.c      | 28 +++++++++++++++++++++++++---
> > >  audio/trace-events |  5 +++++
> > >  2 files changed, 30 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/audio/audio.c b/audio/audio.c
> > > index d6e91901aa..d055b2236c 100644
> > > --- a/audio/audio.c
> > > +++ b/audio/audio.c
> > > @@ -29,6 +29,7 @@
> > >  #include "sysemu/sysemu.h"
> > >  #include "qemu/cutils.h"
> > >  #include "sysemu/replay.h"
> > > +#include "audio/trace.h"
> >=20
> > Can you simply use "trace.h" like in the rest of the codebase?
>=20
> Why?  I need the audio trace points only, and including only those
> avoids object rebuilds in case some unrelated trace points are updated.

There is no global 'trace.h' any more - an unqualified  #include "trace.h=
"
will resolve to the local build directory first, so still pull in the sam=
e
audio/trace.h

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
