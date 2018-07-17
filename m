Received: from eggs.gnu.org ([2001:4830:134:3::10]:37239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ffVpb-0004aK-UK
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:40:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ffVpY-0008Ek-J9
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:40:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ffVpY-0008DZ-A8
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:40:16 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 17 Jul 2018 16:40:10 -0300
Message-Id: <20180717194010.30096-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.0] i386: Rename enum CacheType members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Babu Moger <babu.moger@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Rename DCACHE to DATA_CACHE and ICACHE to INSTRUCTION_CACHE.
This avoids conflict with Linux asm/cachectl.h macros and fixes
build failure on mips hosts.

Reported-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h |   4 +-
 target/i386/cpu.c | 128 +++++++++++++++++++++++-----------------------
 2 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 2c5a0d90a6..194e2e6b92 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1050,8 +1050,8 @@ typedef enum TPRAccess {
 /* Cache information data structures: */
=20
 enum CacheType {
-    DCACHE,
-    ICACHE,
+    DATA_CACHE,
+    INSTRUCTION_CACHE,
     UNIFIED_CACHE
 };
=20
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e0e2f2eea1..f454d4beb3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -71,123 +71,123 @@ struct CPUID2CacheDescriptorInfo {
  * From Intel SDM Volume 2A, CPUID instruction
  */
 struct CPUID2CacheDescriptorInfo cpuid2_cache_descriptors[] =3D {
-    [0x06] =3D { .level =3D 1, .type =3D ICACHE,        .size =3D   8 * =
KiB,
+    [0x06] =3D { .level =3D 1, .type =3D INSTRUCTION_CACHE, .size =3D   =
8 * KiB,
                .associativity =3D 4,  .line_size =3D 32, },
-    [0x08] =3D { .level =3D 1, .type =3D ICACHE,        .size =3D  16 * =
KiB,
+    [0x08] =3D { .level =3D 1, .type =3D INSTRUCTION_CACHE, .size =3D  1=
6 * KiB,
                .associativity =3D 4,  .line_size =3D 32, },
-    [0x09] =3D { .level =3D 1, .type =3D ICACHE,        .size =3D  32 * =
KiB,
+    [0x09] =3D { .level =3D 1, .type =3D INSTRUCTION_CACHE, .size =3D  3=
2 * KiB,
                .associativity =3D 4,  .line_size =3D 64, },
-    [0x0A] =3D { .level =3D 1, .type =3D DCACHE,        .size =3D   8 * =
KiB,
+    [0x0A] =3D { .level =3D 1, .type =3D DATA_CACHE,        .size =3D   =
8 * KiB,
                .associativity =3D 2,  .line_size =3D 32, },
-    [0x0C] =3D { .level =3D 1, .type =3D DCACHE,        .size =3D  16 * =
KiB,
+    [0x0C] =3D { .level =3D 1, .type =3D DATA_CACHE,        .size =3D  1=
6 * KiB,
                .associativity =3D 4,  .line_size =3D 32, },
-    [0x0D] =3D { .level =3D 1, .type =3D DCACHE,        .size =3D  16 * =
KiB,
+    [0x0D] =3D { .level =3D 1, .type =3D DATA_CACHE,        .size =3D  1=
6 * KiB,
                .associativity =3D 4,  .line_size =3D 64, },
-    [0x0E] =3D { .level =3D 1, .type =3D DCACHE,        .size =3D  24 * =
KiB,
+    [0x0E] =3D { .level =3D 1, .type =3D DATA_CACHE,        .size =3D  2=
4 * KiB,
                .associativity =3D 6,  .line_size =3D 64, },
-    [0x1D] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D 128 * =
KiB,
+    [0x1D] =3D { .level =3D 2, .type =3D UNIFIED_CACHE,     .size =3D 12=
8 * KiB,
                .associativity =3D 2,  .line_size =3D 64, },
-    [0x21] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D 256 * =
KiB,
+    [0x21] =3D { .level =3D 2, .type =3D UNIFIED_CACHE,     .size =3D 25=
6 * KiB,
                .associativity =3D 8,  .line_size =3D 64, },
     /* lines per sector is not supported cpuid2_cache_descriptor(),
     * so descriptors 0x22, 0x23 are not included
     */
-    [0x24] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D   1 * =
MiB,
+    [0x24] =3D { .level =3D 2, .type =3D UNIFIED_CACHE,     .size =3D   =
1 * MiB,
                .associativity =3D 16, .line_size =3D 64, },
     /* lines per sector is not supported cpuid2_cache_descriptor(),
     * so descriptors 0x25, 0x20 are not included
     */
-    [0x2C] =3D { .level =3D 1, .type =3D DCACHE,        .size =3D  32 * =
KiB,
+    [0x2C] =3D { .level =3D 1, .type =3D DATA_CACHE,        .size =3D  3=
2 * KiB,
                .associativity =3D 8,  .line_size =3D 64, },
-    [0x30] =3D { .level =3D 1, .type =3D ICACHE,        .size =3D  32 * =
KiB,
+    [0x30] =3D { .level =3D 1, .type =3D INSTRUCTION_CACHE, .size =3D  3=
2 * KiB,
                .associativity =3D 8,  .line_size =3D 64, },
-    [0x41] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D 128 * =
KiB,
+    [0x41] =3D { .level =3D 2, .type =3D UNIFIED_CACHE,     .size =3D 12=
8 * KiB,
                .associativity =3D 4,  .line_size =3D 32, },
-    [0x42] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D 256 * =
KiB,
+    [0x42] =3D { .level =3D 2, .type =3D UNIFIED_CACHE,     .size =3D 25=
6 * KiB,
                .associativity =3D 4,  .line_size =3D 32, },
-    [0x43] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D 512 * =
KiB,
+    [0x43] =3D { .level =3D 2, .type =3D UNIFIED_CACHE,     .size =3D 51=
2 * KiB,
                .associativity =3D 4,  .line_size =3D 32, },
-    [0x44] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D   1 * =
MiB,
+    [0x44] =3D { .level =3D 2, .type =3D UNIFIED_CACHE,     .size =3D   =
1 * MiB,
                .associativity =3D 4,  .line_size =3D 32, },
-    [0x45] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D   2 * =
MiB,
+    [0x45] =3D { .level =3D 2, .type =3D UNIFIED_CACHE,     .size =3D   =
2 * MiB,
                .associativity =3D 4,  .line_size =3D 32, },
-    [0x46] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D   4 * =
MiB,
+    [0x46] =3D { .level =3D 3, .type =3D UNIFIED_CACHE,     .size =3D   =
4 * MiB,
                .associativity =3D 4,  .line_size =3D 64, },
-    [0x47] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D   8 * =
MiB,
+    [0x47] =3D { .level =3D 3, .type =3D UNIFIED_CACHE,     .size =3D   =
8 * MiB,
                .associativity =3D 8,  .line_size =3D 64, },
-    [0x48] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D   3 * =
MiB,
+    [0x48] =3D { .level =3D 2, .type =3D UNIFIED_CACHE,     .size =3D   =
3 * MiB,
                .associativity =3D 12, .line_size =3D 64, },
     /* Descriptor 0x49 depends on CPU family/model, so it is not include=
d */
-    [0x4A] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D   6 * =
MiB,
+    [0x4A] =3D { .level =3D 3, .type =3D UNIFIED_CACHE,     .size =3D   =
6 * MiB,
                .associativity =3D 12, .line_size =3D 64, },
-    [0x4B] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D   8 * =
MiB,
+    [0x4B] =3D { .level =3D 3, .type =3D UNIFIED_CACHE,     .size =3D   =
8 * MiB,
                .associativity =3D 16, .line_size =3D 64, },
-    [0x4C] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D  12 * =
MiB,
+    [0x4C] =3D { .level =3D 3, .type =3D UNIFIED_CACHE,     .size =3D  1=
2 * MiB,
                .associativity =3D 12, .line_size =3D 64, },
-    [0x4D] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D  16 * =
MiB,
+    [0x4D] =3D { .level =3D 3, .type =3D UNIFIED_CACHE,     .size =3D  1=
6 * MiB,
                .associativity =3D 16, .line_size =3D 64, },
-    [0x4E] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D   6 * =
MiB,
+    [0x4E] =3D { .level =3D 2, .type =3D UNIFIED_CACHE,     .size =3D   =
6 * MiB,
                .associativity =3D 24, .line_size =3D 64, },
-    [0x60] =3D { .level =3D 1, .type =3D DCACHE,        .size =3D  16 * =
KiB,
+    [0x60] =3D { .level =3D 1, .type =3D DATA_CACHE,        .size =3D  1=
6 * KiB,
                .associativity =3D 8,  .line_size =3D 64, },
-    [0x66] =3D { .level =3D 1, .type =3D DCACHE,        .size =3D   8 * =
KiB,
+    [0x66] =3D { .level =3D 1, .type =3D DATA_CACHE,        .size =3D   =
8 * KiB,
                .associativity =3D 4,  .line_size =3D 64, },
-    [0x67] =3D { .level =3D 1, .type =3D DCACHE,        .size =3D  16 * =
KiB,
+    [0x67] =3D { .level =3D 1, .type =3D DATA_CACHE,        .size =3D  1=
6 * KiB,
                .associativity =3D 4,  .line_size =3D 64, },
-    [0x68] =3D { .level =3D 1, .type =3D DCACHE,        .size =3D  32 * =
KiB,
+    [0x68] =3D { .level =3D 1, .type =3D DATA_CACHE,        .size =3D  3=
2 * KiB,
                .associativity =3D 4,  .line_size =3D 64, },
-    [0x78] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D   1 * =
MiB,
+    [0x78] =3D { .level =3D 2, .type =3D UNIFIED_CACHE,     .size =3D   =
1 * MiB,
                .associativity =3D 4,  .line_size =3D 64, },
     /* lines per sector is not supported cpuid2_cache_descriptor(),
     * so descriptors 0x79, 0x7A, 0x7B, 0x7C are not included.
     */
-    [0x7D] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D   2 * =
MiB,
+    [0x7D] =3D { .level =3D 2, .type =3D UNIFIED_CACHE,     .size =3D   =
2 * MiB,
                .associativity =3D 8,  .line_size =3D 64, },
-    [0x7F] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D 512 * =
KiB,
+    [0x7F] =3D { .level =3D 2, .type =3D UNIFIED_CACHE,     .size =3D 51=
2 * KiB,
                .associativity =3D 2,  .line_size =3D 64, },
-    [0x80] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D 512 * =
KiB,
+    [0x80] =3D { .level =3D 2, .type =3D UNIFIED_CACHE,     .size =3D 51=
2 * KiB,
                .associativity =3D 8,  .line_size =3D 64, },
-    [0x82] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D 256 * =
KiB,
+    [0x82] =3D { .level =3D 2, .type =3D UNIFIED_CACHE,     .size =3D 25=
6 * KiB,
                .associativity =3D 8,  .line_size =3D 32, },
-    [0x83] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D 512 * =
KiB,
+    [0x83] =3D { .level =3D 2, .type =3D UNIFIED_CACHE,     .size =3D 51=
2 * KiB,
                .associativity =3D 8,  .line_size =3D 32, },
-    [0x84] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D   1 * =
MiB,
+    [0x84] =3D { .level =3D 2, .type =3D UNIFIED_CACHE,     .size =3D   =
1 * MiB,
                .associativity =3D 8,  .line_size =3D 32, },
-    [0x85] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D   2 * =
MiB,
+    [0x85] =3D { .level =3D 2, .type =3D UNIFIED_CACHE,     .size =3D   =
2 * MiB,
                .associativity =3D 8,  .line_size =3D 32, },
-    [0x86] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D 512 * =
KiB,
+    [0x86] =3D { .level =3D 2, .type =3D UNIFIED_CACHE,     .size =3D 51=
2 * KiB,
                .associativity =3D 4,  .line_size =3D 64, },
-    [0x87] =3D { .level =3D 2, .type =3D UNIFIED_CACHE, .size =3D   1 * =
MiB,
+    [0x87] =3D { .level =3D 2, .type =3D UNIFIED_CACHE,     .size =3D   =
1 * MiB,
                .associativity =3D 8,  .line_size =3D 64, },
-    [0xD0] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D 512 * =
KiB,
+    [0xD0] =3D { .level =3D 3, .type =3D UNIFIED_CACHE,     .size =3D 51=
2 * KiB,
                .associativity =3D 4,  .line_size =3D 64, },
-    [0xD1] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D   1 * =
MiB,
+    [0xD1] =3D { .level =3D 3, .type =3D UNIFIED_CACHE,     .size =3D   =
1 * MiB,
                .associativity =3D 4,  .line_size =3D 64, },
-    [0xD2] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D   2 * =
MiB,
+    [0xD2] =3D { .level =3D 3, .type =3D UNIFIED_CACHE,     .size =3D   =
2 * MiB,
                .associativity =3D 4,  .line_size =3D 64, },
-    [0xD6] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D   1 * =
MiB,
+    [0xD6] =3D { .level =3D 3, .type =3D UNIFIED_CACHE,     .size =3D   =
1 * MiB,
                .associativity =3D 8,  .line_size =3D 64, },
-    [0xD7] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D   2 * =
MiB,
+    [0xD7] =3D { .level =3D 3, .type =3D UNIFIED_CACHE,     .size =3D   =
2 * MiB,
                .associativity =3D 8,  .line_size =3D 64, },
-    [0xD8] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D   4 * =
MiB,
+    [0xD8] =3D { .level =3D 3, .type =3D UNIFIED_CACHE,     .size =3D   =
4 * MiB,
                .associativity =3D 8,  .line_size =3D 64, },
-    [0xDC] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D 1.5 * =
MiB,
+    [0xDC] =3D { .level =3D 3, .type =3D UNIFIED_CACHE,     .size =3D 1.=
5 * MiB,
                .associativity =3D 12, .line_size =3D 64, },
-    [0xDD] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D   3 * =
MiB,
+    [0xDD] =3D { .level =3D 3, .type =3D UNIFIED_CACHE,     .size =3D   =
3 * MiB,
                .associativity =3D 12, .line_size =3D 64, },
-    [0xDE] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D   6 * =
MiB,
+    [0xDE] =3D { .level =3D 3, .type =3D UNIFIED_CACHE,     .size =3D   =
6 * MiB,
                .associativity =3D 12, .line_size =3D 64, },
-    [0xE2] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D   2 * =
MiB,
+    [0xE2] =3D { .level =3D 3, .type =3D UNIFIED_CACHE,     .size =3D   =
2 * MiB,
                .associativity =3D 16, .line_size =3D 64, },
-    [0xE3] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D   4 * =
MiB,
+    [0xE3] =3D { .level =3D 3, .type =3D UNIFIED_CACHE,     .size =3D   =
4 * MiB,
                .associativity =3D 16, .line_size =3D 64, },
-    [0xE4] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D   8 * =
MiB,
+    [0xE4] =3D { .level =3D 3, .type =3D UNIFIED_CACHE,     .size =3D   =
8 * MiB,
                .associativity =3D 16, .line_size =3D 64, },
-    [0xEA] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D  12 * =
MiB,
+    [0xEA] =3D { .level =3D 3, .type =3D UNIFIED_CACHE,     .size =3D  1=
2 * MiB,
                .associativity =3D 24, .line_size =3D 64, },
-    [0xEB] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D  18 * =
MiB,
+    [0xEB] =3D { .level =3D 3, .type =3D UNIFIED_CACHE,     .size =3D  1=
8 * MiB,
                .associativity =3D 24, .line_size =3D 64, },
-    [0xEC] =3D { .level =3D 3, .type =3D UNIFIED_CACHE, .size =3D  24 * =
MiB,
+    [0xEC] =3D { .level =3D 3, .type =3D UNIFIED_CACHE,     .size =3D  2=
4 * MiB,
                .associativity =3D 24, .line_size =3D 64, },
 };
=20
@@ -238,10 +238,10 @@ static uint8_t cpuid2_cache_descriptor(CPUCacheInfo=
 *cache)
 #define CACHE_COMPLEX_IDX     (1 << 2)
=20
 /* Encode CacheType for CPUID[4].EAX */
-#define CACHE_TYPE(t) (((t) =3D=3D DCACHE)  ? CACHE_TYPE_D  : \
-                         ((t) =3D=3D ICACHE)  ? CACHE_TYPE_I  : \
-                         ((t) =3D=3D UNIFIED_CACHE) ? CACHE_TYPE_UNIFIED=
 : \
-                         0 /* Invalid value */)
+#define CACHE_TYPE(t) (((t) =3D=3D DATA_CACHE) ? CACHE_TYPE_D : \
+                       ((t) =3D=3D INSTRUCTION_CACHE) ? CACHE_TYPE_I : \
+                       ((t) =3D=3D UNIFIED_CACHE) ? CACHE_TYPE_UNIFIED :=
 \
+                       0 /* Invalid value */)
=20
=20
 /* Encode cache info for CPUID[4] */
@@ -538,7 +538,7 @@ static void encode_topo_cpuid8000001e(CPUState *cs, X=
86CPU *cpu,
=20
 /* L1 data cache: */
 static CPUCacheInfo legacy_l1d_cache =3D {
-    .type =3D DCACHE,
+    .type =3D DATA_CACHE,
     .level =3D 1,
     .size =3D 32 * KiB,
     .self_init =3D 1,
@@ -551,7 +551,7 @@ static CPUCacheInfo legacy_l1d_cache =3D {
=20
 /*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */
 static CPUCacheInfo legacy_l1d_cache_amd =3D {
-    .type =3D DCACHE,
+    .type =3D DATA_CACHE,
     .level =3D 1,
     .size =3D 64 * KiB,
     .self_init =3D 1,
@@ -565,7 +565,7 @@ static CPUCacheInfo legacy_l1d_cache_amd =3D {
=20
 /* L1 instruction cache: */
 static CPUCacheInfo legacy_l1i_cache =3D {
-    .type =3D ICACHE,
+    .type =3D INSTRUCTION_CACHE,
     .level =3D 1,
     .size =3D 32 * KiB,
     .self_init =3D 1,
@@ -578,7 +578,7 @@ static CPUCacheInfo legacy_l1i_cache =3D {
=20
 /*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */
 static CPUCacheInfo legacy_l1i_cache_amd =3D {
-    .type =3D ICACHE,
+    .type =3D INSTRUCTION_CACHE,
     .level =3D 1,
     .size =3D 64 * KiB,
     .self_init =3D 1,
@@ -1310,7 +1310,7 @@ struct X86CPUDefinition {
=20
 static CPUCaches epyc_cache_info =3D {
     .l1d_cache =3D &(CPUCacheInfo) {
-        .type =3D DCACHE,
+        .type =3D DATA_CACHE,
         .level =3D 1,
         .size =3D 32 * KiB,
         .line_size =3D 64,
@@ -1322,7 +1322,7 @@ static CPUCaches epyc_cache_info =3D {
         .no_invd_sharing =3D true,
     },
     .l1i_cache =3D &(CPUCacheInfo) {
-        .type =3D ICACHE,
+        .type =3D INSTRUCTION_CACHE,
         .level =3D 1,
         .size =3D 64 * KiB,
         .line_size =3D 64,
--=20
2.18.0.rc1.1.g3f1ff2140
