Received: from eggs.gnu.org ([2001:4830:134:3::10]:34186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dhdHX-0005Ir-Th
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:57:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dhdHT-0004I2-Ul
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:57:23 -0400
Received: from mail-pg0-x233.google.com ([2607:f8b0:400e:c05::233]:34696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dhdHT-0004H3-Nc
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:57:19 -0400
Received: by mail-pg0-x233.google.com with SMTP id u185so7108457pgb.1
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 07:57:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 15 Aug 2017 07:57:11 -0700
Message-Id: <20170815145714.17635-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 for-2.10 0/3] Fixup logic for exclusive pair
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alistair.francis@xilinx.com, edgar.iglesias@xilinx.com

In reviewing my previous patch, Peter pointed out that it is
CONSTRAINED UNPREDICTABLE what happens when you mix the number
of registers in a LDX[PR] + STX[RP] pair.  So most of the bug
that I thought that I was fixing isn't a bug at all.

That said, the patch does still fix a real bug wrt single-copy
semantics, so patch 2 is largely unchanged; the commit message
is re-worded.

I also un-squashed Alistair's original patches and dropped the
tcg/tcg-op.c change, to be revisited for 2.11.


r~


Alistair Francis (2):
  target/arm: Correct exclusive store cmpxchg memop mask
  target/arm: Require alignment for load exclusive

Richard Henderson (1):
  target/arm: Correct load exclusive pair atomicity

 target/arm/translate-a64.c | 63 ++++++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 24 deletions(-)

-- 
2.13.4
