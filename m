Received: from eggs.gnu.org ([209.51.188.92]:35338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjR72-0006Cc-2s
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:58:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjR71-0008Al-DO
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:58:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjR70-00088j-J5
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:58:46 -0500
Date: Tue, 15 Jan 2019 10:58:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115105548-mutt-send-email-mst@kernel.org>
References: <20190109112728.9214-1-xieyongji@baidu.com>
	<20190109112728.9214-5-xieyongji@baidu.com>
	<ce11d062-1d64-3d35-b617-5c135f1506eb@redhat.com>
	<CAONzpcY6pdSz65Tzj_Ws0M4vskUOXMuaxQ-uYz6NnCvdMgkFOA@mail.gmail.com>
	<a6e0c0b2-bd0b-454c-8280-12e0ec964240@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6e0c0b2-bd0b-454c-8280-12e0ec964240@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 for-4.0 4/7] libvhost-user: Support
 tracking inflight I/O in shared memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Yongji Xie <elohimes@gmail.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, "Coquelin, Maxime" <maxime.coquelin@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>, =?utf-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?= <wrfsh@yandex-team.ru>, qemu-devel <qemu-devel@nongnu.org>, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

On Tue, Jan 15, 2019 at 03:52:21PM +0800, Jason Wang wrote:
> Well, this may work but here're my points:
> 
> 1) The code want to recover from backed crash by introducing extra space to
> store inflight data, but it still depends on the backend to set/get the
> inflight state
> 
> 2) Since the backend could be killed at any time, the backend must have the
> ability to recover from the partial inflight state
> 
> So it looks to me 1) tends to be self-contradictory and 2) tends to be
> recursive. The above lines show how tricky could the code looks like.

This is a well studied field. Basically you make sure you commit with an
atomic write.  Restartable sequences allow accelerating this even
further.

> Solving this at vhost-user level through at backend is probably wrong. It's
> time to consider the support from virtio itself.
> 
> Thanks

I think both approaches have their space.

-- 
MST
