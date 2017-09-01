Received: from eggs.gnu.org ([2001:4830:134:3::10]:37750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1dnij0-0001S9-F8
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 05:58:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1dniiv-00068q-Sn
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 05:58:54 -0400
Received: from mail-io0-x231.google.com ([2607:f8b0:4001:c06::231]:34331)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a175818323@gmail.com>)
	id 1dniiv-00068c-OR
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 05:58:49 -0400
Received: by mail-io0-x231.google.com with SMTP id i200so3376916ioa.1
	for <qemu-devel@nongnu.org>; Fri, 01 Sep 2017 02:58:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170830104304.4a0fca34@w520.home>
References: <20170726113222.52aad9a6@w520.home>
	<CAMxP3BTFgwJtjh78hNBCoxBp1WsnZMZLsqzb3McqCq=-SX0a4g@mail.gmail.com>
	<20170731234626.7664be18@w520.home>
	<CAMxP3BTfMad-ycWHqmW+aVM7rv2CJSv-dmEFUveGBqAWvfbBjQ@mail.gmail.com>
	<20170801090158.35d18f10@w520.home>
	<CAMxP3BRkzXBRPZw9fpCu-w4Fusn6ng_knk1cAz=EDBAiw9UnqA@mail.gmail.com>
	<20170807095224.5438ef8c@w520.home>
	<20170808230043-mutt-send-email-mst@kernel.org>
	<CAMxP3BR=WHKJxcWKH27dcC7DTKGD2y7r12teAUSmMkwp1VDafA@mail.gmail.com>
	<20170822105659.75b5c7e0@w520.home>
	<20170822205940-mutt-send-email-mst@kernel.org>
	<CAMxP3BSNPjRZGOULZ0zKBq8v5Rqv9f5xasx+BD57c=oAS5tSWg@mail.gmail.com>
	<20170829081305.7a2685c6@w520.home>
	<CAMxP3BRFzyyHemEW-2DFRd7r9Py-bkjY7vQRNeBfuhN0XKupJQ@mail.gmail.com>
	<20170830104304.4a0fca34@w520.home>
From: Bob Chen <a175818323@gmail.com>
Date: Fri, 1 Sep 2017 17:58:46 +0800
Message-ID: <CAMxP3BQaWaoAAepffqmWcR07j_RTXcqo41RPXM=U2WoGmne3iw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] =?utf-8?q?About_virtio_device_hotplug_in_Q35!_?=
	=?utf-8?b?44CQ5aSW5Z+f6YKu5Lu2LuiwqOaFjuafpemYheOAkQ==?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, =?UTF-8?B?6ZmI5Y2a?= <chenbo02@meituan.com>, qemu-devel@nongnu.org

More updates:

1. This behavior was found not only on M60, but also on TITAN 1080Ti or Xp.

2. When not setting up the p2p compatibility, i.e. run the original qemu
with GPUs attached to the root pcie bus, the LnkSta on host always remains
at 8 GT/s. Don't know why the new p2p change would cause the GPU driver in
guest to re-negotiate its speed.

I think it has gone beyond the community's responsibility to debug this
tricky issue. So I have contacted nvidia for technical support, and they
are expected to send me a reply in next few weeks. Will keep you guys
updated.


Bob

2017-08-31 0:43 GMT+08:00 Alex Williamson <alex.williamson@redhat.com>:

> On Wed, 30 Aug 2017 17:41:20 +0800
> Bob Chen <a175818323@gmail.com> wrote:
>
> > I think I have observed what you said...
> >
> > The link speed on host remained 8GT/s until I finished running
> > p2pBandwidthLatencyTest
> > for the first time. Then it became 2.5GT/s...
> >
> >
> > # lspci -s 09:00.0 -vvv
> ...
> > LnkSta: Speed 8GT/s, Width x16, TrErr- Train- SlotClk+ DLActive- BWMgmt-
>
> So long as the device renegotiates to 8GT/s under load rather than
> getting stuck at 2.5GT/s, I think this is the expected behavior.  This
> is a power saving measure by the driver.  Thanks,
>
> Alex
>
