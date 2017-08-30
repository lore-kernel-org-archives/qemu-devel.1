Received: from eggs.gnu.org ([2001:4830:134:3::10]:53240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dn65H-0004E6-5p
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:43:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dn65C-0000mq-Af
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:43:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1dn65C-0000m2-4H
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:43:14 -0400
Date: Wed, 30 Aug 2017 10:43:04 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170830104304.4a0fca34@w520.home>
In-Reply-To: <CAMxP3BRFzyyHemEW-2DFRd7r9Py-bkjY7vQRNeBfuhN0XKupJQ@mail.gmail.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Bob Chen <a175818323@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, =?UTF-8?B?6ZmI5Y2a?= <chenbo02@meituan.com>, qemu-devel@nongnu.org

On Wed, 30 Aug 2017 17:41:20 +0800
Bob Chen <a175818323@gmail.com> wrote:

> I think I have observed what you said...
> 
> The link speed on host remained 8GT/s until I finished running
> p2pBandwidthLatencyTest
> for the first time. Then it became 2.5GT/s...
> 
> 
> # lspci -s 09:00.0 -vvv
...
> LnkSta: Speed 8GT/s, Width x16, TrErr- Train- SlotClk+ DLActive- BWMgmt-

So long as the device renegotiates to 8GT/s under load rather than
getting stuck at 2.5GT/s, I think this is the expected behavior.  This
is a power saving measure by the driver.  Thanks,

Alex
