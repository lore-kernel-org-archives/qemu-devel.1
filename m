Received: from eggs.gnu.org ([2001:4830:134:3::10]:48182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gR3aF-0001TT-0l
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 18:13:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gR3aD-0005r0-8D
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 18:12:59 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133]:44280)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gR3aB-0005pG-M4
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 18:12:57 -0500
Received: by mail-lf1-x133.google.com with SMTP id z13so12151025lfe.11
	for <qemu-devel@nongnu.org>; Sun, 25 Nov 2018 15:12:54 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 25 Nov 2018 15:12:36 -0800
Message-Id: <20181125231236.22252-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PULL 0/4] target/xtensa fixes for 3.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>

Hi Peter,

please pull the following batch of fixes for target/xtensa.

The following changes since commit 47c1cc30e440860aa695358f7c2dd0b9d7b53d16:

  Update version for v3.1.0-rc2 release (2018-11-20 18:10:26 +0000)

are available in the git repository at:

  git://github.com/OSLL/qemu-xtensa.git tags/20181125-xtensa

for you to fetch changes up to 895e4897e278572e5265e0333f5e9864be2704a6:

  MAINTAINERS: add missing xtensa patterns (2018-11-22 21:16:43 -0800)

----------------------------------------------------------------
xtensa fixes for 3.1:

- fix register counting logic for linux-user gdbserver;
- provide default memory sizes for XTFPGA boards;
- add missing xtensa patterns to MAINTAINTERS.

----------------------------------------------------------------
Max Filippov (4):
      target/xtensa: gdbstub fix register counting
      target/xtensa: drop num_[core_]regs from dc232b/dc233c configs
      target/xtensa: xtfpga: provide default memory sizes
      MAINTAINERS: add missing xtensa patterns

 MAINTAINERS                                |  2 ++
 hw/xtensa/xtfpga.c                         | 10 ++++++++++
 target/xtensa/core-dc232b.c                |  2 --
 target/xtensa/core-dc232b/gdb-config.inc.c |  1 +
 target/xtensa/core-dc233c.c                |  2 --
 target/xtensa/core-dc233c/gdb-config.inc.c |  1 +
 target/xtensa/gdbstub.c                    | 11 ++++++++---
 7 files changed, 22 insertions(+), 7 deletions(-)
