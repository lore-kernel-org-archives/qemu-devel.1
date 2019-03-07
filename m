Received: from eggs.gnu.org ([209.51.188.92]:44008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1pvq-00044u-2m
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:07:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1pvo-0007Uj-JN
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:07:17 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:53559)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1h1pvo-0007Tr-2Y
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:07:16 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu,  7 Mar 2019 11:06:50 +0100
Message-Id: <20190307100656.14044-4-laurent@vivier.eu>
In-Reply-To: <20190307100656.14044-1-laurent@vivier.eu>
References: <20190307100656.14044-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 3/9] linux-user: Fix ELF_PLATFORM for
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
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20190212074840.13542-3-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/elfload.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 940a97a2f2e9..c1a26021f8d7 100644
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
2.20.1
