Received: from eggs.gnu.org ([2001:4830:134:3::10]:34148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dABin-0003pC-QZ
	for qemu-devel@nongnu.org; Mon, 15 May 2017 04:51:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dABij-0005Xi-1w
	for qemu-devel@nongnu.org; Mon, 15 May 2017 04:51:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dABii-0005XV-RT
	for qemu-devel@nongnu.org; Mon, 15 May 2017 04:51:12 -0400
From: Peter Xu <peterx@redhat.com>
Date: Mon, 15 May 2017 16:50:56 +0800
Message-Id: <1494838260-30439-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] exec: address space translation cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

The problem is that, address_space_get_iotlb_entry() shares a lot with
address_space_translate(). This patch tries to abstract the
shared elements.

Originally, this work is derived from discussion from VT-d passthrough
series discussions [1]. But for sure we can just see this series as a
standalone cleanup. So I posted it separately here.

Smoke tests are done with general VM boots, IOs, especially with vhost
dmar configurations.

I believe with current series I can throw away the old patch [1],
which may be good. But before that, please kindly review. Thanks.

References:

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg02335.html

Peter Xu (4):
  exec: simplify phys_page_find() params
  exec: rename resolve_subpage
  exec: further use is_mmio
  exec: abstract address_space_do_translate()

 exec.c | 122 ++++++++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 76 insertions(+), 46 deletions(-)

-- 
2.7.4
