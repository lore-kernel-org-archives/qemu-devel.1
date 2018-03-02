Received: from eggs.gnu.org ([2001:4830:134:3::10]:56407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1erjK2-0001oG-PD
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:57:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1erjJy-0001zo-Ql
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:57:58 -0500
Received: from mail.uni-paderborn.de ([131.234.142.9]:46778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1erjJy-0001xs-DT
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:57:54 -0500
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Fri,  2 Mar 2018 12:57:39 +0100
Message-Id: <20180302115743.3409-1-kbastian@mail.uni-paderborn.de>
Subject: [Qemu-devel] [PULL 0/4] tricore-patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org

The following changes since commit 427cbc7e4136a061628cb4315cc8182ea36d772f:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2018-03-01 18:46:41 +0000)

are available in the Git repository at:

  https://github.com/bkoppelmann/qemu-tricore-upstream.git tags/pull-tricore-2018-03-02

for you to fetch changes up to ce46335c9f31f9eea1736d9c2d3a11d3a8c2cb6b:

  tricore: renamed masking of PIE (2018-03-02 11:46:36 +0100)

----------------------------------------------------------------
tricore patches

----------------------------------------------------------------
David Brenken (4):
      tricore: added some missing cpu instructions
      tricore: added CORE_ID
      tricore: renamed masking of IE
      tricore: renamed masking of PIE

 target/tricore/cpu.h             |  7 +++++--
 target/tricore/csfr.def          |  1 +
 target/tricore/op_helper.c       | 29 +++++++++++++++--------------
 target/tricore/translate.c       | 31 +++++++++++++++++++++++++++++--
 target/tricore/tricore-opcodes.h |  3 +++
 5 files changed, 53 insertions(+), 18 deletions(-)
