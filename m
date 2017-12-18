Received: from eggs.gnu.org ([2001:4830:134:3::10]:40850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz9R-0005nL-J6
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:24:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz9Q-0007zH-NZ
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:24:29 -0500
Received: from mail-pf0-x22c.google.com ([2607:f8b0:400e:c00::22c]:37918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQz9Q-0007yV-Hs
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:24:28 -0500
Received: by mail-pf0-x22c.google.com with SMTP id u25so9943732pfg.5
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:24:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:24:14 -0800
Message-Id: <20171218172425.18200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 00/11] ARM v8.1 simd + v8.3 complex insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

I've incorporated Alex's feedback from v1, and have now rebased
upon Alex's work so that the complex insns now support fp16.


r~


Richard Henderson (11):
  target/arm: Add ARM_FEATURE_V8_1_SIMD
  target/arm: Decode aa64 armv8.1 scalar three same extra
  target/arm: Decode aa64 armv8.1 three same extra
  target/arm: Decode aa64 armv8.1 scalar/vector x indexed element
  target/arm: Decode aa32 armv8.1 three same
  target/arm: Decode aa32 armv8.1 two reg and a scalar
  target/arm: Add ARM_FEATURE_V8_FCMA
  target/arm: Decode aa64 armv8.3 fcadd
  target/arm: Decode aa64 armv8.3 fcmla
  target/arm: Decode aa32 armv8.3 3-same
  target/arm: Decode aa32 armv8.3 2-reg-index

 target/arm/cpu.h            |   2 +
 target/arm/helper.h         |  31 ++++
 linux-user/elfload.c        |  10 ++
 target/arm/advsimd_helper.c | 420 ++++++++++++++++++++++++++++++++++++++++++++
 target/arm/cpu.c            |   2 +
 target/arm/cpu64.c          |   2 +
 target/arm/translate-a64.c  | 382 ++++++++++++++++++++++++++++++++++++----
 target/arm/translate.c      | 239 ++++++++++++++++++++++---
 target/arm/Makefile.objs    |   2 +-
 9 files changed, 1032 insertions(+), 58 deletions(-)
 create mode 100644 target/arm/advsimd_helper.c

-- 
2.14.3
