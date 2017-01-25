Received: from eggs.gnu.org ([2001:4830:134:3::10]:47512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cWCcz-0003i8-C9
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 20:44:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cWCcy-0005Oc-NH
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 20:44:01 -0500
Received: from mail-yw0-x231.google.com ([2607:f8b0:4002:c05::231]:34457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cWCcy-0005OQ-Ia
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 20:44:00 -0500
Received: by mail-yw0-x231.google.com with SMTP id w75so3588687ywg.1
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 17:44:00 -0800 (PST)
From: ben@skyportsystems.com
Date: Tue, 24 Jan 2017 17:43:26 -0800
Message-Id: <5c6a8bfb4e36acec297d39e2381cb5ed022265f1.1485308342.git.ben@skyportsystems.com>
In-Reply-To: <cover.1485308342.git.ben@skyportsystems.com>
References: <cover.1485308342.git.ben@skyportsystems.com>
In-Reply-To: <cover.1485308342.git.ben@skyportsystems.com>
References: <cover.1485308342.git.ben@skyportsystems.com>
Subject: [Qemu-devel] [PATCH v4 7/9] PC: Support dynamic sysbus on pc_i440fx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ben Warren <ben@skyportsystems.com>

From: Ben Warren <ben@skyportsystems.com>

This allows pc_i440fx-based machines to add new devices such as VM Generation ID
directly to the sysbus.

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
