Received: from eggs.gnu.org ([2001:4830:134:3::10]:58625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1e4nXY-0005F0-Br
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:33:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1e4nXX-0003yp-HA
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:33:40 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:53466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1e4nXX-0003xc-AW
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:33:39 -0400
Received: by mail-lf0-x242.google.com with SMTP id l23so5613147lfk.10
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 05:33:39 -0700 (PDT)
From: riku.voipio@linaro.org
Date: Wed, 18 Oct 2017 15:33:21 +0300
Message-Id: <cc1b3960a1a54125d2c87719fa945179bffbae68.1508329282.git.riku.voipio@linaro.org>
In-Reply-To: <cover.1508329282.git.riku.voipio@linaro.org>
References: <cover.1508329282.git.riku.voipio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/10] linux-user/sh4: Reduce
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
Cc: Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

The real kernel has TASK_SIZE as 0x7c000000, due to quirks with
a couple of SH parts.  But nominally user-space is limited to 2GB.

Signed-off-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20170708025030.15845-4-rth@twiddle.net>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
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
2.14.2
