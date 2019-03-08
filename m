Received: from eggs.gnu.org ([209.51.188.92]:45596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1h2CDS-0000wi-4N
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:54:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1h2CDR-0006VK-5E
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:54:58 -0500
Received: from mail.uni-paderborn.de ([131.234.142.9]:49520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1h2CDQ-0006T6-6x
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:54:57 -0500
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Fri,  8 Mar 2019 10:54:31 +0100
Message-Id: <20190308095433.12116-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/2] tricore patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david.brenken@efs-auto.de, christian.richter@efs-auto.de, georg.hofstetter@efs-auto.de, robert.rasche@efs-auto.de, lars.biermanski@efs-auto.de

The following changes since commit 6cb4f6db4f4367faa33da85b15f75bbbd2bed2a6:

  Merge remote-tracking branch 'remotes/cleber/tags/python-next-pull-request' into staging (2019-03-07 16:16:02 +0000)

are available in the Git repository at:

  https://github.com/bkoppelmann/qemu-tricore-upstream.git tags/pull-tricore-2019-03-08

for you to fetch changes up to d1c1d88ce6fd768cb98cd7af81b1b23ac9fe168d:

  tricore: fixed RCR_CADDN instruction (2019-03-08 10:00:59 +0100)

----------------------------------------------------------------
Fixes mixed up operands in CADDN and CADD

----------------------------------------------------------------
David Brenken (2):
      tricore: fixed RCR_CADD instruction
      tricore: fixed RCR_CADDN instruction

 target/tricore/translate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
-- 
2.21.0
