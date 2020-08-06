Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC8AC433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:23:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0D5822D03
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:23:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D5822D03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3cLe-0006lR-Lf
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 05:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liangpeng10@huawei.com>)
 id 1k3cKc-0005As-IX; Thu, 06 Aug 2020 05:37:02 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41098 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liangpeng10@huawei.com>)
 id 1k3cKa-0007WL-5v; Thu, 06 Aug 2020 05:37:02 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 4BC14C9C85E425E67E81;
 Thu,  6 Aug 2020 17:36:51 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Thu, 6 Aug 2020 17:36:41 +0800
From: Peng Liang <liangpeng10@huawei.com>
To: <qemu-trivial@nongnu.org>
Subject: [PATCH 1/5] log: Add logs for vm start and destroy
Date: Thu, 6 Aug 2020 17:37:16 +0800
Message-ID: <20200806093720.2355692-2-liangpeng10@huawei.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200806093720.2355692-1-liangpeng10@huawei.com>
References: <20200806093720.2355692-1-liangpeng10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35;
 envelope-from=liangpeng10@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 03:36:23
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
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
Cc: Peng Liang <liangpeng10@huawei.com>, qemu-devel@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add logs for vm start and destroy.

Signed-off-by: Peng Liang <liangpeng10@huawei.com>
---
 hw/acpi/core.c  | 3 +++
 hw/core/reset.c | 2 ++
 softmmu/vl.c    | 8 ++++++++
 3 files changed, 13 insertions(+)

diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index ac06db3450..0a24f018cf 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -560,13 +560,16 @@ static void acpi_pm1_cnt_write(ACPIREGS *ar, uint16_t val)
         uint16_t sus_typ = (val >> 10) & 7;
         switch(sus_typ) {
         case 0: /* soft power off */
+            info_report("VM will be soft power off");
             qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
             break;
         case 1:
+            info_report("VM will be suspend state");
             qemu_system_suspend_request();
             break;
         default:
             if (sus_typ == ar->pm1.cnt.s4_val) { /* S4 request */
+                info_report("VM will be S4 state");
                 qapi_event_send_suspend_disk();
                 qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
             }
diff --git a/hw/core/reset.c b/hw/core/reset.c
index 9c477f2bf5..bd583c77ac 100644
--- a/hw/core/reset.c
+++ b/hw/core/reset.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "qemu/queue.h"
 #include "sysemu/reset.h"
+#include "qemu/error-report.h"
 
 /* reset/shutdown handler */
 
@@ -64,6 +65,7 @@ void qemu_devices_reset(void)
 {
     QEMUResetEntry *re, *nre;
 
+    info_report("reset all devices");
     /* reset all devices */
     QTAILQ_FOREACH_SAFE(re, &reset_handlers, entry, nre) {
         re->func(re->opaque);
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 4eb9d1f7fd..a9f06111b3 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -1657,9 +1657,11 @@ static bool main_loop_should_exit(void)
     }
     if (qemu_powerdown_requested()) {
         qemu_system_powerdown();
+        info_report("domain is power down by outside operation");
     }
     if (qemu_vmstop_requested(&r)) {
         vm_stop(r);
+        info_report("domain is stopped by outside operation");
     }
     return false;
 }
@@ -1669,6 +1671,7 @@ void qemu_main_loop(void)
 #ifdef CONFIG_PROFILER
     int64_t ti;
 #endif
+    info_report("qemu enter main_loop");
     while (!main_loop_should_exit()) {
 #ifdef CONFIG_PROFILER
         ti = profile_getclock();
@@ -2941,6 +2944,7 @@ void qemu_init(int argc, char **argv, char **envp)
 
     autostart = 1;
 
+    info_report("qemu pid is %d, options parsing start", getpid());
     /* first pass of option parsing */
     optind = 1;
     while (optind < argc) {
@@ -3154,6 +3158,7 @@ void qemu_init(int argc, char **argv, char **envp)
                 exit(0);
                 break;
             case QEMU_OPTION_m:
+                info_report("memory options parse start");
                 opts = qemu_opts_parse_noisily(qemu_find_opts("memory"),
                                                optarg, true);
                 if (!opts) {
@@ -4152,6 +4157,7 @@ void qemu_init(int argc, char **argv, char **envp)
     current_machine->maxram_size = maxram_size;
     current_machine->ram_slots = ram_slots;
 
+    info_report("configure accelerator %s start", machine_class->name);
     /*
      * Note: uses machine properties such as kernel-irqchip, must run
      * after machine_set_property().
@@ -4300,6 +4306,7 @@ void qemu_init(int argc, char **argv, char **envp)
     replay_checkpoint(CHECKPOINT_INIT);
     qdev_machine_init();
 
+    info_report("machine init start");
     current_machine->boot_order = boot_order;
 
     /* parse features once if machine provides default cpu_type */
@@ -4379,6 +4386,7 @@ void qemu_init(int argc, char **argv, char **envp)
             exit(1);
     }
 
+    info_report("device init start");
     /* init generic devices */
     rom_set_order_override(FW_CFG_ORDER_OVERRIDE_DEVICE);
     qemu_opts_foreach(qemu_find_opts("device"),
-- 
2.18.4


