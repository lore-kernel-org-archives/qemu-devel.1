Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180D9C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 19:50:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDE04206D6
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 19:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDE04206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTsjF-00031h-Tm
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 15:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48194)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dbuono@linux.vnet.ibm.com>) id 1jTsfu-0006p6-4P
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 15:47:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dbuono@linux.vnet.ibm.com>) id 1jTsdk-0000nT-K8
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 15:47:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42310)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1jTsdk-0000nG-3c
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 15:45:04 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03TJWrkG137413
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 15:45:03 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30mh9q556s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 15:45:02 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03TJYYTB001160
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 15:45:02 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30mh9q5564-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2020 15:45:02 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03TJUWUl004204;
 Wed, 29 Apr 2020 19:45:01 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma04dal.us.ibm.com with ESMTP id 30mcu718wh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2020 19:45:01 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 03TJix1N24903948
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Apr 2020 19:44:59 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD3326A04D;
 Wed, 29 Apr 2020 19:44:59 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE38F6A047;
 Wed, 29 Apr 2020 19:44:58 +0000 (GMT)
Received: from Buonos-Thinkpad-X1.ibm.com (unknown [9.160.84.167])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 29 Apr 2020 19:44:58 +0000 (GMT)
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] check-block: Enable iotests with SafeStack
Date: Wed, 29 Apr 2020 15:44:20 -0400
Message-Id: <20200429194420.21147-5-dbuono@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429194420.21147-1-dbuono@linux.vnet.ibm.com>
References: <20200429194420.21147-1-dbuono@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-29_10:2020-04-29,
 2020-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0
 spamscore=0 malwarescore=0 adultscore=0 suspectscore=1 mlxlogscore=897
 impostorscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290145
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 15:44:54
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Tobin Feldman-Fitzthum <tobin@ibm.com>,
 Daniele Buono <dbuono@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SafeStack is a stack protection technique implemented in llvm. It is
enabled with a -fsanitize flag.
iotests are currently disabled when any -fsanitize option is used.
Since SafeStack is useful on production environments, and its
implementation may break the binary, filter it out when the check is
performed, so that if SafeStack was the only -fsanitize option, iotests
are still performed.

Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
---
 tests/check-block.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tests/check-block.sh b/tests/check-block.sh
index ad320c21ba..8e29c868e5 100755
--- a/tests/check-block.sh
+++ b/tests/check-block.sh
@@ -21,7 +21,17 @@ if grep -q "CONFIG_GPROF=y" config-host.mak 2>/dev/null ; then
     exit 0
 fi
 
-if grep -q "CFLAGS.*-fsanitize" config-host.mak 2>/dev/null ; then
+# Disable tests with any sanitizer except for SafeStack
+CFLAGS=$( grep "CFLAGS.*-fsanitize" config-host.mak 2>/dev/null )
+SANITIZE_FLAGS=""
+#Remove all occurrencies of -fsanitize=safe-stack
+for i in ${CFLAGS}; do
+        if [ "${i}" != "-fsanitize=safe-stack" ]; then
+                SANITIZE_FLAGS="${SANITIZE_FLAGS} ${i}"
+        fi
+done
+if echo ${SANITIZE_FLAGS} | grep -q "\-fsanitize" 2>/dev/null; then
+    # Have a sanitize flag that is not allowed, stop
     echo "Sanitizers are enabled ==> Not running the qemu-iotests."
     exit 0
 fi
-- 
2.26.2


