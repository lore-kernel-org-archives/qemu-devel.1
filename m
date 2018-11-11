Received: from eggs.gnu.org ([2001:4830:134:3::10]:44762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuri.benditovich@daynix.com>) id 1gLrmu-000861-Lo
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 10:36:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuri.benditovich@daynix.com>) id 1gLrmq-0002eh-53
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 10:36:36 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
	id 1gLrmm-0002Tt-Oc
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 10:36:30 -0500
Received: by mail-wm1-x341.google.com with SMTP id i73-v6so803260wmd.5
	for <qemu-devel@nongnu.org>; Sun, 11 Nov 2018 07:36:22 -0800 (PST)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Sun, 11 Nov 2018 17:35:58 +0200
Message-Id: <20181111153559.5843-1-yuri.benditovich@daynix.com>
Subject: [Qemu-devel] [PATCH v2 0/1] virtio-net: support RSC v4/v6 tcp
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

Changes from v1:
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

Yuri Benditovich (1):
  virtio-net: support RSC v4/v6 tcp traffic for Windows HCK

 hw/net/virtio-net.c            | 667 ++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-net.h |  81 ++++
 include/net/eth.h              |   2 +
 3 files changed, 749 insertions(+), 1 deletion(-)

-- 
2.17.1
