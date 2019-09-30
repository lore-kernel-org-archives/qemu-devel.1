Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FACDC32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 13:31:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02003215EA
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 13:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02003215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEvmI-000142-KW
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 09:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <borntraeger@de.ibm.com>) id 1iEvbG-0004Nf-Lc
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 09:20:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <borntraeger@de.ibm.com>) id 1iEvb6-00055d-Nf
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 09:20:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24874
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
 id 1iEvax-0004zS-Kk
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 09:20:14 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8UDIHEh134057
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 09:20:03 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vbjd70bqf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 09:20:02 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
 Mon, 30 Sep 2019 14:20:00 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 30 Sep 2019 14:19:58 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8UDJurM58654868
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Sep 2019 13:19:56 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B3C5A42045;
 Mon, 30 Sep 2019 13:19:56 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D8CD42041;
 Mon, 30 Sep 2019 13:19:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Mon, 30 Sep 2019 13:19:56 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
 id 551C8E020F; Mon, 30 Sep 2019 15:19:56 +0200 (CEST)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 03/12] s390x: sclp: refactor invalid command check
Date: Mon, 30 Sep 2019 15:19:46 +0200
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190930131955.101131-1-borntraeger@de.ibm.com>
References: <20190930131955.101131-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19093013-0020-0000-0000-000003730FB9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19093013-0021-0000-0000-000021C8EA23
Message-Id: <20190930131955.101131-4-borntraeger@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-30_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909300138
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
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, kvm@vger.kernel.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Collin Walling <walling@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Janosch Frank <frankja@linux.ibm.com>

Invalid command checking has to be done before the boundary check,
refactoring it now allows to insert the boundary check at the correct
place later.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
Message-Id: <1569591203-15258-2-git-send-email-imbrenda@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/event-facility.c |  3 ---
 hw/s390x/sclp.c           | 17 ++++++++++++++++-
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 797ecbb7a9c8..66205697ae75 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -377,9 +377,6 @@ static void command_handler(SCLPEventFacility *ef, SCCB *sccb, uint64_t code)
     case SCLP_CMD_WRITE_EVENT_MASK:
         write_event_mask(ef, sccb);
         break;
-    default:
-        sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
-        break;
     }
 }
 
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index fac7c3bb6c02..95ebfe7bd2f1 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -219,8 +219,23 @@ int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
         goto out;
     }
 
-    sclp_c->execute(sclp, &work_sccb, code);
+    switch (code & SCLP_CMD_CODE_MASK) {
+    case SCLP_CMDW_READ_SCP_INFO:
+    case SCLP_CMDW_READ_SCP_INFO_FORCED:
+    case SCLP_CMDW_READ_CPU_INFO:
+    case SCLP_CMDW_CONFIGURE_IOA:
+    case SCLP_CMDW_DECONFIGURE_IOA:
+    case SCLP_CMD_READ_EVENT_DATA:
+    case SCLP_CMD_WRITE_EVENT_DATA:
+    case SCLP_CMD_WRITE_EVENT_MASK:
+        break;
+    default:
+        work_sccb.h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
+        goto out_write;
+    }
 
+    sclp_c->execute(sclp, &work_sccb, code);
+out_write:
     cpu_physical_memory_write(sccb, &work_sccb,
                               be16_to_cpu(work_sccb.h.length));
 
-- 
2.21.0


