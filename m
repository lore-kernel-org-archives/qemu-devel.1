Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C282C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 00:30:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8259F207DE
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 00:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LfKvTiyN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8259F207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSUgi-0001tS-KU
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 20:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=549b5cc2b=alistair.francis@wdc.com>)
 id 1kSUet-0000Mi-UL; Tue, 13 Oct 2020 20:28:49 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:47552)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=549b5cc2b=alistair.francis@wdc.com>)
 id 1kSUen-0003z6-1h; Tue, 13 Oct 2020 20:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1602635320; x=1634171320;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iRlx/qzb5H3O+z1NtwCW9n3IpqBQRkhelMspOXd68ZM=;
 b=LfKvTiyNxQN+1BeTWN7mV73KHZVqez5QZx+dweiJuBAMuEnljbyu4EKG
 VV65RJsuEMn8joRyOX2Sx2mSU0gGSBHgnYfu2M+adAG/PpS/GzvWpISfh
 PcBiohiVYYS8/CRAoFwOlWx1tz/8v/mazB/+YtC3WS2YWy0yAl6aHYaBf
 rQYihF+GB/ky7U6hvL76EmMHX19W9h8b5j1opzdrt29JrBuV0qv3rhDFO
 rdnqpCW8Xn+iSSs/+cmbJD9IU42YnJThY9X7z8yGplbXEbPc5+xoIxePb
 pogNNQz9Edus/OkcW37hm4WQ+tzqlqPwXrwlhJMbdt3ruwR5IZQpPYdvA Q==;
IronPort-SDR: VPuPQijy4uddo7iUzIH5BvQIcDRhfik9SD2DwEWd8pkqUpgUE+Hcr20pPpGlivatVMY7JLKotk
 hpd35q6EUI0NV3Pz0lOheokIv6DMDyvmIP4osv3BrvNm65v7Qs6Dd5sQ+Qh2/eebPPAkBC2AVs
 nNKVQQ+Fm15k5sWP34ZYiUVRaELjj0RRyIYgwlj84s7lxJxEGSiKp/tF+C+/QEgqg4T55RnKWh
 e5Z1fyIrblVHHGfZviJBDsI+HLePJFltUziNvEt8+PxiTiyIwtfXOaBJ+vT2lOiJp8c01Epvdw
 1c0=
X-IronPort-AV: E=Sophos;i="5.77,372,1596470400"; d="scan'208";a="259612087"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2020 08:28:38 +0800
IronPort-SDR: RoQPgEjzvgnqWgGA0OdxW+H8Ep55h8x0aEVJOI8AbwidN8BKZGsUn+ik2aAbRWBwFhgD8qZ/Ps
 NQIB2QrGRwkSNEfX0PZC9Al2C4sATcoLtzL8JdnufKZurQCeZQO8BDKl36Y5V5qmaR7Dm3lwSH
 AjjeWMlXjVRk/HZDRQguHgypxxcimlrdM6QLac4T5sR/sx6w37SEcJ+xNUfhfxNI6W/+v2en+R
 bLCxJFw9y1dfH/MdLXMN34zPdVJDwOv5TiLa1Bii5vQn+RWaOb4HecVP7t25KxGPj7YHX1LFId
 wgc2JgDzru+f/LIpRB8bxFSP
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2020 17:15:12 -0700
IronPort-SDR: CX2lR5f6NkZdaViH0xEC8GtDWyoMnOKswefunDliBno1UXsUMG6KBCu2ab3XVN8WPncO1RyQF0
 rz1zdLB2qLFmoRVwjozSjlCjjLklZ6/mCHVhgxONcRvogaH8/DOijiyCNQWh5f0b7uSaMq3tV0
 R7hBYZBxAsthYIV6YQy7mjZT4+5EnpbhbZ4ZV7Pu7H3mGD1VuU3xt4atgr+As/+KSL/2nUmCyK
 eB5PAGyMSW2MGHW68+jcdou52lpxH3dGyBt91SdsIABmSIqPePL0i94Z8VifH56qnHsCV9NzeK
 4aw=
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.55])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Oct 2020 17:28:39 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 2/4] hw/riscv: Return the end address of the loaded firmware
Date: Tue, 13 Oct 2020 17:17:28 -0700
Message-Id: <558cf67162342d65a23262248b040563716628b2.1602634524.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1602634524.git.alistair.francis@wdc.com>
References: <cover.1602634524.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=549b5cc2b=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 20:28:34
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of returning the unused entry address from riscv_load_firmware()
instead return the end address. Also return the end address from
riscv_find_and_load_firmware().

This tells the caller if a firmware was loaded and how big it is. This
can be used to determine the load address of the next image (usually the
kernel).

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/boot.h |  8 ++++----
 hw/riscv/boot.c         | 28 +++++++++++++++++-----------
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index 451338780a..0acbd8aa6e 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -23,10 +23,10 @@
 #include "exec/cpu-defs.h"
 #include "hw/loader.h"
 
-void riscv_find_and_load_firmware(MachineState *machine,
-                                  const char *default_machine_firmware,
-                                  hwaddr firmware_load_addr,
-                                  symbol_fn_t sym_cb);
+target_ulong riscv_find_and_load_firmware(MachineState *machine,
+                                          const char *default_machine_firmware,
+                                          hwaddr firmware_load_addr,
+                                          symbol_fn_t sym_cb);
 char *riscv_find_firmware(const char *firmware_filename);
 target_ulong riscv_load_firmware(const char *firmware_filename,
                                  hwaddr firmware_load_addr,
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 21adaae56e..fa699308a0 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -40,12 +40,13 @@
 #define fw_dynamic_info_data(__val)     cpu_to_le64(__val)
 #endif
 
-void riscv_find_and_load_firmware(MachineState *machine,
-                                  const char *default_machine_firmware,
-                                  hwaddr firmware_load_addr,
-                                  symbol_fn_t sym_cb)
+target_ulong riscv_find_and_load_firmware(MachineState *machine,
+                                          const char *default_machine_firmware,
+                                          hwaddr firmware_load_addr,
+                                          symbol_fn_t sym_cb)
 {
     char *firmware_filename = NULL;
+    target_ulong firmware_end_addr = firmware_load_addr;
 
     if ((!machine->firmware) || (!strcmp(machine->firmware, "default"))) {
         /*
@@ -60,9 +61,12 @@ void riscv_find_and_load_firmware(MachineState *machine,
 
     if (firmware_filename) {
         /* If not "none" load the firmware */
-        riscv_load_firmware(firmware_filename, firmware_load_addr, sym_cb);
+        firmware_end_addr = riscv_load_firmware(firmware_filename,
+                                                firmware_load_addr, sym_cb);
         g_free(firmware_filename);
     }
+
+    return firmware_end_addr;
 }
 
 char *riscv_find_firmware(const char *firmware_filename)
@@ -91,17 +95,19 @@ target_ulong riscv_load_firmware(const char *firmware_filename,
                                  hwaddr firmware_load_addr,
                                  symbol_fn_t sym_cb)
 {
-    uint64_t firmware_entry;
+    uint64_t firmware_entry, firmware_size, firmware_end;
 
     if (load_elf_ram_sym(firmware_filename, NULL, NULL, NULL,
-                         &firmware_entry, NULL, NULL, NULL,
+                         &firmware_entry, NULL, &firmware_end, NULL,
                          0, EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
-        return firmware_entry;
+        return firmware_end;
     }
 
-    if (load_image_targphys_as(firmware_filename, firmware_load_addr,
-                               ram_size, NULL) > 0) {
-        return firmware_load_addr;
+    firmware_size = load_image_targphys_as(firmware_filename,
+                                           firmware_load_addr, ram_size, NULL);
+
+    if (firmware_size > 0) {
+        return firmware_load_addr + firmware_size;
     }
 
     error_report("could not load firmware '%s'", firmware_filename);
-- 
2.28.0


