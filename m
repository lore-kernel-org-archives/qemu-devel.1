Received: from eggs.gnu.org ([208.118.235.92]:53084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gfG2Z-0004CH-BZ
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 22:20:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gfG2Y-0006TS-KV
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 22:20:55 -0500
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:33770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1gfG2Y-0006Sz-Gl
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 22:20:54 -0500
Received: by mail-yw1-xc42.google.com with SMTP id p65so12919395ywe.0
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 19:20:54 -0800 (PST)
MIME-Version: 1.0
References: <20190103101819.7418-1-xieyongji@baidu.com>
	<20190103101819.7418-3-xieyongji@baidu.com>
	<20190103120445-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190103120445-mutt-send-email-mst@kernel.org>
From: Yongji Xie <elohimes@gmail.com>
Date: Fri, 4 Jan 2019 11:20:42 +0800
Message-ID: <CAONzpcbyMebG0wCj+NorbD5fMZiTfUecjUv7iuQjLYZ=qC+zCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 for-4.0 2/7] vhost-user: Support
 providing shared memory to backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Jason Wang <jasowang@redhat.com>, "Coquelin,
	Maxime" <maxime.coquelin@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>, =?UTF-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?= <wrfsh@yandex-team.ru>, qemu-devel <qemu-devel@nongnu.org>, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

On Fri, 4 Jan 2019 at 01:13, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Jan 03, 2019 at 06:18:14PM +0800, elohimes@gmail.com wrote:
> > From: Xie Yongji <xieyongji@baidu.com>
> >
> > This patch introduces two new messages VHOST_USER_GET_SHM_SIZE
> > and VHOST_USER_SET_SHM_FD to support providing shared
> > memory to backend.
> >
> > Firstly, qemu uses VHOST_USER_GET_SHM_SIZE to get the
> > required size of shared memory from backend. Then, qemu
> > allocates memory and sends them back to backend through
> > VHOST_USER_SET_SHM_FD.
>
> So this does create a security concern that remote
> can supply a very big area.
> How about returning a buffer from client to qemu?
>

That's a good idea! Will do it v4.

Thanks,
Yongji
