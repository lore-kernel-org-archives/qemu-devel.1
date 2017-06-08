Received: from eggs.gnu.org ([2001:4830:134:3::10]:54201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dIxvv-0007wP-Gh
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:57:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dIxvq-00076d-Us
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:57:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dIxvq-000767-OR
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:57:02 -0400
Date: Thu, 8 Jun 2017 09:56:59 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <751038014.31767180.1496930219401.JavaMail.zimbra@redhat.com>
In-Reply-To: <765f4687-52ac-ff9d-ef82-037c319e23ec@redhat.com>
References: <20170608115939.30985-1-marcandre.lureau@redhat.com>
	<20170608115939.30985-4-marcandre.lureau@redhat.com>
	<765f4687-52ac-ff9d-ef82-037c319e23ec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/3] test-char: start a /char/serial test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, anthony perard <anthony.perard@citrix.com>, pbonzini@redhat.com

Hi

----- Original Message -----
> On 06/08/2017 06:59 AM, Marc-Andr=C3=A9 Lureau wrote:
> > Quite limited test, to check that the chardev can be created with a
> > path and with the tty alias.
> >=20
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > ---
> >  tests/test-char.c | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >=20
> > diff --git a/tests/test-char.c b/tests/test-char.c
> > index dfe856cb85..ecc3fec194 100644
> > --- a/tests/test-char.c
> > +++ b/tests/test-char.c
> > @@ -5,6 +5,7 @@
> >  #include "qemu/config-file.h"
> >  #include "qemu/sockets.h"
> >  #include "chardev/char-fe.h"
> > +#include "chardev/char-serial.h" /* for HAVE_CHARDEV_SERIAL */
>=20
> Either the comment or the entire #include is now spurious, given the new
> 1/3.

indeed, removed

>=20
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>=20
>=20
