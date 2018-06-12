Received: from eggs.gnu.org ([2001:4830:134:3::10]:59204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSXXR-0004vM-Cu
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSXXQ-0007F2-Kr
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:51:57 -0400
Received: from mail-pl0-x22a.google.com ([2607:f8b0:400e:c01::22a]:34490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fSXXQ-0007EK-E4
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:51:56 -0400
Received: by mail-pl0-x22a.google.com with SMTP id g20-v6so13331820plq.1
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 17:51:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Jun 2018 14:51:28 -1000
Message-Id: <20180612005145.3375-3-richard.henderson@linaro.org>
In-Reply-To: <20180612005145.3375-1-richard.henderson@linaro.org>
References: <20180612005145.3375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 02/19] linux-user/hppa: Fix typo in mknodat
 syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, peter.maydell@linaro.org

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.17.1
