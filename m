Received: from eggs.gnu.org ([209.51.188.92]:48584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <weijiang.yang@intel.com>) id 1gyWTF-0003qA-Tw
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 01:44:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <weijiang.yang@intel.com>) id 1gyWTD-0000ob-KR
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 01:44:05 -0500
Received: from mga06.intel.com ([134.134.136.31]:26985)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <weijiang.yang@intel.com>)
	id 1gyWT9-0000Wk-Ie
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 01:44:01 -0500
From: Yang Weijiang <weijiang.yang@intel.com>
Date: Mon, 25 Feb 2019 21:37:39 +0800
Message-Id: <20190225133744.7095-1-weijiang.yang@intel.com>
Subject: [Qemu-devel] RESEND: [PATCH v3 0/5] This patch-set is to enable
 Guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, cdupontd@redhat.com, rkrcmar@redhat.com, qemu-devel@nongnu.org, mst@redhat.com
Cc: Yang Weijiang <weijiang.yang@intel.com>

Control-flow Enforcement Technology (CET) provides protection against
return/jump-oriented programming (ROP) attacks. To make kvm Guest OS own
the capability, this patch-set is required. It enables CET related CPUID
report, xsaves/xrstors and live-migration etc. in Qemu.

Changelog:

 v3:
 - Add CET MSR save/restore support for live-migration.

 v2:
 - In CPUID.(EAX=d, ECX=1), set return ECX[n] = 0 if bit n corresponds
   to a bit in MSR_IA32_XSS.
 - In CPUID.(EAX=d, ECX=n), set return ECX = 1 if bit n corresponds
   to a bit in MSR_IA32_XSS.
 - Skip Supervisor mode xsave component when calculate User mode
   xave component size in xsave_area_size() and x86_cpu_reset().

Yang Weijiang (5):
  Add CET xsaves/xrstors related macros and structures.
  Add CET SHSTK and IBT CPUID feature-word definitions.
  Add hepler functions for CPUID xsave area size calculation.
  Report CPUID xsave area support for CET.
  Add CET MSR save/restore support for migration

 target/i386/cpu.c     |  73 ++++++++++++++++++++++++++++--
 target/i386/cpu.h     |  48 +++++++++++++++++++-
 target/i386/kvm.c     |  27 ++++++++++++
 target/i386/machine.c | 100 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 244 insertions(+), 4 deletions(-)

-- 
2.17.1
