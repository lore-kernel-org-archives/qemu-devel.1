Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342C3C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 21:08:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 013D3233FF
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 21:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 013D3233FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Rf1-0005T5-5B
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 17:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maxiwell@linux.ibm.com>) id 1i3Re3-000523-5g
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 17:07:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maxiwell@linux.ibm.com>) id 1i3Re1-0001F9-Vj
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 17:07:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1340)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <maxiwell@linux.ibm.com>)
 id 1i3Re1-0001Dl-ND
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 17:07:49 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7TL1rdH003432; Thu, 29 Aug 2019 17:07:47 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2upp2d8kdx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Aug 2019 17:07:46 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7TL1vFa003799;
 Thu, 29 Aug 2019 17:07:46 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2upp2d8kcm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Aug 2019 17:07:46 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7TL58f3025947;
 Thu, 29 Aug 2019 21:07:44 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma04wdc.us.ibm.com with ESMTP id 2ujvv6xs5j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Aug 2019 21:07:44 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7TL7ifJ16187876
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Aug 2019 21:07:44 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0534AAC065;
 Thu, 29 Aug 2019 21:07:44 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F2A0EAC062;
 Thu, 29 Aug 2019 21:07:41 +0000 (GMT)
Received: from maxibm.ibmuc.com (unknown [9.85.226.103])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 29 Aug 2019 21:07:41 +0000 (GMT)
From: "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
To: qemu-devel@nongnu.org
Date: Thu, 29 Aug 2019 18:07:11 -0300
Message-Id: <20190829210711.6570-1-maxiwell@linux.ibm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-29_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908290212
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH] migration: Do not re-read the clock on
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
Cc: ehabkost@redhat.com, mst@redhat.com,
 "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The clock move makes the guest knows about the paused time between the
'stop' and 'migrate' commands. This is an issue in an already-paused
VM because some side effects, like process stalls, could happen
after migration.

So, this patch checks the runstate of guest in the pre_save handler and
do not re-reads the clock in case of paused state (cold migration).

Signed-off-by: Maxiwell S. Garcia <maxiwell@linux.ibm.com>
---
 hw/i386/kvm/clock.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index 80c133a724..2c59b6894b 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -41,6 +41,9 @@ typedef struct KVMClockState {
     uint64_t clock;
     bool clock_valid;
 
+    /* whether the 'clock' value was obtained in the 'paused' state */
+    bool runstate_paused;
+
     /* whether machine type supports reliable KVM_GET_CLOCK */
     bool mach_use_reliable_get_clock;
 
@@ -202,6 +205,8 @@ static void kvmclock_vm_state_change(void *opaque, int running,
             return;
         }
 
+        s->runstate_paused = runstate_check(RUN_STATE_PAUSED);
+
         kvm_synchronize_all_tsc();
 
         kvm_update_clock(s);
@@ -260,9 +265,9 @@ static int kvmclock_pre_load(void *opaque)
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
@@ -277,7 +282,9 @@ static int kvmclock_pre_save(void *opaque)
 {
     KVMClockState *s = opaque;
 
-    kvm_update_clock(s);
+    if (!s->runstate_paused) {
+        kvm_update_clock(s);
+    }
 
     return 0;
 }
-- 
2.20.1


