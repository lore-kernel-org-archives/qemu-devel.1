Received: from eggs.gnu.org ([209.51.188.92]:59567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pixo@polepetko.eu>) id 1hGNT7-0000BP-Ug
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pixo@polepetko.eu>) id 1hGNT6-0001Jz-JN
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:45:45 -0400
From: Stanislav Lanci <pixo@polepetko.eu>
Date: Tue, 16 Apr 2019 14:38:33 +0200
Message-Id: <20190416123833.60649-1-pixo@polepetko.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] Pass through cache information for TOPOEXT CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Stanislav Lanci <pixo@polepetko.eu>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

Signed-off-by: Stanislav Lanci <pixo@polepetko.eu>
---
 target/i386/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d6bb57d210..bc0559fc51 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4546,6 +4546,11 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t inde=
x, uint32_t count,
         break;
     case 0x8000001D:
         *eax =3D 0;
+        /* pass through cache information */
+        if (cpu->cache_info_passthrough) {
+            host_cpuid(index, count, eax, ebx, ecx, edx);
+            break;
+        }
         switch (count) {
         case 0: /* L1 dcache info */
             encode_cache_cpuid8000001d(env->cache_info_amd.l1d_cache, cs=
,
--=20
2.21.0
