Received: from eggs.gnu.org ([2001:4830:134:3::10]:59011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cncie-0007Q9-F2
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 23:01:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cncib-0002Tx-AK
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 23:01:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cncib-0002TS-5J
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 23:01:49 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F3E5381222
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 03:01:48 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Mar 2017 11:01:39 +0800
Message-Id: <1489460502-6686-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PATCH V3 0/3] Several fixes for virito region caches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>

Hi:

This series contains several fixes for virito region caches, please
review.

Thanks.

Jason Wang (3):
  virtio: guard against NULL pfn
  virtio: destroy region cache during reset
  virtio: validate address space cache during init

 hw/virtio/virtio.c | 105 ++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 83 insertions(+), 22 deletions(-)

-- 
2.7.4
