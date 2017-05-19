Received: from eggs.gnu.org ([2001:4830:134:3::10]:47404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dBcNQ-0007JU-N4
	for qemu-devel@nongnu.org; Fri, 19 May 2017 03:31:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dBcNL-00037X-S8
	for qemu-devel@nongnu.org; Fri, 19 May 2017 03:31:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:61751)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dBcNL-00037L-HQ
	for qemu-devel@nongnu.org; Fri, 19 May 2017 03:31:03 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Fri, 19 May 2017 15:30:20 +0800
Message-Id: <1495179026-27872-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v0 0/6] move the tcg files into tcg directory.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, anthony.xu@intel.com, Yang Zhong <yang.zhong@intel.com>

Move the tcg relative files into tcg directory, which will make
the code more clean in qemu.

Yang Zhong (6):
  move tcg relative files into tcg directory
  move tcg relative files into tcg directory
  move tcg header file
  move tcg relative files into tcg directory
  move tcg relative files into tcg directory
  change tcg relative file's compile definition

 Makefile.objs                                | 1 +
 Makefile.target                              | 8 ++------
 tcg/Makefile.objs                            | 2 ++
 tcg-runtime.c => tcg/tcg-runtime.c           | 0
 tci.c => tcg/tci.c                           | 0
 tcg/trace-events                             | 6 ++++++
 translate-all.c => tcg/translate-all.c       | 2 +-
 translate-all.h => tcg/translate-all.h       | 0
 translate-common.c => tcg/translate-common.c | 0
 trace-events                                 | 3 ---
 10 files changed, 12 insertions(+), 10 deletions(-)
 create mode 100644 tcg/Makefile.objs
 rename tcg-runtime.c => tcg/tcg-runtime.c (100%)
 rename tci.c => tcg/tci.c (100%)
 create mode 100644 tcg/trace-events
 rename translate-all.c => tcg/translate-all.c (99%)
 rename translate-all.h => tcg/translate-all.h (100%)
 rename translate-common.c => tcg/translate-common.c (100%)

-- 
1.9.1
