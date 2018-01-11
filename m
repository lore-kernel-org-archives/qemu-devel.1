Received: from eggs.gnu.org ([2001:4830:134:3::10]:53036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <malbarbo@gmail.com>) id 1eZhjn-0000QJ-2j
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:38:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <malbarbo@gmail.com>) id 1eZhjm-0007Bu-De
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:38:03 -0500
From: Marco A L Barbosa <malbarbo@gmail.com>
Date: Thu, 11 Jan 2018 16:37:14 -0200
Message-Id: <20180111183714.22834-2-malbarbo@gmail.com>
Subject: [Qemu-devel] [PATCH v2] linux-user: Add AT_SECURE auxval
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

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
2.11.0
