Received: from eggs.gnu.org ([209.51.188.92]:33906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1guL4M-0002HG-TY
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:45:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1guKvY-0003E2-22
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:36:00 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1guKvX-0003Bh-OZ
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:35:59 -0500
Received: by mail-wm1-x342.google.com with SMTP id h22so4817897wmb.0
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 09:35:59 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 14 Feb 2019 18:35:47 +0100
Message-Id: <1550165756-21617-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/9] vhost: enable for all targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, mst@redhat.com

See also "[PATCH for-3.2 00/10] vhost: preparation for qgraph
conversion of vhost-user-test".  Some of the other vhost-user-test
patches have gone in already, and this is what is left.

These patches are a prerequisite for both kconfig and qgraph.

I will probably test them on macOS myself before these are included
in a pull request, since the previous versions had some issues.
Michael, let me know if you want me to send the pull request.

Thanks,

Paolo

Paolo Bonzini (9):
  vhost-net: move stubs to a separate file
  vhost-net-user: add stubs for when no virtio-net device is present
  vhost: restrict Linux dependency to kernel vhost
  vhost-user: support cross-endian vnet headers
  vhost-net: compile it on all targets that have virtio-net.
  vhost-net: revamp configure logic
  vhost-user-test: create a main loop per TestServer
  vhost-user-test: small changes to init_hugepagefs
  vhost-user-test: create a temporary directory per TestServer

 backends/Makefile.objs     |   5 +-
 configure                  | 102 ++++++++++++++++++-----------
 default-configs/virtio.mak |   4 +-
 hw/net/Makefile.objs       |   4 +-
 hw/net/vhost_net-stub.c    |  92 ++++++++++++++++++++++++++
 hw/net/vhost_net.c         |  85 ++----------------------
 hw/virtio/Makefile.objs    |   8 ++-
 hw/virtio/vhost-backend.c  |  12 +++-
 hw/virtio/vhost-user.c     |  13 +++-
 hw/virtio/vhost.c          |   2 +-
 include/exec/poison.h      |   1 -
 net/Makefile.objs          |   4 +-
 net/net.c                  |   2 +-
 net/vhost-user-stub.c      |  23 +++++++
 net/vhost-user.c           |  13 ++++
 tests/Makefile.include     |   5 +-
 tests/vhost-user-test.c    | 160 +++++++++++++++++++++++----------------------
 17 files changed, 319 insertions(+), 216 deletions(-)
 create mode 100644 hw/net/vhost_net-stub.c
 create mode 100644 net/vhost-user-stub.c

-- 
1.8.3.1
