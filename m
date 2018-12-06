Received: from eggs.gnu.org ([2001:4830:134:3::10]:35016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gUoJf-0000dP-HP
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 02:43:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gUoJe-00047n-62
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 02:43:23 -0500
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:37544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1gUoJa-0003ud-9l
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 02:43:20 -0500
Received: by mail-yb1-xb42.google.com with SMTP id w129-v6so8841848ybe.4
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 23:43:15 -0800 (PST)
MIME-Version: 1.0
References: <20181206063552.6701-1-xieyongji@baidu.com>
	<CAJ+F1C+PrJ2RTNqFQ-Jv8xVrDE+Ozp+YOWoSP9sW0pfwUW1ibA@mail.gmail.com>
In-Reply-To: <CAJ+F1C+PrJ2RTNqFQ-Jv8xVrDE+Ozp+YOWoSP9sW0pfwUW1ibA@mail.gmail.com>
From: Yongji Xie <elohimes@gmail.com>
Date: Thu, 6 Dec 2018 15:43:00 +0800
Message-ID: <CAONzpcb-a=Nz-BCbf1_wrVSZXNk_p8Qy7HPFW_NQY2fp+wzVWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 0/6] vhost-user-blk: Add support
 for backend reconnecting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@gmail.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, nixun@baidu.com, qemu-devel@nongnu.org, lilin24@baidu.com, zhangyu31@baidu.com, chaiwen@baidu.com, Xie Yongji <xieyongji@baidu.com>

On Thu, 6 Dec 2018 at 15:23, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Thu, Dec 6, 2018 at 10:36 AM <elohimes@gmail.com> wrote:
> >
> > From: Xie Yongji <xieyongji@baidu.com>
> >
> > This patchset is aimed at supporting qemu to reconnect
> > vhost-user-blk backend after vhost-user-blk backend crash or
> > restart.
> >
> > The patch 1 tries to implenment the sync connection for
> > "reconnect socket".
> >
> > The patch 2 introduces a new message VHOST_USER_SET_VRING_INFLIGHT
> > to support offering shared memory to backend to record
> > its inflight I/O.
> >
> > The patch 3,4 are the corresponding libvhost-user patches of
> > patch 2. Make libvhost-user support VHOST_USER_SET_VRING_INFLIGHT.
> >
> > The patch 5 supports vhost-user-blk to reconnect backend when
> > connection closed.
> >
> > The patch 6 tells qemu that we support reconnecting now.
> >
> > To use it, we could start qemu with:
> >
> > qemu-system-x86_64 \
> >         -chardev socket,id=3Dchar0,path=3D/path/vhost.socket,reconnect=
=3D1,wait \
> >         -device vhost-user-blk-pci,chardev=3Dchar0 \
>
> Why do you want qemu to be the client since it is actually the one
> that serves and remains alive?  Why make it try to reconnect regularly
> when it could instead wait for a connection to come up?
>

Actually, this patchset should also work when qemu is in server mode.
The reason I make qemu to be client is that some vhost-user backend
such as spdk, vhost-user-blk may still work in server mode. And
seems like we could not make sure all vhost-user backend is working in
client mode.

Thanks,
Yongji
