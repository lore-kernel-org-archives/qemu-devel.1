Received: from eggs.gnu.org ([209.51.188.92]:45611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gggxU-0007fv-PX
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 21:17:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gggxT-0002Fp-NV
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 21:17:36 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:42394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gggxS-00028w-QV
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 21:17:35 -0500
Received: by mail-pg1-x529.google.com with SMTP id d72so993691pga.9
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 18:17:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue,  8 Jan 2019 12:17:20 +1000
Message-Id: <20190108021723.14762-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 0/3] target/alpha update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

One quite old queued patch, and two recent bug fixes.


r~


The following changes since commit c102d9471f8f02d9fbea72ec4505d7089173f470:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190107' into staging (2019-01-07 16:56:33 +0000)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-axp-20190108

for you to fetch changes up to ac89de40ef5d4eb1704aa830342a5371413a81dc:

  pc-bios: Update palcode-clipper (2019-01-08 12:12:51 +1000)

----------------------------------------------------------------
Queued target/alpha patches

----------------------------------------------------------------
Peter Maydell (1):
      hw/alpha/typhoon: Stop calling cpu_unassigned_access()

Richard Henderson (2):
      target/alpha: Fix user-only initialization of fpcr
      pc-bios: Update palcode-clipper

 hw/alpha/typhoon.c      |  47 +++++++++++++++++++++++++++--------------------
 target/alpha/cpu.c      |   6 +++---
 pc-bios/palcode-clipper | Bin 152680 -> 155968 bytes
 roms/qemu-palcode       |   2 +-
 4 files changed, 31 insertions(+), 24 deletions(-)
