Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8D2C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 09:24:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 098E42467B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 09:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098E42467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7FPV-0000Hj-8A
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 04:24:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1j7FOw-0008Hc-Tx
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:24:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1j7FOv-0002qs-QF
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:24:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2762)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1j7FOv-0002pO-J5
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:24:13 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01R9JuiX190067
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 04:24:12 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ydh924axd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 04:24:12 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Thu, 27 Feb 2020 09:23:48 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 27 Feb 2020 09:23:45 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01R9Ni8Z50069592
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Feb 2020 09:23:44 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A568AAE045;
 Thu, 27 Feb 2020 09:23:44 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3472DAE051;
 Thu, 27 Feb 2020 09:23:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.177.63])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 27 Feb 2020 09:23:42 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6] s390x: Rename and use constants for short PSW address and
 mask
Date: Thu, 27 Feb 2020 04:23:41 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200227100632.5292d773.cohuck@redhat.com>
References: <20200227100632.5292d773.cohuck@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022709-0028-0000-0000-000003DE6F45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022709-0029-0000-0000-000024A38DE6
Message-Id: <20200227092341.38558-1-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-27_02:2020-02-26,
 2020-02-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 mlxlogscore=927 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=1
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002270075
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's rename PSW_MASK_ESA_ADDR to PSW_MASK_SHORT_ADDR because we're
not working with a ESA PSW which would not support the extended
addressing bit. Also let's actually use it.

Additionally we introduce PSW_MASK_SHORT_CTRL and use it throughout
the codebase.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/ipl.c     | 2 +-
 target/s390x/cpu.c | 4 ++--
 target/s390x/cpu.h | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 7773499d7f..e36f770a72 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -179,7 +179,7 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
                 /* if not Linux load the address of the (short) IPL PSW */
                 ipl_psw = rom_ptr(4, 4);
                 if (ipl_psw) {
-                    pentry = be32_to_cpu(*ipl_psw) & 0x7fffffffUL;
+                    pentry = be32_to_cpu(*ipl_psw) & PSW_MASK_SHORT_ADDR;
                 } else {
                     error_setg(&err, "Could not get IPL PSW");
                     goto error;
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 8da1905485..3dd396e870 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -78,13 +78,13 @@ static void s390_cpu_load_normal(CPUState *s)
     S390CPU *cpu = S390_CPU(s);
     uint64_t spsw = ldq_phys(s->as, 0);
 
-    cpu->env.psw.mask = spsw & 0xffffffff80000000ULL;
+    cpu->env.psw.mask = spsw & PSW_MASK_SHORT_CTRL;
     /*
      * Invert short psw indication, so SIE will report a specification
      * exception if it was not set.
      */
     cpu->env.psw.mask ^= PSW_MASK_SHORTPSW;
-    cpu->env.psw.addr = spsw & 0x7fffffffULL;
+    cpu->env.psw.addr = spsw & PSW_MASK_SHORT_ADDR;
 
     s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
 }
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 8a557fd8d1..1d17709d6e 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -276,7 +276,8 @@ extern const VMStateDescription vmstate_s390_cpu;
 #define PSW_MASK_RI             0x0000008000000000ULL
 #define PSW_MASK_64             0x0000000100000000ULL
 #define PSW_MASK_32             0x0000000080000000ULL
-#define PSW_MASK_ESA_ADDR       0x000000007fffffffULL
+#define PSW_MASK_SHORT_ADDR     0x000000007fffffffULL
+#define PSW_MASK_SHORT_CTRL     0xffffffff80000000ULL
 
 #undef PSW_ASC_PRIMARY
 #undef PSW_ASC_ACCREG
-- 
2.20.1


