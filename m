Received: from eggs.gnu.org ([2001:4830:134:3::10]:56578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@rivendell.weiser.dinsnail.net>)
	id 1eRlxS-0006ZH-Q4
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 16:31:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@rivendell.weiser.dinsnail.net>)
	id 1eRlxS-0007Sv-1D
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 16:31:22 -0500
Received: from heinz.dinsnail.net
	([2a01:238:43b4:3200:9392:5dcc:2f0e:a960]:49832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@rivendell.weiser.dinsnail.net>)
	id 1eRlxR-0007Qd-O1
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 16:31:21 -0500
From: Michael Weiser <michael.weiser@gmx.de>
Date: Wed, 20 Dec 2017 22:23:03 +0100
Message-Id: <20171220212308.12614-3-michael.weiser@gmx.de>
In-Reply-To: <20171220212308.12614-1-michael.weiser@gmx.de>
References: <20171220212308.12614-1-michael.weiser@gmx.de>
Subject: [Qemu-devel] [PATCH v3 2/7] linux-user: Add separate aarch64_be
 uname
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Weiser <michael.weiser@gmx.de>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

Make big-endian aarch64 systems identify as aarch64_be as expected by
big-endian userland and toolchains.

Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_syscall.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/linux-user/aarch64/target_syscall.h b/linux-user/aarch64/target_syscall.h
index 1b62953eeb..604ab99b14 100644
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
2.15.1
