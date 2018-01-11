Received: from eggs.gnu.org ([2001:4830:134:3::10]:52196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd42-0007SQ-7d
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd41-00007U-72
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:38 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eZd40-0008Ns-W4
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:37 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd3p-0005bg-8b
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:38:25 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 13:37:58 +0000
Message-Id: <1515677902-23436-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
References: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 02/26] linux-user: Add separate aarch64_be uname
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Michael Weiser <michael.weiser@gmx.de>

Make big-endian aarch64 systems identify as aarch64_be as expected by
big-endian userland and toolchains.

Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-id: 20171220212308.12614-3-michael.weiser@gmx.de
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/aarch64/target_syscall.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/linux-user/aarch64/target_syscall.h b/linux-user/aarch64/target_syscall.h
index 1b62953..604ab99 100644
--- a/linux-user/aarch64/target_syscall.h
+++ b/linux-user/aarch64/target_syscall.h
@@ -8,7 +8,11 @@ struct target_pt_regs {
     uint64_t        pstate;
 };
 
+#if defined(TARGET_WORDS_BIGENDIAN)
+#define UNAME_MACHINE "aarch64_be"
+#else
 #define UNAME_MACHINE "aarch64"
+#endif
 #define UNAME_MINIMUM_RELEASE "3.8.0"
 #define TARGET_CLONE_BACKWARDS
 #define TARGET_MINSIGSTKSZ       2048
-- 
2.7.4
