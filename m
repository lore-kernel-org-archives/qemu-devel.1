Received: from eggs.gnu.org ([2001:4830:134:3::10]:58656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dAcT4-00035p-Qa
	for qemu-devel@nongnu.org; Tue, 16 May 2017 09:24:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dAcT1-0006mc-No
	for qemu-devel@nongnu.org; Tue, 16 May 2017 09:24:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1dAcT1-0006lw-HZ
	for qemu-devel@nongnu.org; Tue, 16 May 2017 09:24:47 -0400
References: <1494838260-30439-1-git-send-email-peterx@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <9a93009b-f909-3142-5bc5-915b9a10ed20@redhat.com>
Date: Tue, 16 May 2017 15:24:14 +0200
MIME-Version: 1.0
In-Reply-To: <1494838260-30439-1-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/4] exec: address space translation
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>



On 05/15/2017 10:50 AM, Peter Xu wrote:
> The problem is that, address_space_get_iotlb_entry() shares a lot with
> address_space_translate(). This patch tries to abstract the
> shared elements.
> 
> Originally, this work is derived from discussion from VT-d passthrough
> series discussions [1]. But for sure we can just see this series as a
> standalone cleanup. So I posted it separately here.
> 
> Smoke tests are done with general VM boots, IOs, especially with vhost
> dmar configurations.
> 
> I believe with current series I can throw away the old patch [1],
> which may be good. But before that, please kindly review. Thanks.

I faced the problem the old patch fixes when declaring and attaching an 
IOMMU device, but booting the kernel with intel_iommu=off.

I tested again with patches 1 & 4 of your series, and I confirm it fixes 
the issue:
Tested-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks!
Maxime

> 
> References:
> 
> [1] https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg02335.html
> 
> Peter Xu (4):
>    exec: simplify phys_page_find() params
>    exec: rename resolve_subpage
>    exec: further use is_mmio
>    exec: abstract address_space_do_translate()
> 
>   exec.c | 122 ++++++++++++++++++++++++++++++++++++++++-------------------------
>   1 file changed, 76 insertions(+), 46 deletions(-)
> 
