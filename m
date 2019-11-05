Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B5BC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 20:57:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAF0421A49
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 20:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF0421A49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS5ti-00068D-ME
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 15:57:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58000)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iS5ov-0000DV-Ve
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:52:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iS5ou-0001sY-H5
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:52:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24702
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iS5ou-0001qp-CO; Tue, 05 Nov 2019 15:52:56 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 xA5KpXvX020357; Tue, 5 Nov 2019 15:52:55 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2w3ftes64t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 15:52:55 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id xA5KpbnC020609;
 Tue, 5 Nov 2019 15:52:55 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2w3ftes64c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 15:52:55 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xA5KnvbE031295;
 Tue, 5 Nov 2019 20:52:54 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma01dal.us.ibm.com with ESMTP id 2w11e7hh87-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 20:52:54 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xA5KqrpW29360612
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Nov 2019 20:52:53 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 61D2E124055;
 Tue,  5 Nov 2019 20:52:53 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F75C124054;
 Tue,  5 Nov 2019 20:52:53 +0000 (GMT)
Received: from localhost (unknown [9.53.179.218])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  5 Nov 2019 20:52:53 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/55] x86: do not advertise die-id in query-hotpluggbale-cpus
 if '-smp dies' is not set
Date: Tue,  5 Nov 2019 14:51:59 -0600
Message-Id: <20191105205243.3766-12-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191105205243.3766-1-mdroth@linux.vnet.ibm.com>
References: <20191105205243.3766-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-11-05_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1911050170
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
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-stable@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

Commit 176d2cda0 (i386/cpu: Consolidate die-id validity in smp context) added
new 'die-id' topology property to CPUs and exposed it via QMP command
query-hotpluggable-cpus, which broke -device/device_add cpu-foo for existing
users that do not support die-id/dies yet. That's would be fine if it happened
to new machine type only but it also happened to old machine types,
which breaks migration from old QEMU to the new one, for example following CLI:

  OLD-QEMU -M pc-i440fx-4.0 -smp 1,max_cpus=2 \
           -device qemu64-x86_64-cpu,socket-id=1,core-id=0,thread-id
is not able to start with new QEMU, complaining about invalid die-id.

After discovering regression, the patch
   "pc: Don't make die-id mandatory unless necessary"
makes die-id optional so old CLI would work.

However it's not enough as new QEMU still exposes die-id via query-hotpluggbale-cpus
QMP command, so the users that started old machine type on new QEMU, using all
properties (including die-id) received from QMP command (as required), won't be
able to start old QEMU using the same properties since it doesn't support die-id.

Fix it by hiding die-id in query-hotpluggbale-cpus for all machine types in case
'-smp dies' is not provided on CLI or -smp dies = 1', in which case smp_dies == 1
and APIC ID is calculated in default way (as it was before DIE support) so we won't
need compat code as in both cases the topology provided to guest via CPUID is the same.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20190902120222.6179-1-imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
(cherry picked from commit c6c1bb89fb46f3b88f832e654cf5a6f7941aac51)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/i386/pc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 947f81070f..d011733ff7 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2887,8 +2887,10 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
                                  ms->smp.threads, &topo);
         ms->possible_cpus->cpus[i].props.has_socket_id = true;
         ms->possible_cpus->cpus[i].props.socket_id = topo.pkg_id;
-        ms->possible_cpus->cpus[i].props.has_die_id = true;
-        ms->possible_cpus->cpus[i].props.die_id = topo.die_id;
+        if (pcms->smp_dies > 1) {
+            ms->possible_cpus->cpus[i].props.has_die_id = true;
+            ms->possible_cpus->cpus[i].props.die_id = topo.die_id;
+        }
         ms->possible_cpus->cpus[i].props.has_core_id = true;
         ms->possible_cpus->cpus[i].props.core_id = topo.core_id;
         ms->possible_cpus->cpus[i].props.has_thread_id = true;
-- 
2.17.1


