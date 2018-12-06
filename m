Received: from eggs.gnu.org ([2001:4830:134:3::10]:36151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gUqAa-0001lo-5W
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:42:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gUqAY-0002Wr-G4
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:42:08 -0500
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:34758)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1gUqAY-0002VK-Ag
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:42:06 -0500
Received: by mail-yb1-xb41.google.com with SMTP id a67-v6so10678572ybg.1
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 01:42:06 -0800 (PST)
MIME-Version: 1.0
References: <20181206063552.6701-1-xieyongji@baidu.com>
	<1157991544088071@myt4-a988562a11ab.qloud-c.yandex.net>
In-Reply-To: <1157991544088071@myt4-a988562a11ab.qloud-c.yandex.net>
From: Yongji Xie <elohimes@gmail.com>
Date: Thu, 6 Dec 2018 17:41:52 +0800
Message-ID: <CAONzpcZ4Mvp6vFF9y1X9ymrtRi0G+sZAC2bSjH0f1tv=7V6_9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: yury-kotov@yandex-team.ru
Cc: "Michael S. Tsirkin" <mst@redhat.com>, marcandre.lureau@redhat.com, nixun@baidu.com, qemu-devel@nongnu.org, lilin24@baidu.com, zhangyu31@baidu.com, chaiwen@baidu.com, Xie Yongji <xieyongji@baidu.com>

On Thu, 6 Dec 2018 at 17:21, Yury Kotov <yury-kotov@yandex-team.ru> wrote:
>
> Hi, it's very interesting patchset.
>
> I also research reconnecting issue for vhost-user-blk and SPDK.
> Did you support a case when vhost backend is not started but QEMU does?
>

Now we do not support this case. Because qemu have to get config from vhost-user
backend through VHOST_USER_GET_CONFIG when we initialize the
vhost-user-blk device.

If we delay getting config until we connect vhost-user backend, guest
driver may get incorrect
configuration? That's why I modify the "wait" option to support client mode.

Thanks,
Yongji
