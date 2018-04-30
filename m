Received: from eggs.gnu.org ([2001:4830:134:3::10]:59008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fDAQ0-00061q-WC
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 11:08:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fDAPx-0004yD-M0
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 11:08:44 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:39399)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fDAPx-0004xi-Dv
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 11:08:41 -0400
Received: by mail-lf0-x242.google.com with SMTP id j193-v6so12575394lfg.6
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 08:08:41 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Mon, 30 Apr 2018 17:08:32 +0200
Message-Id: <20180430150837.20470-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 0/5] Xilinx queue 2018-04-30
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

The following changes since commit 6f0c4706b35dead265509115ddbd2a8d1af516c1:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20180427-pull-request' into staging (2018-04-27 12:27:59 +0100)

are available in the git repository at:

  git@github.com:edgarigl/qemu.git tags/edgar/xilinx-next-2018-04-30.for-upstream

for you to fetch changes up to fce6a8eceb07e27f0cdea87427f4e560dfa0b1c8:

  target-microblaze: mmu: Make the TLBX MISS bit read-only (2018-04-30 16:43:20 +0200)

----------------------------------------------------------------
edgar/xilinx-next-2018-01.for-upstream

----------------------------------------------------------------
Edgar E. Iglesias (5):
      target-microblaze: Respect MSR.PVR as read-only
      target-microblaze: Fix trap checks for FPU insns
      target-microblaze: Don't clobber the IMM reg for ld/st reversed
      target-microblaze: mmu: Make TLBSX write-only
      target-microblaze: mmu: Make the TLBX MISS bit read-only

 target/microblaze/mmu.c       | 9 ++++++++-
 target/microblaze/translate.c | 6 ++----
 2 files changed, 10 insertions(+), 5 deletions(-)

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
