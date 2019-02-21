Received: from eggs.gnu.org ([209.51.188.92]:42186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gwdC9-00071I-NN
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 20:30:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gwdC8-0007bD-Qb
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 20:30:37 -0500
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:44346)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1gwdC8-0007aA-Iq
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 20:30:36 -0500
Received: by mail-qt1-x842.google.com with SMTP id d2so4027873qti.11
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 17:30:36 -0800 (PST)
MIME-Version: 1.0
References: <20190218102748.2242-1-xieyongji@baidu.com>
	<20190220145851-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190220145851-mutt-send-email-mst@kernel.org>
From: Yongji Xie <elohimes@gmail.com>
Date: Thu, 21 Feb 2019 09:30:23 +0800
Message-ID: <CAONzpcY03LOpg42iXZWK4VJtSBbiCCHyn2dyFpC7w=Y=3m-MnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 0/7] vhost-user-blk: Add support for
 backend reconnecting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Jason Wang <jasowang@redhat.com>, "Coquelin,
	Maxime" <maxime.coquelin@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>, =?UTF-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?= <wrfsh@yandex-team.ru>, qemu-devel <qemu-devel@nongnu.org>, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

On Thu, 21 Feb 2019 at 04:00, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Feb 18, 2019 at 06:27:41PM +0800, elohimes@gmail.com wrote:
> > From: Xie Yongji <xieyongji@baidu.com>
> >
> > This patchset is aimed at supporting qemu to reconnect
> > vhost-user-blk backend after vhost-user-blk backend crash or
> > restart.
> >
> > The patch 1 introduces two new messages VHOST_USER_GET_INFLIGHT_FD
> > and VHOST_USER_SET_INFLIGHT_FD to support transferring shared
> > buffer between qemu and backend.
> >
> > The patch 2 deletes some redundant check in contrib/libvhost-user.c.
> >
> > The patch 3,4 are the corresponding libvhost-user patches of
> > patch 1. Make libvhost-user support VHOST_USER_GET_INFLIGHT_FD
> > and VHOST_USER_SET_INFLIGHT_FD.
> >
> > The patch 5 allows vhost-user-blk to use the two new messages
> > to get/set inflight buffer from/to backend.
> >
> > The patch 6 supports vhost-user-blk to reconnect backend when
> > connection closed.
> >
> > The patch 7 introduces VHOST_USER_PROTOCOL_F_SLAVE_SHMFD
> > to vhost-user-blk backend which is used to tell qemu that
> > we support reconnecting now.
> >
> > To use it, we could start qemu with:
> >
> > qemu-system-x86_64 \
> >         -chardev socket,id=char0,path=/path/vhost.socket,reconnect=1, \
> >         -device vhost-user-blk-pci,chardev=char0 \
> >
> > and start vhost-user-blk backend with:
> >
> > vhost-user-blk -b /path/file -s /path/vhost.socket
> >
> > Then we can restart vhost-user-blk at any time during VM running.
>
> Sorry is elohimes@gmail.com also an address that belongs to
> Xie Yongji?
>

Yes, that's also my email address.

Thanks,
Yongji
