Received: from eggs.gnu.org ([2001:4830:134:3::10]:59034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1foD8K-0002Q5-9R
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:31:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1foD8H-0005XD-6Z
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:31:36 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:33090)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1foD8H-0005Wc-00
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:31:33 -0400
Received: by mail-pl0-x242.google.com with SMTP id b90-v6so4445862plb.0
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 12:31:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 10 Aug 2018 12:31:23 -0700
Message-Id: <20180810193129.1556-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/6] target/arm: More sve-ish fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, alex.bennee@linaro.org

All from problems reported by Laurent this week.  Five of them are
SVE related, but while trying to simplify one of the reports I
discovered that I had broken ARMv8.3 just before final commit.


r~


Richard Henderson (6):
  target/arm: Adjust FPCR_MASK for FZ16
  target/arm: Ignore float_flag_input_denormal from fp_status_f16
  target/arm: Use fp_status_fp16 for do_fmpa_zpzzz_h
  target/arm: Use FZ not FZ16 for SVE FCVT single-half and double-half
  target/arm: Fix aa64 FCADD and FCMLA decode
  softfloat: Fix missing inexact for floating-point add

 target/arm/cpu.h           |  2 +-
 fpu/softfloat.c            |  2 +-
 target/arm/helper.c        | 11 ++++++++++-
 target/arm/sve_helper.c    |  2 +-
 target/arm/translate-a64.c | 12 ++++++------
 target/arm/translate-sve.c |  4 ++--
 6 files changed, 21 insertions(+), 12 deletions(-)

-- 
2.17.1
