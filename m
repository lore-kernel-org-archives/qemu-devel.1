Received: from eggs.gnu.org ([2001:4830:134:3::10]:48276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cl1Fu-0001er-Bb
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 17:37:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cl1Fq-0008CO-Bl
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 17:37:26 -0500
Received: from mail-pg0-x236.google.com ([2607:f8b0:400e:c05::236]:35958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1cl1Fq-0008Bb-6K
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 17:37:22 -0500
Received: by mail-pg0-x236.google.com with SMTP id 187so17201646pgb.3
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 14:37:20 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon,  6 Mar 2017 14:37:08 -0800
Message-Id: <1488839828-4231-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PULL 0/2] xtensa updates
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

please pull the following batch of updates for target/xtensa.

The following changes since commit 10f25e4844cb9b3f02fb032f88051dd5b65b4206:

  Merge remote-tracking branch 'remotes/yongbok/tags/mips-20170222' into staging (2017-02-23 09:59:40 +0000)

are available in the git repository at:

  git://github.com/OSLL/qemu-xtensa.git tags/20170306-xtensa

for you to fetch changes up to cb3825b9afdb1800cef1be9c9a732c803d8bb29e:

  target/xtensa: add two missing headers to core import script (2017-02-23 10:50:56 -0800)

----------------------------------------------------------------
target/xtensa updates:

- instantiate local memories in xtensa sim machine;
- add two missing include files to xtensa core importing script.

----------------------------------------------------------------
Max Filippov (2):
      target/xtensa: sim: instantiate local memories
      target/xtensa: add two missing headers to core import script

 hw/xtensa/sim.c              |  40 ++++++++---
 target/xtensa/cpu.h          |  16 +++++
 target/xtensa/import_core.sh |   2 +
 target/xtensa/overlay_tool.h | 160 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 209 insertions(+), 9 deletions(-)

-- 
Thanks.
-- Max
