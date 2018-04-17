Received: from eggs.gnu.org ([2001:4830:134:3::10]:43522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <saipava@xhdsaipava40.localdomain>)
	id 1f8Qa5-0007qI-8S
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 09:23:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <saipava@xhdsaipava40.localdomain>)
	id 1f8Qa2-000421-24
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 09:23:33 -0400
Received: from mail-by2nam03on0062.outbound.protection.outlook.com
	([104.47.42.62]:11136
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <saipava@xhdsaipava40.localdomain>)
	id 1f8Qa1-00041P-CG
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 09:23:29 -0400
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Date: Tue, 17 Apr 2018 18:53:11 +0530
Message-ID: <1523971392-25164-1-git-send-email-saipava@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1] xilinx_spips dummy bytes fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alistair@alistair23.me, crosthwaite.peter@gmail.com, peter.maydell@linaro.org, edgar.iglesias@gmail.com, frasse.iglesias@gmail.com
Cc: qemu-devel@nongnu.org

For zynq-7000 boards, we saw issues when u-boot/linux accessing the qspi.
Issue is due to wrong dummy byte transfers for few of un-handled commands ex: 0x9F, 0x6, 0xe9, 0x4, 0x18, etc
There are many unhandled commands which do not require dummy bytes but they can be followed by address cycles.

To fix this issue for above commands, the next upcoming tx bytes are not considered dummies rather sent to slave directly.

Sai Pavan Boddu (1):
  xilinx_spips: send dummy only if cmd requires it

 hw/ssi/xilinx_spips.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

-- 
2.7.4
