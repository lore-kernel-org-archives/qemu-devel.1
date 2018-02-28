Received: from eggs.gnu.org ([2001:4830:134:3::10]:35413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er7Rs-0003FH-Nm
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:31:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er7Ro-0006Df-TH
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:31:32 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:43934)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1er7Ro-0006D9-NC
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:31:28 -0500
Received: by mail-pf0-x244.google.com with SMTP id z14so1408308pfe.10
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 11:31:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 28 Feb 2018 11:31:09 -0800
Message-Id: <20180228193125.20577-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 00/16] ARM v8.1 simd + v8.3 complex insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

I believe I've incorporated all of Peter's feedback from v2.
This is based on target-arm.next, which now contains Alex's fp16 work.

Re-tested our standard aarch64 risu tests with -cpu cortex-a57,
and against the new risu tests I posted this morning for aa64 and aa32.


r~


Richard Henderson (16):
  target/arm: Add ARM_FEATURE_V8_RDM
  target/arm: Refactor disas_simd_indexed decode
  target/arm: Refactor disas_simd_indexed size checks
  target/arm: Decode aa64 armv8.1 scalar three same extra
  target/arm: Decode aa64 armv8.1 three same extra
  target/arm: Decode aa64 armv8.1 scalar/vector x indexed element
  target/arm: Decode aa32 armv8.1 three same
  target/arm: Decode aa32 armv8.1 two reg and a scalar
  target/arm: Enable ARM_FEATURE_V8_RDM
  target/arm: Add ARM_FEATURE_V8_FCMA
  target/arm: Decode aa64 armv8.3 fcadd
  target/arm: Decode aa64 armv8.3 fcmla
  target/arm: Decode aa32 armv8.3 3-same
  target/arm: Decode aa32 armv8.3 2-reg-index
  target/arm: Decode t32 simd 3reg and 2reg_scalar extension
  target/arm: Enable ARM_FEATURE_V8_FCMA

 target/arm/cpu.h           |   2 +
 target/arm/helper.h        |  31 +++
 linux-user/elfload.c       |   2 +
 target/arm/cpu.c           |   2 +
 target/arm/cpu64.c         |   2 +
 target/arm/translate-a64.c | 514 ++++++++++++++++++++++++++++++++++++---------
 target/arm/translate.c     | 275 +++++++++++++++++++++---
 target/arm/vec_helper.c    | 429 +++++++++++++++++++++++++++++++++++++
 target/arm/Makefile.objs   |   2 +-
 9 files changed, 1133 insertions(+), 126 deletions(-)
 create mode 100644 target/arm/vec_helper.c

-- 
2.14.3
