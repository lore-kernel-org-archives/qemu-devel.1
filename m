Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB83C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CA8620776
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CA8620776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRx6F-0004ni-E3
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 08:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yubihong@huawei.com>)
 id 1kRx4r-00039w-G8; Mon, 12 Oct 2020 08:37:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5226 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yubihong@huawei.com>)
 id 1kRx4n-0007ZC-1x; Mon, 12 Oct 2020 08:37:20 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id F0B39CC97BC2EED742DD;
 Mon, 12 Oct 2020 20:37:03 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Mon, 12 Oct 2020
 20:36:55 +0800
From: Bihong Yu <yubihong@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-trivial@nongnu.org>
Subject: [PATCH v2 2/8] migration: Don't use '#' flag of printf format
Date: Mon, 12 Oct 2020 21:08:54 +0800
Message-ID: <1602508140-11372-3-git-send-email-yubihong@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1602508140-11372-1-git-send-email-yubihong@huawei.com>
References: <1602508140-11372-1-git-send-email-yubihong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191; envelope-from=yubihong@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 07:12:20
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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
Cc: yubihong@huawei.com, zhengchuan@huawei.com, quintela@redhat.com,
 dgilbert@redhat.com, alex.chen@huawei.com, wanghao232@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Bihong Yu <yubihong@huawei.com>
Reviewed-by: Chuan Zheng <zhengchuan@huawei.com>
---
 migration/block.c | 2 +-
 migration/ram.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/block.c b/migration/block.c
index 4b8576b..273392b 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -998,7 +998,7 @@ static int block_load(QEMUFile *f, void *opaque, int version_id)
                    (addr == 100) ? '\n' : '\r');
             fflush(stdout);
         } else if (!(flags & BLK_MIG_FLAG_EOS)) {
-            fprintf(stderr, "Unknown block migration flags: %#x\n", flags);
+            fprintf(stderr, "Unknown block migration flags: 0x%x\n", flags);
             return -EINVAL;
         }
         ret = qemu_file_get_error(f);
diff --git a/migration/ram.c b/migration/ram.c
index 433489d..6ed4f9e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3298,7 +3298,7 @@ static int ram_load_postcopy(QEMUFile *f)
             multifd_recv_sync_main();
             break;
         default:
-            error_report("Unknown combination of migration flags: %#x"
+            error_report("Unknown combination of migration flags: 0x%x"
                          " (postcopy mode)", flags);
             ret = -EINVAL;
             break;
@@ -3576,7 +3576,7 @@ static int ram_load_precopy(QEMUFile *f)
             if (flags & RAM_SAVE_FLAG_HOOK) {
                 ram_control_load_hook(f, RAM_CONTROL_HOOK, NULL);
             } else {
-                error_report("Unknown combination of migration flags: %#x",
+                error_report("Unknown combination of migration flags: 0x%x",
                              flags);
                 ret = -EINVAL;
             }
-- 
1.8.3.1


