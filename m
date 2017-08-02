Received: from eggs.gnu.org ([2001:4830:134:3::10]:36131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dcqRD-0003JP-N7
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 05:59:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dcqRA-0002aq-Lu
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 05:59:35 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:50517)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dcqRA-0002Yg-Fh
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 05:59:32 -0400
From: James Hogan <james.hogan@imgtec.com>
Date: Wed, 2 Aug 2017 10:59:14 +0100
Message-ID: <cover.7fbcecb0d0061824a32985f26b9c1b7f816203b0.1501667615.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.10 0/3] target/mips: Fix fallout from
 indirect branch optimisation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: James Hogan <james.hogan@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Richard Henderson <rth@twiddle.net>

Primarily patch 1 fixes some fallout from the recent indirect branch
optimisations in v2.10.0-rc0, where interrupt handling may be delayed
after interrupts are enabled until it is too late.

Patch 2 and 3 then fix a couple of other loosely related issues spotted
in the process or in testing.

Please give a good look (I'm only roughly familiar with icount stuff),
and consider for v2.10.

Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: Richard Henderson <rth@twiddle.net>

James Hogan (3):
  target/mips: Use BS_EXCP where interrupts are expected
  target/mips: Drop redundant gen_io_start/stop()
  target/mips: Fix RDHWR CC with icount

 target/mips/translate.c | 66 ++++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 21 deletions(-)

-- 
git-series 0.8.10
