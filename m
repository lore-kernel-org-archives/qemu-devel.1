Received: from eggs.gnu.org ([2001:4830:134:3::10]:34060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cVZ8N-0005HV-4G
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 02:33:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cVZ8M-0006pp-CE
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 02:33:47 -0500
Received: from mail-pf0-x22d.google.com ([2607:f8b0:400e:c00::22d]:32817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cVZ8M-0006pf-6z
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 02:33:46 -0500
Received: by mail-pf0-x22d.google.com with SMTP id y143so39247482pfb.0
	for <qemu-devel@nongnu.org>; Sun, 22 Jan 2017 23:33:46 -0800 (PST)
From: ben@skyportsystems.com
Date: Sun, 22 Jan 2017 23:32:52 -0800
Message-Id: <3e4eb32b6037a314042a00d99439922c6fef332f.1485155611.git.ben@skyportsystems.com>
In-Reply-To: <cover.1485155611.git.ben@skyportsystems.com>
References: <cover.1485155611.git.ben@skyportsystems.com>
In-Reply-To: <cover.1485155611.git.ben@skyportsystems.com>
References: <cover.1485155611.git.ben@skyportsystems.com>
Subject: [Qemu-devel] [PATCH v3 6/6] PC: Support dynamic sysbus on pc_i440fx
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
2.10.1 (Apple Git-78)
