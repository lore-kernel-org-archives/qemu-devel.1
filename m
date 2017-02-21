Received: from eggs.gnu.org ([2001:4830:134:3::10]:38132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cgFeZ-0002c2-CX
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:59:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cgFeW-0007Tx-Ct
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:59:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cgFeW-0007Tt-6u
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:59:08 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 49AF24E024
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 18:59:08 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 21 Feb 2017 18:58:59 +0000
Message-Id: <20170221185901.3256-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] virtio: migration fixes for memory region
 cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Bug fixes for the recently added memory region cache in virtio.  This series
fixes live migration, see patches for details.

Stefan Hajnoczi (2):
  virtio: invalidate memory in vring_set_avail_event()
  virtio: add missing region cache init in virtio_load()

 hw/virtio/virtio.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

-- 
2.9.3
