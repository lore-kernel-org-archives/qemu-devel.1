Received: from eggs.gnu.org ([2001:4830:134:3::10]:51335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCG70-0008OC-QN
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 21:29:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCG70-0005Ht-17
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 21:29:06 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  7 Nov 2017 23:28:25 -0300
Message-Id: <20171108022828.7242-4-f4bug@amsat.org>
In-Reply-To: <20171108022828.7242-1-f4bug@amsat.org>
References: <20171108022828.7242-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 3/6] hw/arm: deprecate the Gumstix boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/gumstix.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/gumstix.c b/hw/arm/gumstix.c
index bba9e9f57a..160f7f089c 100644
--- a/hw/arm/gumstix.c
+++ b/hw/arm/gumstix.c
@@ -129,6 +129,7 @@ static void connex_class_init(ObjectClass *oc, void *data)
     mc->desc = "Gumstix Connex (PXA255)";
     mc->init = connex_init;
     mc->ignore_memory_transaction_failures = true;
+    mc->deprecated_reason = "Unmaintained";
 }
 
 static const TypeInfo connex_type = {
@@ -145,6 +146,7 @@ static void verdex_class_init(ObjectClass *oc, void *data)
     mc->init = verdex_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("pxa270-c0");
+    mc->deprecated_reason = "Unmaintained";
 }
 
 static const TypeInfo verdex_type = {
-- 
2.15.0
