Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2774C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77507221E2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77507221E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3cMx-0001KA-E3
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 05:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liangpeng10@huawei.com>)
 id 1k3cKe-0005BM-1M; Thu, 06 Aug 2020 05:37:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41184 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liangpeng10@huawei.com>)
 id 1k3cKb-0007Wa-W2; Thu, 06 Aug 2020 05:37:03 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 575B5283BBFFE51F18CF;
 Thu,  6 Aug 2020 17:36:56 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Thu, 6 Aug 2020 17:36:50 +0800
From: Peng Liang <liangpeng10@huawei.com>
To: <qemu-trivial@nongnu.org>
Subject: [PATCH 5/5] log: Add logs during qemu start
Date: Thu, 6 Aug 2020 17:37:20 +0800
Message-ID: <20200806093720.2355692-6-liangpeng10@huawei.com>
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

Add logs during qemu start.

Signed-off-by: Peng Liang <liangpeng10@huawei.com>
---
 blockdev.c         | 2 ++
 softmmu/vl.c       | 2 ++
 util/oslib-posix.c | 3 +--
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 3848a9c8ab..8e3ab8a9b2 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1001,6 +1001,8 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type,
         qdict_put_str(bs_opts, "rerror", rerror);
     }
 
+    info_report("blockdev init(%s).", filename ? filename : "");
+
     /* Actual block device init: Functionality shared with blockdev-add */
     blk = blockdev_init(filename, bs_opts, errp);
     bs_opts = NULL;
diff --git a/softmmu/vl.c b/softmmu/vl.c
index a9f06111b3..493518de66 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -1070,6 +1070,8 @@ static void configure_blockdev(BlockdevOptionsQueue *bdo_queue,
         exit(0);
     }
 
+    info_report("Finish drive init.");
+
     default_drive(default_cdrom, snapshot, machine_class->block_default_type, 2,
                   CDROM_OPTS);
     default_drive(default_floppy, snapshot, IF_FLOPPY, 0, FD_OPTS);
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index ad8001a4ad..87c1c8569e 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -66,9 +66,7 @@
 
 #include "qemu/mmap-alloc.h"
 
-#ifdef CONFIG_DEBUG_STACK_USAGE
 #include "qemu/error-report.h"
-#endif
 
 #define MAX_MEM_PREALLOC_THREAD_COUNT 16
 
@@ -558,6 +556,7 @@ static bool touch_all_pages(char *area, size_t hpagesize, size_t numpages,
     g_free(memset_thread);
     memset_thread = NULL;
 
+    info_report("Finish touching all pages.");
     return memset_thread_failed;
 }
 
-- 
2.18.4


