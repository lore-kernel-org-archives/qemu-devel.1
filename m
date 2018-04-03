Received: from eggs.gnu.org ([2001:4830:134:3::10]:38216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1f3NzD-0008VU-EE
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:36:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1f3NzA-0008Am-7w
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:36:39 -0400
Received: from mout.web.de ([212.227.15.3]:54891)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.kiszka@web.de>) id 1f3Nz9-0008AH-UP
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:36:36 -0400
From: Jan Kiszka <jan.kiszka@web.de>
Date: Tue,  3 Apr 2018 17:36:10 +0200
Message-Id: <cover.1522769774.git.jan.kiszka@web.de>
Subject: [Qemu-devel] [PATCH v2 0/4] target-i386: Enhance SVM support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Valentine Sinitsyn <valentine.sinitsyn@gmail.com>

These patches allow to run Jailhouse in emulated x86-64 mode under QEMU.
AMD IOMMU only works with one additional hack, but that's a different
story, and we can test these changes without it.

Change in v2:
 - build fix for 32-bit hosts
 - replaces NPT exitinfo magics with symbolic constants

Jan

Jan Kiszka (4):
  target-i386: Add NMI interception to SVM
  target-i386: Allow interrupt injection after STGI
  target-i386: Mark cpu_vmexit noreturn
  target-i386: Add NPT support

 target/i386/cpu.c         |   2 +-
 target/i386/cpu.h         |  10 ++-
 target/i386/excp_helper.c | 216 +++++++++++++++++++++++++++++++++++++++++++++-
 target/i386/mem_helper.c  |   6 +-
 target/i386/seg_helper.c  |   1 +
 target/i386/svm.h         |  14 +++
 target/i386/svm_helper.c  |  23 +++++
 target/i386/translate.c   |   3 +-
 8 files changed, 266 insertions(+), 9 deletions(-)

-- 
2.13.6
