Received: from eggs.gnu.org ([2001:4830:134:3::10]:56918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cTCq6-0002VO-Pu
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:21:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cTCq6-0007Iv-0w
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:21:10 -0500
Received: from mail-pf0-x233.google.com ([2607:f8b0:400e:c00::233]:35488)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cTCq5-0007Ib-S9
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:21:09 -0500
Received: by mail-pf0-x233.google.com with SMTP id f144so55387570pfa.2
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 11:21:09 -0800 (PST)
From: ben@skyportsystems.com
Date: Mon, 16 Jan 2017 11:20:58 -0800
Message-Id: <91fadf23ab57b3accffc4af99083dfc8ada291fa.1484594095.git.ben@skyportsystems.com>
In-Reply-To: <cover.1484593565.git.ben@skyportsystems.com>
References: <cover.1484593565.git.ben@skyportsystems.com>
In-Reply-To: <cover.1484594095.git.ben@skyportsystems.com>
References: <cover.1484594095.git.ben@skyportsystems.com>
Subject: [Qemu-devel] [PATCH v2 6/6] PC: Support dynamic sysbus on pc_i440fx
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

Signed-off-by: Ben Warren <ben@skyportsystems.com>
---
 hw/i386/pc_piix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index a54a468..8ac894c 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -435,6 +435,7 @@ static void pc_i440fx_machine_options(MachineClass *m)
     m->hot_add_cpu = pc_hot_add_cpu;
     m->default_machine_opts = "firmware=bios-256k.bin";
     m->default_display = "std";
+    m->has_dynamic_sysbus = true;
 }
 
 static void pc_i440fx_2_8_machine_options(MachineClass *m)
-- 
2.7.4
