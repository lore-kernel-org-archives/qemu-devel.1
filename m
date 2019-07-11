Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8AEC742A2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 19:47:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D034F20863
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 19:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D034F20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlf2d-0002C5-09
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 15:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47947)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <maxiwell@linux.ibm.com>) id 1hlf2P-0001eO-UO
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 15:47:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maxiwell@linux.ibm.com>) id 1hlf2O-0000iS-PL
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 15:47:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37124)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <maxiwell@linux.ibm.com>)
 id 1hlf2M-0000eM-BT; Thu, 11 Jul 2019 15:47:26 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6BJlBde078194; Thu, 11 Jul 2019 15:47:16 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2tp9r1vg8p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jul 2019 15:47:16 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x6BJj3R8022527;
 Thu, 11 Jul 2019 19:47:15 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma01dal.us.ibm.com with ESMTP id 2tjk97pb3r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jul 2019 19:47:14 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6BJlDYo54985132
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Jul 2019 19:47:13 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 59D7EC6057;
 Thu, 11 Jul 2019 19:47:13 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 71BAEC6055;
 Thu, 11 Jul 2019 19:47:12 +0000 (GMT)
Received: from maxibm.br.ibm.com (unknown [9.18.235.216])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 11 Jul 2019 19:47:12 +0000 (GMT)
From: "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Jul 2019 16:47:02 -0300
Message-Id: <20190711194702.26598-1-maxiwell@linux.ibm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-11_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907110218
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH v2] migration: Do not re-read the clock on
 pre_save in case of paused guest
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
Cc: "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Re-read the timebase before migrate was ported from x86 commit:
   6053a86fe7bd: kvmclock: reduce kvmclock difference on migration

The clock move makes the guest knows about the paused time between
the stop and migrate commands. This is an issue in an already-paused
VM because some side effects, like process stalls, could happen
after migration.

So, this patch checks the runstate of guest in the pre_save handler and
do not re-reads the timebase in case of paused state (cold migration).

Signed-off-by: Maxiwell S. Garcia <maxiwell@linux.ibm.com>
---
 hw/ppc/ppc.c         | 13 +++++++++----
 target/ppc/cpu-qom.h |  1 +
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index a9e508c496..8572e45274 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -1008,6 +1008,8 @@ static void timebase_save(PPCTimebase *tb)
      * there is no need to update it from KVM here
      */
     tb->guest_timebase = ticks + first_ppc_cpu->env.tb_env->tb_offset;
+
+    tb->runstate_paused = runstate_check(RUN_STATE_PAUSED);
 }
 
 static void timebase_load(PPCTimebase *tb)
@@ -1051,9 +1053,9 @@ void cpu_ppc_clock_vm_state_change(void *opaque, int running,
 }
 
 /*
- * When migrating, read the clock just before migration,
- * so that the guest clock counts during the events
- * between:
+ * When migrating a running guest, read the clock just
+ * before migration, so that the guest clock counts
+ * during the events between:
  *
  *  * vm_stop()
  *  *
@@ -1068,7 +1070,10 @@ static int timebase_pre_save(void *opaque)
 {
     PPCTimebase *tb = opaque;
 
-    timebase_save(tb);
+    /* guest_timebase won't be overridden in case of paused guest */
+    if (!tb->runstate_paused) {
+        timebase_save(tb);
+    }
 
     return 0;
 }
diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index be9b4c30c3..5fbcdee9c9 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -201,6 +201,7 @@ typedef struct PowerPCCPUClass {
 typedef struct PPCTimebase {
     uint64_t guest_timebase;
     int64_t time_of_the_day_ns;
+    bool runstate_paused;
 } PPCTimebase;
 
 extern const struct VMStateDescription vmstate_ppc_timebase;
-- 
2.20.1


