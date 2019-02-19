Received: from eggs.gnu.org ([209.51.188.92]:45847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwDts-0000IW-JP
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 17:30:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwDtq-0002Ty-V8
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 17:30:03 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35706)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gwDtq-0002QD-4p
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 17:30:02 -0500
Received: by mail-pg1-x543.google.com with SMTP id s198so10808097pgs.2
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 14:29:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 19 Feb 2019 14:29:47 -0800
Message-Id: <20190219222952.22183-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v5 0/5] target/arm: Implement ARMv8.2-FHM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Changes since v4:

Fixed the FZ16 issue.
Add the aa64 HWCAP bits for both JSConv and FHM.


r~


Richard Henderson (5):
  target/arm: Add helpers for FMLAL
  target/arm: Implement FMLAL and FMLSL for aarch64
  target/arm: Implement VFMAL and VFMSL for aarch32
  target/arm: Enable ARMv8.2-FHM for -cpu max
  linux-user: Enable HWCAP_ASIMDFHM, HWCAP_JSCVT

 target/arm/cpu.h           |  10 +++
 target/arm/helper.h        |   9 +++
 linux-user/elfload.c       |   2 +
 target/arm/cpu.c           |   1 +
 target/arm/cpu64.c         |   2 +
 target/arm/translate-a64.c |  49 +++++++++++-
 target/arm/translate.c     | 129 +++++++++++++++++++++++---------
 target/arm/vec_helper.c    | 148 +++++++++++++++++++++++++++++++++++++
 8 files changed, 316 insertions(+), 34 deletions(-)

-- 
2.17.2
