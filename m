Received: from eggs.gnu.org ([2001:4830:134:3::10]:34851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d3lNh-0000l2-SU
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 11:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d3lNc-0004yN-Rh
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 11:30:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d3lNc-0004y7-Ld
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 11:30:52 -0400
References: <34EFBCA9F01B0748BEB6B629CE643AE60BB3AC7D@DGGEMA505-MBS.china.huawei.com>
	<766978f5-8eae-7293-8fb4-2a7a568d301f@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e130e60e-db1f-0355-5a7b-2ece3ae7a999@redhat.com>
Date: Thu, 27 Apr 2017 17:30:46 +0200
MIME-Version: 1.0
In-Reply-To: <766978f5-8eae-7293-8fb4-2a7a568d301f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [BUG] QEMU crashes with dpdk virtio pmd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, wangyunjian <wangyunjian@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: caihe <caihe@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>



On 25/04/2017 14:02, Jason Wang wrote:
> 
> Thanks a lot for the fix.
> 
> Two questions:
> 
> - If virtio_net_set_status() is the only function that may access tx_bh,
> it looks like setting tx_waiting to zero is sufficient?

I think clearing tx_bh is better anyway, as leaving a dangling pointer
is not very hygienic.

Paolo

> - Can you post a formal patch for this?
