Received: from eggs.gnu.org ([2001:4830:134:3::10]:54166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e9W3q-0002ST-2Z
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 08:54:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e9W3p-0005IN-8k
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 08:54:30 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:56568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e9W3p-0005HD-1g
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 08:54:29 -0400
Received: by mail-wm0-x242.google.com with SMTP id z3so22985882wme.5
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 05:54:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 31 Oct 2017 13:53:55 +0100
Message-Id: <20171031125358.23377-5-richard.henderson@linaro.org>
In-Reply-To: <20171031125358.23377-1-richard.henderson@linaro.org>
References: <20171031125358.23377-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 4/7] linux-user/hppa: Fix typo for
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
Cc: riku.voipio@iki.fi, Helge Deller <deller@gmx.de>, Richard Henderson <rth@twiddle.net>

From: Helge Deller <deller@gmx.de>

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Helge Deller <deller@gmx.de>
Message-Id: <20170311100543.GA29669@ls3530.fritz.box>
Signed-off-by: Richard Henderson <rth@twiddle.net>
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
2.13.6
