Received: from eggs.gnu.org ([208.118.235.92]:50656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <weijiang.yang@intel.com>) id 1gc4RH-0005iM-6M
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 03:21:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <weijiang.yang@intel.com>) id 1gc4RD-0005pO-78
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 03:21:15 -0500
Received: from mga06.intel.com ([134.134.136.31]:14739)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <weijiang.yang@intel.com>)
	id 1gc4RB-0005nR-68
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 03:21:11 -0500
From: Yang Weijiang <weijiang.yang@intel.com>
Date: Wed, 26 Dec 2018 16:25:16 +0800
Message-Id: <cover.1545806972.git.weijiang.yang@intel.com>
Subject: [Qemu-devel] [PATCH 0/4] This patch-set is to enable Guest CET
 support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, rkrcmar@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com, yu-cheng.yu@intel.com, yi.z.zhang@intel.com, hjl.tools@gmail.com
Cc: Yang Weijiang <weijiang.yang@intel.com>

Control-flow Enforcement Technology (CET) provides protection against
return/jump-oriented programming (ROP) attacks. To make kvm Guest OS
own the capability, this patch-set is required. It enables CET related
CPUID report and xsaves/xrstors support etc in qemu.

Yang Weijiang (4):
  Add CET xsaves/xrstors related macros and structures.
  Add CET SHSTK and IBT CPUID feature-word definitions.
  Add hepler functions for CPUID xsave area size calculation.
  Report CPUID xsave area support for CET.

 target/i386/cpu.c | 67 ++++++++++++++++++++++++++++++++++++++++++++---
 target/i386/cpu.h | 36 ++++++++++++++++++++++++-
 2 files changed, 99 insertions(+), 4 deletions(-)

-- 
2.17.1
