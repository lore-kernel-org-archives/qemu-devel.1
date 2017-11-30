Received: from eggs.gnu.org ([2001:4830:134:3::10]:37547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eKLCo-0007dC-Me
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 04:32:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eKLCi-00057N-Nk
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 04:32:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eKLCi-00055e-H4
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 04:32:24 -0500
Date: Thu, 30 Nov 2017 10:32:15 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171130103215.223c2145.cohuck@redhat.com>
In-Reply-To: <20171129174428.27548-2-ppandit@redhat.com>
References: <20171129174428.27548-1-ppandit@redhat.com>
	<20171129174428.27548-2-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/2] virtio: check VirtQueue Vring
 object is set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, zhangboxian <zhangboxian@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>

On Wed, 29 Nov 2017 23:14:27 +0530
P J P <ppandit@redhat.com> wrote:

> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> A guest could attempt to use an uninitialised VirtQueue object
> or unset Vring.align leading to a arithmetic exception. Add check
> to avoid it.
> 
> Reported-by: Zhangboxian <zhangboxian@huawei.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/virtio/virtio.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
