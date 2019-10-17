Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2692AECE58D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 21:04:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E54B121D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 21:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E54B121D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59893 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLCww-0004g4-44
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 17:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cheloha@linux.vnet.ibm.com>) id 1iLCsM-0000SG-4a
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 17:00:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cheloha@linux.vnet.ibm.com>) id 1iLCsJ-0008ME-UQ
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 17:00:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19462
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cheloha@linux.vnet.ibm.com>)
 id 1iLCsJ-0008LY-4J
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 16:59:59 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9HKchW3075174
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 16:59:57 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vpvtm6ty3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 16:59:57 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x9HKq9VH106924
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 16:59:57 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vpvtm6txw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Oct 2019 16:59:57 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9HKtfQv012820;
 Thu, 17 Oct 2019 20:59:56 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma01dal.us.ibm.com with ESMTP id 2vk6f85dk8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Oct 2019 20:59:56 +0000
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x9HKxtac44695904
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2019 20:59:55 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 08A29136055;
 Thu, 17 Oct 2019 20:59:55 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C945C136053;
 Thu, 17 Oct 2019 20:59:54 +0000 (GMT)
Received: from rascal.austin.ibm.com (unknown [9.41.179.32])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 17 Oct 2019 20:59:54 +0000 (GMT)
From: Scott Cheloha <cheloha@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] migration: savevm_state_handler_insert: constant-time
 element insertion
Date: Thu, 17 Oct 2019 15:59:53 -0500
Message-Id: <20191017205953.13122-3-cheloha@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191017205953.13122-1-cheloha@linux.vnet.ibm.com>
References: <20191017205953.13122-1-cheloha@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-17_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910170186
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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

savevm_state's SaveStateEntry TAILQ is a priority queue.  Priority
sorting is maintained by searching from head to tail for a suitable
insertion spot.  Insertion is thus an O(n) operation.

If we instead keep track of the head of each priority's subqueue
within that larger queue we can reduce this operation to O(1) time.

savevm_state_handler_remove() becomes slightly more complex to
accomodate these gains: we need to replace the head of a priority's
subqueue when removing it.

With O(1) insertion, booting VMs with many SaveStateEntry objects is
more plausible.  For example, a ppc64 VM with maxmem=8T has 40000 such
objects to insert.

Signed-off-by: Scott Cheloha <cheloha@linux.vnet.ibm.com>
---
 migration/savevm.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index b2e3b7222a..f7a2d36bba 100644
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
 
@@ -709,24 +711,42 @@ static void savevm_state_handler_insert(SaveStateEntry *nse)
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
 }
 
 static void savevm_state_handler_remove(SaveStateEntry *se)
 {
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
     QTAILQ_REMOVE(&savevm_state.handlers, se, entry);
 }
 
-- 
2.23.0


