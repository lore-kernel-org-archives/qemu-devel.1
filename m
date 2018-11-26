Received: from eggs.gnu.org ([2001:4830:134:3::10]:59954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gRGom-00051f-RX
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 08:20:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gRGoh-0007pH-QT
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 08:20:52 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gRGoh-0007oM-Kv
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 08:20:47 -0500
Received: by mail-wr1-x444.google.com with SMTP id v6so18868092wrr.12
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 05:20:47 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 26 Nov 2018 14:20:38 +0100
Message-Id: <1543238443-4993-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] vhost: enable for all targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

vhost does not have to be supported only if KVM is present, in fact
vhost-user does not even need any kind of kernel support.  This series
changes this.  The rationale is that, when vhost-user-test.c will be
converted to qgraph, it will be able to test vhost-user support
for virtio-mmio backend even on x86.

Paolo Bonzini (5):
  vhost-net: move stubs to a separate file
  vhost-net-user: add stubs for when no virtio-net device is present
  vhost: restrict Linux dependency to kernel vhost
  vhost-net: compile it on all targets that have virtio-net.
  vhost-net: revamp configure logic

 backends/Makefile.objs     |   5 +--
 configure                  | 101 ++++++++++++++++++++++++++++-----------------
 default-configs/virtio.mak |   4 +-
 hw/net/Makefile.objs       |   4 +-
 hw/net/vhost_net-stub.c    |  95 ++++++++++++++++++++++++++++++++++++++++++
 hw/net/vhost_net.c         |  78 ++--------------------------------
 hw/virtio/Makefile.objs    |   5 ++-
 hw/virtio/vhost-backend.c  |  11 ++++-
 include/exec/poison.h      |   1 -
 net/Makefile.objs          |   4 +-
 net/net.c                  |   2 +-
 net/vhost-user-stub.c      |  23 +++++++++++
 tests/Makefile.include     |   5 +--
 13 files changed, 209 insertions(+), 129 deletions(-)
 create mode 100644 hw/net/vhost_net-stub.c
 create mode 100644 net/vhost-user-stub.c

-- 
1.8.3.1
