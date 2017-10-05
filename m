Received: from eggs.gnu.org ([2001:4830:134:3::10]:40785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e07G4-0002KA-JG
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:36:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e07G0-0001yp-Js
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:36:16 -0400
Received: from mail-qt0-x22f.google.com ([2607:f8b0:400d:c0d::22f]:55452)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e07G0-0001yQ-F1
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:36:12 -0400
Received: by mail-qt0-x22f.google.com with SMTP id x54so25684375qth.12
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 07:36:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  5 Oct 2017 10:36:01 -0400
Message-Id: <20171005143601.21584-5-richard.henderson@linaro.org>
In-Reply-To: <20171005143601.21584-1-richard.henderson@linaro.org>
References: <20171005143601.21584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 4/4] linux-user/sh4: Reduce
 TARGET_VIRT_ADDR_SPACE_BITS to 31
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

The real kernel has TASK_SIZE as 0x7c000000, due to quirks with
a couple of SH parts.  But nominally user-space is limited to 2GB.

Signed-off-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20170708025030.15845-4-rth@twiddle.net>
---
 target/sh4/cpu.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 79f85d3365..123f34783a 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -45,7 +45,11 @@
 #define TARGET_PAGE_BITS 12	/* 4k XXXXX */
 
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
-#define TARGET_VIRT_ADDR_SPACE_BITS 32
+#ifdef CONFIG_USER_ONLY
+# define TARGET_VIRT_ADDR_SPACE_BITS 31
+#else
+# define TARGET_VIRT_ADDR_SPACE_BITS 32
+#endif
 
 #define SR_MD 30
 #define SR_RB 29
-- 
2.13.6
