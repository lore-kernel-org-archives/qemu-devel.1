Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24225C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 20:46:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0124821479
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 20:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0124821479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41681 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSpAa-0004GP-HB
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 16:46:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxiwell@linux.ibm.com>) id 1hSp9C-0003Rt-8S
	for qemu-devel@nongnu.org; Mon, 20 May 2019 16:44:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxiwell@linux.ibm.com>) id 1hSp9B-0006NC-10
	for qemu-devel@nongnu.org; Mon, 20 May 2019 16:44:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxiwell@linux.ibm.com>)
	id 1hSp9A-0006LL-M5
	for qemu-devel@nongnu.org; Mon, 20 May 2019 16:44:36 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4KKb5UG129731
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 16:44:35 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2sm2m31w9y-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 16:44:35 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <maxiwell@linux.ibm.com>;
	Mon, 20 May 2019 21:44:34 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
	by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Mon, 20 May 2019 21:44:32 +0100
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
	[9.57.199.110])
	by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	x4KKiVBM37027842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Mon, 20 May 2019 20:44:31 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38BC2AE05F;
	Mon, 20 May 2019 20:44:31 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C54BAAE060;
	Mon, 20 May 2019 20:44:29 +0000 (GMT)
Received: from maxibm.ibmuc.com (unknown [9.85.147.231])
	by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
	Mon, 20 May 2019 20:44:29 +0000 (GMT)
From: "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
To: qemu-devel@nongnu.org
Date: Mon, 20 May 2019 17:43:40 -0300
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520204340.832-1-maxiwell@linux.ibm.com>
References: <20190520204340.832-1-maxiwell@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19052020-0040-0000-0000-000004F20D6D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011132; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000286; SDB=6.01206188; UDB=6.00633353;
	IPR=6.00987148; 
	MB=3.00026975; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-20 20:44:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052020-0041-0000-0000-000008FE206E
Message-Id: <20190520204340.832-2-maxiwell@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-20_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=962 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905200129
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH 1/1] spapr: Do not re-read the clock on
 pre_save handler on migration
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>,
	david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This handler was added in the commit:
  42043e4f1241: spapr: clock should count only if vm is running

In a scenario without migration, this pre_save handler is not
triggered, so the 'stop/cont' commands save and restore the clock
in the function 'cpu_ppc_clock_vm_state_change.' The SW clock
in the guest doesn't know about this pause.

If the command 'migrate' is called between 'stop' and 'cont',
the pre_save handler re-read the clock, and the SW clock in the
guest will know about the pause between 'stop' and 'migrate.'
If the guest is running a workload like HTC, a side-effect of
this is a lot of process stall messages (with call traces) in
the kernel guest.

Signed-off-by: Maxiwell S. Garcia <maxiwell@linux.ibm.com>
---
 hw/ppc/ppc.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index ad20584f26..3fb50cbeee 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -1056,35 +1056,11 @@ void cpu_ppc_clock_vm_state_change(void *opaque, int running,
     }
 }
 
-/*
- * When migrating, read the clock just before migration,
- * so that the guest clock counts during the events
- * between:
- *
- *  * vm_stop()
- *  *
- *  * pre_save()
- *
- *  This reduces clock difference on migration from 5s
- *  to 0.1s (when max_downtime == 5s), because sending the
- *  final pages of memory (which happens between vm_stop()
- *  and pre_save()) takes max_downtime.
- */
-static int timebase_pre_save(void *opaque)
-{
-    PPCTimebase *tb = opaque;
-
-    timebase_save(tb);
-
-    return 0;
-}
-
 const VMStateDescription vmstate_ppc_timebase = {
     .name = "timebase",
     .version_id = 1,
     .minimum_version_id = 1,
     .minimum_version_id_old = 1,
-    .pre_save = timebase_pre_save,
     .fields      = (VMStateField []) {
         VMSTATE_UINT64(guest_timebase, PPCTimebase),
         VMSTATE_INT64(time_of_the_day_ns, PPCTimebase),
-- 
2.20.1


