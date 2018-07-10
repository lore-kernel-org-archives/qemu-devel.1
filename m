Received: from eggs.gnu.org ([2001:4830:134:3::10]:50371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fcoTB-00032g-Ux
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 04:58:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fcoT8-0003ty-RT
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 04:58:02 -0400
Received: from mga09.intel.com ([134.134.136.24]:44704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
	id 1fcoT8-0003tC-IO
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 04:57:58 -0400
From: Jingqi Liu <jingqi.liu@intel.com>
Date: Tue, 10 Jul 2018 16:57:31 +0800
Message-Id: <1531213054-63327-1-git-send-email-jingqi.liu@intel.com>
Subject: [Qemu-devel] [PATCH 0/3] x86/cpu: Enable a few new cpu features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: qemu-devel@nongnu.org, wei.w.wang@intel.com, Jingqi Liu <jingqi.liu@intel.com>

Enable a few new cpu features including UMONITOR, UMWAIT, TPAUSE,
MOVDIRI and MOVDIR64B.

UMONITOR, UMWAIT, and TPAUSE are a set of user wait instructions.
MOVDIRI moves doubleword or quadword from register to memory through
direct store.
MOVDIR64B moves 64-bytes as direct-store with 64-bytes write atomicity.

The bits definition:
CPUID.(EAX=7,ECX=0):ECX[bit 05] WAITPKG
CPUID.(EAX=7,ECX=0):ECX[bit 27] MOVDIRI
CPUID.(EAX=7,ECX=0):ECX[bit 28] MOVDIR64B

The release document ref below link:
https://software.intel.com/sites/default/files/managed/c5/15/\
architecture-instruction-set-extensions-programming-reference.pdf

Jingqi Liu (3):
  x86/cpu: Enable UMONITOR/UMWAIT/TPAUSE cpu features
  x86/cpu: Enable MOVDIRI cpu feature
  x86/cpu: Enable MOVDIR64B cpu feature

 target/i386/cpu.c | 6 +++---
 target/i386/cpu.h | 3 +++
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
1.8.3.1
