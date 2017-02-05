Received: from eggs.gnu.org ([2001:4830:134:3::10]:59584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1caIsG-0002bT-Rm
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 04:12:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1caIsG-0001t3-1P
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 04:12:44 -0500
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:36568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1caIsF-0001st-SU
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 04:12:43 -0500
Received: by mail-pg0-x235.google.com with SMTP id v184so19465821pgv.3
	for <qemu-devel@nongnu.org>; Sun, 05 Feb 2017 01:12:43 -0800 (PST)
From: ben@skyportsystems.com
Date: Sun,  5 Feb 2017 01:12:03 -0800
Message-Id: <a0d502ddafd0bb57633d863c8b2d89693ad5b06f.1486285434.git.ben@skyportsystems.com>
In-Reply-To: <cover.1486285434.git.ben@skyportsystems.com>
References: <cover.1486285434.git.ben@skyportsystems.com>
In-Reply-To: <cover.1486285434.git.ben@skyportsystems.com>
References: <cover.1486285434.git.ben@skyportsystems.com>
Subject: [Qemu-devel] [PATCH v5 08/10] PC: Support dynamic sysbus on
 pc_i440fx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lersek@redhat.com, mst@redhat.com, imammedo@redhat.com, Ben Warren <ben@skyportsystems.com>

From: Ben Warren <ben@skyportsystems.com>

This allows pc_i440fx-based machines to add new devices such as
VM Generation ID directly to the sysbus.

Signed-off-by: Ben Warren <ben@skyportsystems.com>
---
 hw/i386/pc_piix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 9f102aa..c8ad99c 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -435,6 +435,7 @@ static void pc_i440fx_machine_options(MachineClass *m)
     m->hot_add_cpu = pc_hot_add_cpu;
     m->default_machine_opts = "firmware=bios-256k.bin";
     m->default_display = "std";
+    m->has_dynamic_sysbus = true;
 }
 
 static void pc_i440fx_2_9_machine_options(MachineClass *m)
-- 
2.7.4
