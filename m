Received: from eggs.gnu.org ([2001:4830:134:3::10]:32807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ea6Wq-0008Kv-O6
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 16:06:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ea6Wn-0002hx-KW
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 16:06:20 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:34987)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ea6Wn-0002gx-DG
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 16:06:17 -0500
Received: by mail-pg0-x241.google.com with SMTP id d6so5352938pgv.2
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 13:06:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 12 Jan 2018 13:06:09 -0800
Message-Id: <20180112210613.14124-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 0/4] TCG queued patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, aurelien@aurel32.net

This includes a fix for the tcg/arm bug exposed by the ppc64 code change
for comparisons.

It also includes improvements to tcg/arm and tcg/ppc to allow for larger
CPUFooState structures, as exposed by expanding CPUARMState for 2048-bit
vector registers.

Note that tcg/mips has the exact same problem.  However, the mips isa
makes it more difficult to fix up.  I'd like someone with hardware to
make this change.



r~



The following changes since commit 7398166ddf7c6dbbc9cae6ac69bb2feda14b40ac:

  Merge remote-tracking branch 'remotes/kraxel/tags/vnc-20180112-pull-request' into staging (2018-01-12 16:01:30 +0000)

are available in the Git repository at:

  git://github.com/rth7680/qemu.git tags/pull-tcg-20180112

for you to fetch changes up to bb08c35b17b7245c696bd12e527453e624e77da3:

  tcg/ppc: Allow a 32-bit offset to the constant pool (2018-01-12 12:50:36 -0800)

----------------------------------------------------------------
Queued tcg patches

----------------------------------------------------------------
Richard Henderson (4):
      tcg/arm: Fix double-word comparisons
      tcg/arm: Support tlb offsets larger than 64k
      tcg/ppc: Support tlb offsets larger than 64k
      tcg/ppc: Allow a 32-bit offset to the constant pool

 tcg/arm/tcg-target.inc.c | 142 ++++++++++++++++++++++++++++++++---------------
 tcg/ppc/tcg-target.inc.c |  84 ++++++++++++++++------------
 2 files changed, 144 insertions(+), 82 deletions(-)
