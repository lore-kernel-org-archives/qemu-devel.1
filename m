Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE261C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 06:17:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75A0520738
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 06:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="DEAkSWcB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75A0520738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8HPb-00068g-Fa
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 02:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k8HKK-0004L3-S4
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 02:12:00 -0400
Received: from mail-dm6nam08on2119.outbound.protection.outlook.com
 ([40.107.102.119]:43040 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k8HKJ-0001Ya-9A
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 02:12:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tj6PEN0GYT9389zSedJcJ5CTOuZzeV1GqBQ2bfjfc16jIgOmCHaltA9wtBhVlD81H2mL+OCfZlswpIozuy+qMSHaBaFImOU00Eg7WSDi8hZMHNypnu9n2IaMZYdj4UjlusguN3F3RFhGOonRNKBQjkIHSCeUVKVIZ6IsUSPa/P6zPaSpdPv75jlbQymXP8c7dQdwSQQGs2GQTZpY/HsrSSy0YbT8UKAsuucazkpCcnGxXae9kYLU7hfh3Dcswq7boSy7DfvHvTwUMILghnFumE3GXT7744WeeeDKTRPMJCZvej7tjXoJ/XF+RRUKOYFYcFVisF5ADEZxgXIG+m9SoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRhs2novFQWQnQokVQCeusPDfBEBhfeP1bRZh7zsdmE=;
 b=SQNLTrYXTAdmzxAL7UKvAKKTR83RkS1RR++GFQwHX56Gc2DLZqmmrb4FLoZG1A8jkBuC1MqTBr+rwKuKZ0Rg5eCPU+DN1/h+lUchIQi03Cu09tRO5HE4st8WJq5P/7kX/g7HUOrVJb9VeH9MWxNxa02f7UTouTvYTJkmCILAN5DQASNskriLEyD68MxJcHhEtbmzEZT8a42gFQMti7Lmb1Lq1b3B3KZFCHNe3Ts/15MgPfNTCpLsWQwFRfDjSBJrA/DOeNUfPup6vl787zVP3LkWisUEWs/3Uz1HU8H1z3eiGg0UGUXTDqouSkBtldQSTeFmRyLD9TEZ4Tsn/hO6eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRhs2novFQWQnQokVQCeusPDfBEBhfeP1bRZh7zsdmE=;
 b=DEAkSWcBWXTkNFMVjIcttA60QcFwGs9HsJw9SGGvGRD1mZTfWsRbtpGrqQ/Ww2jZfOxnknlY2+JLxnzx3mxZSkWhvDMtAws4NQr2LTsAfiwYGLSljYlFPePoQayGpXiBGW3d5V5AOHEcH3W7kwCXmFJ+PDXuzcYTlfLyRCm5IDU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3486.namprd03.prod.outlook.com (2603:10b6:805:44::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Wed, 19 Aug
 2020 06:11:53 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 06:11:53 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 15/15] scripts/oss-fuzz: Add crash trace minimization script
Date: Wed, 19 Aug 2020 02:11:10 -0400
Message-Id: <20200819061110.1320568-16-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819061110.1320568-1-alxndr@bu.edu>
References: <20200819061110.1320568-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR1501CA0012.namprd15.prod.outlook.com
 (2603:10b6:207:17::25) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL0PR1501CA0012.namprd15.prod.outlook.com (2603:10b6:207:17::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Wed, 19 Aug 2020 06:11:51 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b20200f-80cc-4a75-c0d2-08d84406c425
X-MS-TrafficTypeDiagnostic: SN6PR03MB3486:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB34869D1B23C00ED2B26BFD88BA5D0@SN6PR03MB3486.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ENXJwSSVD8Jk+0x0taAUEQlrMIZVmmOK1OxH9K13/usXuQW+yy0m5WxtBaD5hgBJarYQMDsF+zVHFq8/lfbMUb/0LEnSyz6DT8UdTx4aQy72lXQKyUjmCRR6rngSWWKfR6blBEHJ9qrQAZBogkmymICzbly/CY6k+6j0/dNuQZcR/nliXKHwPkOjMBIoxSwpzyUDT1qsNZhXRCkhJOTop60UUcyX93zoX6L+wkUdK8ttWqJ5t2vYnZq+fZkEGj7obYWPFR7zegdiJ+lNO7XCWAQttNrvEuZzfbig5C88YejU/Bp/sWSDYLJi03w+awou82JXcUAwpG7AVcEU1/cdnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(5660300002)(66946007)(1076003)(6666004)(66476007)(8676002)(66556008)(956004)(86362001)(786003)(54906003)(316002)(2616005)(26005)(75432002)(4326008)(6916009)(6512007)(6486002)(8936002)(36756003)(16526019)(186003)(2906002)(478600001)(52116002)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: rkTgH9bnjKP0GAzOC98/o5tlpAz5PAmUmk67EuzTyla7SRDBhv+19GMJHmxtLiGSusqzoXoBp31Im0sH0dedsyw3V0fxc9nRvGtXDJiz+NcyF9FPLz0P5SDv8lWClPDv2pUCnnF7jL0eMdc8sMGbdvrcKVHDXEj2zTRe5V9fWQDJQRh0PyasC/5tQWTyRbQ93TrnUwiMse+MLez7ZIScxM9HJIaI9cbA5t7ZuituskZkY8XGZJvAzSs/Ca3MPup7JF9Pz/Pds3hYk2quS4d4VzNx7H5mcWnFO1Tur7hMnDVKxoRtSrBqNMo7zcptBDASLZAH2MNBsfcINvG0/t4BylNJmE2ibIpoS93FqQ9J+9d4MOHPCW20AatCt5RqnNg7yeRLk8BlBJagrl9w/eB6N1ievt3g2IMfLC98/9f5/G/FbDuj2LuW5XWeHULk3UJbF6Wl55Tmd5hsrCfdz14WwtInlzbDLcry264MKg1Fo/IuATXhjJqYJW8joRkyaRJeBB20aTdUhRNjnnrZ7TJKkMVJxDNoxDDzuS71KgIoBcuq94vIr4F/g7wf3rlsjJJlG7Rzvc3YJerQE5WikA4ACaUg7n3FKhf2fEVX4V4WUEYFxlIPdQPR+DPEUzORGMflqKl0DoDRl0PseOzq5qTqzw==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b20200f-80cc-4a75-c0d2-08d84406c425
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 06:11:52.9313 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VR7ibrM/2pl+B3zj++UPRUwk6EFtokFQYK3sPAcnFJVEo5+4Pin8cCqVjjNwqYYx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3486
Received-SPF: pass client-ip=40.107.102.119; envelope-from=alxndr@bu.edu;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 02:11:44
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 f4bug@amsat.org, darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Once we find a crash, we can convert it into a QTest trace. Usually this
trace will contain many operations that are unneeded to reproduce the
crash. This script tries to minimize the crashing trace, by removing
operations and trimming QTest bufwrite(write addr len data...) commands.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 scripts/oss-fuzz/minimize_qtest_trace.py | 118 +++++++++++++++++++++++
 1 file changed, 118 insertions(+)
 create mode 100755 scripts/oss-fuzz/minimize_qtest_trace.py

diff --git a/scripts/oss-fuzz/minimize_qtest_trace.py b/scripts/oss-fuzz/minimize_qtest_trace.py
new file mode 100755
index 0000000000..2f1f4f368e
--- /dev/null
+++ b/scripts/oss-fuzz/minimize_qtest_trace.py
@@ -0,0 +1,118 @@
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
+    stdo = rc.communicate()[0]
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
+        print("Trying to remove {}".format(newtrace[i]))
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
+    CRASH_TOKEN = os.getenv("CRASH_TOKEN")
+    QEMU_ARGS += " -qtest stdio -monitor none -serial none "
+    minimize_trace(sys.argv[1], sys.argv[2])
-- 
2.27.0


