Received: from eggs.gnu.org ([2001:4830:134:3::10]:45787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cprSz-0000VN-51
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 03:10:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cprSv-0003Xl-VS
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 03:10:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cprSv-0003Xd-PQ
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 03:10:53 -0400
Date: Mon, 20 Mar 2017 15:10:45 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170320071045.GM17405@pxdev.xzpeter.org>
References: <1489980999-5965-1-git-send-email-jasowang@redhat.com>
	<1489980999-5965-2-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1489980999-5965-2-git-send-email-jasowang@redhat.com>
Subject: Re: [Qemu-devel] [PATCH fixup 1/2] intel_iommu: use the correct
 memory region for device IOTLB notification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On Mon, Mar 20, 2017 at 11:36:38AM +0800, Jason Wang wrote:
> We have a specific memory region for DMAR now, so it's wrong to
> trigger the notifier with the root region.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- peterx
