Received: from eggs.gnu.org ([2001:4830:134:3::10]:50349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fSh1G-0003s9-RB
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:59:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fSh1C-0007P7-Tk
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:59:22 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:52061)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fSh1C-0007OV-J4
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:59:18 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 12 Jun 2018 12:58:29 +0200
Message-Id: <20180612105831.25703-7-laurent@vivier.eu>
In-Reply-To: <20180612105831.25703-1-laurent@vivier.eu>
References: <20180612105831.25703-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 6/8] linux-user/hppa: Fix typo in mknodat syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180607184844.30126-3-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/hppa/syscall_nr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/hppa/syscall_nr.h b/linux-user/hppa/syscall_nr.h
index 55bdf71d50..9c1d0a195d 100644
--- a/linux-user/hppa/syscall_nr.h
+++ b/linux-user/hppa/syscall_nr.h
@@ -279,7 +279,7 @@
 #define TARGET_NR_ppoll             274
 #define TARGET_NR_openat            275
 #define TARGET_NR_mkdirat           276
-#define TARGET_NR_mknotat           277
+#define TARGET_NR_mknodat           277
 #define TARGET_NR_fchownat          278
 #define TARGET_NR_futimesat         279
 #define TARGET_NR_fstatat64         280
-- 
2.14.4
