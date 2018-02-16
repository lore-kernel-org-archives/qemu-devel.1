Received: from eggs.gnu.org ([2001:4830:134:3::10]:40683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1emnzN-0006kA-9c
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 16:56:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1emnzK-0007O8-8X
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 16:56:17 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:35027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1emnzK-0007Nf-22
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 16:56:14 -0500
Received: by mail-pl0-x242.google.com with SMTP id bb3so2386300plb.2
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 13:56:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 16 Feb 2018 13:56:03 -0800
Message-Id: <20180216215608.13227-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 0/5] target/arm: linux-user changes for sve
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

Changes since v2:
  * 5 patches merged,
  * The PR_SVE_SET/GET_VL patch is more specifically user-only.
  * Split the signal frame patch into 4 parts.


r~


Richard Henderson (5):
  linux-user: Implement aarch64 PR_SVE_SET/GET_VL
  aarch64-linux-user: Split out helpers for guest signal handling
  aarch64-linux-user: Remove struct target_aux_context
  aarch64-linux-user: Add support for EXTRA signal frame records
  aarch64-linux-user: Add support for SVE signal frame records

 linux-user/aarch64/target_syscall.h |   3 +
 target/arm/cpu.h                    |   1 +
 linux-user/signal.c                 | 367 +++++++++++++++++++++++++++++-------
 linux-user/syscall.c                |  27 +++
 target/arm/cpu64.c                  |  41 ++++
 5 files changed, 372 insertions(+), 67 deletions(-)

-- 
2.14.3
