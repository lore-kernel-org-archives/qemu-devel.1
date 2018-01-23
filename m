Received: from eggs.gnu.org ([2001:4830:134:3::10]:43457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1edzs2-00075q-NH
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:48:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1edzs0-0002Pr-4b
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:48:18 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:52914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1edzrz-0002OF-R7
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:48:16 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 23 Jan 2018 15:48:02 +0100
Message-Id: <20180123144807.5618-9-laurent@vivier.eu>
In-Reply-To: <20180123144807.5618-1-laurent@vivier.eu>
References: <20180123144807.5618-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 08/13] linux-user: Add AT_SECURE auxval
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marco A L Barbosa <malbarbo@gmail.com>, Laurent Vivier <laurent@vivier.eu>

From: Marco A L Barbosa <malbarbo@gmail.com>

Signed-off-by: Marco A L Barbosa <malbarbo@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180111183714.22834-2-malbarbo@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/elfload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 20f3d8c2c3..32a47674e6 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1354,7 +1354,7 @@ struct exec
                                  ~(abi_ulong)(TARGET_ELF_EXEC_PAGESIZE-1))
 #define TARGET_ELF_PAGEOFFSET(_v) ((_v) & (TARGET_ELF_EXEC_PAGESIZE-1))
 
-#define DLINFO_ITEMS 14
+#define DLINFO_ITEMS 15
 
 static inline void memcpy_fromfs(void * to, const void * from, unsigned long n)
 {
@@ -1786,6 +1786,7 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     NEW_AUX_ENT(AT_HWCAP, (abi_ulong) ELF_HWCAP);
     NEW_AUX_ENT(AT_CLKTCK, (abi_ulong) sysconf(_SC_CLK_TCK));
     NEW_AUX_ENT(AT_RANDOM, (abi_ulong) u_rand_bytes);
+    NEW_AUX_ENT(AT_SECURE, (abi_ulong) qemu_getauxval(AT_SECURE));
 
 #ifdef ELF_HWCAP2
     NEW_AUX_ENT(AT_HWCAP2, (abi_ulong) ELF_HWCAP2);
-- 
2.14.3
