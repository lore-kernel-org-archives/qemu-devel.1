Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35178C433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 13:38:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4B1E207F7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 13:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B1E207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRbYV-0003pH-Ub
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 09:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yubihong@huawei.com>)
 id 1kRYPP-0005QF-Q2; Sun, 11 Oct 2020 06:16:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5217 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yubihong@huawei.com>)
 id 1kRYPM-0002Dx-8L; Sun, 11 Oct 2020 06:16:55 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 2CE4264D8877ED3F1F8A;
 Sun, 11 Oct 2020 18:16:45 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Sun, 11 Oct 2020
 18:16:37 +0800
From: Bihong Yu <yubihong@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-trivial@nongnu.org>
Subject: [PATCH v1 3/8] migration: Add spaces around operator
Date: Sun, 11 Oct 2020 18:48:36 +0800
Message-ID: <1602413321-22252-4-git-send-email-yubihong@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1602413321-22252-1-git-send-email-yubihong@huawei.com>
References: <1602413321-22252-1-git-send-email-yubihong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191; envelope-from=yubihong@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 06:16:45
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 11 Oct 2020 09:36:17 -0400
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
Cc: alex.chen@huawei.com, zhengchuan@huawei.com, wanghao232@huawei.com,
 dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by:Bihong Yu <yubihong@huawei.com>
Reviewed-by: Chuan Zheng <zhengchuan@huawei.com>
Signed-off-by: Bihong Yu <yubihong@huawei.com>
---
 migration/migration.c    |  4 ++--
 migration/postcopy-ram.c |  2 +-
 migration/ram.c          |  2 +-
 migration/savevm.c       |  2 +-
 migration/vmstate.c      | 10 +++++-----
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 0575ecb..e050f57 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2478,8 +2478,8 @@ static void migrate_handle_rp_req_pages(MigrationState *ms, const char* rbname,
      * Since we currently insist on matching page sizes, just sanity check
      * we're being asked for whole host pages.
      */
-    if (start & (our_host_ps-1) ||
-       (len & (our_host_ps-1))) {
+    if (start & (our_host_ps - 1) ||
+       (len & (our_host_ps - 1))) {
         error_report("%s: Misaligned page request, start: " RAM_ADDR_FMT
                      " len: %zd", __func__, start, len);
         mark_source_rp_bad(ms);
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 0a2f88a8..eea92bb 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -403,7 +403,7 @@ bool postcopy_ram_supported_by_host(MigrationIncomingState *mis)
                      strerror(errno));
         goto out;
     }
-    g_assert(((size_t)testarea & (pagesize-1)) == 0);
+    g_assert(((size_t)testarea & (pagesize - 1)) == 0);
 
     reg_struct.range.start = (uintptr_t)testarea;
     reg_struct.range.len = pagesize;
diff --git a/migration/ram.c b/migration/ram.c
index 59bdd15..90b277b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1563,7 +1563,7 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len)
         rs->last_req_rb = ramblock;
     }
     trace_ram_save_queue_pages(ramblock->idstr, start, len);
-    if (start+len > ramblock->used_length) {
+    if (start + len > ramblock->used_length) {
         error_report("%s request overrun start=" RAM_ADDR_FMT " len="
                      RAM_ADDR_FMT " blocklen=" RAM_ADDR_FMT,
                      __func__, start, len, ramblock->used_length);
diff --git a/migration/savevm.c b/migration/savevm.c
index d2e141f..9e95df1 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -521,7 +521,7 @@ static const VMStateDescription vmstate_configuration = {
         VMSTATE_VBUFFER_ALLOC_UINT32(name, SaveState, 0, NULL, len),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * []) {
         &vmstate_target_page_bits,
         &vmstate_capabilites,
         &vmstate_uuid,
diff --git a/migration/vmstate.c b/migration/vmstate.c
index bafa890..e9d2aef 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -32,13 +32,13 @@ static int vmstate_n_elems(void *opaque, const VMStateField *field)
     if (field->flags & VMS_ARRAY) {
         n_elems = field->num;
     } else if (field->flags & VMS_VARRAY_INT32) {
-        n_elems = *(int32_t *)(opaque+field->num_offset);
+        n_elems = *(int32_t *)(opaque + field->num_offset);
     } else if (field->flags & VMS_VARRAY_UINT32) {
-        n_elems = *(uint32_t *)(opaque+field->num_offset);
+        n_elems = *(uint32_t *)(opaque + field->num_offset);
     } else if (field->flags & VMS_VARRAY_UINT16) {
-        n_elems = *(uint16_t *)(opaque+field->num_offset);
+        n_elems = *(uint16_t *)(opaque + field->num_offset);
     } else if (field->flags & VMS_VARRAY_UINT8) {
-        n_elems = *(uint8_t *)(opaque+field->num_offset);
+        n_elems = *(uint8_t *)(opaque + field->num_offset);
     }
 
     if (field->flags & VMS_MULTIPLY_ELEMENTS) {
@@ -54,7 +54,7 @@ static int vmstate_size(void *opaque, const VMStateField *field)
     int size = field->size;
 
     if (field->flags & VMS_VBUFFER) {
-        size = *(int32_t *)(opaque+field->size_offset);
+        size = *(int32_t *)(opaque + field->size_offset);
         if (field->flags & VMS_MULTIPLY) {
             size *= field->size;
         }
-- 
1.8.3.1


