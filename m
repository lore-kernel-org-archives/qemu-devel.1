Received: from eggs.gnu.org ([2001:4830:134:3::10]:42099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etFmq-00088A-Qr
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:50:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etFmq-0000qL-12
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:50:00 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42940 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1etFmp-0000qF-Su
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:49:59 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 69368404008D
	for <qemu-devel@nongnu.org>; Tue,  6 Mar 2018 16:49:59 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Mar 2018 17:49:54 +0100
Message-Id: <20180306164957.24275-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] change q35 default NIC to e1000e
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

Paolo Bonzini (3):
  qom: introduce object_class_get_list_sorted
  net: allow using any PCI NICs in -net or -nic
  q35: change default NIC to e1000e

 hw/i386/pc.c            |  7 +++---
 hw/i386/pc_piix.c       |  6 ++++-
 hw/i386/pc_q35.c        |  8 ++++++-
 hw/pci/pci.c            | 61 ++++++++++++++++++++++++-------------------------
 include/hw/i386/pc.h    |  3 ++-
 include/qom/object.h    | 10 ++++++++
 qdev-monitor.c          |  9 +-------
 qom/object.c            | 14 ++++++++++++
 target/alpha/cpu.c      | 15 +-----------
 target/hppa/cpu.c       | 14 +-----------
 target/lm32/cpu.c       | 15 +-----------
 target/sh4/cpu.c        | 15 +-----------
 target/tricore/helper.c |  2 +-
 13 files changed, 78 insertions(+), 101 deletions(-)

-- 
2.14.3
