Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA8CC4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:43:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80A252074B
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fKYpi4cv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A252074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kONDb-0005VY-Ja
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 11:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=537b2d3de=alistair.francis@wdc.com>)
 id 1kONCG-0004EF-7P; Fri, 02 Oct 2020 11:42:12 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:56208)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=537b2d3de=alistair.francis@wdc.com>)
 id 1kONCE-00045p-0n; Fri, 02 Oct 2020 11:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601653547; x=1633189547;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yqzJylZKVBoQLrbRf8f30FXXBLs3GyNMgU46lH2ELio=;
 b=fKYpi4cvuJMCSN5mmSXLuTXdMLTQ8HDDkNbRoIH6pk9sy3IWA4voGPvH
 VlZ7ze9HIoM33RDc2Epp3KwilEEoAPZhxD5FsFuJT8hpoNyoSrzSodpTn
 dDXQ30Gj0osb0VKTw4iVcZ5hGzVZsqWWSo4sQjqi8B7HJ/R1sySPSOE8G
 Dh9ta2JZMX4//4EDVuI6F3oGOo+1VnsRIxLkIEmKpwdcy9h5NrLDZlef3
 oTkBojNpuiiRi6q99nbeQvQZ46GQ3Lyv1vv0HyIzZpL30+JktXYiBsoXu
 kwd2U8ysenprH0qEQaBAVfeKK6QL76TuJ+3OpbWA+lxsP7Q1kdGfkmwCk g==;
IronPort-SDR: MS6kGOvM6xYJB1ey1BvrgDon9+sxjAxdtjswv90VFDlxn/d7jC28/Af6wjpv57+MqARHs71rPG
 BD1uA9BPvn5iY1yWnKkpJ9dV10oJEmT4rQqe6vE6CtkZc3DpCeGV4cFroLDmbIkybm4QuotWT/
 U+uVTXVcHGcjwCdNxOuB0ZDh9YAncpWnziWKGnRtwfoUN8iit6hkDnV7x9af1fm7Bi410SEfSf
 FMS6QrrtCz6AlRnrdwhLld3O6VVVMxEvqNR0+wYasHKEoWJEquYcxl9km+kGncYh+yMcpq2/SU
 nL8=
X-IronPort-AV: E=Sophos;i="5.77,328,1596470400"; d="scan'208";a="252338169"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 23:45:45 +0800
IronPort-SDR: IZFzHTq9+VrF5Xq+05yiW9qNNXLy9M1BsWa8E7L3r+Xodqrwkqy4RitavioL+kL7Rt4TCbnsiU
 SbTYQadhqKVw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2020 08:28:04 -0700
IronPort-SDR: w0lVzOato0+43o5+FEcQx0W5sep/GuD/moYP001i42tt5krx//FlFJrW33jmcR+y2l+EzIqdtb
 O3lLV0ZjVIdA==
WDCIronportException: Internal
Received: from dbzljc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.174])
 by uls-op-cesaip01.wdc.com with ESMTP; 02 Oct 2020 08:42:07 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 2/4] hw/riscv: Return the end address of the loaded firmware
Date: Fri,  2 Oct 2020 08:31:08 -0700
Message-Id: <dc18ce8e762658aa80337a97e6e9c978ab9e1696.1601652616.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1601652616.git.alistair.francis@wdc.com>
References: <cover.1601652616.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=537b2d3de=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 11:42:05
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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


