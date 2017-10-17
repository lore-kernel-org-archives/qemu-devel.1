Received: from eggs.gnu.org ([2001:4830:134:3::10]:34308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4FWS-0007GB-0z
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 20:14:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4FWR-0004yc-09
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 20:14:15 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 16 Oct 2017 21:12:05 -0300
Message-Id: <20171017001209.32276-36-f4bug@amsat.org>
In-Reply-To: <20171017001209.32276-1-f4bug@amsat.org>
References: <20171017001209.32276-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 35/39] i386/pc: move vmport.c from hw/misc/
 to hw/i386/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 default-configs/i386-softmmu.mak   | 1 -
 default-configs/x86_64-softmmu.mak | 1 -
 hw/{misc => i386}/vmport.c         | 0
 hw/i386/Makefile.objs              | 1 +
 hw/misc/Makefile.objs              | 2 --
 5 files changed, 1 insertion(+), 4 deletions(-)
 rename hw/{misc => i386}/vmport.c (100%)

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index d2ab2f6655..dbc4e65652 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -41,7 +41,6 @@ CONFIG_PCI_PIIX=y
 CONFIG_WDT_IB700=y
 CONFIG_ISA_DEBUG=y
 CONFIG_ISA_TESTDEV=y
-CONFIG_VMPORT=y
 CONFIG_SGA=y
 CONFIG_LPC_ICH9=y
 CONFIG_PCI_Q35=y
diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-softmmu.mak
index 9bde2f1c4b..f1fe508ff4 100644
--- a/default-configs/x86_64-softmmu.mak
+++ b/default-configs/x86_64-softmmu.mak
@@ -41,7 +41,6 @@ CONFIG_PCI_PIIX=y
 CONFIG_WDT_IB700=y
 CONFIG_ISA_DEBUG=y
 CONFIG_ISA_TESTDEV=y
-CONFIG_VMPORT=y
 CONFIG_SGA=y
 CONFIG_LPC_ICH9=y
 CONFIG_PCI_Q35=y
diff --git a/hw/misc/vmport.c b/hw/i386/vmport.c
similarity index 100%
rename from hw/misc/vmport.c
rename to hw/i386/vmport.c
diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
index 909ead6a77..feff56a9b7 100644
--- a/hw/i386/Makefile.objs
+++ b/hw/i386/Makefile.objs
@@ -9,3 +9,4 @@ obj-$(CONFIG_XEN) += ../xenpv/ xen/
 obj-y += kvmvapic.o
 obj-y += acpi-build.o
 obj-y += pci-assign-load-rom.o
+obj-y += vmport.o
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 19202d90cf..03bc758592 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -11,8 +11,6 @@ common-obj-$(CONFIG_EDU) += edu.o
 common-obj-y += unimp.o
 common-obj-y += vmcoreinfo.o
 
-obj-$(CONFIG_VMPORT) += vmport.o
-
 # ARM devices
 common-obj-$(CONFIG_PL310) += arm_l2x0.o
 common-obj-$(CONFIG_INTEGRATOR_DEBUG) += arm_integrator_debug.o
-- 
2.15.0.rc0
