Received: from eggs.gnu.org ([2001:4830:134:3::10]:41042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gKj5g-0005lE-JK
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:07:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gKj5X-0003Kw-NK
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:07:14 -0500
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Thu,  8 Nov 2018 13:06:26 +0100
Message-Id: <20181108120628.29926-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/2] target/riscv: Bugfixes found in decodetree
 conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kbastian@mail.uni-paderborn.de, mjc@sifive.com, sagark@eecs.berkeley.edu, palmer@sifive.com, Alistair.Francis@wdc.com
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org

Hi,

while going through the reviews of the riscv-decodetree patches, two bugs came
up that I fix here. There is one more problem [1] mentioned by Richard but 
I don't have the time to investigate it further.

[1] https://patchwork.kernel.org/patch/10650293/

Bastian Koppelmann (2):
  target/riscv: Fix FCLASS_D being treated as RV64 only
  target/riscv: Fix sfence.vm/a both available in any priv version

 target/riscv/translate.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

-- 
2.19.1
