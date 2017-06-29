Received: from eggs.gnu.org ([2001:4830:134:3::10]:40739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQUz2-0002Xn-Qz
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:39:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQUz2-0001Zz-04
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:39:28 -0400
Date: Thu, 29 Jun 2017 16:39:15 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170629083915.GB19976@lemon.lan>
References: <20170628184724.21378-1-stefanha@redhat.com>
	<20170628184724.21378-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170628184724.21378-3-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/6] libqos: add virtio used ring support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On Wed, 06/28 19:47, Stefan Hajnoczi wrote:
> Existing tests do not touch the virtqueue used ring.  Instead they poll
> the virtqueue ISR register and peek into their request's device-specific
> status field.
> 
> It turns out that the virtqueue ISR register can be set to 1 more than
> once for a single notification (see commit
> 83d768b5640946b7da55ce8335509df297e2c7cd "virtio: set ISR on dataplane
> notifications").  This causes problems for tests that assume a 1:1
> correspondence between the ISR being 1 and request completion.
> 
> Peeking at device-specific status fields is also problematic if the
> device has no field that can be abused for EINPROGRESS polling
> semantics.  This is the case if all the field's values may be set by the
> device; there's no magic constant left for polling.
> 
> It's time to process the used ring for completed requests, just like a
> real virtio guest driver.  This patch adds the necessary APIs.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
