Received: from eggs.gnu.org ([209.51.188.92]:36962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gi0Xc-0003OP-UP
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 12:24:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gi0Xb-0006Ah-2x
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 12:24:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gi0Xa-0006A2-Sr
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 12:24:19 -0500
Date: Fri, 11 Jan 2019 12:24:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190111122047-mutt-send-email-mst@kernel.org>
References: <20190109112728.9214-1-xieyongji@baidu.com>
	<20190110102551.GD19025@stefanha-x1.localdomain>
	<CAONzpcYgVWUFg1uSHOLzOS5en2vHP_=oNXQvWQEZd9FdYi2uxA@mail.gmail.com>
	<20190111155342.GA14776@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111155342.GA14776@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v4 for-4.0 0/7] vhost-user-blk: Add support
 for backend reconnecting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Yongji Xie <elohimes@gmail.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Jason Wang <jasowang@redhat.com>, "Coquelin, Maxime" <maxime.coquelin@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>, =?utf-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?= <wrfsh@yandex-team.ru>, nixun@baidu.com, qemu-devel <qemu-devel@nongnu.org>, lilin24@baidu.com, zhangyu31@baidu.com, chaiwen@baidu.com, Xie Yongji <xieyongji@baidu.com>

On Fri, Jan 11, 2019 at 03:53:42PM +0000, Stefan Hajnoczi wrote:
> I'm concerned that this approach to device recovery is invasive and hard
> to test.  Instead I would use VIRTIO's Device Status Field
> DEVICE_NEEDS_RESET bit to tell the guest driver that a reset is
> necessary.  This is more disruptive - drivers either have to resubmit or
> fail I/O with EIO - but it's also simple and more likely to work
> correctly (it only needs to be implemented correctly in the guest
> driver, not in the many available vhost-user backend implementations).
> 
> Stefan

Unfortunately drivers don't support DEVICE_NEEDS_RESET yet.
I'll be happy to accept patches, but this means we
can't depend on DEVICE_NEEDS_RESET for basic functionality
like reconnect. And given virtio 1.0 has been there
for a while now, I suspect the only way to start using
it is by adding a new feature flag.

Unfortunate but true.

-- 
MST
