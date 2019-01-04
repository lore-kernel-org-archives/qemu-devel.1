Received: from eggs.gnu.org ([208.118.235.92]:59318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gfKpJ-0002U0-MN
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 03:27:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gfKpI-0004po-Qj
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 03:27:33 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45616)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gfKpI-0004pI-K2
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 03:27:32 -0500
Received: by mail-wr1-x441.google.com with SMTP id t6so35842815wrr.12
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 00:27:32 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  4 Jan 2019 09:27:29 +0100
Message-Id: <20190104082731.24967-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/2] include: update Linux headers to
 4.21-rc1/5.0-rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, cohuck@redhat.com, peter.maydell@linaro.org

This is the same patch I've sent, except that scripts/update-linux-headers.sh
changes are split to a separate commit.

Paolo

Paolo Bonzini (2):
  scripts/update-linux-headers.sh: adjust for Linux 4.21-rc1 (or
    5.0-rc1)
  include: update Linux headers to 4.21-rc1/5.0-rc1

 include/standard-headers/drm/drm_fourcc.h     |   63 +
 include/standard-headers/linux/ethtool.h      |   19 +-
 .../linux/input-event-codes.h                 |   17 +
 include/standard-headers/linux/pci_regs.h     |    1 +
 include/standard-headers/linux/vhost_types.h  |  128 ++
 .../standard-headers/linux/virtio_balloon.h   |    8 +
 include/standard-headers/linux/virtio_blk.h   |   54 +
 .../standard-headers/linux/virtio_config.h    |    3 +
 include/standard-headers/linux/virtio_gpu.h   |   18 +
 include/standard-headers/linux/virtio_ring.h  |   52 +
 linux-headers/asm-arm/unistd-common.h         |    1 +
 linux-headers/asm-arm64/unistd.h              |    1 +
 linux-headers/asm-generic/unistd.h            |   10 +-
 linux-headers/asm-mips/sgidefs.h              |    8 -
 linux-headers/asm-mips/unistd.h               | 1074 +----------------
 linux-headers/asm-mips/unistd_n32.h           |  338 ++++++
 linux-headers/asm-mips/unistd_n64.h           |  334 +++++
 linux-headers/asm-mips/unistd_o32.h           |  374 ++++++
 linux-headers/asm-powerpc/unistd.h            |  389 +-----
 linux-headers/asm-powerpc/unistd_32.h         |  381 ++++++
 linux-headers/asm-powerpc/unistd_64.h         |  372 ++++++
 linux-headers/linux/kvm.h                     |   29 +
 linux-headers/linux/vfio.h                    |   92 ++
 linux-headers/linux/vhost.h                   |  113 +-
 linux-headers/linux/vhost_types.h             |    1 +
 scripts/update-linux-headers.sh               |   11 +
 26 files changed, 2302 insertions(+), 1589 deletions(-)
 create mode 100644 include/standard-headers/linux/vhost_types.h
 create mode 100644 linux-headers/asm-mips/unistd_n32.h
 create mode 100644 linux-headers/asm-mips/unistd_n64.h
 create mode 100644 linux-headers/asm-mips/unistd_o32.h
 create mode 100644 linux-headers/asm-powerpc/unistd_32.h
 create mode 100644 linux-headers/asm-powerpc/unistd_64.h
 create mode 100644 linux-headers/linux/vhost_types.h

-- 
2.20.1
