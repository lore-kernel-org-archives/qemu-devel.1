Received: from eggs.gnu.org ([2001:4830:134:3::10]:46348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1cmQni-00088N-N0
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 15:06:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1cmQne-0002QG-Nt
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 15:06:10 -0500
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 10 Mar 2017 22:05:48 +0200
Message-Id: <20170310200550.13313-1-krzk@kernel.org>
Subject: [Qemu-devel] [PATCH v2 0/2] qdev: Minor const improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org, Krzysztof Kozlowski <krzk@kernel.org>

Hi,

Minor improvements.

Changes since v1:
1. Follow suggestions from v1 discussion - drop other consts.

Best regards,
Krzysztof


Krzysztof Kozlowski (2):
  qdev: Constify value passed to qdev_prop_set_macaddr
  qdev: Constify local variable returned by blk_bs

 hw/core/qdev-properties-system.c | 2 +-
 hw/core/qdev-properties.c        | 3 ++-
 include/hw/qdev-properties.h     | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.9.3
