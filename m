Received: from eggs.gnu.org ([208.118.235.92]:46520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuri.benditovich@daynix.com>) id 1gf2nj-0003Al-N1
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:12:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuri.benditovich@daynix.com>) id 1gf2nf-00036N-Lq
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:12:43 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
	id 1gf2nf-00032d-DJ
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:12:39 -0500
Received: by mail-wm1-x344.google.com with SMTP id b11so29240899wmj.1
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 05:12:39 -0800 (PST)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Thu,  3 Jan 2019 15:12:28 +0200
Message-Id: <20190103131230.24934-1-yuri.benditovich@daynix.com>
Subject: [Qemu-devel] [PATCH v4 0/2] virtio-net: support RSC v4/v6 tcp
 traffic for Windows HCK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, jasowang@redhat.com, dmitry.fleytman@gmail.com, qemu-devel@nongnu.org
Cc: yan@daynix.com

Changes in v1:
* Changes in standard header moved to virtio_net.c
* added inline procedures for header fields access
* Removed unused define
* Removed unrelated changes
* Renamed RSC timeout define
* Removed unnecessary check for VHOST
* RSC struct names prefixed by Virtio
* Added note about migration
* Mail address in signature
* Style fixes

Changes in v3:
* added comment regarding chain loss on migration

Changes in v4:
* added patch changing feature bit from 38 to 61

Yuri Benditovich (2):
  virtio-net: support RSC v4/v6 tcp traffic for Windows HCK
  virtio-net: changed VIRTIO_NET_F_RSC_EXT to be 61

 hw/net/virtio-net.c            | 667 ++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-net.h |  83 ++++
 include/net/eth.h              |   2 +
 3 files changed, 751 insertions(+), 1 deletion(-)

-- 
2.17.1
