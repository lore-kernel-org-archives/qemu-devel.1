Received: from eggs.gnu.org ([2001:4830:134:3::10]:38753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1ejNjU-0005DJ-7s
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:17:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1ejNjP-0005d2-Al
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:17:44 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:56169)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1ejNjP-0005cb-2m
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:17:39 -0500
Received: by mail-wm0-x242.google.com with SMTP id 143so2415854wma.5
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 03:17:39 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed,  7 Feb 2018 11:17:24 +0000
Message-Id: <20180207111729.15737-1-ard.biesheuvel@linaro.org>
Subject: [Qemu-devel] [PATCH v6 0/5] target-arm: add SHA-3,
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

Changes since v5:
- fix use of same register for destination and source in SHA-512 code
- use correct free() function in SHA-3 code
- drop helper for sm3ss1 in SM3 code
- include fixed version of SM4 (correct # of iterations)
- enable SM4 in user mode emulator

Changes since v4:
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

Ard Biesheuvel (5):
  target/arm: implement SHA-512 instructions
  target/arm: implement SHA-3 instructions
  target/arm: implement SM3 instructions
  target/arm: implement SM4 instructions
  target/arm: enable user-mode SHA-3, SM3, SM4 and SHA-512 instruction
    support

 linux-user/elfload.c       |  19 ++
 target/arm/cpu.h           |   4 +
 target/arm/cpu64.c         |   4 +
 target/arm/crypto_helper.c | 277 +++++++++++++++-
 target/arm/helper.h        |  12 +
 target/arm/translate-a64.c | 340 ++++++++++++++++++++
 6 files changed, 655 insertions(+), 1 deletion(-)

-- 
2.11.0
