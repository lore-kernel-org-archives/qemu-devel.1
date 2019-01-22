Received: from eggs.gnu.org ([209.51.188.92]:37832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <weijiang.yang@intel.com>) id 1gmJHa-0007g7-Fw
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:13:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <weijiang.yang@intel.com>) id 1gmJHZ-0006i5-Ky
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:13:34 -0500
Received: from mga12.intel.com ([192.55.52.136]:53079)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <weijiang.yang@intel.com>)
	id 1gmJHU-0006YX-Im
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:13:30 -0500
From: Yang Weijiang <weijiang.yang@intel.com>
Date: Wed, 23 Jan 2019 05:06:44 +0800
Message-Id: <20190122210648.26320-1-weijiang.yang@intel.com>
Subject: [Qemu-devel] [PATCH v2 0/4] This patch-set is to enable Guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, cdupontd@redhat.com, rkrcmar@redhat.com, qemu-devel@nongnu.org, mst@redhat.com, yu-cheng.yu@intel.com, yi.z.zhang@intel.com, hjl.tools@gmail.com
Cc: weijiang.yang@intel.com

Control-flow Enforcement Technology (CET) provides protection against
return/jump-oriented programming (ROP) attacks. To make kvm Guest OS own
the capability, this patch-set is required. It enables CET related CPUID
report and xsaves/xrstors support etc in qemu.

Changelog:
 v2:
 - In CPUID.(EAX=d, ECX=1), set return ECX[n] = 0 if bit n corresponds 
   to a bit in MSR_IA32_XSS.
 - In CPUID.(EAX=d, ECX=n), set return ECX = 1 if bit n corresponds
   to a bit in MSR_IA32_XSS.
 - Skip Supervisor mode xsave component when calculate User mode
   xave component size in xsave_area_size() and x86_cpu_reset(). 

Yang Weijiang (4):
  Add CET xsaves/xrstors related macros and structures.
  Add CET SHSTK and IBT CPUID feature-word definitions.
  Add hepler functions for CPUID xsave area size calculation.
  Report CPUID xsave area support for CET.

 target/i386/cpu.c | 73 +++++++++++++++++++++++++++++++++++++++++++++--
 target/i386/cpu.h | 36 ++++++++++++++++++++++-
 2 files changed, 105 insertions(+), 4 deletions(-)

-- 
2.17.1
