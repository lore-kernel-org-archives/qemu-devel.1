Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B65C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 10:29:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A876E21548
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 10:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A876E21548
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kH2n2-0003cb-Qf
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 06:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kH2jM-0005KR-5D
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 06:26:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4741 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kH2jG-000884-Hd
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 06:26:03 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 93FA71400BF92FAB66BD;
 Sat, 12 Sep 2020 18:25:51 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Sat, 12 Sep 2020
 18:25:43 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <eblake@redhat.com>, <dgilbert@redhat.com>,
 <berrange@redhat.com>
Subject: [PATCH v2 6/6] migration/tls: add trace points for multifd-tls
Date: Sat, 12 Sep 2020 18:36:19 +0800
Message-ID: <1599906979-17240-7-git-send-email-zhengchuan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1599906979-17240-1-git-send-email-zhengchuan@huawei.com>
References: <1599906979-17240-1-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=zhengchuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/12 06:25:47
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

add trace points for multifd-tls for debug.

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
Signed-off-by: Yan Jin <jinyan12@huawei.com>
---
 migration/multifd.c    | 10 +++++++++-
 migration/trace-events |  5 +++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 8aea4e0..0760502 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -732,7 +732,11 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
     QIOChannel *ioc = QIO_CHANNEL(qio_task_get_source(task));
     Error *err = NULL;
 
-    qio_task_propagate_error(task, &err);
+    if (qio_task_propagate_error(task, &err)) {
+        trace_multifd_tls_outgoing_handshake_error(ioc, error_get_pretty(err));
+    } else {
+        trace_multifd_tls_outgoing_handshake_complete(ioc);
+    }
     multifd_channel_connect(p, ioc, err);
 }
 
@@ -749,6 +753,7 @@ static void multifd_tls_channel_connect(MultiFDSendParams *p,
         return;
     }
 
+    trace_multifd_tls_outgoing_handshake_start(ioc, tioc, hostname);
     qio_channel_set_name(QIO_CHANNEL(tioc), "multifd-tls-outgoing");
     qio_channel_tls_handshake(tioc,
                               multifd_tls_outgoing_handshake,
@@ -764,6 +769,9 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
 {
     MigrationState *s = p->s;
 
+    trace_multifd_set_outgoing_channel(
+        ioc, object_get_typename(OBJECT(ioc)), s->hostname, error);
+
     if (!error) {
         if (s->parameters.tls_creds &&
             *s->parameters.tls_creds &&
diff --git a/migration/trace-events b/migration/trace-events
index 4ab0a50..78db982 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -109,6 +109,11 @@ multifd_send_sync_main_wait(uint8_t id) "channel %d"
 multifd_send_terminate_threads(bool error) "error %d"
 multifd_send_thread_end(uint8_t id, uint64_t packets, uint64_t pages) "channel %d packets %" PRIu64 " pages %"  PRIu64
 multifd_send_thread_start(uint8_t id) "%d"
+multifd_tls_outgoing_handshake_start(void *ioc, void *tioc, const char *hostname) "ioc=%p tioc=%p hostname=%s"
+multifd_tls_outgoing_handshake_error(void *ioc, const char *err) "ioc=%p err=%s"
+multifd_tls_outgoing_handshake_complete(void *ioc, void) "ioc=%p"
+multifd_set_outgoing_channel(void *ioc, const char *ioctype, const char *hostname, void *err)  "ioc=%p ioctype=%s hostname=%s err=%p"
+
 ram_discard_range(const char *rbname, uint64_t start, size_t len) "%s: start: %" PRIx64 " %zx"
 ram_load_loop(const char *rbname, uint64_t addr, int flags, void *host) "%s: addr: 0x%" PRIx64 " flags: 0x%x host: %p"
 ram_load_postcopy_loop(uint64_t addr, int flags) "@%" PRIx64 " %x"
-- 
1.8.3.1


