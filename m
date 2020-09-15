Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E933EC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 02:55:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9802720897
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 02:55:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9802720897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI17c-0002Zc-M8
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 22:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kI15k-0007r6-PQ
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 22:53:12 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4697 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kI15g-0003WR-L5
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 22:53:12 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 45F4FE96C1B94AFEE44C;
 Tue, 15 Sep 2020 10:53:04 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Tue, 15 Sep 2020
 10:52:58 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <eblake@redhat.com>, <dgilbert@redhat.com>,
 <berrange@redhat.com>
Subject: [PATCH v4 3/6] migration/tls: add tls_hostname into MultiFDSendParams
Date: Tue, 15 Sep 2020 11:03:59 +0800
Message-ID: <1600139042-104593-4-git-send-email-zhengchuan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1600139042-104593-1-git-send-email-zhengchuan@huawei.com>
References: <1600139042-104593-1-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=zhengchuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 22:53:05
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
Cc: zhengchuan@huawei.com, zhang.zhanghailiang@huawei.com, yuxiating@huawei.com,
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, alex.chen@huawei.com,
 jinyan12@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since multifd creation is async with migration_channel_connect, we should
pass the hostname from MigrationState to MultiFDSendParams.

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
Signed-off-by: Yan Jin <jinyan12@huawei.com>
---
 migration/multifd.c | 5 +++++
 migration/multifd.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/migration/multifd.c b/migration/multifd.c
index d044120..f8cd5fe 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -548,6 +548,8 @@ void multifd_save_cleanup(void)
         qemu_sem_destroy(&p->sem_sync);
         g_free(p->name);
         p->name = NULL;
+        g_free(p->tls_hostname);
+        p->tls_hostname = NULL;
         multifd_pages_clear(p->pages);
         p->pages = NULL;
         p->packet_len = 0;
@@ -751,10 +753,12 @@ int multifd_save_setup(Error **errp)
     int thread_count;
     uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
     uint8_t i;
+    MigrationState *s;
 
     if (!migrate_use_multifd()) {
         return 0;
     }
+    s = migrate_get_current();
     thread_count = migrate_multifd_channels();
     multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
     multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
@@ -779,6 +783,7 @@ int multifd_save_setup(Error **errp)
         p->packet->magic = cpu_to_be32(MULTIFD_MAGIC);
         p->packet->version = cpu_to_be32(MULTIFD_VERSION);
         p->name = g_strdup_printf("multifdsend_%d", i);
+        p->tls_hostname = g_strdup(s->hostname);
         socket_send_channel_create(multifd_new_send_channel_async, p);
     }
 
diff --git a/migration/multifd.h b/migration/multifd.h
index 448a03d..8d6751f 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -71,6 +71,8 @@ typedef struct {
     uint8_t id;
     /* channel thread name */
     char *name;
+    /* tls hostname */
+    char *tls_hostname;
     /* channel thread id */
     QemuThread thread;
     /* communication channel */
-- 
1.8.3.1


