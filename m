Received: from eggs.gnu.org ([2001:4830:134:3::10]:39455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1f97dE-0006Ko-Mw
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 07:21:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1f97d9-00081r-4d
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 07:21:40 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:36039)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1f97d8-0007zk-Td
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 07:21:35 -0400
Received: by mail-lf0-x243.google.com with SMTP id d20-v6so274178lfe.3
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 04:21:34 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu, 19 Apr 2018 13:21:26 +0200
Message-Id: <20180419112131.16932-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 0/5] target-microblaze: Misc bug fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, sai.pavan.boddu@xilinx.com, alistair@alistair23.me, frasse.iglesias@gmail.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Hi,

This is a series of fixes for bugs I ran into when adding support
for extended addressing. It would be nice to get these into 2.12
if it's not too late.

Cheers,
Edgar

Edgar E. Iglesias (5):
  target-microblaze: Respect MSR.PVR as read-only
  target-microblaze: Fix trap checks for FPU insns
  target-microblaze: Don't clobber the IMM reg for ld/st reversed
  target-microblaze: mmu: Make TLBSX write-only
  target-microblaze: mmu: Make the TLBX MISS bit read-only

 target/microblaze/cpu.h       |  4 +++-
 target/microblaze/mmu.c       |  9 ++++++++-
 target/microblaze/translate.c | 12 ++----------
 3 files changed, 13 insertions(+), 12 deletions(-)

-- 
2.14.1
