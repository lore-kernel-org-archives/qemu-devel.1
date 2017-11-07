Received: from eggs.gnu.org ([2001:4830:134:3::10]:52454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eC0uu-0000On-Vi
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:15:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eC0up-0007pn-7U
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:15:36 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:38228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eC0uo-0007lV-WE
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:15:31 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  7 Nov 2017 10:15:59 +0000
Message-Id: <1510049762-4609-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 0/3] cocoa queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: programmingkidx@gmail.com

Cocoa patches for rc0.

The following changes since commit 299d1ea9bb56bd9f45f905125489bdd7d543a1aa:

  Merge remote-tracking branch 'remotes/yongbok/tags/mips-20171106' into staging (2017-11-06 16:13:10 +0000)

are available in the git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-cocoa-20171107

for you to fetch changes up to ef2088f9af16d3a19f5f094da160dd8ba52231a9:

  ui/cocoa.m: Send ctrl-alt key combos to guest if QEMU isn't using them (2017-11-07 10:14:14 +0000)

----------------------------------------------------------------
cocoa queue:
 * make scrolling work in GUI monitor windows
 * change ungrab to ctrl-alt-g (matching gtk)
 * pass unused ctrl-alt combos to guest

----------------------------------------------------------------
John Arbuckle (2):
      ui/cocoa.m: Make scrolling work again in GUI monitor windows
      ui/cocoa.m: move ungrab to ctrl-alt-g

Peter Maydell (1):
      ui/cocoa.m: Send ctrl-alt key combos to guest if QEMU isn't using them

 ui/cocoa.m | 135 +++++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 86 insertions(+), 49 deletions(-)
