Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0BEC388F2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 04:17:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E491220756
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 04:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E491220756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZnlK-0006zR-Vj
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 23:17:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaihaoyu1@huawei.com>)
 id 1kZnko-0006aF-1T
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 23:17:06 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:2070)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaihaoyu1@huawei.com>)
 id 1kZnkl-0001zg-Jm
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 23:17:05 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CQGh63hDszhYkV;
 Tue,  3 Nov 2020 12:16:54 +0800 (CST)
Received: from [10.108.235.54] (10.108.235.54) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Tue, 3 Nov 2020 12:16:46 +0800
Subject: [PATCH v2 0/3] softmmu: some space-style problems while coding
References: <edcc3e56-2419-8645-8639-d9e50d710a1d@huawei.com>
To: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>
From: chaihaoyu <chaihaoyu1@huawei.com>
X-Forwarded-Message-Id: <edcc3e56-2419-8645-8639-d9e50d710a1d@huawei.com>
Message-ID: <f97efd59-6d7b-3e85-b13a-20eff7a2d78a@huawei.com>
Date: Tue, 3 Nov 2020 12:16:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <edcc3e56-2419-8645-8639-d9e50d710a1d@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.108.235.54]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=chaihaoyu1@huawei.com;
 helo=szxga06-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 22:10:41
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: alex.chen@huawei.com, hunongda@huawei.com, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Hi, recently I found some code style problems while using checkpatch.pl tool,please review.

Date: Tue, 3 Nov 2020 11:19:37 +0800
Subject: [PATCH] space style
signed-off-by: Haoyu Chai<chaihaoyu1@huawei.com>
---
 softmmu/physmem.c      |  2 +-
 softmmu/qdev-monitor.c |  4 ++--
 softmmu/vl.c           | 12 ++++++------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 78c1b6580a..44b068ee85 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -3457,7 +3457,7 @@ int qemu_target_page_bits_min(void)

 bool cpu_physical_memory_is_io(hwaddr phys_addr)
 {
-    MemoryRegion*mr;
+    MemoryRegion *mr;
     hwaddr l = 1;
     bool res;

diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
index e283d9c9c0..c2b218adce 100644
--- a/softmmu/qdev-monitor.c
+++ b/softmmu/qdev-monitor.c
@@ -500,7 +500,7 @@ static BusState *qbus_find(const char *path, Error **errp)
         }

         /* find device */
-        if (sscanf(path+pos, "%127[^/]%n", elem, &len) != 1) {
+        if (sscanf(path + pos, "%127[^/]%n", elem, &len) != 1) {
             g_assert_not_reached();
             elem[0] = len = 0;
         }
@@ -535,7 +535,7 @@ static BusState *qbus_find(const char *path, Error **errp)
         }

         /* find bus */
-        if (sscanf(path+pos, "%127[^/]%n", elem, &len) != 1) {
+        if (sscanf(path + pos, "%127[^/]%n", elem, &len) != 1) {
             g_assert_not_reached();
             elem[0] = len = 0;
         }
diff --git a/softmmu/vl.c b/softmmu/vl.c
index c4667d91fe..d37520a356 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2418,7 +2418,7 @@ static const QEMUOption *lookup_opt(int argc, char **argv,
         r++;
     }
     popt = qemu_options;
-    for(;;) {
+    for (;;) {
         if (!popt->name) {
             error_report("invalid option");
             exit(1);
@@ -3008,7 +3008,7 @@ void qemu_init(int argc, char **argv, char **envp)

     /* second pass of option parsing */
     optind = 1;
-    for(;;) {
+    for (;;) {
         if (optind >= argc) {
             break;
         }
@@ -3023,7 +3023,7 @@ void qemu_init(int argc, char **argv, char **envp)
                 error_report("Option not supported for this target");
                 exit(1);
             }
-            switch(popt->index) {
+            switch (popt->index) {
             case QEMU_OPTION_cpu:
                 /* hw initialization will check this */
                 cpu_option = optarg;
@@ -3182,13 +3182,13 @@ void qemu_init(int argc, char **argv, char **envp)
 #endif
             case QEMU_OPTION_audio_help:
                 audio_legacy_help();
-                exit (0);
+                exit(0);
                 break;
             case QEMU_OPTION_audiodev:
                 audio_parse_option(optarg);
                 break;
             case QEMU_OPTION_soundhw:
-                select_soundhw (optarg);
+                select_soundhw(optarg);
                 break;
             case QEMU_OPTION_h:
                 help(0);
@@ -4323,7 +4323,7 @@ void qemu_init(int argc, char **argv, char **envp)
     if (watchdog) {
         i = select_watchdog(watchdog);
         if (i > 0)
-            exit (i == 1 ? 1 : 0);
+            exit(i == 1 ? 1 : 0);
     }

     /* This checkpoint is required by replay to separate prior clock
-- 

