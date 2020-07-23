Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B8EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:46:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 028422068F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="3AfpBDn4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 028422068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jySBs-0006y6-9A
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 23:46:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jyS68-0004kC-Vr
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 23:40:45 -0400
Received: from mail-mw2nam12on2114.outbound.protection.outlook.com
 ([40.107.244.114]:16939 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jyS67-0002Ew-3b
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 23:40:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dm9uO/8bd1AtRLw0zRum4+nwmO3MK7LiUXwkW4S7CWC0n34AbPb3gmCmqNCond+inwp3Ddj9Q0MCSV14b6T1sJXYKaQ6Rxdvg4U3q79IGAgYJG0TRcHhiu6KltogBlT1g0IloMrTtDbT0zBjEVYneRFkqkfXboxCWse9bdiaFa17XIwp3ZI8wD2WLrxjPKJYpc7DpuSDKLn6cxRb/f6CRw37aibKeY+K9fa7wdfYzFk/P4fKx/oL0jIWbWL5eHprW6pcnZ6JBDLeqSIVbyJ+fggAZzE2iFGyuHTuZwhKdmGNCy0+cqGSGtpNuM2q3TxZ1s8TjyBCP0fbDrD6DxF23w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piuHyXxbwdw425eGOf9k+yjiqN6g9rFW75SW4RFIU/0=;
 b=aiVsqdU6VLbFqWXrUaxVyuRhhErTO+dtengPajV0TdLdSDN0ra3Ow4hOQdtUEvLJvmhnBZ58G2GA24B+HI25qYadKwlftSlQOXyEQo0g9DMUvmlTQcpGELelUGS0u8t501UND+cZ/G4wIWXvBFyGnAVp5LTqy/A3rDE2PlKkqcmrMD/fezVRSrTke1Ag9235vUXDGF6HDsPQoIdNcjjf6KZIfsQHQgL3Drd/GUM5Ce8NaSK2n9UyOmaLUGpPAktkCRsr2QKyCSYR++ELv1GVFjb6ZCwkUvi1vO8cckRxwhSNGAlGWvLSVZP768U2e04qKYq5Qd06N/LNOOkIyRTspw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piuHyXxbwdw425eGOf9k+yjiqN6g9rFW75SW4RFIU/0=;
 b=3AfpBDn4l7iTqz0p3ScHvc7C4lDHd24kK/HSFGrT2YpIssN1BwSGz6+opR+YsOWIaq3uyq+y3oPsxKDCihQnkhFHJcHi/EiK35UrbH0KDTk4cFsMSVWVKQLFVSns1rraWo19YcMe6cjaGGxto7FjCCwpGeScdYPy9O9ZzRmzG54=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3982.namprd03.prod.outlook.com (2603:10b6:805:67::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Thu, 23 Jul
 2020 03:40:25 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b%7]) with mapi id 15.20.3216.024; Thu, 23 Jul 2020
 03:40:25 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/12] scripts/oss-fuzz: Add crash trace minimization script
Date: Wed, 22 Jul 2020 23:39:33 -0400
Message-Id: <20200723033933.21883-13-alxndr@bu.edu>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723033933.21883-1-alxndr@bu.edu>
References: <20200723033933.21883-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0057.namprd16.prod.outlook.com
 (2603:10b6:208:234::26) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR16CA0057.namprd16.prod.outlook.com (2603:10b6:208:234::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend
 Transport; Thu, 23 Jul 2020 03:40:24 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da03a4da-039f-46b5-99f2-08d82eba226e
X-MS-TrafficTypeDiagnostic: SN6PR03MB3982:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3982AC21EA3BE42766B2ECAFBA760@SN6PR03MB3982.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PkgNP1Qu4oYY7zllAFTrp7F3FYYgp8oEVw+N8RSpOvTN5TbuJmK1IHxkePQFHL6xp+b1uNZj2tN35KxwBZKPndQwElRYh63qBPsbWZhlXDZp5pFH2OfbJ5920ZpymV3KjrrzTTEbZIjmZtcZTOLz6FFwUCs0eJh/4KOcEGrRd3pPCAcWkNoBZoVeLqiXdsgiTyHTq3J3zhLCunJ+mVkr/sBf9SFI9DuQVimENOC4ECgYgPbOUs46//axUW6Pj8BiDzbx+o7J6G5b/f2pAs9oc2kOCZc1rOtSQ6wIKbKVajXyUf1FrUSDi77egPa2M+h9vcOdaqE+yFignTryc0iwAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(6916009)(4326008)(36756003)(478600001)(5660300002)(2616005)(956004)(6666004)(8936002)(52116002)(7696005)(66946007)(66556008)(66476007)(6486002)(75432002)(26005)(8676002)(16526019)(54906003)(86362001)(186003)(316002)(1076003)(786003)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 7nlR2iUA03eHdEMvK35k5nf8cqyonftcp372qYf6lxy2Yk6McAE3KVWXbIa++mYrUVeDKXswvJvc6aMJGMNN35R900tWD1cHcCxvB5EbRy7iRzXQeicM3d1VF7kBVPwOQUHOz5flLhCO5JUYxrfC0Vv5WOAf5CXc1ui6MFdfBQs8i/LhREG9Clh3w7WfmbJOCPWnYMOE4i8cTwFrdc+IFIykZIZMTKPWYCkg32DLifWgw+lSrnkfAg2oIC2tKIF0AjuxCzb7yxGDEgzgmGYPVyry5hNiezzJU4XjhTO12jTYkF0PEFl8vhjuaPoNJnmcz2iNMLhLyPRoMYTPq4AExGS0vFVoH6Gg0DiUt16R1Se3TNaCYs/XCgcd2hT5D7db6FkY5+AMh9/k2AMIb4BzhZdemC1abcqOujP358tPxQAeherJ0bDXyNG3+7yPRJGsaVnNLpc8v4SkD2oPp+DrLqYrIMuw/1xKzlKWGMd8fkw=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: da03a4da-039f-46b5-99f2-08d82eba226e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 03:40:25.1142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UqXIuSC0v1sXvWomrE3qXtqw0oHwEOUYXuOTepj1dlNrLAEIm0kEJ31FMmXZh/mr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3982
Received-SPF: pass client-ip=40.107.244.114; envelope-from=alxndr@bu.edu;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 23:40:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: thuth@redhat.com, Alexander Bulekov <alxndr@bu.edu>, f4bug@amsat.org,
 darren.kenny@oracle.com, bsd@redhat.com, dstepanov.src@gmail.com,
 stefanha@redhat.com, andrew@coatesdev.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Once we find a crash, we can convert it into a QTest trace. Usually this
trace will contain many operations that are unneeded to reproduce the
crash. This script tries to minimize the crashing trace, by removing
operations and trimming QTest bufwrite(write addr len data...) commands.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
I know its hard to make sense of this patch and the previous one without
a real example, but I didn't want to delay sending this set. I'll try to
find and old crash (maybe for one of the e1000e bugs) and show exactly
how I go from binary libFuzzer blob to qtest reproducer.

 scripts/oss-fuzz/minimize_qtest_trace.py | 117 +++++++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100755 scripts/oss-fuzz/minimize_qtest_trace.py

diff --git a/scripts/oss-fuzz/minimize_qtest_trace.py b/scripts/oss-fuzz/minimize_qtest_trace.py
new file mode 100755
index 0000000000..c318032049
--- /dev/null
+++ b/scripts/oss-fuzz/minimize_qtest_trace.py
@@ -0,0 +1,117 @@
+#!/usr/bin/env python3
+# -*- coding: utf-8 -*-
+
+"""
+This takes a crashing qtest trace and tries to remove superflous operations
+"""
+
+import sys
+import os
+import subprocess
+import time
+
+QEMU_ARGS = None
+QEMU_PATH = None
+TIMEOUT = 5
+CRASH_TOKEN = None
+
+
+def usage():
+    sys.exit("""\
+Usage: QEMU_PATH="/path/to/qemu" QEMU_ARGS="args" {} input_trace output_trace
+By default, will try to use the second-to-last line in the output to identify
+whether the crash occred. Optionally, manually set a string that idenitifes the
+crash by setting CRASH_TOKEN=
+""".format((sys.argv[0])))
+
+
+def check_if_trace_crashes(trace, path):
+    global CRASH_TOKEN
+    with open(path, "w") as tracefile:
+        tracefile.write("".join(trace))
+    rc = subprocess.Popen("timeout -s 9 {}s {} {} 2>&1 < {}".format(TIMEOUT,
+                          QEMU_PATH, QEMU_ARGS, path),
+                          shell=True, stdin=subprocess.PIPE,
+                          stdout=subprocess.PIPE)
+    stdo, None = rc.communicate()
+    output = stdo.decode('unicode_escape')
+    if rc.returncode == 137:    # Timed Out
+        return False
+    if len(output.splitlines()) < 2:
+        return False
+
+    if CRASH_TOKEN is None:
+        CRASH_TOKEN = output.splitlines()[-2]
+
+    return CRASH_TOKEN in output
+
+
+def minimize_trace(inpath, outpath):
+    global TIMEOUT
+    with open(inpath) as f:
+        trace = f.readlines()
+    start = time.time()
+    if not check_if_trace_crashes(trace, outpath):
+        sys.exit("The input qtest trace didn't cause a crash...")
+    end = time.time()
+    print("Crashed in {} seconds".format(end-start))
+    TIMEOUT = (end-start)*5
+    print("Setting the timeout for {} seconds".format(TIMEOUT))
+    print("Identifying Crashes by this string: {}".format(CRASH_TOKEN))
+
+    i = 0
+    newtrace = trace[:]
+    while i < len(newtrace):
+        prior = newtrace[i]
+        # Try to remove the line completely
+        newtrace[i] = ""
+        if check_if_trace_crashes(newtrace, outpath):
+            i += 1
+            continue
+        newtrace[i] = prior
+        # Try to split up writes into multiple commands, each of which can be
+        # removed.
+        if newtrace[i].startswith("write "):
+            addr = int(newtrace[i].split()[1], 16)
+            length = int(newtrace[i].split()[2], 16)
+            data = newtrace[i].split()[3][2:]
+            if length > 1:
+                leftlength = int(length/2)
+                rightlength = length - leftlength
+                newtrace.insert(i+1, "")
+                while leftlength > 0:
+                    newtrace[i] = "write {} {} 0x{}\n".format(
+                            hex(addr),
+                            hex(leftlength),
+                            data[:leftlength*2])
+                    newtrace[i+1] = "write {} {} 0x{}\n".format(
+                            hex(addr+leftlength),
+                            hex(rightlength),
+                            data[leftlength*2:])
+                    if check_if_trace_crashes(newtrace, outpath):
+                        break
+                    else:
+                        leftlength -= 1
+                        rightlength += 1
+                if check_if_trace_crashes(newtrace, outpath):
+                    i -= 1
+                else:
+                    newtrace[i] = prior
+                    del newtrace[i+1]
+        i += 1
+    check_if_trace_crashes(newtrace, outpath)
+
+
+if __name__ == '__main__':
+    if len(sys.argv) < 3:
+        usage()
+
+    QEMU_PATH = os.getenv("QEMU_PATH")
+    QEMU_ARGS = os.getenv("QEMU_ARGS")
+    if QEMU_PATH is None or QEMU_ARGS is None:
+        usage()
+    if "accel" not in QEMU_ARGS:
+        QEMU_ARGS += " -accel qtest"
+    CRASH_TOKEN = os.getenv(CRASH_TOKEN)
+    QEMU_ARGS += " -qtest stdio -monitor none -serial none "
+    minimize_trace(sys.argv[1], sys.argv[2])
-- 
2.27.0


