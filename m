Received: from eggs.gnu.org ([2001:4830:134:3::10]:40729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gYz8T-0005Df-FZ
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 15:05:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gYz8P-0001U4-Sk
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 15:05:05 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:42687 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gYz8N-0001Pj-Ge
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 15:05:01 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 17 Dec 2018 21:04:38 +0100
Message-Id: <20181217200444.14812-1-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 0/6] target/mips: Amend MXU support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, jancraig@amazon.com, smarkovic@wavecomp.com, amarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Various updates to MXU ASE support.

Aleksandar Markovic (6):
  target/mips: MXU: Add missing opcodes/decoding for LX* instructions
  target/mips: MXU: Add generic naming for optn2 constants
  target/mips: MXU: Improve textual description
  target/mips: MXU: Add handlers for logic instructions
  target/mips: MXU: Add handlers for max/min instructions
  target/mips: MXU: Add handlers for an align instruction

 target/mips/translate.c | 954 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 850 insertions(+), 104 deletions(-)

-- 
2.17.1
