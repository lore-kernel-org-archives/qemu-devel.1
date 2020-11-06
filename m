Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92592C55178
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 10:40:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDD3220702
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 10:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD3220702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kazAl-0007PJ-5z
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 05:40:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kaz9Z-0006od-VD
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 05:39:33 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2443)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kaz9X-0004ra-AD
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 05:39:33 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CSH1w3qgHzLtZx;
 Fri,  6 Nov 2020 18:39:16 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Fri, 6 Nov 2020
 18:39:14 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>, <berrange@redhat.com>
Subject: [PATCH v2] migration/multifd: close TLS channel before socket finalize
Date: Fri, 6 Nov 2020 18:54:54 +0800
Message-ID: <1604660094-123959-1-git-send-email-zhengchuan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=zhengchuan@huawei.com; helo=szxga05-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 05:03:20
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: yubihong@huawei.com, zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, alex.chen@huawei.com, wanghao232@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since we now support tls multifd, when we cancel migration, the TLS
sockets will be left as CLOSE-WAIT On Src which results in socket
leak.
Fix it by closing TLS channel before socket finalize.

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
---
 migration/multifd.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/migration/multifd.c b/migration/multifd.c
index 68b171f..a6838dc 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -523,6 +523,19 @@ static void multifd_send_terminate_threads(Error *err)
     }
 }
 
+static void multifd_tls_socket_close(QIOChannel *ioc, Error *err)
+{
+    if (ioc &&
+        object_dynamic_cast(OBJECT(ioc),
+                            TYPE_QIO_CHANNEL_TLS)) {
+        /*
+         * TLS channel is special, we need close it before
+         * socket finalize.
+         */
+        qio_channel_close(ioc, &err);
+    }
+}
+
 void multifd_save_cleanup(void)
 {
     int i;
@@ -542,6 +555,7 @@ void multifd_save_cleanup(void)
         MultiFDSendParams *p = &multifd_send_state->params[i];
         Error *local_err = NULL;
 
+        multifd_tls_socket_close(p->c, NULL);
         socket_send_channel_destroy(p->c);
         p->c = NULL;
         qemu_mutex_destroy(&p->mutex);
-- 
1.8.3.1


