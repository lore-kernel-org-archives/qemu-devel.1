Received: from eggs.gnu.org ([209.51.188.92]:58759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gjQoW-0003IA-6i
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:39:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gjQoV-0000gE-6t
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:39:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gjQoV-0000fH-0w
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:39:39 -0500
Date: Tue, 15 Jan 2019 15:39:21 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190115153921.GD16157@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190110124946.GL2178@redhat.com>
	<CAONzpcZCTqN3CN1DBd6WdjKoTSr257Y2vOCuLOh9LBb-5K_hpg@mail.gmail.com>
	<20190110132443.GM2178@redhat.com>
	<CAONzpcZ5HXP2-9PEZW=RwunviAcPL3kYosJhUWB0g09j=pf0oQ@mail.gmail.com>
	<20190110141125.GP2178@redhat.com>
	<CAONzpcY8LdzEEqourAjw5mZR9fjtjv20HqvyOvaWVoriD4Cbjg@mail.gmail.com>
	<20190110164125.GS2178@redhat.com>
	<CAONzpcb4hk87JhF0Cuz4xWDto5EOaKQSVPvegiUVF+2TbYGouw@mail.gmail.com>
	<20190111083237.GA18491@redhat.com>
	<CAONzpcaB=JVG2nkPMUUFLkGM14j=pZGSA8hyTBQ-+syL5J_WgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAONzpcaB=JVG2nkPMUUFLkGM14j=pZGSA8hyTBQ-+syL5J_WgA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 for-4.0 1/7] char-socket: Enable
 "nowait" option on client sockets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongji Xie <elohimes@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Jason Wang <jasowang@redhat.com>, "Coquelin, Maxime" <maxime.coquelin@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>, =?utf-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?= <wrfsh@yandex-team.ru>, qemu-devel <qemu-devel@nongnu.org>, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

On Fri, Jan 11, 2019 at 04:36:11PM +0800, Yongji Xie wrote:
> On Fri, 11 Jan 2019 at 16:32, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> >
> > On Fri, Jan 11, 2019 at 03:50:40PM +0800, Yongji Xie wrote:
> > > On Fri, 11 Jan 2019 at 00:41, Daniel P. Berrang=C3=A9 <berrange@red=
hat.com> wrote:
> > > >
> > > > We need to fix qemu_chr_fe_wait_connected so that it does explici=
t
> > > > synchronization wrt to any ongoing background connection process.
> > > > It must only return once all TLS/telnet/websock handshakes have
> > > > completed.  If we fix that correctly, then I believe it will  als=
o
> > > > solve the problem you're trying to address.
> > > >
> > >
> > > Yes, I think this should be the right way to go. To fix it, my thou=
ght
> > > is to track the async QIOChannelSocket in SocketChardev. Then we ca=
n
> > > easily get the connection progress in qemu_chr_fe_wait_connected().=
 Do
> > > you have any suggestion?
> >
> > I've got a few patches that refactor the code to fix this. I'll send =
them
> > today and CC you on them.
> >
>=20
> That would be great! Thank you.

It took me rather longer than expected to fully debug all scenarios, but
I've finally sent patches:

https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg03344.html

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
