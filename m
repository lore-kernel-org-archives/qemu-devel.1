Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C3CC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 17:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EFA920787
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 17:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EFA920787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOmEZ-00033E-FB
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 13:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alazar@bitdefender.com>) id 1jOmDx-0002eB-LR
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 13:53:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alazar@bitdefender.com>) id 1jOmDt-00086d-Th
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 13:53:19 -0400
Received: from mx01.bbu.dsd.mx.bitdefender.com ([91.199.104.161]:40574)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alazar@bitdefender.com>)
 id 1jOmDs-00080D-8R
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 13:53:16 -0400
Received: from smtp.bitdefender.com (smtp02.buh.bitdefender.net [10.17.80.76])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 BE8F4306E47C; Wed, 15 Apr 2020 20:53:13 +0300 (EEST)
Received: from localhost (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id A707E303EF00;
 Wed, 15 Apr 2020 20:53:13 +0300 (EEST)
From: Adalbert =?iso-8859-2?b?TGF643I=?= <alazar@bitdefender.com>
Subject: Re: [RFC PATCH v1 03/26] char-socket: fix the client mode when
 created through QMP
To: Markus Armbruster <armbru@redhat.com>
In-Reply-To: <87tv1kg7p9.fsf@dusky.pond.sub.org>
References: <20200415005938.23895-1-alazar@bitdefender.com>
 <20200415005938.23895-4-alazar@bitdefender.com>
 <CAJ+F1CLLpzdoNqwgMQh8j4Sd4_HGEmBt=x1wPsHXvgZ7O=8Kzg@mail.gmail.com>
 <15869512460.BE82bEee.22517@host> <87tv1kg7p9.fsf@dusky.pond.sub.org>
Date: Wed, 15 Apr 2020 20:53:40 +0300
Message-ID: <15869732200.9DFE1C.30594@host>
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
Cc: =?iso-8859-1?q?Paolo=0A?= Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 15 Apr 2020 16:11:14 +0200, Markus Armbruster <armbru@redhat.com>=
 wrote:
> Adalbert Laz=C3=A3r <alazar@bitdefender.com> writes:
>=20
> > On Wed, 15 Apr 2020 12:37:34 +0200, Marc-Andr=C3=A9 Lureau <marcandre=
.lureau@gmail.com> wrote:
> >> Hi
> >>=20
> >> On Wed, Apr 15, 2020 at 3:00 AM Adalbert Laz=C4=83r <alazar@bitdefen=
der.com> wrote:
> >> >
> >> > qmp_chardev_open_socket() ignores the absence of the 'server' argu=
ment
> >> > and always switches to listen/server mode.
> >> >
> >> > CC: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> >> > CC: Paolo Bonzini <pbonzini@redhat.com>
> >> > Signed-off-by: Adalbert Laz=C4=83r <alazar@bitdefender.com>
> >> > ---
> >> >  chardev/char-socket.c | 2 +-
> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >
> >> > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> >> > index 9b2deb0125..fd0106ab85 100644
> >> > --- a/chardev/char-socket.c
> >> > +++ b/chardev/char-socket.c
> >> > @@ -1310,7 +1310,7 @@ static void qmp_chardev_open_socket(Chardev =
*chr,
> >> >      SocketChardev *s =3D SOCKET_CHARDEV(chr);
> >> >      ChardevSocket *sock =3D backend->u.socket.data;
> >> >      bool do_nodelay     =3D sock->has_nodelay ? sock->nodelay : f=
alse;
> >> > -    bool is_listen      =3D sock->has_server  ? sock->server  : t=
rue;
> >> > +    bool is_listen      =3D sock->has_server  ? sock->server  : f=
alse;
> >>=20
> >> I don't understand what you mean. It defaults to server mode. We can=
't
> >> change that.
> >
> > First of all, thanks for your comments.
> >
> > I understand that a chardev socket is either in client mode or in ser=
ver
> > mode.  If the 'server' parameter is not used, the socket is put in cl=
ient
> > mode. At least this is the behavior when the socket is created by par=
sing
> > the command line. But, when created through QMP, without the 'server'=
 parameter,
> > the socket is put in server mode.
> >
> > Until this moment, I did not think that we can use "server=3Dno" thro=
ugh QMP :))
>=20
> Start here:
>=20
>     $ socat "READLINE,history=3D$HOME/.qmp_history,prompt=3DQMP>" UNIX-=
CONNECT:$HOME/work/images/test-qmp=20
>     {"QMP": {"version": {"qemu": {"micro": 92, "minor": 2, "major": 4},=
 "package": "v5.0.0-rc2-30-g25b0509e28"}, "capabilities": ["oob"]}}
>     QMP>{"execute": "qmp_capabilities"}
>     {"return": {}}
>     QMP>{"execute":"chardev-add", "arguments": {"id":"foo", "backend": =
{"type": "socket", "data": {"addr": {"type": "inet", "data": {"host": "0.=
0.0.0", "port": "2445"}}, "server": false}}}}
>     {"error": {"class": "GenericError", "desc": "Failed to connect sock=
et: Connection refused"}}
>=20

Thank you, Markus.

I wanted to say that while I was writing the reply, I had an aha! moment =
and I was
amused that I have not thought to use server=3Dno/false and I used the wr=
ong verb tense.

