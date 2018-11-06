Received: from eggs.gnu.org ([2001:4830:134:3::10]:60228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gJzgy-0008Hr-P3
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:38:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gJzgw-0004Ma-Ah
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:38:44 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52310)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gJzgq-00049H-KG
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:38:36 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gJzgj-0007cN-Ea
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 11:38:29 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  6 Nov 2018 11:38:21 +0000
Message-Id: <20181106113826.25810-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/5] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Handful of bugfix patches for arm for rc0; also
one milkymist patch, thrown in since I was putting
the pullreq together anyway.

thanks
-- PMM

The following changes since commit 03c1ca1c51783603d42eb0f91d35961f0f4b4947:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20181105' into staging (2018-11-06 09:10:46 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20181106

for you to fetch changes up to 23463e0e4aeb2f0a9c60549a2c163f4adc0b8512:

  target/arm: Fix ATS1Hx instructions (2018-11-06 11:32:14 +0000)

----------------------------------------------------------------
target-arm queue:
 * Remove can't-happen if() from handle_vec_simd_shli()
 * hw/arm/exynos4210: Zero memory allocated for Exynos4210State
 * Set S and PTW in 64-bit PAR format
 * Fix ATS1Hx instructions
 * milkymist: Check for failure trying to load BIOS image

----------------------------------------------------------------
Peter Maydell (5):
      target/arm: Remove can't-happen if() from handle_vec_simd_shli()
      milkymist: Check for failure trying to load BIOS image
      hw/arm/exynos4210: Zero memory allocated for Exynos4210State
      target/arm: Set S and PTW in 64-bit PAR format
      target/arm: Fix ATS1Hx instructions

 hw/arm/exynos4210.c        |  2 +-
 hw/lm32/milkymist.c        |  5 ++++-
 target/arm/helper.c        | 14 ++++++++------
 target/arm/translate-a64.c |  8 +++-----
 4 files changed, 16 insertions(+), 13 deletions(-)
