Received: from eggs.gnu.org ([2001:4830:134:3::10]:52622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dHtcj-0003XL-8c
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:08:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dHtce-0002Ib-6w
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:08:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dHtce-0002Hp-0h
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:08:48 -0400
Date: Mon, 5 Jun 2017 18:08:39 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170605180805-mutt-send-email-mst@kernel.org>
References: <20170526142858.19931-1-maxime.coquelin@redhat.com>
	<20170530211819-mutt-send-email-mst@kernel.org>
	<7d4af4dd-270b-605f-9535-7bf8323e74c2@redhat.com>
	<20170601165540-mutt-send-email-mst@kernel.org>
	<04975954-9972-d900-0a88-b0a2587766e1@redhat.com>
	<20170602180458-mutt-send-email-mst@kernel.org>
	<ea6e599e-a50f-3a1c-c61e-fdfcbf706e7f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea6e599e-a50f-3a1c-c61e-fdfcbf706e7f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/6] vhost-user: Specify and implement
 device IOTLB support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: yuanhan.liu@linux.intel.com, qemu-devel@nongnu.org, peterx@redhat.com, Maxime Coquelin <maxime.coquelin@redhat.com>, marcandre.lureau@gmail.com, wexu@redhat.com, vkaplans@redhat.com, jfreiman@redhat.com

On Mon, Jun 05, 2017 at 04:51:55PM +0800, Jason Wang wrote:
> > 
> > I think that if we could get rid of both accesses, it would be
> > nice. Would need a feature bit naturally and we'd need to
> > support old kernels but at least it will be contained and
> > well documented.
> > 
> 
> Technically we can, but we still need a workaround for old kernels. So I'm
> not sure it's worth to do.
> 
> Thanks

I see it as valuable for documentation purposes.

-- 
MST
