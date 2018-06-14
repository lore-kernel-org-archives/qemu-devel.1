Received: from eggs.gnu.org ([2001:4830:134:3::10]:50189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fTYnt-0002UG-L6
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:25:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fTYnq-000690-F8
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:25:09 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:41595)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fTYnq-00067X-5N
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:25:06 -0400
Received: by mail-lf0-x243.google.com with SMTP id d24-v6so11380513lfa.8
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 13:25:05 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu, 14 Jun 2018 22:25:00 +0200
Message-Id: <20180614202502.668-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 0/2] target-microblaze: Coverity fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, frasse.iglesias@gmail.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

This series has fixes for the Coverity issues that Peter Maydell
reported.

CID 1391441
CID 1391443

Best regards,
Edgar


Edgar E. Iglesias (2):
  target-microblaze: mmu: Correct masking of output addresses
  target-microblaze: Rework NOP/zero instruction handling

 target/microblaze/mmu.c       |  1 -
 target/microblaze/translate.c | 15 ++++-----------
 2 files changed, 4 insertions(+), 12 deletions(-)

-- 
2.14.1
