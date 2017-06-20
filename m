Received: from eggs.gnu.org ([2001:4830:134:3::10]:44736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dNLiK-0002tN-0t
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 12:09:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dNLiF-0003Wh-Vd
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 12:09:12 -0400
Received: from mail-lf0-x22b.google.com ([2a00:1450:4010:c07::22b]:33286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dNLiF-0003Vs-NN
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 12:09:07 -0400
Received: by mail-lf0-x22b.google.com with SMTP id m77so77912982lfe.0
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 09:09:07 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 20 Jun 2017 18:08:57 +0200
Message-Id: <1497974944-27050-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 0/7] target-microblaze: Add support for BSXFI
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

Cheers,
Edgar

Edgar E. Iglesias (7):
  target-microblaze: dec_barrel: Use bool instead of unsigned int
  target-microblaze: dec_barrel: Use extract32
  target-microblaze: dec_barrel: Add braces around if-statements
  target-microblaze: dec_barrel: Plug TCG temp leak
  target-microblaze: dec_barrel: Add BSEFI
  target-microblaze: dec_barrel: Add BSIFI
  target-microblaze: Add CPU version 10.0

 target/microblaze/cpu.c       |  1 +
 target/microblaze/translate.c | 54 ++++++++++++++++++++++++++++++++-----------
 2 files changed, 41 insertions(+), 14 deletions(-)

-- 
2.7.4
