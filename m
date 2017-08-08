Received: from eggs.gnu.org ([2001:4830:134:3::10]:42214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dfAnK-0002W6-HT
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:08:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dfAnF-0007iB-IC
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:08:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dfAnF-0007hk-C7
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:07:57 -0400
Date: Tue, 8 Aug 2017 23:07:49 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170808230043-mutt-send-email-mst@kernel.org>
References: <859362e8-0d98-3865-8bad-a15bfa218167@redhat.com>
	<20170726092931.0678689e@w520.home>
	<20170726190348-mutt-send-email-mst@kernel.org>
	<20170726113222.52aad9a6@w520.home>
	<CAMxP3BTFgwJtjh78hNBCoxBp1WsnZMZLsqzb3McqCq=-SX0a4g@mail.gmail.com>
	<20170731234626.7664be18@w520.home>
	<CAMxP3BTfMad-ycWHqmW+aVM7rv2CJSv-dmEFUveGBqAWvfbBjQ@mail.gmail.com>
	<20170801090158.35d18f10@w520.home>
	<CAMxP3BRkzXBRPZw9fpCu-w4Fusn6ng_knk1cAz=EDBAiw9UnqA@mail.gmail.com>
	<20170807095224.5438ef8c@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170807095224.5438ef8c@w520.home>
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
Cc: Bob Chen <a175818323@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>, =?utf-8?B?6ZmI5Y2a?= <chenbo02@meituan.com>, qemu-devel@nongnu.org

On Mon, Aug 07, 2017 at 09:52:24AM -0600, Alex Williamson wrote:
> I wonder if it has something to do
> with the link speed/width advertised on the switch port.  I don't think
> the endpoint can actually downshift the physical link, so lspci on the
> host should probably still show the full bandwidth capability, but
> maybe the driver is somehow doing rate limiting.  PCIe gets a little
> more complicated as we go to newer versions, so it's not quite as
> simple as exposing a different bit configuration to advertise 8GT/s,
> x16. Last I tried to do link matching it was deemed too complicated
> for something I couldn't prove at the time had measurable value.  This
> might be a good way to prove that value if it makes a difference here.
> I can't think why else you'd see such a performance difference, but
> testing to see if the KVM exit rate is significantly different could
> still be an interesting verification.

It might be easiest to just dust off that patch and see whether it
helps.

-- 
MST
