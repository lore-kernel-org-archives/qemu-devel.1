Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5680DC3B189
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:51:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A28520848
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A28520848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2B9O-0007EJ-Aw
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 04:51:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengzhimin1@huawei.com>) id 1j2AxE-000732-2S
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengzhimin1@huawei.com>) id 1j2AxC-0005Em-0q
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:39 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2780 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fengzhimin1@huawei.com>)
 id 1j2AxB-00052d-LY
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:37 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id B5A68D545394A53FED95;
 Thu, 13 Feb 2020 17:38:25 +0800 (CST)
Received: from huawei.com (10.173.220.198) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 13 Feb 2020
 17:38:16 +0800
From: Zhimin Feng <fengzhimin1@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>, <armbru@redhat.com>,
 <eblake@redhat.com>
Subject: [PATCH RFC 14/14] migration/rdma: RDMA cleanup for multifd migration
Date: Thu, 13 Feb 2020 17:37:55 +0800
Message-ID: <20200213093755.370-15-fengzhimin1@huawei.com>
X-Mailer: git-send-email 2.24.0.windows.2
In-Reply-To: <20200213093755.370-1-fengzhimin1@huawei.com>
References: <20200213093755.370-1-fengzhimin1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.220.198]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: jemmy858585@gmail.com, Zhimin Feng <fengzhimin1@huawei.com>,
 qemu-devel@nongnu.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Zhimin Feng <fengzhimin1@huawei.com>
---
 migration/multifd.c | 6 ++++++
 migration/rdma.c    | 5 ++---
 migration/rdma.h    | 1 +
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index ba5e0b11d0..886c8e1271 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -429,6 +429,9 @@ void multifd_save_cleanup(void)
         g_free(p->packet);
         p->packet =3D NULL;
         if (migrate_use_rdma()) {
+            p->rdma->listen_id =3D NULL;
+            p->rdma->channel =3D NULL;
+            qemu_rdma_cleanup(p->rdma);
             g_free(p->rdma);
         }
     }
@@ -835,6 +838,9 @@ int multifd_load_cleanup(Error **errp)
         g_free(p->packet);
         p->packet =3D NULL;
         if (migrate_use_rdma()) {
+            p->rdma->listen_id =3D NULL;
+            p->rdma->channel =3D NULL;
+            qemu_rdma_cleanup(p->rdma);
             g_free(p->rdma);
         }
     }
diff --git a/migration/rdma.c b/migration/rdma.c
index b7b56c0493..0a48713d03 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2096,11 +2096,11 @@ static int qemu_rdma_write(QEMUFile *f, RDMAConte=
xt *rdma,
     return 0;
 }
=20
-static void qemu_rdma_cleanup(RDMAContext *rdma)
+void qemu_rdma_cleanup(RDMAContext *rdma)
 {
     int idx;
=20
-    if (rdma->cm_id && rdma->connected) {
+    if (rdma->channel && rdma->cm_id && rdma->connected) {
         if ((rdma->error_state ||
              migrate_get_current()->state =3D=3D MIGRATION_STATUS_CANCEL=
LING) &&
             !rdma->received_error) {
@@ -2181,7 +2181,6 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
     rdma->host =3D NULL;
 }
=20
-
 static int qemu_rdma_source_init(RDMAContext *rdma, bool pin_all, Error =
**errp)
 {
     int ret, idx;
diff --git a/migration/rdma.h b/migration/rdma.h
index 7dc3895698..b78f79ddc2 100644
--- a/migration/rdma.h
+++ b/migration/rdma.h
@@ -283,6 +283,7 @@ int qemu_rdma_exchange_send(RDMAContext *rdma, RDMACo=
ntrolHeader *head,
 int qemu_rdma_registration(void *opaque);
 int qemu_rdma_block_for_wrid(RDMAContext *rdma, int wrid_requested,
                              uint32_t *byte_len);
+void qemu_rdma_cleanup(RDMAContext *rdma);
=20
 void rdma_start_outgoing_migration(void *opaque, const char *host_port,
                                    Error **errp);
--=20
2.19.1



