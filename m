Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A187AC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 04:25:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C77F220791
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 04:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C77F220791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTdmk-0000hq-M9
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 00:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kTdXi-0005xv-SW
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 00:10:06 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36940 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kTdXg-0007I4-NY
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 00:10:06 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 87C02B2F8DAD10F3D499;
 Sat, 17 Oct 2020 12:10:01 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Sat, 17 Oct 2020
 12:09:51 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>
Subject: [PATCH v3 18/18] migration/rdma: RDMA cleanup for multifd migration
Date: Sat, 17 Oct 2020 12:25:48 +0800
Message-ID: <1602908748-43335-19-git-send-email-zhengchuan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1602908748-43335-1-git-send-email-zhengchuan@huawei.com>
References: <1602908748-43335-1-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=zhengchuan@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/17 00:10:01
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
Cc: yubihong@huawei.com, zhang.zhanghailiang@huawei.com, fengzhimin1@huawei.com,
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, alex.chen@huawei.com,
 wanghao232@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
---
 migration/multifd.c |  6 ++++++
 migration/multifd.h |  1 +
 migration/rdma.c    | 16 +++++++++++++++-
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index c4d90ef..f548122 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -574,6 +574,9 @@ void multifd_save_cleanup(void)
         p->packet_len = 0;
         g_free(p->packet);
         p->packet = NULL;
+#ifdef CONFIG_RDMA
+        multifd_rdma_cleanup(p->rdma);
+#endif
         multifd_send_state->ops->send_cleanup(p, &local_err);
         if (local_err) {
             migrate_set_error(migrate_get_current(), local_err);
@@ -1017,6 +1020,9 @@ int multifd_load_cleanup(Error **errp)
         p->packet_len = 0;
         g_free(p->packet);
         p->packet = NULL;
+#ifdef CONFIG_RDMA
+        multifd_rdma_cleanup(p->rdma);
+#endif
         multifd_recv_state->ops->recv_cleanup(p);
     }
     qemu_sem_destroy(&multifd_recv_state->sem_sync);
diff --git a/migration/multifd.h b/migration/multifd.h
index ec9e897..6fddd4e 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -183,6 +183,7 @@ typedef struct {
 
 #ifdef CONFIG_RDMA
 MultiFDSetup *multifd_rdma_setup(void);
+void multifd_rdma_cleanup(void *opaque);
 #endif
 void multifd_send_terminate_threads(Error *err);
 int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp);
diff --git a/migration/rdma.c b/migration/rdma.c
index 519fa7a..89bf54b 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2368,7 +2368,7 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
 {
     int idx;
 
-    if (rdma->cm_id && rdma->connected) {
+    if (rdma->channel && rdma->cm_id && rdma->connected) {
         if ((rdma->error_state ||
              migrate_get_current()->state == MIGRATION_STATUS_CANCELLING) &&
             !rdma->received_error) {
@@ -4609,6 +4609,20 @@ static MultiFDSetup multifd_rdma_ops = {
     .recv_channel_setup = multifd_rdma_recv_channel_setup
 };
 
+void multifd_rdma_cleanup(void *opaque)
+{
+    RDMAContext *rdma = (RDMAContext *)opaque;
+
+    if (!migrate_use_rdma()) {
+        return;
+    }
+
+    rdma->listen_id = NULL;
+    rdma->channel = NULL;
+    qemu_rdma_cleanup(rdma);
+    g_free(rdma);
+}
+
 MultiFDSetup *multifd_rdma_setup(void)
 {
     MultiFDSetup *rdma_ops;
-- 
1.8.3.1


