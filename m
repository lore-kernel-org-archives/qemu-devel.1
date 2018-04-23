Received: from eggs.gnu.org ([2001:4830:134:3::10]:55322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fAae2-0001U0-Mo
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 08:32:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fAadx-000871-Q6
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 08:32:34 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:39888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fAadx-00086U-IB
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 08:32:29 -0400
Received: by mail-lf0-x241.google.com with SMTP id p142-v6so14686038lfd.6
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 05:32:29 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Mon, 23 Apr 2018 14:32:20 +0200
Message-Id: <20180423123225.30503-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v2 0/5] target-microblaze: Misc bug fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, sai.pavan.boddu@xilinx.com, alistair@alistair23.me, frasse.iglesias@gmail.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Hi,

This is a series of fixes for bugs I ran into when adding support
for extended addressing. It would be nice to get these into 2.12
if it's not too late.

Cheers,
Edgar

ChangeLog:

v1 -> v2:
* Corrected fix making MSR.PVR read-only.

Edgar E. Iglesias (5):
  target-microblaze: Respect MSR.PVR as read-only
  target-microblaze: Fix trap checks for FPU insns
  target-microblaze: Don't clobber the IMM reg for ld/st reversed
  target-microblaze: mmu: Make TLBSX write-only
  target-microblaze: mmu: Make the TLBX MISS bit read-only

 target/microblaze/mmu.c       | 9 ++++++++-
 target/microblaze/translate.c | 6 ++----
 2 files changed, 10 insertions(+), 5 deletions(-)

-- 
2.14.1
