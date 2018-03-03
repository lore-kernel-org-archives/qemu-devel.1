Received: from eggs.gnu.org ([2001:4830:134:3::10]:56799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1es8Iy-000629-CL
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 09:38:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1es8Iv-0003up-AE
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 09:38:32 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:53747)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1es8Iv-0003ud-4Y
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 09:38:29 -0500
Received: by mail-wm0-x241.google.com with SMTP id t74so8161175wme.3
	for <qemu-devel@nongnu.org>; Sat, 03 Mar 2018 06:38:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  3 Mar 2018 14:38:18 +0000
Message-Id: <20180303143823.27055-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4 0/5] target/arm linux-user changes for sve
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

Changes since v3:
  * Review comments applied.
  * Frame allocation generalized in patch 5; hopefully this
    eliminates some of the confusion seen during review.

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
 linux-user/signal.c                 | 415 ++++++++++++++++++++++++++++++------
 linux-user/syscall.c                |  27 +++
 target/arm/cpu64.c                  |  41 ++++
 5 files changed, 418 insertions(+), 69 deletions(-)

-- 
2.14.3
