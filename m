Received: from eggs.gnu.org ([2001:4830:134:3::10]:54575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dFx8i-0002te-8g
	for qemu-devel@nongnu.org; Wed, 31 May 2017 02:29:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dFx8e-00036X-Bw
	for qemu-devel@nongnu.org; Wed, 31 May 2017 02:29:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:50237)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dFx8e-00036B-2i
	for qemu-devel@nongnu.org; Wed, 31 May 2017 02:29:48 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Wed, 31 May 2017 14:28:58 +0800
Message-Id: <1496212144-14947-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v2 0/6] tcg: move the tcg files into tcg/
 subdirectory.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eblake@redhat.com
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, anthony.xu@intel.com, Yang Zhong <yang.zhong@intel.com>

Move the tcg related files into tcg/ subdirectory, which will make
the code more clean in qemu. Next step, we will base on those changes 
to disable tcg.

Yang Zhong (6):
  tcg: move tcg-runtime.c to tcg/ subdirectory
  tcg: move translate-all.c to tcg/ subdirectory
  tcg: move tcg header file
  tcg: move translate-common.c to tcg/ subdirectory
  tcg: move tci.c to tcg/ subdirectory
  tcg: change tcg related file's compile definition

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
