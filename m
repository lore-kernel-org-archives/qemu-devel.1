Received: from eggs.gnu.org ([2001:4830:134:3::10]:38498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gZGV5-0007Vo-9U
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:37:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gZGV4-0005fI-Hf
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:37:35 -0500
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:46173)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1gZGV4-0005eo-B7
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:37:34 -0500
Received: by mail-yw1-xc42.google.com with SMTP id t13so6730581ywe.13
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 06:37:34 -0800 (PST)
MIME-Version: 1.0
References: <20181218100002.11219-1-xieyongji@baidu.com>
	<20181218100002.11219-2-xieyongji@baidu.com>
	<CAMxuvawx1GXar_UX5Pa_JEEW7EFnG092_PZGKiUL73wtd+s7cg@mail.gmail.com>
In-Reply-To: <CAMxuvawx1GXar_UX5Pa_JEEW7EFnG092_PZGKiUL73wtd+s7cg@mail.gmail.com>
From: Yongji Xie <elohimes@gmail.com>
Date: Tue, 18 Dec 2018 21:33:16 +0800
Message-ID: <CAONzpcZ7nAsEdO4-y=4gxJ2Qof8gzsCAazwCZQtd8nO_Kpt-gQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 for-4.0 1/7] chardev: Add disconnected
 option for chardev socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>, "Coquelin,
	Maxime" <maxime.coquelin@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

On Tue, 18 Dec 2018 at 20:24, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi
>
> On Tue, Dec 18, 2018 at 2:01 PM <elohimes@gmail.com> wrote:
> >
> > From: Xie Yongji <xieyongji@baidu.com>
> >
> > New option "disconnected" is added to init the chardev socket
> > in disconnected state. Then we can use qemu_chr_fe_wait_connected()
> > to connect when necessary. Now it would be used for unix domain
> > socket of vhost-user-blk device to support reconnect.
>
> What difference does that make if you wait for connection in
> qemu_chr_fe_wait_connected(), or during chardev setup?
>

Wait for connection in qemu_chr_fe_wait_connected() could make
it possible to start qemu before backend. Maybe we need to support
this case?

Thanks,
Yongji
