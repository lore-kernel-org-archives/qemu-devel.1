Received: from eggs.gnu.org ([2001:4830:134:3::10]:38959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dNLRF-00050t-2l
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 11:51:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dNLRB-0003xn-U4
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 11:51:33 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:32878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dNLRB-0003xA-NS
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 11:51:29 -0400
Received: by mail-lf0-x241.google.com with SMTP id u62so15459040lfg.0
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 08:51:29 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 20 Jun 2017 17:51:18 +0200
Message-Id: <1497973886-26257-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 0/8] target-microblaze: Misc configurability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistai@xilinx.com, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Fixes and a few additional properties to control the configuration
of the CPU. The property names are taken from the device-tree bindings.

Cheers,
Edgar

Edgar E. Iglesias (8):
  target-microblaze: Correct bit shift for the PVR0 version field
  target-microblaze: Don't hard code 0xb as initial MB version
  target-microblaze: Add CPU versions 9.4, 9.5 and 9.6
  target-microblaze: Introduce a use-barrel property
  target-microblaze: Introduce a use-div property
  target-microblaze: Introduce a use-hw-mul property
  target-microblaze: Introduce a use-msr-instr property
  target-microblaze: Introduce a use-pcmp-instr property

 target/microblaze/cpu.c       | 38 ++++++++++++++++++++++++--------------
 target/microblaze/cpu.h       |  7 +++++++
 target/microblaze/translate.c | 17 ++++++++---------
 3 files changed, 39 insertions(+), 23 deletions(-)

-- 
2.7.4
