Received: from eggs.gnu.org ([2001:4830:134:3::10]:56618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIvmh-0003Lz-9F
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 06:07:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIvmc-0001YZ-8C
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 06:07:11 -0500
Received: from mga05.intel.com ([192.55.52.43]:37967)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cIvmc-0001XE-03
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 06:07:06 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Mon, 19 Dec 2016 19:05:51 +0800
Message-Id: <1482145554-88823-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v3 0/3] Vhost-user Spec: extension for vhost-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@gmail.com, mst@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, virtio-comment@lists.oasis-open.org
Cc: Wei Wang <wei.w.wang@intel.com>

This spec patch series extends the vhost-user protocol to support the vhost-pci
based inter-VM communiaction.

v2->v3 changes:
1) replace VHOST_USER_SET_DEV_INFO with VHOST_USER_SET_DEVICE_ID 
2) replace VHOST_USER_SET_PEER_CONNECTION with VHOST_USER_SET_VHOST_PCI

v1->v2 changes:
1) start from the simpler case - change "1-slave-N-master" to "1-slave-1-master"
configuration plane. Accordingly, the previous "uuid", "conn_id" are removed;
2) add the _CREATE_ and _DESTROY_ comands to the VHOST_USER_SET_PEER_CONNECTION
message; and
3) fix the VHOST_USER prefix.

Wei Wang (3):
  spec/vhost-user: extend vhost-user to support the vhost-pci based
    inter-vm communiaction
  spec/vhost-user: add VHOST_USER_PROTOCOL_F_SET_DEVICE_ID
  spec/vhost-user: add the VHOST_USER_SET_VHOST_PCI message

 docs/specs/vhost-user.txt | 44 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

-- 
2.7.4
