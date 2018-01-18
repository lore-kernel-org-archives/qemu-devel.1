Received: from eggs.gnu.org ([2001:4830:134:3::10]:46744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ecH46-00048O-TQ
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:45:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ecH46-0003zC-2k
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:45:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36041)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ecH45-0003yT-Sz
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:45:38 -0500
Date: Thu, 18 Jan 2018 22:45:31 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1516308132-10272-16-git-send-email-mst@redhat.com>
References: <1516308132-10272-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516308132-10272-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v4 15/29] hw/acpi-build: Make next_base easy to
 follow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Dou Liyang <douly.fnst@cn.fujitsu.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

From: Dou Liyang <douly.fnst@cn.fujitsu.com>

It may be hard to read the assignment statement of "next_base", so

S/next_base += (1ULL << 32) - pcms->below_4g_mem_size;
 /next_base = mem_base + mem_len;

... for readability.

No functionality change.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 6f38fb9..dc4b2b9 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2394,7 +2394,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
             }
             mem_base = 1ULL << 32;
             mem_len = next_base - pcms->below_4g_mem_size;
-            next_base += (1ULL << 32) - pcms->below_4g_mem_size;
+            next_base = mem_base + mem_len;
         }
         numamem = acpi_data_push(table_data, sizeof *numamem);
         build_srat_memory(numamem, mem_base, mem_len, i - 1,
-- 
MST
