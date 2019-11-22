Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44518C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 07:56:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18F4520659
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 07:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F4520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY3o9-00065o-Rm
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 02:56:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1iY3kV-0002TR-2N
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 02:53:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1iY3kT-0004Ta-T0
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 02:53:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47482
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1iY3kT-0004TC-Oh
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 02:53:01 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAM7mAlh063289
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 02:53:01 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wdkdff3qv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 02:53:01 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Fri, 22 Nov 2019 07:52:59 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 22 Nov 2019 07:52:57 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAM7qtmY50069650
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Nov 2019 07:52:55 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6972011C050;
 Fri, 22 Nov 2019 07:52:55 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5934011C05B;
 Fri, 22 Nov 2019 07:52:53 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.41.23])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 22 Nov 2019 07:52:53 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] s390x: Beautify machine reset
Date: Fri, 22 Nov 2019 02:52:18 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122075218.23935-1-frankja@linux.ibm.com>
References: <20191122075218.23935-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112207-4275-0000-0000-00000384C27D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112207-4276-0000-0000-000038984231
Message-Id: <20191122075218.23935-5-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-21_07:2019-11-21,2019-11-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999
 adultscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 impostorscore=0
 suspectscore=1 malwarescore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911220068
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Add comments that tell you which diag308 subcode caused the reset
* Sort by diag308 reset subcode

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index c1d1440272..88f7758721 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -330,15 +330,7 @@ static void s390_machine_reset(MachineState *machine)
     s390_cmma_reset();
 
     switch (reset_type) {
-    case S390_RESET_EXTERNAL:
-    case S390_RESET_REIPL:
-        qemu_devices_reset();
-        s390_crypto_reset();
-
-        /* configure and start the ipl CPU only */
-        run_on_cpu(cs, s390_do_cpu_ipl, RUN_ON_CPU_NULL);
-        break;
-    case S390_RESET_MODIFIED_CLEAR:
+    case S390_RESET_MODIFIED_CLEAR: /* Subcode 0 */
         CPU_FOREACH(t) {
             run_on_cpu(t, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
         }
@@ -346,7 +338,7 @@ static void s390_machine_reset(MachineState *machine)
         s390_crypto_reset();
         run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
         break;
-    case S390_RESET_LOAD_NORMAL:
+    case S390_RESET_LOAD_NORMAL: /* Subcode 1 */
         CPU_FOREACH(t) {
             if (t == cs) {
                 continue;
@@ -357,6 +349,14 @@ static void s390_machine_reset(MachineState *machine)
         run_on_cpu(cs, s390_do_cpu_initial_reset, RUN_ON_CPU_NULL);
         run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
         break;
+    case S390_RESET_EXTERNAL: /* Externally triggered reboot */
+    case S390_RESET_REIPL: /* Subcode 4 */
+        qemu_devices_reset();
+        s390_crypto_reset();
+
+        /* configure and start the ipl CPU only */
+        run_on_cpu(cs, s390_do_cpu_ipl, RUN_ON_CPU_NULL);
+        break;
     default:
         g_assert_not_reached();
     }
-- 
2.20.1


