Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34AAC32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 10:01:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8CFE20673
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 10:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8CFE20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipUdW-0007jc-4Q
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 05:01:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengzhimin1@huawei.com>) id 1ipPvD-00010K-Il
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:59:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengzhimin1@huawei.com>) id 1ipPvB-0001Mm-V5
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:59:51 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:34926 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fengzhimin1@huawei.com>)
 id 1ipPvB-0001Gs-B6
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:59:49 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id D4B8ADE520CCB6F82A54;
 Thu,  9 Jan 2020 12:59:45 +0800 (CST)
Received: from huawei.com (10.173.220.198) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 9 Jan 2020
 12:59:36 +0800
From: Zhimin Feng <fengzhimin1@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>, <armbru@redhat.com>,
 <eblake@redhat.com>
Subject: [PATCH RFC 09/12] migration/rdma: Wait for all multiRDMA to complete
 registration
Date: Thu, 9 Jan 2020 12:59:19 +0800
Message-ID: <20200109045922.904-10-fengzhimin1@huawei.com>
X-Mailer: git-send-email 2.24.0.windows.2
In-Reply-To: <20200109045922.904-1-fengzhimin1@huawei.com>
References: <20200109045922.904-1-fengzhimin1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.220.198]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
X-Mailman-Approved-At: Thu, 09 Jan 2020 04:56:54 -0500
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
Cc: jemmy858585@gmail.com, fengzhimin <fengzhimin1@huawei.com>,
 qemu-devel@nongnu.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: fengzhimin <fengzhimin1@huawei.com>

Signed-off-by: fengzhimin <fengzhimin1@huawei.com>
---
 migration/rdma.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/migration/rdma.c b/migration/rdma.c
index 6ecc870844..425dfa709d 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -439,6 +439,10 @@ struct {
     MultiRDMASendParams *params;
     /* number of created threads */
     int count;
+    /* this mutex protects the following parameters */
+    QemuMutex mutex_sync;
+    /* number of registered multiRDMA channels */
+    unsigned int reg_mr_channels;
     /* syncs main thread and channels */
     QemuSemaphore sem_sync;
 } *multiRDMA_send_state;
@@ -3998,6 +4002,11 @@ static int qemu_rdma_registration_stop(QEMUFile *f=
, void *opaque,
                     rdma->dest_blocks[i].remote_host_addr;
             local->block[i].remote_rkey =3D rdma->dest_blocks[i].remote_=
rkey;
         }
+
+        /* Wait for all multiRDMA channels to complete registration */
+        if (migrate_use_multiRDMA()) {
+            qemu_sem_wait(&multiRDMA_send_state->sem_sync);
+        }
     }
=20
     trace_qemu_rdma_registration_stop(flags);
@@ -4562,6 +4571,17 @@ static void *multiRDMA_send_thread(void *opaque)
         }
     }
=20
+    /*
+     * Inform the main RDMA thread to run when multiRDMA
+     * threads have completed registration.
+     */
+    qemu_mutex_lock(&multiRDMA_send_state->mutex_sync);
+    if (++multiRDMA_send_state->reg_mr_channels =3D=3D
+        migrate_multiRDMA_channels()) {
+        qemu_sem_post(&multiRDMA_send_state->sem_sync);
+    }
+    qemu_mutex_unlock(&multiRDMA_send_state->mutex_sync);
+
     while (true) {
         qemu_sem_wait(&p->sem);
=20
@@ -4616,6 +4636,8 @@ static int multiRDMA_save_setup(const char *host_po=
rt, Error **errp)
     multiRDMA_send_state->params =3D g_new0(MultiRDMASendParams,
                                           thread_count);
     atomic_set(&multiRDMA_send_state->count, 0);
+    atomic_set(&multiRDMA_send_state->reg_mr_channels, 0);
+    qemu_mutex_init(&multiRDMA_send_state->mutex_sync);
     qemu_sem_init(&multiRDMA_send_state->sem_sync, 0);
=20
     for (i =3D 0; i < thread_count; i++) {
@@ -4714,6 +4736,7 @@ int multiRDMA_save_cleanup(void)
         g_free(multiRDMA_send_state->params[i].rdma);
     }
=20
+    qemu_mutex_destroy(&multiRDMA_send_state->mutex_sync);
     qemu_sem_destroy(&multiRDMA_send_state->sem_sync);
     g_free(multiRDMA_send_state);
     multiRDMA_send_state =3D NULL;
--=20
2.19.1



