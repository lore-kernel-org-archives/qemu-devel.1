Received: from eggs.gnu.org ([2001:4830:134:3::10]:46993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cS4wO-0007bo-AE
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 11:43:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cS4wK-0007yH-Dx
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 11:43:00 -0500
Received: from mx6-phx2.redhat.com ([209.132.183.39]:34207)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1cS4wK-0007xz-5t
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 11:42:56 -0500
Date: Fri, 13 Jan 2017 11:42:55 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Message-ID: <2061630680.2431853.1484325775861.JavaMail.zimbra@redhat.com>
In-Reply-To: <e3ce4505-4349-3b5a-84d5-decb39dab03d@redhat.com>
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
	<20170111172956.11255-28-marcandre.lureau@redhat.com>
	<e3ce4505-4349-3b5a-84d5-decb39dab03d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 27/40] char: move QIOChannel-related in
 char-io.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com

Hi

----- Original Message -----
> On 01/11/2017 11:29 AM, Marc-Andr=C3=A9 Lureau wrote:
>=20
> Grammar in subject is a bit terse; maybe:
>=20
> char: move QIOChannel-related stuff to char-io.h
>=20
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  chardev/char-io.h     |  24 +++++++
> >  chardev/char-io.c     | 168
> >  ++++++++++++++++++++++++++++++++++++++++++++++++
> >  chardev/char.c        | 174
> >  +-------------------------------------------------
> >  chardev/Makefile.objs |   1 +
> >  4 files changed, 194 insertions(+), 173 deletions(-)
> >  create mode 100644 chardev/char-io.h
> >  create mode 100644 chardev/char-io.c
> >=20
> > diff --git a/chardev/char-io.h b/chardev/char-io.h
> > new file mode 100644
> > index 0000000000..ea559fd124
> > --- /dev/null
> > +++ b/chardev/char-io.h
> > @@ -0,0 +1,24 @@
> > +#ifndef CHAR_IO_H
> > +#define CHAR_IO_H
>=20
> Must... resist... the temptation to repeat myself!

Ok, I'll just copy the original copyright from qemu-char.c in all the files=
 I created in the series.

>=20
> > +
> > +#include "qemu/osdep.h"
>=20
> .h files should NOT include osdep.h; since all .c files included it
> before any other .h file, then all things in osdep.h are already in
> scope at the point the .h file starts.

ok

>=20
>=20
> > +static gboolean io_watch_poll_prepare(GSource *source,
> > +                                      gint *timeout_)
> > +{
>=20
> Why the weird spelling of timeout_ ?  Maybe timeout_unused is better?
>=20
>=20
> > +++ b/chardev/char.c
>=20
> > -static gboolean io_watch_poll_prepare(GSource *source,
> > -                                      gint *timeout_)
>=20
> Then again, it's code motion.  Again, up to you if you want to tweak
> style things during code motion, or split them into a general cleanup
> patch separately.

yeah, weird style, any idea why Anthony wrote it that way in commit 96c6384=
77?

I guess I may just drop the _ during the move
