Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A2AC43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 18:12:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5296120663
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 18:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5296120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53650 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfTRg-0007t6-DX
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 14:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51383)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <maxiwell@linux.ibm.com>) id 1hfT49-0007US-9T
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 13:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maxiwell@linux.ibm.com>) id 1hfT47-00011B-Tj
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 13:47:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49436
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <maxiwell@linux.ibm.com>)
 id 1hfT47-0000m4-MW
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 13:47:39 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5OHl0I9106389; Mon, 24 Jun 2019 13:47:29 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2tb1y6kqc9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Jun 2019 13:47:28 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5OHjspA032605;
 Mon, 24 Jun 2019 17:47:27 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma04dal.us.ibm.com with ESMTP id 2t9by6fe54-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Jun 2019 17:47:27 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5OHlQUR51511728
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Jun 2019 17:47:26 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 287E47805C;
 Mon, 24 Jun 2019 17:47:26 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7022F78069;
 Mon, 24 Jun 2019 17:47:24 +0000 (GMT)
Received: from maxibm.ibmuc.com (unknown [9.85.234.214])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon, 24 Jun 2019 17:47:24 +0000 (GMT)
From: "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
To: qemu-devel@nongnu.org
Date: Mon, 24 Jun 2019 14:46:36 -0300
Message-Id: <20190624174636.12428-1-maxiwell@linux.ibm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-24_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906240141
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH] migration: Use RunState enum to save global
 state pre migrate
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, dgilbert@redhat.com,
 "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The GlobalState struct has two confusing fields:
- uint8_t runstate[100]
- RunState state

The first field saves the 'current_run_state' from vl.c file before
migrate. The second field is filled in the post load func using the
'runstate' value. So, this commit renames the 'runstate' to
'state_pre_migrate' and use the same type used by 'state' and
'current_run_state' variables.

Signed-off-by: Maxiwell S. Garcia <maxiwell@linux.ibm.com>
---
 include/sysemu/sysemu.h  |  2 +-
 migration/global_state.c | 65 ++++++----------------------------------
 vl.c                     | 11 ++-----
 3 files changed, 12 insertions(+), 66 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 61579ae71e..483b536c4f 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -23,7 +23,7 @@ bool runstate_check(RunState state);
 void runstate_set(RunState new_state);
 int runstate_is_running(void);
 bool runstate_needs_reset(void);
-bool runstate_store(char *str, size_t size);
+RunState runstate_get(void);
 typedef struct vm_change_state_entry VMChangeStateEntry;
 typedef void VMChangeStateHandler(void *opaque, int running, RunState state);
 
diff --git a/migration/global_state.c b/migration/global_state.c
index 2c8c447239..b49b99f3a1 100644
--- a/migration/global_state.c
+++ b/migration/global_state.c
@@ -20,8 +20,7 @@
 #include "trace.h"
 
 typedef struct {
-    uint32_t size;
-    uint8_t runstate[100];
+    RunState state_pre_migrate;
     RunState state;
     bool received;
 } GlobalState;
@@ -30,21 +29,14 @@ static GlobalState global_state;
 
 int global_state_store(void)
 {
-    if (!runstate_store((char *)global_state.runstate,
-                        sizeof(global_state.runstate))) {
-        error_report("runstate name too big: %s", global_state.runstate);
-        trace_migrate_state_too_big();
-        return -EINVAL;
-    }
+    global_state.state_pre_migrate = runstate_get();
+
     return 0;
 }
 
 void global_state_store_running(void)
 {
-    const char *state = RunState_str(RUN_STATE_RUNNING);
-    assert(strlen(state) < sizeof(global_state.runstate));
-    strncpy((char *)global_state.runstate,
-           state, sizeof(global_state.runstate));
+    global_state.state_pre_migrate = RUN_STATE_RUNNING;
 }
 
 bool global_state_received(void)
@@ -60,7 +52,6 @@ RunState global_state_get_runstate(void)
 static bool global_state_needed(void *opaque)
 {
     GlobalState *s = opaque;
-    char *runstate = (char *)s->runstate;
 
     /* If it is not optional, it is mandatory */
 
@@ -70,8 +61,8 @@ static bool global_state_needed(void *opaque)
 
     /* If state is running or paused, it is not needed */
 
-    if (strcmp(runstate, "running") == 0 ||
-        strcmp(runstate, "paused") == 0) {
+    if (s->state_pre_migrate == RUN_STATE_RUNNING ||
+        s->state_pre_migrate == RUN_STATE_PAUSED) {
         return false;
     }
 
@@ -82,45 +73,10 @@ static bool global_state_needed(void *opaque)
 static int global_state_post_load(void *opaque, int version_id)
 {
     GlobalState *s = opaque;
-    Error *local_err = NULL;
-    int r;
-    char *runstate = (char *)s->runstate;
-
     s->received = true;
-    trace_migrate_global_state_post_load(runstate);
-
-    if (strnlen((char *)s->runstate,
-                sizeof(s->runstate)) == sizeof(s->runstate)) {
-        /*
-         * This condition should never happen during migration, because
-         * all runstate names are shorter than 100 bytes (the size of
-         * s->runstate). However, a malicious stream could overflow
-         * the qapi_enum_parse() call, so we force the last character
-         * to a NUL byte.
-         */
-        s->runstate[sizeof(s->runstate) - 1] = '\0';
-    }
-    r = qapi_enum_parse(&RunState_lookup, runstate, -1, &local_err);
-
-    if (r == -1) {
-        if (local_err) {
-            error_report_err(local_err);
-        }
-        return -EINVAL;
-    }
-    s->state = r;
-
-    return 0;
-}
-
-static int global_state_pre_save(void *opaque)
-{
-    GlobalState *s = opaque;
-
-    trace_migrate_global_state_pre_save((char *)s->runstate);
-    s->size = strnlen((char *)s->runstate, sizeof(s->runstate)) + 1;
-    assert(s->size <= sizeof(s->runstate));
+    s->state = s->state_pre_migrate;
 
+    trace_migrate_global_state_post_load(RunState_str(s->state));
     return 0;
 }
 
@@ -129,11 +85,9 @@ static const VMStateDescription vmstate_globalstate = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = global_state_post_load,
-    .pre_save = global_state_pre_save,
     .needed = global_state_needed,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT32(size, GlobalState),
-        VMSTATE_BUFFER(runstate, GlobalState),
+        VMSTATE_UINT32(state_pre_migrate, GlobalState),
         VMSTATE_END_OF_LIST()
     },
 };
@@ -141,7 +95,6 @@ static const VMStateDescription vmstate_globalstate = {
 void register_global_state(void)
 {
     /* We would use it independently that we receive it */
-    strcpy((char *)&global_state.runstate, "");
     global_state.received = false;
     vmstate_register(NULL, 0, &vmstate_globalstate, &global_state);
 }
diff --git a/vl.c b/vl.c
index 99a56b5556..2b15d68d60 100644
--- a/vl.c
+++ b/vl.c
@@ -680,16 +680,9 @@ bool runstate_check(RunState state)
     return current_run_state == state;
 }
 
-bool runstate_store(char *str, size_t size)
+RunState runstate_get(void)
 {
-    const char *state = RunState_str(current_run_state);
-    size_t len = strlen(state) + 1;
-
-    if (len > size) {
-        return false;
-    }
-    memcpy(str, state, len);
-    return true;
+    return current_run_state;
 }
 
 static void runstate_init(void)
-- 
2.20.1


