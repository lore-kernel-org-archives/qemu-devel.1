Received: from eggs.gnu.org ([2001:4830:134:3::10]:35892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePgk8-0003l0-39
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:33:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePgk7-0006xY-Bs
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:33:00 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 15 Dec 2017 00:30:13 -0300
Message-Id: <20171215033015.738-42-f4bug@amsat.org>
In-Reply-To: <20171215033015.738-1-f4bug@amsat.org>
References: <20171215033015.738-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 41/43] i386/pc: move vmmouse.c to hw/i386/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org, Richard Henderson <rth@twiddle.net>

It's a x86-only device, so it does not make sense to keep it
in the shared misc folder.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/{input => i386}/vmmouse.c | 0
 hw/i386/Makefile.objs        | 1 +
 hw/input/Makefile.objs       | 1 -
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename hw/{input => i386}/vmmouse.c (100%)

diff --git a/hw/input/vmmouse.c b/hw/i386/vmmouse.c
similarity index 100%
rename from hw/input/vmmouse.c
rename to hw/i386/vmmouse.c
diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
index 1548ad1ad0..fd279e7584 100644
--- a/hw/i386/Makefile.objs
+++ b/hw/i386/Makefile.objs
@@ -6,6 +6,7 @@ obj-y += x86-iommu.o intel_iommu.o
 obj-y += amd_iommu.o
 obj-$(CONFIG_XEN) += ../xenpv/ xen/
 obj-$(CONFIG_VMPORT) += vmport.o
+obj-$(CONFIG_VMMOUSE) += vmmouse.o
 
 obj-y += kvmvapic.o
 obj-y += acpi-build.o
diff --git a/hw/input/Makefile.objs b/hw/input/Makefile.objs
index 7715d7230d..636f794b6b 100644
--- a/hw/input/Makefile.objs
+++ b/hw/input/Makefile.objs
@@ -6,7 +6,6 @@ common-obj-$(CONFIG_PL050) += pl050.o
 common-obj-y += ps2.o
 common-obj-$(CONFIG_STELLARIS_INPUT) += stellaris_input.o
 common-obj-$(CONFIG_TSC2005) += tsc2005.o
-common-obj-$(CONFIG_VMMOUSE) += vmmouse.o
 
 common-obj-$(CONFIG_VIRTIO) += virtio-input.o
 common-obj-$(CONFIG_VIRTIO) += virtio-input-hid.o
-- 
2.15.1
