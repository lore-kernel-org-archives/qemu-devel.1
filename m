Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881DCC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 03:58:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D91B2084D
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 03:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D91B2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3X34-0000Kb-Kb
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 23:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1k3X2L-0007Z6-F8
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 23:57:49 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4164 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1k3X2J-0001RH-Gf
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 23:57:49 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 12F61C008C9CF37D27D8;
 Thu,  6 Aug 2020 11:57:43 +0800 (CST)
Received: from localhost (10.174.185.104) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Thu, 6 Aug 2020
 11:57:34 +0800
From: Ying Fang <fangying1@huawei.com>
To: <qemu-devel@nongnu.org>, <imammedo@redhat.com>, <mst@redhat.com>
Subject: [PATCH v5 1/2] hw/smbios: add options for type 4 max-speed and
 current-speed
Date: Thu, 6 Aug 2020 11:56:33 +0800
Message-ID: <20200806035634.376-2-fangying1@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200806035634.376-1-fangying1@huawei.com>
References: <20200806035634.376-1-fangying1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.185.104]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190; envelope-from=fangying1@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 23:57:43
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
Cc: lvivier@redhat.com, zhang.zhanghailiang@huawei.com, alex.chen@huawei.com,
 Ying Fang <fangying1@huawei.com>, Heyi Guo <guoheyi@huawei.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Common VM users sometimes care about CPU speed, so we add two new
options to allow VM vendors to present CPU speed to their users.
Normally these information can be fetched from host smbios.

Strictly speaking, the "max speed" and "current speed" in type 4
are not really for the max speed and current speed of processor, for
"max speed" identifies a capability of the system, and "current speed"
identifies the processor's speed at boot (see smbios spec), but some
applications do not tell the differences.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Ying Fang <fangying1@huawei.com>
Signed-off-by: Heyi Guo <guoheyi@huawei.com>
---
 hw/smbios/smbios.c | 36 ++++++++++++++++++++++++++++++++----
 qemu-options.hx    |  2 +-
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 11d476c4a2..53181a58eb 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -93,9 +93,21 @@ static struct {
     const char *manufacturer, *version, *serial, *asset, *sku;
 } type3;
 
+/*
+ * SVVP requires max_speed and current_speed to be set and not being
+ * 0 which counts as unknown (SMBIOS 3.1.0/Table 21). Set the
+ * default value to 2000MHz as we did before.
+ */
+#define DEFAULT_CPU_SPEED 2000
+
 static struct {
     const char *sock_pfx, *manufacturer, *version, *serial, *asset, *part;
-} type4;
+    uint64_t max_speed;
+    uint64_t current_speed;
+} type4 = {
+    .max_speed = DEFAULT_CPU_SPEED,
+    .current_speed = DEFAULT_CPU_SPEED
+};
 
 static struct {
     size_t nvalues;
@@ -273,6 +285,14 @@ static const QemuOptDesc qemu_smbios_type4_opts[] = {
         .name = "version",
         .type = QEMU_OPT_STRING,
         .help = "version number",
+    },{
+        .name = "max-speed",
+        .type = QEMU_OPT_NUMBER,
+        .help = "max speed in MHz",
+    },{
+        .name = "current-speed",
+        .type = QEMU_OPT_NUMBER,
+        .help = "speed at system boot in MHz",
     },{
         .name = "serial",
         .type = QEMU_OPT_STRING,
@@ -587,9 +607,8 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
     SMBIOS_TABLE_SET_STR(4, processor_version_str, type4.version);
     t->voltage = 0;
     t->external_clock = cpu_to_le16(0); /* Unknown */
-    /* SVVP requires max_speed and current_speed to not be unknown. */
-    t->max_speed = cpu_to_le16(2000); /* 2000 MHz */
-    t->current_speed = cpu_to_le16(2000); /* 2000 MHz */
+    t->max_speed = cpu_to_le16(type4.max_speed);
+    t->current_speed = cpu_to_le16(type4.current_speed);
     t->status = 0x41; /* Socket populated, CPU enabled */
     t->processor_upgrade = 0x01; /* Other */
     t->l1_cache_handle = cpu_to_le16(0xFFFF); /* N/A */
@@ -1130,6 +1149,15 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
             save_opt(&type4.serial, opts, "serial");
             save_opt(&type4.asset, opts, "asset");
             save_opt(&type4.part, opts, "part");
+            type4.max_speed = qemu_opt_get_number(opts, "max-speed",
+                                                  DEFAULT_CPU_SPEED);
+            type4.current_speed = qemu_opt_get_number(opts, "current-speed",
+                                                      DEFAULT_CPU_SPEED);
+            if (type4.max_speed > UINT16_MAX ||
+                type4.current_speed > UINT16_MAX) {
+                error_setg(errp, "SMBIOS CPU speed is too large (> %d)",
+                           UINT16_MAX);
+            }
             return;
         case 11:
             qemu_opts_validate(opts, qemu_smbios_type11_opts, &err);
diff --git a/qemu-options.hx b/qemu-options.hx
index ea0638e92d..50b068423c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2073,7 +2073,7 @@ DEF("smbios", HAS_ARG, QEMU_OPTION_smbios,
     "              [,sku=str]\n"
     "                specify SMBIOS type 3 fields\n"
     "-smbios type=4[,sock_pfx=str][,manufacturer=str][,version=str][,serial=str]\n"
-    "              [,asset=str][,part=str]\n"
+    "              [,asset=str][,part=str][,max-speed=%d][,current-speed=%d]\n"
     "                specify SMBIOS type 4 fields\n"
     "-smbios type=17[,loc_pfx=str][,bank=str][,manufacturer=str][,serial=str]\n"
     "               [,asset=str][,part=str][,speed=%d]\n"
-- 
2.23.0


