Received: from eggs.gnu.org ([2001:4830:134:3::10]:42565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eR8je-0007vC-4C
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 22:38:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eR8jb-0004uf-Hv
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 22:38:30 -0500
Received: from mga05.intel.com ([192.55.52.43]:53788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eR8jb-0004rZ-AO
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 22:38:27 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Tue, 19 Dec 2017 11:37:28 +0800
Message-Id: <20171219033730.12748-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v3 0/2] Add clflushopt to "Skylake-Server" cpu
 model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>

Changes in v3:
 * Rebase on QEMU 2.12.
 * Add 2.12 PC machine types. Denis V. Lunev has already posted a
   similar patch [1]. If that one is merged first, please ignore patch 1
   in this patch series.

[1] https://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg02961.html

Haozhong Zhang (2):
  pc: add 2.12 machine types
  target/i386: add clflushopt to "Skylake-Server" cpu model

 hw/i386/pc_piix.c    | 15 ++++++++++++---
 hw/i386/pc_q35.c     | 13 +++++++++++--
 include/hw/i386/pc.h |  8 ++++++++
 target/i386/cpu.c    |  2 +-
 4 files changed, 32 insertions(+), 6 deletions(-)

-- 
2.14.1
