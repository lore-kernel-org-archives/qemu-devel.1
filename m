Received: from eggs.gnu.org ([2001:4830:134:3::10]:46367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQqOZ-0001Np-0n
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:35:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQqOU-0000CH-50
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:35:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49210 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fQqOT-0000C1-Uq
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:35:42 -0400
Date: Thu, 7 Jun 2018 16:35:31 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180607083531.GG750@xz-mi>
References: <20180606173233.28080-1-berrange@redhat.com>
	<20180606173233.28080-4-berrange@redhat.com>
	<CAFEAcA-_e7mMB07fOCN6qmm-9YTPG2HSMJ3-z=0wRHaa+uTteA@mail.gmail.com>
	<20180607035805.GH7815@xz-mi> <878t7r3wlj.fsf@dusky.pond.sub.org>
	<20180607074456.GC750@xz-mi> <20180607082651.GC28827@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180607082651.GC28827@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/3] util: remove redundant include of
 glib.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Olaf Hering <olaf@aepfle.de>, Stefan Berger <stefanb@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Jun 07, 2018 at 09:26:51AM +0100, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Jun 07, 2018 at 03:44:56PM +0800, Peter Xu wrote:
> > On Thu, Jun 07, 2018 at 09:05:28AM +0200, Markus Armbruster wrote:
> > > Peter Xu <peterx@redhat.com> writes:
> > >=20
> > > > On Wed, Jun 06, 2018 at 07:31:53PM +0100, Peter Maydell wrote:
> > > >> On 6 June 2018 at 18:32, Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
> > > >> > Code must only ever include glib.h indirectly via the glib-com=
pat.h
> > > >> > header file, because we will need some macros set before glib.=
h is
> > > >> > pulled in. Adding extra includes of glib.h will (soon) cause c=
ompile
> > > >> > failures such as:
> > > >> >
> > > >> > In file included from /home/berrange/src/virt/qemu/include/qem=
u/osdep.h:107,
> > > >> >                  from /home/berrange/src/virt/qemu/include/qem=
u/iova-tree.h:26,
> > > >> >                  from util/iova-tree.c:13:
> > > >> > /home/berrange/src/virt/qemu/include/glib-compat.h:22: error: =
"GLIB_VERSION_MIN_REQUIRED" redefined [-Werror]
> > > >> >  #define GLIB_VERSION_MIN_REQUIRED GLIB_VERSION_2_40
> > > >> >
> > > >> > In file included from /usr/include/glib-2.0/glib/gtypes.h:34,
> > > >> >                  from /usr/include/glib-2.0/glib/galloca.h:32,
> > > >> >                  from /usr/include/glib-2.0/glib.h:30,
> > > >> >                  from util/iova-tree.c:12:
> > > >> > /usr/include/glib-2.0/glib/gversionmacros.h:237: note: this is=
 the location of the previous definition
> > > >> >  # define GLIB_VERSION_MIN_REQUIRED      (GLIB_VERSION_CUR_STA=
BLE)
> > > >> >
> > > >> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > > >> > ---
> > > >> >  util/iova-tree.c | 1 -
> > > >> >  1 file changed, 1 deletion(-)
> > > >> >
> > > >> > diff --git a/util/iova-tree.c b/util/iova-tree.c
> > > >> > index 2d9cebfc89..d39cd8bb29 100644
> > > >> > --- a/util/iova-tree.c
> > > >> > +++ b/util/iova-tree.c
> > > >> > @@ -9,7 +9,6 @@
> > > >> >   * This work is licensed under the terms of the GNU GPL, vers=
ion 2 or later.
> > > >> >   */
> > > >> >
> > > >> > -#include <glib.h>
> > > >> >  #include "qemu/iova-tree.h"
> > > >>=20
> > > >> While we're fixing up the headers in this file:
> > > >> it should start with an include of qemu/osdep.h,
> > > >> and qemu/iova-tree.h should not include osdep.h...
> > > >
> > > > Sorry to messed this up.  It was used for hwaddr definition.
> > > >
> > > > Maybe we can just replace hwaddr usage in iova-tree.[ch] with
> > > > something like uint64_t?  Then I think we can drop the osdep.h.
> > >=20
> > > Every compilation unit must include "osdep.h" first.  Its file comm=
ent
> > > explains why.  If it's insufficiently convincing, we should fix it =
:)
> >=20
> > Ah... :)
> >=20
> > Then maybe also we can let iova-tree.c to include osdep.h (instead of
> > glib.h), and remove that line in iova-tree.h
>=20
> Yeah, I'll repost with that changed

Thanks for fixing that!

--=20
Peter Xu
