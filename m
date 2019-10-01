Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC28C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:08:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0184120815
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0184120815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFT88-0003dM-6Z
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 21:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsc-00021S-BB
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsW-0002aF-QP
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14720)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRsQ-0001zh-Bq; Tue, 01 Oct 2019 19:48:23 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NlQWQ134232; Tue, 1 Oct 2019 19:47:55 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vccwberjx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:55 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x91NltKl138568;
 Tue, 1 Oct 2019 19:47:55 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vccwberjm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:55 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91NjkEU027150;
 Tue, 1 Oct 2019 23:47:54 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma03dal.us.ibm.com with ESMTP id 2v9y587bja-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:54 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91Nlrxm53477790
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:53 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 86D242805E;
 Tue,  1 Oct 2019 23:47:53 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B4152805A;
 Tue,  1 Oct 2019 23:47:53 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:53 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 76/97] iotests: add testing shim for script-style python tests
Date: Tue,  1 Oct 2019 18:45:55 -0500
Message-Id: <20191001234616.7825-77-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
References: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-01_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=948 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010203
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: John Snow <jsnow@redhat.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

Because the new-style python tests don't use the iotests.main() test
launcher, we don't turn on the debugger logging for these scripts
when invoked via ./check -d.

Refactor the launcher shim into new and old style shims so that they
share environmental configuration.

Two cleanup notes: debug was not actually used as a global, and there
was no reason to create a class in an inner scope just to achieve
default variables; we can simply create an instance of the runner with
the values we want instead.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190709232550.10724-14-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
(cherry picked from commit 456a2d5ac7641c7e75c76328a561b528a8607a8e)
*prereq for 1a37e31244/88d2aa533a
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/qemu-iotests/iotests.py | 40 +++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index a7006662ff..5efc21d801 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -61,7 +61,6 @@ cachemode = os.environ.get('CACHEMODE')
 qemu_default_machine = os.environ.get('QEMU_DEFAULT_MACHINE')
 
 socket_scm_helper = os.environ.get('SOCKET_SCM_HELPER', 'socket_scm_helper')
-debug = False
 
 luks_default_secret_object = 'secret,id=keysec0,data=' + \
                              os.environ.get('IMGKEYSECRET', '')
@@ -817,11 +816,22 @@ def skip_if_unsupported(required_formats=[], read_only=False):
         return func_wrapper
     return skip_test_decorator
 
-def main(supported_fmts=[], supported_oses=['linux'], supported_cache_modes=[],
-         unsupported_fmts=[]):
-    '''Run tests'''
+def execute_unittest(output, verbosity, debug):
+    runner = unittest.TextTestRunner(stream=output, descriptions=True,
+                                     verbosity=verbosity)
+    try:
+        # unittest.main() will use sys.exit(); so expect a SystemExit
+        # exception
+        unittest.main(testRunner=runner)
+    finally:
+        if not debug:
+            sys.stderr.write(re.sub(r'Ran (\d+) tests? in [\d.]+s',
+                                    r'Ran \1 tests', output.getvalue()))
 
-    global debug
+def execute_test(test_function=None,
+                 supported_fmts=[], supported_oses=['linux'],
+                 supported_cache_modes=[], unsupported_fmts=[]):
+    """Run either unittest or script-style tests."""
 
     # We are using TEST_DIR and QEMU_DEFAULT_MACHINE as proxies to
     # indicate that we're not being run via "check". There may be
@@ -853,13 +863,15 @@ def main(supported_fmts=[], supported_oses=['linux'], supported_cache_modes=[],
 
     logging.basicConfig(level=(logging.DEBUG if debug else logging.WARN))
 
-    class MyTestRunner(unittest.TextTestRunner):
-        def __init__(self, stream=output, descriptions=True, verbosity=verbosity):
-            unittest.TextTestRunner.__init__(self, stream, descriptions, verbosity)
+    if not test_function:
+        execute_unittest(output, verbosity, debug)
+    else:
+        test_function()
+
+def script_main(test_function, *args, **kwargs):
+    """Run script-style tests outside of the unittest framework"""
+    execute_test(test_function, *args, **kwargs)
 
-    # unittest.main() will use sys.exit() so expect a SystemExit exception
-    try:
-        unittest.main(testRunner=MyTestRunner)
-    finally:
-        if not debug:
-            sys.stderr.write(re.sub(r'Ran (\d+) tests? in [\d.]+s', r'Ran \1 tests', output.getvalue()))
+def main(*args, **kwargs):
+    """Run tests using the unittest framework"""
+    execute_test(None, *args, **kwargs)
-- 
2.17.1


