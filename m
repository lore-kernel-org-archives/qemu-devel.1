Received: from eggs.gnu.org ([209.51.188.92]:55927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1grP84-0000CK-2v
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:28:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1grP81-0004Qj-Rz
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:28:47 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed,  6 Feb 2019 16:28:06 +0100
Message-Id: <20190206152807.31896-7-laurent@vivier.eu>
In-Reply-To: <20190206152807.31896-1-laurent@vivier.eu>
References: <20190206152807.31896-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 6/7] hw/cpu/cluster: Mark the cpu-cluster device
 with user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org, Anthony Green <green@moxielogic.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org, Andrzej Zaborowski <balrogg@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Luc Michel <luc.michel@greensocs.com>, Alistair Francis <alistair.francis@wdc.com>

From: Thomas Huth <thuth@redhat.com>

The device can not be instantiated by the user and QEMU currently
aborts when you try to use it:

$ x86_64-softmmu/qemu-system-x86_64 -device cpu-cluster
qemu-system-x86_64: hw/cpu/cluster.c:73: cpu_cluster_realize:
 Assertion `cbdata.cpu_count > 0' failed.
Aborted (core dumped)

Since this is an internal device only, mark it with user_creatable = false.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <1549371525-29899-1-git-send-email-thuth@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/cpu/cluster.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/cpu/cluster.c b/hw/cpu/cluster.c
index 25f90702b1..6f5f037b3c 100644
--- a/hw/cpu/cluster.c
+++ b/hw/cpu/cluster.c
@@ -79,6 +79,9 @@ static void cpu_cluster_class_init(ObjectClass *klass, void *data)
 
     dc->props = cpu_cluster_properties;
     dc->realize = cpu_cluster_realize;
+
+    /* This is not directly for users, CPU children must be attached by code */
+    dc->user_creatable = false;
 }
 
 static const TypeInfo cpu_cluster_type_info = {
-- 
2.20.1
