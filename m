Received: from eggs.gnu.org ([209.51.188.92]:58972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gpetr-0000vx-WC
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:54:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gpeto-00029Y-57
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:54:53 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:42334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gpetk-0001p5-A4
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:54:50 -0500
Received: by mail-pl1-x636.google.com with SMTP id y1so3725491plp.9
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 11:54:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Feb 2019 11:54:02 -0800
Message-Id: <20190201195404.30486-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/2] target/arm: Complete ARMv8.3-PAuth
 linux-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

Most of the v1 patch set has been merged.
Changes since v1:

 * I've added the missing check against arg3 through arg5.
 * I've removed the -O1 I had cribed from the MTE patch set.


r~


Richard Henderson (2):
  linux-user: Implement PR_PAC_RESET_KEYS
  tests/tcg/aarch64: Add pauth smoke test

 linux-user/aarch64/target_syscall.h |  7 ++++++
 linux-user/syscall.c                | 36 +++++++++++++++++++++++++++++
 tests/tcg/aarch64/pauth-1.c         | 23 ++++++++++++++++++
 tests/tcg/aarch64/Makefile.target   |  6 ++++-
 4 files changed, 71 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/aarch64/pauth-1.c

-- 
2.17.2
