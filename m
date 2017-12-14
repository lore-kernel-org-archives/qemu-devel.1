Received: from eggs.gnu.org ([2001:4830:134:3::10]:36514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1ePKpi-0004WI-UM
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 23:09:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1ePKpf-000119-1l
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 23:09:19 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:35218
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1ePKpe-0000xo-M4
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 23:09:14 -0500
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Date: Thu, 14 Dec 2017 12:08:55 +0800
Message-ID: <20171214040855.22231-3-douly.fnst@cn.fujitsu.com>
In-Reply-To: <20171214040855.22231-1-douly.fnst@cn.fujitsu.com>
References: <20171214040855.22231-1-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RESEND PATCH for-2.12 2/2] hw/acpi-build: Make
 next_base easy to follow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ehabkost@redhat.com, imammedo@redhat.com, mst@redhat.com
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, indou.takao@jp.fujitsu.com, Dou Liyang <douly.fnst@cn.fujitsu.com>

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
index 73519ab3ac..2010108ae0 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2381,7 +2381,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
             }
             mem_base = 1ULL << 32;
             mem_len = next_base - pcms->below_4g_mem_size;
-            next_base += (1ULL << 32) - pcms->below_4g_mem_size;
+            next_base = mem_base + mem_len;
         }
         numamem = acpi_data_push(table_data, sizeof *numamem);
         build_srat_memory(numamem, mem_base, mem_len, i - 1,
-- 
2.14.3
