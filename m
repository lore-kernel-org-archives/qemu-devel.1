Received: from eggs.gnu.org ([2001:4830:134:3::10]:42045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cS86t-0001hv-Pf
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:06:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cS86s-00057q-M2
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:06:03 -0500
Received: from mail-yb0-x243.google.com ([2607:f8b0:4002:c09::243]:36567)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cS86s-00056w-IO
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:06:02 -0500
Received: by mail-yb0-x243.google.com with SMTP id l23so2166274ybj.3
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 12:06:02 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 13 Jan 2017 12:05:52 -0800
Message-Id: <20170113200556.2574-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 0/4] tcg fixes
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

Two problems found with my most recent tcg-2.9 queued patches;
two patches for tcg/aarch64 that had been submitted but somehow
dropped off the patch queue.

With this, aarch64 risu passes on aarch64 again.


r~


The following changes since commit b6af8ea60282df514f87d32e36afd1c9aeee28c8:

  Merge remote-tracking branch 'remotes/ehabkost/tags/x86-and-machine-pull-request' into staging (2017-01-13 14:38:21 +0000)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-tcg-20170113

for you to fetch changes up to 8cf9a3d3f7a4b95f33e0bda5416b9c93ec887dd3:

  tcg/aarch64: Fix tcg_out_movi (2017-01-13 11:47:29 -0800)

----------------------------------------------------------------
Fixes and more queued patches

----------------------------------------------------------------
Richard Henderson (4):
      tcg/s390: Fix merge error with facilities
      target/arm: Fix ubfx et al for aarch64
      tcg/aarch64: Fix addsub2 for 0+C
      tcg/aarch64: Fix tcg_out_movi

 target/arm/translate-a64.c   |  2 +-
 tcg/aarch64/tcg-target.inc.c | 66 ++++++++++++++++++++++----------------------
 tcg/s390/tcg-target.inc.c    |  2 +-
 3 files changed, 35 insertions(+), 35 deletions(-)
