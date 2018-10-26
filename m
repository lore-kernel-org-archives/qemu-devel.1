Received: from eggs.gnu.org ([2001:4830:134:3::10]:35411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gFz1I-0006G6-3z
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 06:07:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gFz1G-0005jA-Ex
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 06:07:08 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 26 Oct 2018 11:06:48 +0100
Message-Id: <1540548409-22560-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1540548409-22560-1-git-send-email-thuth@redhat.com>
References: <1540548409-22560-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] hw/arm: Deprecate the "collie" board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

"collie" has no entry in the MAINTAINERS file, and the initial commit
with ID c64b21d519a6ecae12f65625fa60f3035ed88644 said:

"Add very basic implementation of collie PDA emulation. The system lacks
 LoCoMo and graphics/sound emulation. Linux kernel boots up to mounting
 rootfs (theoretically it can be provided in pflash images)."

Thus the board is incomplete, since after that initial commit, there were
only the usual QEMU API-related rework patches applied to this file.
Unless someone speaks up and says that this board is still useful, we
should consider to remove it, so mark it as deprecated now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/collie.c      | 1 +
 qemu-deprecated.texi | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index 48b732c..e41bbc5 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -60,6 +60,7 @@ static void collie_machine_init(MachineClass *mc)
     mc->init = collie_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("sa1110");
+    mc->deprecation_reason = "board is incomplete and unmaintained";
 }
 
 DEFINE_MACHINE("collie", collie_machine_init)
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 11b870c..acf9809 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -129,6 +129,11 @@ This machine type uses an unmaintained firmware, broken in lots of ways,
 and unable to start post-2004 operating systems. 40p machine type should be
 used instead.
 
+@subsection collie (ARM) (since 3.1)
+
+The board is incomplete and unmaintained. Use a different ARM board if
+possible instead.
+
 @section Device options
 
 @subsection Block device options
-- 
1.8.3.1
