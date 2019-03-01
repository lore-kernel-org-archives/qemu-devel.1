Received: from eggs.gnu.org ([209.51.188.92]:54306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1gzhvC-0006w7-W4
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 08:09:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1gzhvC-0004Ft-4q
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 08:09:50 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:58420 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1gzhvB-0003mX-SF
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 08:09:50 -0500
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Date: Fri,  1 Mar 2019 14:08:36 +0100
Message-Id: <1551445720-19622-1-git-send-email-mateja.marjanovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v2 0/4] target/mips: Optimize support for
 certain MSA instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com

From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>

This series optimizes the support for certain MSA instructions.

v2:
  -Fixed indentation in two places
  -Fixed bugs for the cases when the destination register and
  one of the source registers are the same

Mateja Marjanovic (4):
  target/mips: Optimize support for MSA instructions ILVEV.<B|H|W|D>
  target/mips: Optimize support for MSA instructions ILVOD.<B|H|W|D>
  target/mips: Optimize support for MSA instructions ILVL.<B|H|W|D>
  target/mips: Optimize support for MSA instructions ILVR.<B|H|W|D>

 target/mips/msa_helper.c | 236 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 205 insertions(+), 31 deletions(-)

-- 
2.7.4
