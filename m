Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B382C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:52:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A96752223F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="KLKrp7ag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A96752223F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT3fl-0002Xc-Bc
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 09:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kT3WW-0007gO-E5
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:42:28 -0400
Received: from mail-eopbgr750112.outbound.protection.outlook.com
 ([40.107.75.112]:30180 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kT3WT-0000kr-Pa
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:42:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnzRMn2AiJiP9B25sbvyg4e7w991keDReA2BhPQvrwfNvDV7gr+MjSjigGwRSnXYAoKeJYPKURlv6qLKOhLZdwA4P9KtXk3PspJVVnjKLCVBxA+EIx1n5+oSjX37IWev/e0+X17QCHLou+iiUjQSqswIE3xFA/IQP04cXqoxkZfd0LWJbdROhZFd7zV2QK/fzcRJbdTmoMrDOTo+imdhrQXfUBM4kdUHBbrK0fOrkAHEQR8Z08big9OBjdywLqscM+P+dsNV7tzRIaXWDKh7n51gmkoTUfiYNy/yM99VNmdWV7cIjCvD7kYKKCmleEhzC9PcdfvrTLxqauBmozQzZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEFUshzLvCD3WoaBe1HXg+kvAmJfN0iQC9/oKOMPCBY=;
 b=QSWplBEO14WM3IY9J3vc7fpzhb/rE2QBU7BuexnlotFFhlc8M4jl7aaqA9F7wNDGVSwVhx1iXQ3fgsj6bBoManY8LgTwENM+uAZTdMEd/6j2ZM0PtDjJsst0xzq+Clz4pBvI8rc6xAzl8ZloX5jeEBkLbf8eeMnmEIoNP9chCNq63LW6veTfMtfuVlAvFFVr59p+aETOOjflzRE9WUTFUpPFUEn6lc/Jqaiiafbr+UyE8YGGol4/PfnbhftYwE6DNsPjea3dmXSJRyXr1MhZqpX8tRjZpb8TVk+yxeYOSUD10F/f7lvOKz2BKQbhWghMUpM61WWkcmg5uA8MzFfR2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEFUshzLvCD3WoaBe1HXg+kvAmJfN0iQC9/oKOMPCBY=;
 b=KLKrp7agBYhm2tZ8UsJaoKjZ0NzUItBY9UyxcKHvxzwM77sq8+bwjE9YnfbmxDb6LLstOH4otSdhiZPK3O1rlzLoyfUHRJNkzNr7pP6yyDUOoC1YuEcdqtmJmM/nJUcU9tuNrsxX1EGm62KUC5mzy9SAAG6iSNDoWcLwpLh6nTE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SA0PR03MB5465.namprd03.prod.outlook.com (2603:10b6:806:b5::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Thu, 15 Oct
 2020 13:42:09 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3455.031; Thu, 15 Oct 2020
 13:42:09 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 11/16] scripts/oss-fuzz: Add crash trace minimization script
Date: Thu, 15 Oct 2020 09:41:31 -0400
Message-Id: <20201015134137.205958-12-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201015134137.205958-1-alxndr@bu.edu>
References: <20201015134137.205958-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [72.93.72.163]
X-ClientProxiedBy: BL1PR13CA0055.namprd13.prod.outlook.com
 (2603:10b6:208:257::30) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL1PR13CA0055.namprd13.prod.outlook.com (2603:10b6:208:257::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.8 via Frontend
 Transport; Thu, 15 Oct 2020 13:42:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7742fc98-b48c-4141-8e53-08d871101cbe
X-MS-TrafficTypeDiagnostic: SA0PR03MB5465:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR03MB5465D5EA81C4A4AD7812E788BA020@SA0PR03MB5465.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9XwjS3phOsO/tHMStSQnPa8cSb+GKs15nIHnBcLNcgA9Sikq4qYiQb2qoVUdoGIRi5hHNiOtd7QElND7yW1YhtREbzJCFGlviWckmaHE5teJOu18a/D2RzgJJ8Q3vE7v/zbq7vfP78AgOtYDvotSyHbQNsXeBvQ3zsXPuzIoOWaIWCGhc0LfW9KCpdPUCkhNQ4JpUdJBPNvameDY9fq3Lq9KHpPYPE8wYeuyNRzxfAPMF/WfLf/1lODYcksq2cK5La6xnMzetWT5JFmtPUdtEl8n8KaK4AGreQL7hKlYwmimPiHX45QVf1HwO9LN88KKQQLLda6a3PqaYkMASWi9nmbjgxye5SYZD4eF+4UMwY2qJOcEOXeLKtZN5tZyneKd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(5660300002)(54906003)(2616005)(8936002)(34490700002)(1076003)(66476007)(66946007)(6666004)(83380400001)(956004)(4326008)(6512007)(6486002)(8676002)(75432002)(6506007)(26005)(6916009)(52116002)(2906002)(86362001)(186003)(16526019)(786003)(316002)(66556008)(478600001)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: A6n8foDwuxo25GJ43qIu+535KhVdH8ZFvrxYsiHgqs0M6SikCq/Lbi1ZVSGs7oJzoU8CeCWWKYBttq9ymYBcGbvJ2+nQWH+fW1q1KQWSSb/YrqKQ7V65DyffxW5hnBRPO04OWRq09yAMZW5GyCDGYzBduB9USPY293bfDsV6rcO8V/io9qkT13Trthtn98QSFN2sIcN8g+2db0A/30FRZeWmZ4vTACj7pde8BXDaph8cwtQAD8sDh4zd23/5EdUyuKbEPVpnFxfSFOO0gLpUdseASTH/EnArGZcZ59YXgA5kJngFjqfI8A2TeGK65pTfOxvOIOyY0M6NtpT1Tf5ARq88PbIeAuNHqCSak7yCS2s6ZYg2QJs4s6Q6Htf+OCpn6XmNQnIn6hn9gp6c2tYAXbcr9So0HnuRv/CZoP5Ss1h0nk+jhmRnkLoZZ/Bn8x21am6AeUB3DzXjvP83iMYNhIy+/47yCDEQFbYd2gE6BVG6C5fAZe+vFb9GC1iQQUILfnWofvHPf10BF0ZiRDfs/OXC0Jk0tUelykNeMJqWGr1MfgREA8WzjcMRcaz72MFmGp29P2HFbCtTZVH0Gr7OGTcmswQ3UuzKpMdYpt9O4lY34YmUBs+2l3dLz0XWsfcgI3PFsDuQhxW2pkm9lQ3PFg==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7742fc98-b48c-4141-8e53-08d871101cbe
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 13:42:09.0639 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0K16U5QnDIaYTiGNHL3Q65FJJa/bo8IPpfAV+6BEjvuIkl19uyoh/xX6gHL0bhf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5465
Received-SPF: pass client-ip=40.107.75.112; envelope-from=alxndr@bu.edu;
 helo=NAM02-BL2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 09:42:04
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
 pbonzini@redhat.com, dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Once we find a crash, we can convert it into a QTest trace. Usually this
trace will contain many operations that are unneeded to reproduce the
crash. This script tries to minimize the crashing trace, by removing
operations and trimming QTest bufwrite(write addr len data...) commands.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
---
 scripts/oss-fuzz/minimize_qtest_trace.py | 157 +++++++++++++++++++++++
 1 file changed, 157 insertions(+)
 create mode 100755 scripts/oss-fuzz/minimize_qtest_trace.py

diff --git a/scripts/oss-fuzz/minimize_qtest_trace.py b/scripts/oss-fuzz/minimize_qtest_trace.py
new file mode 100755
index 0000000000..5e405a0d5f
--- /dev/null
+++ b/scripts/oss-fuzz/minimize_qtest_trace.py
@@ -0,0 +1,157 @@
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
+import struct
+
+QEMU_ARGS = None
+QEMU_PATH = None
+TIMEOUT = 5
+CRASH_TOKEN = None
+
+write_suffix_lookup = {"b": (1, "B"),
+                       "w": (2, "H"),
+                       "l": (4, "L"),
+                       "q": (8, "Q")}
+
+def usage():
+    sys.exit("""\
+Usage: QEMU_PATH="/path/to/qemu" QEMU_ARGS="args" {} input_trace output_trace
+By default, will try to use the second-to-last line in the output to identify
+whether the crash occred. Optionally, manually set a string that idenitifes the
+crash by setting CRASH_TOKEN=
+""".format((sys.argv[0])))
+
+def check_if_trace_crashes(trace, path):
+    global CRASH_TOKEN
+    with open(path, "w") as tracefile:
+        tracefile.write("".join(trace))
+
+    rc = subprocess.Popen("timeout -s 9 {timeout}s {qemu_path} {qemu_args} 2>&1\
+    < {trace_path}".format(timeout=TIMEOUT,
+                           qemu_path=QEMU_PATH,
+                           qemu_args=QEMU_ARGS,
+                           trace_path=path),
+                          shell=True,
+                          stdin=subprocess.PIPE,
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
+    # For each line
+    while i < len(newtrace):
+        # 1.) Try to remove it completely and reproduce the crash. If it works,
+        # we're done.
+        prior = newtrace[i]
+        print("Trying to remove {}".format(newtrace[i]))
+        # Try to remove the line completely
+        newtrace[i] = ""
+        if check_if_trace_crashes(newtrace, outpath):
+            i += 1
+            continue
+        newtrace[i] = prior
+
+        # 2.) Try to replace write{bwlq} commands with a write addr, len
+        # command. Since this can require swapping endianness, try both LE and
+        # BE options. We do this, so we can "trim" the writes in (3)
+        if (newtrace[i].startswith("write") and not
+            newtrace[i].startswith("write ")):
+            suffix = newtrace[i].split()[0][-1]
+            assert(suffix in write_suffix_lookup)
+            addr = int(newtrace[i].split()[1], 16)
+            value = int(newtrace[i].split()[2], 16)
+            for endianness in ['<', '>']:
+                data = struct.pack("{end}{size}".format(end=endianness,
+                                   size=write_suffix_lookup[suffix][1]),
+                                   value)
+                newtrace[i] = "write {addr} {size} 0x{data}\n".format(
+                    addr=hex(addr),
+                    size=hex(write_suffix_lookup[suffix][0]),
+                    data=data.hex())
+                if(check_if_trace_crashes(newtrace, outpath)):
+                    break
+            else:
+                newtrace[i] = prior
+
+        # 3.) If it is a qtest write command: write addr len data, try to split
+        # it into two separate write commands. If splitting the write down the
+        # middle does not work, try to move the pivot "left" and retry, until
+        # there is no space left. The idea is to prune unneccessary bytes from
+        # long writes, while accommodating arbitrary MemoryRegion access sizes
+        # and alignments.
+        if newtrace[i].startswith("write "):
+            addr = int(newtrace[i].split()[1], 16)
+            length = int(newtrace[i].split()[2], 16)
+            data = newtrace[i].split()[3][2:]
+            if length > 1:
+                leftlength = int(length/2)
+                rightlength = length - leftlength
+                newtrace.insert(i+1, "")
+                while leftlength > 0:
+                    newtrace[i] = "write {addr} {size} 0x{data}\n".format(
+                            addr=hex(addr),
+                            size=hex(leftlength),
+                            data=data[:leftlength*2])
+                    newtrace[i+1] = "write {addr} {size} 0x{data}\n".format(
+                            addr=hex(addr+leftlength),
+                            size=hex(rightlength),
+                            data=data[leftlength*2:])
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
+    # if "accel" not in QEMU_ARGS:
+    #     QEMU_ARGS += " -accel qtest"
+    CRASH_TOKEN = os.getenv("CRASH_TOKEN")
+    QEMU_ARGS += " -qtest stdio -monitor none -serial none "
+    minimize_trace(sys.argv[1], sys.argv[2])
-- 
2.28.0


