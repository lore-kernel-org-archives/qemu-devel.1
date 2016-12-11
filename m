Received: from eggs.gnu.org ([2001:4830:134:3::10]:33242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cFuxn-0007gp-Hd
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 22:38:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cFuxk-0000yO-GK
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 22:38:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cFuxk-0000yE-AN
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 22:38:08 -0500
Date: Sun, 11 Dec 2016 05:38:02 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20161211053749-mutt-send-email-mst@kernel.org>
References: <1480908432-82844-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1480908432-82844-1-git-send-email-arei.gonglei@huawei.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 0/3] cryptodev: prepare works for
 hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gonglei <arei.gonglei@huawei.com>
Cc: qemu-devel@nongnu.org, wu.wubin@huawei.com, longpeng2@huawei.com

On Mon, Dec 05, 2016 at 11:27:09AM +0800, Gonglei wrote:
> The patch set make the cryptodev object can be hot plugging
> in safety, and which are preparing works for virtio-crypto
> device hotpulgging.


Thanks, pls remember to ping after 2.8 is out.

> Gonglei (3):
>   cryptodev: introduce a new is_used property
>   cryptodev: wrap the ready flag
>   virtio-crypto: avoid one cryptodev device is used by multiple virtio
>     crypto devices
> 
>  backends/cryptodev-builtin.c |  4 ++++
>  backends/cryptodev.c         | 34 ++++++++++++++++++++++++++++++----
>  hw/virtio/virtio-crypto.c    | 22 +++++++++++++++++++---
>  include/sysemu/cryptodev.h   | 42 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 95 insertions(+), 7 deletions(-)
> 
> -- 
> 1.8.3.1
> 
