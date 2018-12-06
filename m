Received: from eggs.gnu.org ([2001:4830:134:3::10]:39472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1gUqKL-0000p8-3Y
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:52:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1gUqKG-0002qQ-3n
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:52:13 -0500
Received: from forwardcorp1o.cmail.yandex.net ([37.9.109.47]:43522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1gUqKF-0002on-Ks
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:52:07 -0500
From: Yury Kotov <yury-kotov@yandex-team.ru>
In-Reply-To: <CAONzpcZ4Mvp6vFF9y1X9ymrtRi0G+sZAC2bSjH0f1tv=7V6_9Q@mail.gmail.com>
References: <20181206063552.6701-1-xieyongji@baidu.com>
	<1157991544088071@myt4-a988562a11ab.qloud-c.yandex.net>
	<CAONzpcZ4Mvp6vFF9y1X9ymrtRi0G+sZAC2bSjH0f1tv=7V6_9Q@mail.gmail.com>
MIME-Version: 1.0
Date: Thu, 06 Dec 2018 12:52:04 +0300
Message-Id: <1184491544089924@myt4-a988562a11ab.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
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
To: Yongji Xie <elohimes@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "nixun@baidu.com" <nixun@baidu.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "lilin24@baidu.com" <lilin24@baidu.com>, "zhangyu31@baidu.com" <zhangyu31@baidu.com>, "chaiwen@baidu.com" <chaiwen@baidu.com>, Xie Yongji <xieyongji@baidu.com>

Yes, I also think that realize shout be sync.

But may be it's better to add an 'disconnected' option to init the charde=
v
in disconnected state, then do the first connection with
qemu_chr_fe_wait_connected from vhost_user_blk_realize. So when
connection will be broken in realize we can try again.
What do you think about it?

Regards,
Yury

06.12.2018, 12:42, "Yongji Xie" <elohimes@gmail.com>:
> On Thu, 6 Dec 2018 at 17:21, Yury Kotov <yury-kotov@yandex-team.ru> wro=
te:
>> =C2=A0Hi, it's very interesting patchset.
>>
>> =C2=A0I also research reconnecting issue for vhost-user-blk and SPDK.
>> =C2=A0Did you support a case when vhost backend is not started but QEM=
U does?
>
> Now we do not support this case. Because qemu have to get config from v=
host-user
> backend through VHOST_USER_GET_CONFIG when we initialize the
> vhost-user-blk device.
>
> If we delay getting config until we connect vhost-user backend, guest
> driver may get incorrect
> configuration? That's why I modify the "wait" option to support client =
mode.
>
> Thanks,
> Yongji
