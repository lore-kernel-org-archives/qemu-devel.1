Received: from eggs.gnu.org ([209.51.188.92]:52334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hJwtK-0005Ca-O8
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:11:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hJwtJ-0003OW-Uw
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:11:34 -0400
Received: from mga04.intel.com ([192.55.52.120]:13449)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1hJwtJ-0003Nl-M6
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:11:33 -0400
From: Zhang Chen <chen.zhang@intel.com >
Date: Fri, 26 Apr 2019 17:07:27 +0800
Message-Id: <20190426090730.2691-1-chen.zhang@intel.com>
Subject: [Qemu-devel] [PATCH 0/3] Optimize COLO related codes and description
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Markus Armbruster <armbru@redhat.com>, qemu-dev <qemu-devel@nongnu.org>
Cc: Zhang Chen <zhangckid@gmail.com>, Zhang Chen <chen.zhang@intel.com>

From: Zhang Chen <chen.zhang@intel.com>

In this series we optimize codes and fix some tiny issues.

Zhang Chen (3):
  migration/colo.c: Remove redundant input parameter
  migration/colo.h: Remove obsolete codes
  qemu-option.hx: Update missed parameter for colo-compare

 include/migration/colo.h  | 4 +---
 migration/colo-failover.c | 2 +-
 migration/colo.c          | 2 +-
 qemu-options.hx           | 9 ++++++---
 4 files changed, 9 insertions(+), 8 deletions(-)

-- 
2.17.GIT
