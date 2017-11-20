Received: from eggs.gnu.org ([2001:4830:134:3::10]:58142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1eGtVp-0004WP-O0
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:21:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1eGtVo-0007j9-TP
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:21:53 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:42558)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1eGtVo-0007if-Lv
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:21:52 -0500
Received: by mail-lf0-x242.google.com with SMTP id m1so11692099lfj.9
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 13:21:52 -0800 (PST)
From: riku.voipio@linaro.org
Date: Mon, 20 Nov 2017 23:21:32 +0200
Message-Id: <92afb153103c38c1ccc9d4c34512cf1767e676c5.1511212753.git.riku.voipio@linaro.org>
In-Reply-To: <cover.1511212753.git.riku.voipio@linaro.org>
References: <cover.1511212753.git.riku.voipio@linaro.org>
Subject: [Qemu-devel] [PULL 04/15] linux-user/hppa: Fix typo for
 TARGET_NR_epoll_wait
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>

From: Helge Deller <deller@gmx.de>

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Helge Deller <deller@gmx.de>
Message-Id: <20170311100543.GA29669@ls3530.fritz.box>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/hppa/syscall_nr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/hppa/syscall_nr.h b/linux-user/hppa/syscall_nr.h
index 0f396fa1e2..55bdf71d50 100644
--- a/linux-user/hppa/syscall_nr.h
+++ b/linux-user/hppa/syscall_nr.h
@@ -228,7 +228,7 @@
 #define TARGET_NR_lookup_dcookie    223
 #define TARGET_NR_epoll_create      224
 #define TARGET_NR_epoll_ctl         225
-#define TARGET_NR_epill_wait        226
+#define TARGET_NR_epoll_wait        226
 #define TARGET_NR_remap_file_pages  227
 #define TARGET_NR_semtimedop        228
 #define TARGET_NR_mq_open           229
-- 
2.14.2
