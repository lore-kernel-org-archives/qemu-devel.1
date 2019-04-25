Received: from eggs.gnu.org ([209.51.188.92]:45898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJism-0003ON-AA
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 14:14:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJisl-0002Vp-AY
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 14:14:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hJisl-0002U6-4V
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 14:14:03 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 25 Apr 2019 15:13:42 -0300
Message-Id: <20190425181342.15360-5-ehabkost@redhat.com>
In-Reply-To: <20190425181342.15360-1-ehabkost@redhat.com>
References: <20190425181342.15360-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 4/4] Pass through cache information for TOPOEXT
 CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, Stanislav Lanci <pixo@polepetko.eu>

From: Stanislav Lanci <pixo@polepetko.eu>

Signed-off-by: Stanislav Lanci <pixo@polepetko.eu>
Message-Id: <20190416123833.60649-1-pixo@polepetko.eu>
[ehabkost: removed redundant comment line]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d92b0f6fcc..722c5514d4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4591,6 +4591,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     case 0x8000001D:
         *eax = 0;
+        if (cpu->cache_info_passthrough) {
+            host_cpuid(index, count, eax, ebx, ecx, edx);
+            break;
+        }
         switch (count) {
         case 0: /* L1 dcache info */
             encode_cache_cpuid8000001d(env->cache_info_amd.l1d_cache, cs,
-- 
2.18.0.rc1.1.g3f1ff2140
