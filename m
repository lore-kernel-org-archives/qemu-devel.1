Received: from eggs.gnu.org ([2001:4830:134:3::10]:56071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dc9iv-0001hS-RW
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:23:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dc9iv-0003ki-0O
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:23:01 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dc9iu-0003ax-PG
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:23:00 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dc9if-0000rv-W3
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 13:22:46 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 31 Jul 2017 13:22:38 +0100
Message-Id: <1501503765-15639-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/7] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

ARM queue for 2.10: all M profile bugfixes...

thanks
-- PMM

The following changes since commit 25dd0e77898c3e10796d4cbeb35e8af5ba6ce975:

  Merge remote-tracking branch 'remotes/mjt/tags/trivial-patches-fetch' into staging (2017-07-31 11:27:43 +0100)

are available in the git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170731

for you to fetch changes up to 89cbc3778a3d61761e2231e740269218c9a8a41d:

  hw/mps2_scc: fix incorrect properties (2017-07-31 13:11:56 +0100)

----------------------------------------------------------------
target-arm queue:
 * fix broken properties on MPS2 SCC device
 * fix MPU trace handling of write vs exec
 * fix MPU M profile bugs:
   - not handling system space or PPB region correctly
   - not resetting state
   - not migrating MPU_RNR

----------------------------------------------------------------
Peter Maydell (6):
      target/arm: Correct MPU trace handling of write vs execute
      target/arm: Don't do MPU lookups for addresses in M profile PPB region
      target/arm: Don't allow guest to make System space executable for M profile
      target/arm: Rename cp15.c6_rgnr to pmsav7.rnr
      target/arm: Move PMSAv7 reset into arm_cpu_reset() so M profile MPUs get reset
      target/arm: Migrate MPU_RNR register state for M profile cores

Philippe Mathieu-Daudé (1):
      hw/mps2_scc: fix incorrect properties

 target/arm/cpu.h      |  3 +--
 hw/intc/armv7m_nvic.c | 14 +++++-----
 hw/misc/mps2-scc.c    |  4 +--
 target/arm/cpu.c      | 14 ++++++++++
 target/arm/helper.c   | 71 ++++++++++++++++++++++++++++++++++-----------------
 target/arm/machine.c  | 30 +++++++++++++++++++++-
 6 files changed, 101 insertions(+), 35 deletions(-)
