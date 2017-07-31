Received: from eggs.gnu.org ([2001:4830:134:3::10]:39298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dcASE-0003yx-4Y
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:09:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dcASA-0002su-0e
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:09:50 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:2978)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dcAS9-0002oO-Qc
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:09:45 -0400
From: James Hogan <james.hogan@imgtec.com>
Date: Mon, 31 Jul 2017 14:09:11 +0100
Message-ID: <cover.6535001d6b9cd2357109d19b1060e3f6a2b958a7.1501506432.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/2] mips: KVM T&E segment support for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: James Hogan <james.hogan@imgtec.com>, Yongbok Kim <yongbok.kim@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org

MIPS KVM trap & emulate guest kernels have a different segment layout
compared with traditional MIPS kernels, to allow both the user and
kernel code to run from the user address segment without repeatedly
trapping to KVM.

QEMU currently supports this layout only for KVM, but its sometimes
useful to be able to run these kernels in QEMU on a PC. This patchset
enables it for TCG too.

This also paves the way for MIPS KVM VZ support (which uses the normal
virtual memory layout) by abstracting whether user mode kernel segments
are in use.

Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org

James Hogan (2):
  mips: Improve segment defs for KVM T&E guests
  mips: Add KVM T&E segment support for TCG

 hw/mips/addr.c            | 12 ++++++++++++
 hw/mips/mips_malta.c      | 17 +++++++----------
 include/hw/mips/cpudevs.h |  5 +++--
 target/mips/helper.c      | 27 +++++++++++++--------------
 target/mips/translate.c   |  4 ++--
 5 files changed, 37 insertions(+), 28 deletions(-)

-- 
git-series 0.8.10
