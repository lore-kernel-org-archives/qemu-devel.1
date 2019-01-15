Received: from eggs.gnu.org ([209.51.188.92]:56115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gjSaq-0002k9-85
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 12:33:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gjSao-0007pH-OJ
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 12:33:40 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gjSao-0007ip-H6
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 12:33:38 -0500
Received: by mail-wm1-x344.google.com with SMTP id f188so4079010wmf.5
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 09:33:29 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 15 Jan 2019 18:33:20 +0100
Message-Id: <1547573605-25711-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/5] vhost: enable for all targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, philmd@redhat.com

vhost does not have to be supported only if KVM is present, in fact
vhost-user does not even need any kind of kernel support.  This series
changes this.  The rationale is that, when vhost-user-test.c will be
converted to qgraph, it will be able to test vhost-user support
for virtio-mmio backend even on x86.

v1->v2: use vhost_types.h for portability to the BSDs.

Based-on: <20190104082731.24967-1-pbonzini@redhat.com>

Paolo Bonzini (5):
  vhost-net: move stubs to a separate file
  vhost-net-user: add stubs for when no virtio-net device is present
  vhost: restrict Linux dependency to kernel vhost
  vhost-net: compile it on all targets that have virtio-net.
  vhost-net: revamp configure logic

 backends/Makefile.objs     |   5 +--
 configure                  | 102 ++++++++++++++++++++++++++++-----------------
 default-configs/virtio.mak |   4 +-
 hw/net/Makefile.objs       |   4 +-
 hw/net/vhost_net-stub.c    |  92 ++++++++++++++++++++++++++++++++++++++++
 hw/net/vhost_net.c         |  85 +++----------------------------------
 hw/virtio/Makefile.objs    |   5 ++-
 hw/virtio/vhost-backend.c  |  12 +++++-
 hw/virtio/vhost-user.c     |  13 +++++-
 hw/virtio/vhost.c          |   2 +-
 include/exec/poison.h      |   1 -
 net/Makefile.objs          |   4 +-
 net/net.c                  |   2 +-
 net/vhost-user-stub.c      |  23 ++++++++++
 tests/Makefile.include     |   5 +--
 tests/vhost-user-test.c    |  16 ++++---
 16 files changed, 234 insertions(+), 141 deletions(-)
 create mode 100644 hw/net/vhost_net-stub.c
 create mode 100644 net/vhost-user-stub.c

-- 
1.8.3.1
