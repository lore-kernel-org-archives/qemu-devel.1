Received: from eggs.gnu.org ([2001:4830:134:3::10]:36854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dNfEA-0008BY-HX
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:59:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dNfE6-0008S5-Jj
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:59:22 -0400
Received: from mail-lf0-x229.google.com ([2a00:1450:4010:c07::229]:33284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dNfE6-0008RW-Cy
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:59:18 -0400
Received: by mail-lf0-x229.google.com with SMTP id m77so94799212lfe.0
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 05:59:18 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed, 21 Jun 2017 14:59:08 +0200
Message-Id: <1498049955-28646-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v2 0/7] target-microblaze: Add support for BSXFI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, alistai@xilinx.com, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add support for bitfield extract and deposit instructions.
This is based on top of the Misc configurability series
I just sent out:
https://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg04496.html

Cheers,
Edgar

ChangeLog:

v1 -> v2:
* Simplify undef behavior checks for BSIFI
* Add undef behavior checks for BSEFI

Edgar E. Iglesias (7):
  target-microblaze: dec_barrel: Use bool instead of unsigned int
  target-microblaze: dec_barrel: Use extract32
  target-microblaze: dec_barrel: Add braces around if-statements
  target-microblaze: dec_barrel: Plug TCG temp leak
  target-microblaze: dec_barrel: Add BSEFI
  target-microblaze: dec_barrel: Add BSIFI
  target-microblaze: Add CPU version 10.0

 target/microblaze/cpu.c       |  1 +
 target/microblaze/translate.c | 60 +++++++++++++++++++++++++++++++++----------
 2 files changed, 47 insertions(+), 14 deletions(-)

-- 
2.7.4
