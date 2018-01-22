Received: from eggs.gnu.org ([2001:4830:134:3::10]:44685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1edfs0-0006yM-Aa
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 12:27:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1edfrx-0004cB-88
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 12:26:56 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:43980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1edfrx-0004bM-0z
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 12:26:53 -0500
Received: by mail-wm0-x241.google.com with SMTP id g1so17768027wmg.2
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 09:26:52 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 22 Jan 2018 17:26:39 +0000
Message-Id: <20180122172643.29742-1-ard.biesheuvel@linaro.org>
Subject: [Qemu-devel] [PATCH v5 0/4] target-arm: add SHA-3,
 SM3 and SHA512 instruction support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>

Changes sinve v4:
- restructure code changes to make it easier on the reviewer
- add Peter's R-b to #4

Changes since v3:
- don't bother with helpers for the SHA3 instructions: they are simple enough
  to be emitted as TCG ops directly
- rebase onto Richard's pending SVE work

Changes since v2:
- fix thinko in big-endian aware handling of 64-bit quantities: this is not
  needed given that the NEON registers are represented as arrays of uint64_t
  so they always appear in the correct order.
- add support for SM3 instructions (Chinese SHA derivative)

Changes since v1:
- update SHA512 patch to adhere more closely to the existing style, and to
  the way the instruction encodings are classified in the ARM ARM (#1)
- add patch implementing the new SHA3 instructions EOR3/RAX1/XAR/BCAX (#2)
- enable support for these instructions in user mode emulation (#3)

Ard Biesheuvel (4):
  target/arm: implement SHA-512 instructions
  target/arm: implement SHA-3 instructions
  target/arm: implement SM3 instructions
  target/arm: enable user-mode SHA-3, SM3 and SHA-512 instruction
    support

 linux-user/elfload.c       |  18 ++
 target/arm/cpu.h           |   3 +
 target/arm/cpu64.c         |   3 +
 target/arm/crypto_helper.c | 192 +++++++++++-
 target/arm/helper.h        |  10 +
 target/arm/translate-a64.c | 319 ++++++++++++++++++++
 6 files changed, 544 insertions(+), 1 deletion(-)

-- 
2.11.0
