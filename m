Received: from eggs.gnu.org ([2001:4830:134:3::10]:33973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1cxske-0008GB-9K
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 06:10:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1cxskb-0002uM-65
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 06:10:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1cxskb-0002te-02
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 06:10:17 -0400
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Tue, 11 Apr 2017 12:10:00 +0200
Message-Id: <20170411101002.28451-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [RFC 0/2] vhost-user: Specify device IOTLB support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, vkaplans@redhat.com, jasowang@redhat.com, wexu@redhat.com, peterx@redhat.com, yuanhan.liu@linux.intel.com, virtio-comment@lists.oasis-open.org, qemu-devel@nongnu.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>

This two-patches series aims at specifying the protocol update
required to support device IOTLB with user backends.

The protocol is very close to kernel backends, except that a new
communication channel is introduced to enable the slave to send
requests to the master.

While unix sockets are bidirectionnal, I create a dedicated channel
for slave intiated requests to simplify message handling with multi-
threaded masters and slaves.

Maxime Coquelin (2):
  spec/vhost-user: Introduce secondary channel for slave initiated
    requests
  spec/vhost-user spec: Add IOMMU support

 docs/specs/vhost-user.txt | 94 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

-- 
2.9.3
