Received: from eggs.gnu.org ([2001:4830:134:3::10]:54681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fQzxt-0005WU-FU
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 14:48:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fQzxs-0001iD-Oz
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 14:48:53 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:36931)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fQzxs-0001hx-JB
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 14:48:52 -0400
Received: by mail-pf0-x241.google.com with SMTP id y5-v6so4434182pfn.4
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 11:48:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Jun 2018 11:48:42 -0700
Message-Id: <20180607184844.30126-3-richard.henderson@linaro.org>
In-Reply-To: <20180607184844.30126-1-richard.henderson@linaro.org>
References: <20180607184844.30126-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/4] linux-user/hppa: Fix typo in mknodat
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
Cc: laurent@vivier.eu

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
