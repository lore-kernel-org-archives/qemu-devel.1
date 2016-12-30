Received: from eggs.gnu.org ([2001:4830:134:3::10]:34374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cMsyy-0008Eu-9O
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 03:56:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cMsyv-00089q-7U
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 03:56:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cMsyv-00089K-1I
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 03:56:09 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri, 30 Dec 2016 16:55:52 +0800
Message-Id: <1483088160-6714-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH 0/8] VT-d ioapic irq test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: Jan Kiszka <jan.kiszka@web.de>, Paolo Bonzini <pbonzini@redhat.com>, agordeev@redhat.com, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Andrew Jones <drjones@redhat.com>, peterx@redhat.com

The previous vt-d unittest series only contains the very basic tests.
Let's enlarge it step by step.

This series expanded it with IOAPIC irq test.

Peter Xu (8):
  pci: introduce pci_intx_line()
  pci: introduce pci_msi_set_enable()
  lib/asm-generic: add atomic.h
  x86: ioapic: generalize trigger mode
  intel-iommu: add report prefixes
  intel-iommu: use atomic ops for irte index alloc
  intel-iommu: allow setup trigger mode for irte
  intel-iommu: add ioapic irq test

 lib/asm-generic/atomic.h | 21 ++++++++++++++++++
 lib/pci.c                | 24 ++++++++++++++++++--
 lib/pci.h                |  2 ++
 lib/x86/apic.h           |  6 +++++
 lib/x86/atomic.h         |  2 ++
 lib/x86/intel-iommu.c    | 58 +++++++++++++++++++++++++++++++++++++++++++-----
 lib/x86/intel-iommu.h    |  3 +++
 x86/intel-iommu.c        | 50 ++++++++++++++++++++++++++++++++++++-----
 x86/ioapic.c             | 34 +++++++++++++---------------
 9 files changed, 169 insertions(+), 31 deletions(-)
 create mode 100644 lib/asm-generic/atomic.h

-- 
2.7.4
