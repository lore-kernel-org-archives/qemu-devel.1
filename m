Received: from eggs.gnu.org ([209.51.188.92]:46620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtSoG-0004DM-VK
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 02:48:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtSoF-0005wq-2m
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 02:48:52 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44337)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtSoE-0005qP-PV
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 02:48:50 -0500
Received: by mail-pg1-x542.google.com with SMTP id y1so860812pgk.11
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 23:48:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 23:48:40 -0800
Message-Id: <20190212074840.13542-3-richard.henderson@linaro.org>
In-Reply-To: <20190212074840.13542-1-richard.henderson@linaro.org>
References: <20190212074840.13542-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 2/2] linux-user: Fix ELF_PLATFORM for
 aarch64_be-linux-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, qemu-arm@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index d796d51ec6..5aa0628ae9 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -537,7 +537,11 @@ static const char *get_elf_platform(void)
 
 #define ELF_ARCH        EM_AARCH64
 #define ELF_CLASS       ELFCLASS64
-#define ELF_PLATFORM    "aarch64"
+#ifdef TARGET_WORDS_BIGENDIAN
+# define ELF_PLATFORM    "aarch64_be"
+#else
+# define ELF_PLATFORM    "aarch64"
+#endif
 
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
-- 
2.17.2
