Received: from eggs.gnu.org ([2001:4830:134:3::10]:39754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dnbPi-0004Z9-Bq
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 22:10:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dnbPf-0007H2-Hh
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 22:10:30 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:16790
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dnbPf-0007Fx-7N
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 22:10:27 -0400
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Date: Fri, 1 Sep 2017 10:10:03 +0800
Message-ID: <1504231805-30957-3-git-send-email-douly.fnst@cn.fujitsu.com>
In-Reply-To: <1504231805-30957-1-git-send-email-douly.fnst@cn.fujitsu.com>
References: <1504231805-30957-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v6 2/4] hw/acpi-build: Make assignment
 statement of next_base easy to read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, mst@redhat.com, rth@twiddle.net, Dou Liyang <douly.fnst@cn.fujitsu.com>

It may be hard to read the assignment statement of "next_base", so

S/next_base += (1ULL << 32) - pcms->below_4g_mem_size;
 /next_base = mem_base + mem_len;

... for readability.

No functionality change.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 hw/i386/acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index a0cf3bf..48525a1 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2411,7 +2411,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
             }
             mem_base = 1ULL << 32;
             mem_len = next_base - pcms->below_4g_mem_size;
-            next_base += (1ULL << 32) - pcms->below_4g_mem_size;
+            next_base = mem_base + mem_len;
         }
         numamem = acpi_data_push(table_data, sizeof *numamem);
         build_srat_memory(numamem, mem_base, mem_len, i - 1,
-- 
2.5.5
