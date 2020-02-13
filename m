Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E077AC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:39:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9752217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9752217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Ay6-0008RB-NO
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 04:39:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45967)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengzhimin1@huawei.com>) id 1j2Ax1-0006i1-QX
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengzhimin1@huawei.com>) id 1j2Ax0-00053V-JR
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:27 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2775 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fengzhimin1@huawei.com>)
 id 1j2Ax0-000518-8t
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:26 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id BF46E89C10EBFCAF3469;
 Thu, 13 Feb 2020 17:38:20 +0800 (CST)
Received: from huawei.com (10.173.220.198) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 13 Feb 2020
 17:38:12 +0800
From: Zhimin Feng <fengzhimin1@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>, <armbru@redhat.com>,
 <eblake@redhat.com>
Subject: [PATCH RFC 07/14] migration/rdma: Export the
 'qemu_rdma_registration_handle' and 'qemu_rdma_exchange_send' functions
Date: Thu, 13 Feb 2020 17:37:48 +0800
Message-ID: <20200213093755.370-8-fengzhimin1@huawei.com>
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
 migration/rdma.c | 25 +++++--------------------
 migration/rdma.h | 16 ++++++++++++++++
 2 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 2f1e69197f..23f7f525f4 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -170,17 +170,6 @@ static void network_to_dest_block(RDMADestBlock *db)
     db->remote_rkey =3D ntohl(db->remote_rkey);
 }
=20
-/*
- * Main structure for IB Send/Recv control messages.
- * This gets prepended at the beginning of every Send/Recv.
- */
-typedef struct QEMU_PACKED {
-    uint32_t len;     /* Total length of data portion */
-    uint32_t type;    /* which control command to perform */
-    uint32_t repeat;  /* number of commands in data portion of same type=
 */
-    uint32_t padding;
-} RDMAControlHeader;
-
 static void control_to_network(RDMAControlHeader *control)
 {
     control->type =3D htonl(control->type);
@@ -289,10 +278,6 @@ static void network_to_result(RDMARegisterResult *re=
sult)
 };
=20
 const char *print_wrid(int wrid);
-static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader =
*head,
-                                   uint8_t *data, RDMAControlHeader *res=
p,
-                                   int *resp_idx,
-                                   int (*callback)(RDMAContext *rdma));
=20
 static inline uint64_t ram_chunk_index(const uint8_t *start,
                                        const uint8_t *host)
@@ -1590,10 +1575,10 @@ static void qemu_rdma_move_header(RDMAContext *rd=
ma, int idx,
  * to perform an *additional* exchange of message just to provide a resp=
onse by
  * instead piggy-backing on the acknowledgement.
  */
-static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader =
*head,
-                                   uint8_t *data, RDMAControlHeader *res=
p,
-                                   int *resp_idx,
-                                   int (*callback)(RDMAContext *rdma))
+int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
+                            uint8_t *data, RDMAControlHeader *resp,
+                            int *resp_idx,
+                            int (*callback)(RDMAContext *rdma))
 {
     int ret =3D 0;
=20
@@ -3210,7 +3195,7 @@ static int dest_ram_sort_func(const void *a, const =
void *b)
  *
  * Keep doing this until the source tells us to stop.
  */
-static int qemu_rdma_registration_handle(QEMUFile *f, void *opaque)
+int qemu_rdma_registration_handle(QEMUFile *f, void *opaque)
 {
     RDMAControlHeader reg_resp =3D { .len =3D sizeof(RDMARegisterResult)=
,
                                .type =3D RDMA_CONTROL_REGISTER_RESULT,
diff --git a/migration/rdma.h b/migration/rdma.h
index ace6e5be90..8e1a6edf57 100644
--- a/migration/rdma.h
+++ b/migration/rdma.h
@@ -144,6 +144,17 @@ typedef struct QEMU_PACKED RDMADestBlock {
     uint32_t padding;
 } RDMADestBlock;
=20
+/*
+ * Main structure for IB Send/Recv control messages.
+ * This gets prepended at the beginning of every Send/Recv.
+ */
+typedef struct QEMU_PACKED {
+    uint32_t len;     /* Total length of data portion */
+    uint32_t type;    /* which control command to perform */
+    uint32_t repeat;  /* number of commands in data portion of same type=
 */
+    uint32_t padding;
+} RDMAControlHeader;
+
 /*
  * Virtual address of the above structures used for transmitting
  * the RAMBlock descriptions at connection-time.
@@ -264,6 +275,11 @@ struct QIOChannelRDMA {
 };
=20
 int multifd_channel_rdma_connect(void *opaque);
+int qemu_rdma_registration_handle(QEMUFile *f, void *opaque);
+int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
+                            uint8_t *data, RDMAControlHeader *resp,
+                            int *resp_idx,
+                            int (*callback)(RDMAContext *rdma));
=20
 void rdma_start_outgoing_migration(void *opaque, const char *host_port,
                                    Error **errp);
--=20
2.19.1



