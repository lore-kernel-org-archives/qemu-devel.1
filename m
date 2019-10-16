Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B29FFA372A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 17:28:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D65A92064B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 17:28:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D65A92064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKn5w-0004wO-12
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 13:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36020)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cheloha@linux.vnet.ibm.com>) id 1iKmNC-00041R-CR
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:42:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cheloha@linux.vnet.ibm.com>) id 1iKmN9-00067s-8r
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:42:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13836)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cheloha@linux.vnet.ibm.com>)
 id 1iKmN8-00066L-VR
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:42:03 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9GGbF6v055415
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 12:41:59 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vp67rhr37-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 12:41:59 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x9GGfw8o095682
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 12:41:59 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vp67rhr2q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Oct 2019 12:41:58 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9GGeeJF023910;
 Wed, 16 Oct 2019 16:41:58 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma03dal.us.ibm.com with ESMTP id 2vk6f97jjd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Oct 2019 16:41:58 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x9GGfvpw40632780
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Oct 2019 16:41:57 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 406DE124053;
 Wed, 16 Oct 2019 16:41:57 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D7884124052;
 Wed, 16 Oct 2019 16:41:56 +0000 (GMT)
Received: from rascal.austin.ibm.com (unknown [9.41.179.32])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 16 Oct 2019 16:41:56 +0000 (GMT)
From: Scott Cheloha <cheloha@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] migration: savevm_state_insert_handler: constant-time element
 insertion
Date: Wed, 16 Oct 2019 11:41:56 -0500
Message-Id: <20191016164156.4506-1-cheloha@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-16_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910160140
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
X-Mailman-Approved-At: Wed, 16 Oct 2019 13:27:17 -0400
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
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Registering a SaveStateEntry object via savevm_state_insert_handler()
is an O(n) operation because the list is a priority queue maintained by
walking the list from head to tail to find a suitable insertion point.

This adds considerable overhead for VMs with many such objects.  For
instance, ppc64 machines with large maxmem (8T+) spend ~10% or more of
their CPU time in savevm_state_insert_handler() before attempting to
boot a kernel.

If we track the head for each priority's subqueue we can insert new
elements in constant time.

This commit also introduces a new function, savevm_state_remove_handler(),
which abstracts the logic for replacing the head of an element's subqueue
when removing it.

Signed-off-by: Scott Cheloha <cheloha@linux.vnet.ibm.com>
---
 migration/savevm.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 8d95e261f6..f7a2d36bba 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -250,6 +250,7 @@ typedef struct SaveStateEntry {
 
 typedef struct SaveState {
     QTAILQ_HEAD(, SaveStateEntry) handlers;
+    SaveStateEntry *handler_pri_head[MIG_PRI_MAX + 1];
     int global_section_id;
     uint32_t len;
     const char *name;
@@ -261,6 +262,7 @@ typedef struct SaveState {
 
 static SaveState savevm_state = {
     .handlers = QTAILQ_HEAD_INITIALIZER(savevm_state.handlers),
+    .handler_pri_head = { [MIG_PRI_DEFAULT ... MIG_PRI_MAX] = NULL },
     .global_section_id = 0,
 };
 
@@ -709,20 +711,43 @@ static void savevm_state_handler_insert(SaveStateEntry *nse)
 {
     MigrationPriority priority = save_state_priority(nse);
     SaveStateEntry *se;
+    int i;
 
     assert(priority <= MIG_PRI_MAX);
 
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
-        if (save_state_priority(se) < priority) {
+    for (i = priority - 1; i >= 0; i--) {
+        se = savevm_state.handler_pri_head[i];
+        if (se != NULL) {
+            assert(save_state_priority(se) < priority);
             break;
         }
     }
 
-    if (se) {
+    if (i >= 0) {
         QTAILQ_INSERT_BEFORE(se, nse, entry);
     } else {
         QTAILQ_INSERT_TAIL(&savevm_state.handlers, nse, entry);
     }
+
+    if (savevm_state.handler_pri_head[priority] == NULL) {
+        savevm_state.handler_pri_head[priority] = nse;
+    }
+}
+
+static void savevm_state_handler_remove(SaveStateEntry *se)
+{
+    SaveStateEntry *next;
+    MigrationPriority priority = save_state_priority(se);
+
+    if (se == savevm_state.handler_pri_head[priority]) {
+        next = QTAILQ_NEXT(se, entry);
+        if (next != NULL && save_state_priority(next) == priority) {
+            savevm_state.handler_pri_head[priority] = next;
+        } else {
+            savevm_state.handler_pri_head[priority] = NULL;
+        }
+    }
+    QTAILQ_REMOVE(&savevm_state.handlers, se, entry);
 }
 
 /* TODO: Individual devices generally have very little idea about the rest
@@ -777,7 +802,7 @@ void unregister_savevm(DeviceState *dev, const char *idstr, void *opaque)
 
     QTAILQ_FOREACH_SAFE(se, &savevm_state.handlers, entry, new_se) {
         if (strcmp(se->idstr, id) == 0 && se->opaque == opaque) {
-            QTAILQ_REMOVE(&savevm_state.handlers, se, entry);
+            savevm_state_handler_remove(se);
             g_free(se->compat);
             g_free(se);
         }
@@ -841,7 +866,7 @@ void vmstate_unregister(DeviceState *dev, const VMStateDescription *vmsd,
 
     QTAILQ_FOREACH_SAFE(se, &savevm_state.handlers, entry, new_se) {
         if (se->vmsd == vmsd && se->opaque == opaque) {
-            QTAILQ_REMOVE(&savevm_state.handlers, se, entry);
+            savevm_state_handler_remove(se);
             g_free(se->compat);
             g_free(se);
         }
-- 
2.23.0


