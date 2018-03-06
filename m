Received: from eggs.gnu.org ([2001:4830:134:3::10]:59342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etIXH-00068j-8B
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 14:46:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etIXE-0001Yy-4n
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 14:46:07 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1etIXD-0001Yp-U0
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 14:46:04 -0500
Received: by mail-wm0-x241.google.com with SMTP id 139so429043wmn.2
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 11:46:03 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Mar 2018 20:45:57 +0100
Message-Id: <20180306194600.9650-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] change q35 default NIC to e1000e
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Thomas Huth <thuth@redhat.com>

The Intel 82574 NIC has better performance and more features than
the aging e1000 (aka 82540), for example MSI-X.  This patch chooses it
by default for the Q35 machine type.  As suggested by Thomas, instead
of special casing e1000e, all PCI NIC device names become valid models
for "-net nic,model=..." or "-nic model=..." (patches 1-2).

Paolo

v1->v2: fix compilation

Paolo Bonzini (3):
  qom: introduce object_class_get_list_sorted
  net: allow using any PCI NICs in -net or -nic
  q35: change default NIC to e1000e

 hw/i386/pc.c            |  7 +++---
 hw/i386/pc_piix.c       |  6 ++++-
 hw/i386/pc_q35.c        |  8 ++++++-
 hw/pci/pci.c            | 61 ++++++++++++++++++++++++-------------------------
 include/hw/i386/pc.h    |  3 ++-
 include/qom/object.h    | 11 +++++++++
 qdev-monitor.c          |  9 +-------
 qom/object.c            | 13 +++++++++++
 target/alpha/cpu.c      | 15 +-----------
 target/hppa/cpu.c       | 15 +-----------
 target/lm32/cpu.c       | 15 +-----------
 target/sh4/cpu.c        | 15 +-----------
 target/tricore/helper.c |  2 +-
 13 files changed, 78 insertions(+), 102 deletions(-)

-- 
2.14.3
