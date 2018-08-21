Received: from eggs.gnu.org ([2001:4830:134:3::10]:54574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fs9tR-0008LR-QU
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 12:52:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fs9tQ-00056E-OR
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 12:52:33 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Aug 2018 17:52:12 +0100
Message-Id: <20180821165215.29069-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/3] Detabify target/arm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

This patchset removes hardcoded tabs from target/arm.

Normally we're generally against patches which only do style
fixups, preferring to fix up code as we need to touch it.
But in this case, almost all of the tabs are in the old
iwMMXt instruction set handling, which we have not needed
to touch in years, so the "fix as we touch it" process isn't
going to adjust them. Also, since they're changes to
barely-touched code they're not going to cause conflicts with
other work-in-progress in that area or be likely to result in
future pain trying to do stable backports of bugfixes.
So I think it's reasonable to do a bulk fixup in this case,
especially for translate.c, which is a file that sees active
development in other parts of the same file.

This isn't intended to announce an open season for
coding style fixup patches -- that is up to the individual
submaintainer and should not be done unsolicited.

thanks
-- PMM

Peter Maydell (3):
  target/arm: Untabify translate.c
  target/arm: Untabify iwmmxt_helper.c
  target/arm: Remove a handful of stray tabs

 target/arm/cpu.h           |  16 +--
 target/arm/arm-semi.c      |   2 +-
 target/arm/iwmmxt_helper.c | 234 ++++++++++++++++++-------------------
 target/arm/translate.c     | 122 +++++++++----------
 4 files changed, 187 insertions(+), 187 deletions(-)

-- 
2.18.0
