Received: from eggs.gnu.org ([2001:4830:134:3::10]:34254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gUr3e-0001g7-LC
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 05:39:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gUr0B-0006VG-25
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 05:35:32 -0500
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:43052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1gUr0A-0006SD-OU
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 05:35:26 -0500
Received: by mail-yb1-xb43.google.com with SMTP id x144so6593004ybg.10
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 02:35:26 -0800 (PST)
MIME-Version: 1.0
References: <20181206063552.6701-1-xieyongji@baidu.com>
	<1157991544088071@myt4-a988562a11ab.qloud-c.yandex.net>
	<CAONzpcZ4Mvp6vFF9y1X9ymrtRi0G+sZAC2bSjH0f1tv=7V6_9Q@mail.gmail.com>
	<1184491544089924@myt4-a988562a11ab.qloud-c.yandex.net>
In-Reply-To: <1184491544089924@myt4-a988562a11ab.qloud-c.yandex.net>
From: Yongji Xie <elohimes@gmail.com>
Date: Thu, 6 Dec 2018 18:35:12 +0800
Message-ID: <CAONzpcaDa-5R8WPZM2i6i44naf=rB3JNOxHwOpN7Gm+TBm9GVQ@mail.gmail.com>
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

On Thu, 6 Dec 2018 at 17:52, Yury Kotov <yury-kotov@yandex-team.ru> wrote:
>
> Yes, I also think that realize shout be sync.
>
> But may be it's better to add an 'disconnected' option to init the chardev
> in disconnected state, then do the first connection with
> qemu_chr_fe_wait_connected from vhost_user_blk_realize. So when
> connection will be broken in realize we can try again.
> What do you think about it?
>

Sounds good to me. And maybe we need to add a timeout for the retrying.

Thanks,
Yongji
