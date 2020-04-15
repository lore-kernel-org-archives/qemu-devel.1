Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0519FC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 12:55:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D25EB206D5
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 12:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D25EB206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOha7-0003bi-0W
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 08:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60823)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alazar@bitdefender.com>) id 1jOhZN-0002ue-D0
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:55:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alazar@bitdefender.com>) id 1jOhZL-0000XL-Nx
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:55:08 -0400
Received: from mx01.bbu.dsd.mx.bitdefender.com ([91.199.104.161]:33388)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alazar@bitdefender.com>)
 id 1jOhZL-0000Wm-F3
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:55:07 -0400
Received: from smtp.bitdefender.com (smtp02.buh.bitdefender.net [10.17.80.76])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 1639D306E47C; Wed, 15 Apr 2020 15:55:05 +0300 (EEST)
Received: from localhost (unknown [89.136.169.210])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id EC7BC303EF00;
 Wed, 15 Apr 2020 15:55:04 +0300 (EEST)
From: Adalbert =?iso-8859-2?b?TGF643I=?= <alazar@bitdefender.com>
Subject: Re: [RFC PATCH v1 05/26] char-socket: add 'fd' property
To: =?iso-8859-1?q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
In-Reply-To: <CAJ+F1CLrHNs=WS6+zOLquX6jXxSnEzMF1ZrM_X7M9oYSZVB6pA@mail.gmail.com>
References: <20200415005938.23895-1-alazar@bitdefender.com>
 <20200415005938.23895-6-alazar@bitdefender.com>
 <CAJ+F1CLrHNs=WS6+zOLquX6jXxSnEzMF1ZrM_X7M9oYSZVB6pA@mail.gmail.com>
Date: Wed, 15 Apr 2020 15:55:31 +0300
Message-ID: <15869553310.3fFA6f0.1898@host>
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

On Wed, 15 Apr 2020 12:56:18 +0200, Marc-Andr=C3=A9 Lureau <marcandre.lur=
eau@gmail.com> wrote:
> On Wed, Apr 15, 2020 at 3:07 AM Adalbert Laz=C4=83r <alazar@bitdefender=
.com> wrote:
> >
> > This is used by the VM introspection object, after handshake, to hand
> > over the file descriptor to KVM.
> >
> > CC: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> > CC: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Adalbert Laz=C4=83r <alazar@bitdefender.com>
>=20
>=20
> patch looks ok,
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
>=20
> Though I wonder about potential conflicts of fd usage here..
>

The 'plan' was to pass the file descriptor to KVM, disable socket
reconnect and forget about this file descriptor. But, we need a way
to signal from KVM to QEMU that the file descriptor was closed and to
reconnect the socket.

There were some vsock issues in kernel (shutdown on the socket was
not detected in some cases or something else) and having the fd checked
for POLLHUP in QEMU helped, but these issues might be already fixed,
because I've seen a lot of improvements made on vsock code.

>=20
> > ---
> >  chardev/char-socket.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > index 22ab242748..76d0fb8839 100644
> > --- a/chardev/char-socket.c
> > +++ b/chardev/char-socket.c
> > @@ -1499,6 +1499,21 @@ static bool char_socket_get_reconnecting(Objec=
t *obj, Error **errp)
> >      return s->reconnect_time > 0;
> >  }
> >
> > +static void
> > +char_socket_get_fd(Object *obj, Visitor *v, const char *name, void *=
opaque,
> > +                   Error **errp)
> > +{
> > +    int fd =3D -1;
> > +    SocketChardev *s =3D SOCKET_CHARDEV(obj);
> > +    QIOChannelSocket *sock =3D QIO_CHANNEL_SOCKET(s->sioc);
> > +
> > +    if (sock) {
> > +        fd =3D sock->fd;
> > +    }
> > +
> > +    visit_type_int32(v, name, &fd, errp);
> > +}
> > +
> >  static int tcp_chr_reconnect_time(Chardev *chr, int secs)
> >  {
> >      SocketChardev *s =3D SOCKET_CHARDEV(chr);
> > @@ -1539,6 +1554,9 @@ static void char_socket_class_init(ObjectClass =
*oc, void *data)
> >      object_class_property_add_bool(oc, "reconnecting",
> >                                     char_socket_get_reconnecting,
> >                                     NULL, &error_abort);
> > +
> > +    object_class_property_add(oc, "fd", "int32", char_socket_get_fd,
> > +                              NULL, NULL, NULL, &error_abort);
> >  }
> >
> >  static const TypeInfo char_socket_type_info =3D {
> >
>=20
>=20
> --=20
> Marc-Andr=C3=A9 Lureau
>=20

