Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552C0C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 16:21:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A4382075B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 16:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4382075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52854 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG4Lu-0005w9-ES
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 12:21:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hG4KU-0005BM-SI
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:19:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hG4KP-0002mF-Pl
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:19:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hG4KJ-0002VE-M2
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:19:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 889BA308620B;
	Mon, 15 Apr 2019 16:19:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.22.189])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F4B1608C1;
	Mon, 15 Apr 2019 16:19:16 +0000 (UTC)
Date: Mon, 15 Apr 2019 17:19:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Message-ID: <20190415161913.GQ5718@redhat.com>
References: <20190415160609.24240-1-marcandre.lureau@redhat.com>
	<20190415160809.GP5718@redhat.com>
	<CAJ+F1CJwW-20YWbYgcHGhtBDZnHGAHSrj-OHht0hFb5O8ndsFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJwW-20YWbYgcHGhtBDZnHGAHSrj-OHht0hFb5O8ndsFQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Mon, 15 Apr 2019 16:19:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] socket: allow wait=false for client
 socket
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415161913.D0d7zauwJ0uTMnm3zf6HVjZFM-T87SxlLeZgRNHvva0@z>

On Mon, Apr 15, 2019 at 06:16:33PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> On Mon, Apr 15, 2019 at 6:08 PM Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
> >
> > On Mon, Apr 15, 2019 at 06:06:09PM +0200, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > Commit 767abe7 ("chardev: forbid 'wait' option with client sockets"=
)
> > > is a bit too strict. Current libvirt always set wait=3Dfalse, and w=
ill
> > > thus fail to add client chardev.
> > >
> > > Make the code more permissive, allowing wait=3Dfalse with client so=
cket
> > > chardevs.
> > >
> > > Fixes: 767abe7f49e8be14d29da5db3527817b5d696a52
> > > Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  chardev/char-socket.c | 10 +++++++---
> > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > > index 3916505d67..ebc1adb83e 100644
> > > --- a/chardev/char-socket.c
> > > +++ b/chardev/char-socket.c
> > > @@ -1263,9 +1263,13 @@ static bool qmp_chardev_validate_socket(Char=
devSocket *sock,
> > >              return false;
> > >          }
> > >          if (sock->has_wait) {
> > > -            error_setg(errp, "%s",
> > > -                       "'wait' option is incompatible with "
> > > -                       "socket in client connect mode");
> > > +            warn_report("'wait' option is deprecated with "
> > > +                        "socket in client connect mode");
> > > +            if (sock->wait) {
> > > +                error_setg(errp, "%s",
> > > +                           "'wait' option is incompatible with "
> > > +                           "socket in client connect mode");
> > > +            }
> > >              return false;
> > >          }
> > >      }
> >
> > NB, it should also update qemu-deprecated.texi
>=20
> Is that clear enough?
>=20
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 2219386769..0f53d1c228 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -105,6 +105,12 @@ details.
>  The ``query-events'' command has been superseded by the more powerful
>  and accurate ``query-qmp-schema'' command.
>=20
> +@subsection chardev client socket with 'wait' option (since 4.0)
> +
> +The ``chardev-add'' and ``chardev-change'' should not be used to
> +create client sockets with a ``wait'' field, which is reserved for
> +server sockets only.

It applies to command line syntax too, so I would just generalize that
a little to

 "Character devices creating sockets in client mode should not
  specify the 'wait' field, which is only applicable to sockets
  in server mode"


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

