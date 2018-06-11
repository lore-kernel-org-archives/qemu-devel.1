Received: from eggs.gnu.org ([2001:4830:134:3::10]:60772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fSMNJ-00016S-HE
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:56:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fSMNI-0006sU-Ql
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:56:45 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fSMNI-0006nu-JS
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:56:44 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Jun 2018 13:56:31 +0100
Message-Id: <20180611125633.32755-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/2] cputlb: document iotlb.addr,
 fix txfail physaddr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>

This patchset is two vaguely related patches that I wrote
while I was trying to understand the cputlb code enough to
add support for small-MPU-regions for v7M/v8M.

Patch 1 is just a docs comment patch, describing what the
CPUIOTLBEntry 'addr' field actually contains.

Patch 2 fixes a bug that doesn't yet have any visible effects
(we were passing cpu_transaction_failed() the wrong value for
the physaddr) roughly as suggested by Paolo back in
https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg02419.html

thanks
-- PMM

Peter Maydell (2):
  cpu-defs.h: Document CPUIOTLBEntry 'addr' field
  cputlb: Pass cpu_transaction_failed() the correct physaddr

 include/exec/cpu-defs.h |  9 +++++++
 include/exec/exec-all.h | 13 ++++++++--
 accel/tcg/cputlb.c      | 56 +++++++++++++++++++++++++++++++----------
 exec.c                  |  5 ++--
 4 files changed, 66 insertions(+), 17 deletions(-)

-- 
2.17.1
