Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446DDC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 05:50:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C231207E8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 05:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C231207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqs7e-0001DC-8w
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 01:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1jqs6t-0000Dn-FN
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 01:50:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20342)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1jqs6r-0005UV-Od
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 01:50:11 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0625W2P8072501
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2020 01:50:08 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 320sk0aa0f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 01:50:08 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0625f7Ts105086
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2020 01:50:08 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 320sk0aa06-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2020 01:50:07 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0625jGUP005271;
 Thu, 2 Jul 2020 05:50:07 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma01dal.us.ibm.com with ESMTP id 320wfkdvad-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2020 05:50:07 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0625o5Ff37552558
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2020 05:50:05 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 973B46A057;
 Thu,  2 Jul 2020 05:50:05 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 26FD56A04D;
 Thu,  2 Jul 2020 05:50:05 +0000 (GMT)
Received: from Buonos-Thinkpad-X1.ibm.com (unknown [9.160.82.151])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu,  2 Jul 2020 05:50:04 +0000 (GMT)
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] check-block: enable iotests with cfi-icall
Date: Thu,  2 Jul 2020 01:49:47 -0400
Message-Id: <20200702054948.10257-2-dbuono@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200702054948.10257-1-dbuono@linux.vnet.ibm.com>
References: <20200702054948.10257-1-dbuono@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-02_02:2020-07-01,
 2020-07-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 cotscore=-2147483648
 clxscore=1015 impostorscore=0 mlxlogscore=777 spamscore=0 mlxscore=0
 suspectscore=1 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007020037
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 01:50:06
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniele Buono <dbuono@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cfi-icall is a form of Control-Flow Integrity for indirect function
calls implemented by llvm. It is enabled with a -fsanitize flag.

iotests are currently disabled when -fsanitize options is used, with the
exception of SafeStack.

This patch implements a generic filtering mechanism to allow iotests
with a set of known-to-be-safe -fsanitize option. Then mark SafeStack
and the new options used for cfi-icall safe for iotests

Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
---
 tests/check-block.sh | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tests/check-block.sh b/tests/check-block.sh
index 8e29c868e5..7691213bd9 100755
--- a/tests/check-block.sh
+++ b/tests/check-block.sh
@@ -21,14 +21,18 @@ if grep -q "CONFIG_GPROF=y" config-host.mak 2>/dev/null ; then
     exit 0
 fi
 
-# Disable tests with any sanitizer except for SafeStack
-CFLAGS=$( grep "CFLAGS.*-fsanitize" config-host.mak 2>/dev/null )
-SANITIZE_FLAGS=""
-#Remove all occurrencies of -fsanitize=safe-stack
-for i in ${CFLAGS}; do
-        if [ "${i}" != "-fsanitize=safe-stack" ]; then
-                SANITIZE_FLAGS="${SANITIZE_FLAGS} ${i}"
+# Disable tests with any sanitizer except for specific ones
+SANITIZE_FLAGS=$( grep "CFLAGS.*-fsanitize" config-host.mak 2>/dev/null )
+ALLOWED_SANITIZE_FLAGS="safe-stack cfi-icall sanitize-blacklist"
+#Remove all occurrencies of allowed Sanitize flags
+for j in ${ALLOWED_SANITIZE_FLAGS}; do
+    TMP_FLAGS=${SANITIZE_FLAGS}
+    SANITIZE_FLAGS=""
+    for i in ${TMP_FLAGS}; do
+        if ! echo ${i} | grep -q "${j}" 2>/dev/null; then
+            SANITIZE_FLAGS="${SANITIZE_FLAGS} ${i}"
         fi
+    done
 done
 if echo ${SANITIZE_FLAGS} | grep -q "\-fsanitize" 2>/dev/null; then
     # Have a sanitize flag that is not allowed, stop
-- 
2.26.2


