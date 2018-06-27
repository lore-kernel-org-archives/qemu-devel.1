Received: from eggs.gnu.org ([2001:4830:134:3::10]:34613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fY5j8-00021B-6d
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 04:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fY5j4-0002Km-Up
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 04:22:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34276 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1fY5j4-0002Fq-Qy
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 04:22:54 -0400
From: Pankaj Gupta <pagupta@redhat.com>
Date: Wed, 27 Jun 2018 13:52:46 +0530
Message-Id: <20180627082248.14921-1-pagupta@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] virtio-rng: fix old guest kernel hang
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, amit@kernel.org, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, slopezpa@redhat.com

 virtio-rng device causing old guest kernels(2.6.32) to hang on latest qemu.
 The driver attempts to read from the virtio-rng device too early in it's
 initialization. Qemu detects guest is not ready and returns, resulting in
 hang. Below patches fix this.


Stefan Hajnoczi(1):
  virtio-rng: process pending requests when driver is ready

Pankaj Gupta(1):
  virtio: Set status early in VirtIODevice parent object

 virtio-rng.c |   13 +++++++++++++
 virtio.c     |    3 ++-
 2 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.14.3
