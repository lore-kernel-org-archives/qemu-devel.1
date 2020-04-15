Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F622C2BB55
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 12:09:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65B3C206A2
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 12:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B3C206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOgrV-0004NT-JI
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 08:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alazar@bitdefender.com>) id 1jOgqt-0003yW-4x
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:09:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alazar@bitdefender.com>) id 1jOgqr-00055H-2e
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:09:10 -0400
Received: from mx01.bbu.dsd.mx.bitdefender.com ([91.199.104.161]:60666)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alazar@bitdefender.com>)
 id 1jOgqq-00053i-62
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:09:08 -0400
Received: from smtp.bitdefender.com (smtp02.buh.bitdefender.net [10.17.80.76])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 4EF37306E47C; Wed, 15 Apr 2020 15:09:05 +0300 (EEST)
Received: from localhost (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id E2730303EF00;
 Wed, 15 Apr 2020 15:09:04 +0300 (EEST)
From: Adalbert =?iso-8859-2?b?TGF643I=?= <alazar@bitdefender.com>
Subject: Re: [RFC PATCH v1 02/26] char-socket: allow vsock parameters (cid,
 port)
To: =?iso-8859-1?q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
In-Reply-To: <CAJ+F1CKKi8L9x3S5HRZEVqAmtLgafb6rmKO3h7tGbnxKkJVzZA@mail.gmail.com>
References: <20200415005938.23895-1-alazar@bitdefender.com>
 <20200415005938.23895-3-alazar@bitdefender.com>
 <CAJ+F1CKKi8L9x3S5HRZEVqAmtLgafb6rmKO3h7tGbnxKkJVzZA@mail.gmail.com>
Date: Wed, 15 Apr 2020 15:09:31 +0300
Message-ID: <15869525710.4AB02.25596@host>
User-agent: void
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.199.104.161
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 15 Apr 2020 12:43:31 +0200, Marc-Andr=C3=A9 Lureau <marcandre.lur=
eau@gmail.com> wrote:
> Hi
>=20
> On Wed, Apr 15, 2020 at 3:00 AM Adalbert Laz=C4=83r <alazar@bitdefender=
.com> wrote:
> >
> > The introspection tool can run in a separate VM and the introspected
> > VM will establish a connection using a virtual socket.
> >
> > CC: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> > CC: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Adalbert Laz=C4=83r <alazar@bitdefender.com>
>=20
> We should also add QMP support.
>=20

The virtual socket seems to be created with the next QMP command:

{
  "execute" : "chardev-add", "arguments" :
  {
     "id" : "id1", "backend" :
     {
        "type" : "socket", "data" :
        {
            "reconnect" : 10, "addr" :
            {
                "type" : "vsock", "data" : { "cid" : "321", "port" : "123=
4" }
            }
        }
     }
   }
}

From what I remember, only the creation from command line was missing.

> Please add some tests in tests/test-char.c.
>=20

Sure.
Thanks.

> > ---
> >  chardev/char-socket.c | 27 ++++++++++++++++++++++++---
> >  chardev/char.c        |  3 +++
> >  2 files changed, 27 insertions(+), 3 deletions(-)
> >
> > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > index bd966aace1..9b2deb0125 100644
> > --- a/chardev/char-socket.c
> > +++ b/chardev/char-socket.c
> > @@ -23,6 +23,11 @@
> >   */
> >
> >  #include "qemu/osdep.h"
> > +
> > +#ifdef CONFIG_AF_VSOCK
> > +#include <linux/vm_sockets.h>
> > +#endif /* CONFIG_AF_VSOCK */
> > +
> >  #include "chardev/char.h"
> >  #include "io/channel-socket.h"
> >  #include "io/channel-tls.h"
> > @@ -590,6 +595,14 @@ static char *qemu_chr_compute_filename(SocketCha=
rdev *s)
> >                                 s->is_listen ? ",server" : "",
> >                                 left, phost, right, pserv);
> >
> > +#ifdef CONFIG_AF_VSOCK
> > +    case AF_VSOCK:
> > +        return g_strdup_printf("vsock:%d:%d%s",
> > +                               ((struct sockaddr_vm *)(ss))->svm_cid=
,
> > +                               ((struct sockaddr_vm *)(ss))->svm_por=
t,
> > +                               s->is_listen ? ",server" : "");
> > +#endif
> > +
> >      default:
> >          return g_strdup_printf("unknown");
> >      }
> > @@ -1378,18 +1391,19 @@ static void qemu_chr_parse_socket(QemuOpts *o=
pts, ChardevBackend *backend,
> >  {
> >      const char *path =3D qemu_opt_get(opts, "path");
> >      const char *host =3D qemu_opt_get(opts, "host");
> > +    const char *cid  =3D qemu_opt_get(opts, "cid");
> >      const char *port =3D qemu_opt_get(opts, "port");
> >      const char *fd =3D qemu_opt_get(opts, "fd");
> >      SocketAddressLegacy *addr;
> >      ChardevSocket *sock;
> >
> > -    if ((!!path + !!fd + !!host) !=3D 1) {
> > +    if ((!!path + !!fd + !!host + !!cid) !=3D 1) {
> >          error_setg(errp,
> > -                   "Exactly one of 'path', 'fd' or 'host' required")=
;
> > +                   "Exactly one of 'path', 'fd', 'cid' or 'host' req=
uired");
> >          return;
> >      }
> >
> > -    if (host && !port) {
> > +    if ((host || cid) && !port) {
> >          error_setg(errp, "chardev: socket: no port given");
> >          return;
> >      }
> > @@ -1444,6 +1458,13 @@ static void qemu_chr_parse_socket(QemuOpts *op=
ts, ChardevBackend *backend,
> >              .has_ipv6 =3D qemu_opt_get(opts, "ipv6"),
> >              .ipv6 =3D qemu_opt_get_bool(opts, "ipv6", 0),
> >          };
> > +    } else if (cid) {
> > +        addr->type =3D SOCKET_ADDRESS_LEGACY_KIND_VSOCK;
> > +        addr->u.vsock.data =3D g_new0(VsockSocketAddress, 1);
> > +        *addr->u.vsock.data =3D (VsockSocketAddress) {
> > +            .cid  =3D g_strdup(cid),
> > +            .port =3D g_strdup(port),
> > +        };
> >      } else if (fd) {
> >          addr->type =3D SOCKET_ADDRESS_LEGACY_KIND_FD;
> >          addr->u.fd.data =3D g_new(String, 1);
> > diff --git a/chardev/char.c b/chardev/char.c
> > index e77564060d..39e36ceb97 100644
> > --- a/chardev/char.c
> > +++ b/chardev/char.c
> > @@ -852,6 +852,9 @@ QemuOptsList qemu_chardev_opts =3D {
> >          },{
> >              .name =3D "host",
> >              .type =3D QEMU_OPT_STRING,
> > +        },{
> > +            .name =3D "cid",
> > +            .type =3D QEMU_OPT_STRING,
> >          },{
> >              .name =3D "port",
> >              .type =3D QEMU_OPT_STRING,
> >
>=20
>=20
> --=20
> Marc-Andr=C3=A9 Lureau

