Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C3EC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 12:06:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 869B420825
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 12:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bi2HNjMP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 869B420825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45660 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNyrB-0002tt-LG
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 08:06:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hNylm-0007Sm-8t
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hNylk-0003Vx-Uj
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:26 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:38531)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hNylg-0003OI-Vv
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:23 -0400
Received: by mail-wr1-x432.google.com with SMTP id v11so1815858wru.5
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 05:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=cukpgcV1j7F/Z6mZritMbWeaif27ugZHIZtYyXsN4A8=;
	b=Bi2HNjMPDT7eJlmlr0XLAiopmtU56VPynJDqZTS8WlwQFTi/XARaAcIOJd0MhMMT/K
	ALR7GxrnQYF4Vrjt3qpSqjcqyj+rUWx2NB1rqIpD87Kd/mIbCgv8bQtfCvPUssnFdlOO
	SMrZsHXbLlCIuQHn28T8muoVdy8tj/HChqLRKtm6NIyrwYhqhDfto96hxxBWtWfNPRkW
	F4XEWbuMSgLDKTBn2Bt7AxOZWUYXoDEuK7AznnQdIGOHVmJVxJwkg6A5rTuPeBItGDA0
	q0p0vHd1LYyaKRfbNupPz98UHCPgwLbJa870vs5NZb9P7pPfnLWreXCQ9upDFcnldcB0
	4/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=cukpgcV1j7F/Z6mZritMbWeaif27ugZHIZtYyXsN4A8=;
	b=jBYsTTJMelhKojxbFTWSs+v8ML/bD1OqVuirB7+x1+Zutqrf86UIBxu+i/Rm3k2Bbd
	JaJL50xcXdX+1zRZfNe6soADB0n2iGRW5QLmaxPd9ma99F6jdX89h7a8dZx8dRrroTfH
	QE9cfXvVNZqQxSn92V7EaUm7OC8QszR3hxYJq4AWNgQNpckxNS4C2wnDXXQD1Ok/6xm5
	cKqQQqFAuIrIJ35i2uY0olcRE2qRSkLGf99AXNgVuiu+P27dYlI6fqpbnuzRRWeaMqYV
	XuGCEPKMq8YX902htj6FyyA9XQFHWCCxD+Ngb0iCmZu5ntbfwTmHq3XIXexK4YAKnqkn
	84GA==
X-Gm-Message-State: APjAAAVWyW8BYdmoeu5yiUKlDopQnV58LB1ZXZWgQ4vVkxpr/nChu0ml
	1got1v8PiqamQ/A1tSdtYGjcTAuhfUI=
X-Google-Smtp-Source: APXvYqzXVmz/jqtglC66eZ+PQzxyA56be6UM6u/MUWmqFUvcSsx40OjdhV+4O82doOB80vnzZGW7ZA==
X-Received: by 2002:a5d:6a47:: with SMTP id t7mr21325003wrw.307.1557230417468; 
	Tue, 07 May 2019 05:00:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id g3sm12348596wmf.9.2019.05.07.05.00.15
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 05:00:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 12:59:58 +0100
Message-Id: <20190507120011.18100-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507120011.18100-1-peter.maydell@linaro.org>
References: <20190507120011.18100-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::432
Subject: [Qemu-devel] [PULL 02/15] pflash_cfi01: New
 pflash_cfi01_legacy_drive()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Markus Armbruster <armbru@redhat.com>

Factored out of pc_system_firmware_init() so the next commit can reuse
it in hw/arm/virt.c.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190416091348.26075-3-armbru@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/block/flash.h |  1 +
 hw/block/pflash_cfi01.c  | 28 ++++++++++++++++++++++++++++
 hw/i386/pc_sysfw.c       | 16 ++--------------
 3 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/include/hw/block/flash.h b/include/hw/block/flash.h
index a0f488732af..1acaf7de802 100644
--- a/include/hw/block/flash.h
+++ b/include/hw/block/flash.h
@@ -24,6 +24,7 @@ PFlashCFI01 *pflash_cfi01_register(hwaddr base,
                                    int be);
 BlockBackend *pflash_cfi01_get_blk(PFlashCFI01 *fl);
 MemoryRegion *pflash_cfi01_get_memory(PFlashCFI01 *fl);
+void pflash_cfi01_legacy_drive(PFlashCFI01 *dev, DriveInfo *dinfo);
 
 /* pflash_cfi02.c */
 
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 16dfae14b80..333b7362771 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -44,9 +44,12 @@
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "qemu/bitops.h"
+#include "qemu/error-report.h"
 #include "qemu/host-utils.h"
 #include "qemu/log.h"
+#include "qemu/option.h"
 #include "hw/sysbus.h"
+#include "sysemu/blockdev.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
 
@@ -968,6 +971,31 @@ MemoryRegion *pflash_cfi01_get_memory(PFlashCFI01 *fl)
     return &fl->mem;
 }
 
+/*
+ * Handle -drive if=pflash for machines that use properties.
+ * If @dinfo is null, do nothing.
+ * Else if @fl's property "drive" is already set, fatal error.
+ * Else set it to the BlockBackend with @dinfo.
+ */
+void pflash_cfi01_legacy_drive(PFlashCFI01 *fl, DriveInfo *dinfo)
+{
+    Location loc;
+
+    if (!dinfo) {
+        return;
+    }
+
+    loc_push_none(&loc);
+    qemu_opts_loc_restore(dinfo->opts);
+    if (fl->blk) {
+        error_report("clashes with -machine");
+        exit(1);
+    }
+    qdev_prop_set_drive(DEVICE(fl), "drive",
+                        blk_by_legacy_dinfo(dinfo), &error_fatal);
+    loc_pop(&loc);
+}
+
 static void postload_update_cb(void *opaque, int running, RunState state)
 {
     PFlashCFI01 *pfl = opaque;
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 75925f5d3f7..751fcafa121 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -269,9 +269,7 @@ void pc_system_firmware_init(PCMachineState *pcms,
 {
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     int i;
-    DriveInfo *pflash_drv;
     BlockBackend *pflash_blk[ARRAY_SIZE(pcms->flash)];
-    Location loc;
 
     if (!pcmc->pci_enabled) {
         old_pc_system_rom_init(rom_memory, true);
@@ -280,18 +278,8 @@ void pc_system_firmware_init(PCMachineState *pcms,
 
     /* Map legacy -drive if=pflash to machine properties */
     for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
-        pflash_drv = drive_get(IF_PFLASH, 0, i);
-        if (pflash_drv) {
-            loc_push_none(&loc);
-            qemu_opts_loc_restore(pflash_drv->opts);
-            if (pflash_cfi01_get_blk(pcms->flash[i])) {
-                error_report("clashes with -machine");
-                exit(1);
-            }
-            qdev_prop_set_drive(DEVICE(pcms->flash[i]), "drive",
-                                blk_by_legacy_dinfo(pflash_drv), &error_fatal);
-            loc_pop(&loc);
-        }
+        pflash_cfi01_legacy_drive(pcms->flash[i],
+                                  drive_get(IF_PFLASH, 0, i));
         pflash_blk[i] = pflash_cfi01_get_blk(pcms->flash[i]);
     }
 
-- 
2.20.1


