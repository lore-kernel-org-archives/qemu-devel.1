Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96568C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 01:21:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C14A122253
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 01:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="xpd48baG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14A122253
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV2p4-0003ec-NO
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 21:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kV2cK-0001Jn-1i
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 21:08:40 -0400
Received: from mail-co1nam11on2130.outbound.protection.outlook.com
 ([40.107.220.130]:28640 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kV2cI-0004s9-5A
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 21:08:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWuYGCY7ZTx09R98cgPfGEi4H8R2ICp48lgMc1p16S1XHqDi0r3Yxz/yY+6Y6IE1Cx2iybKMCmIh7Vf/P7StmBuu/7W+ly0kcGPr0ej21VIkrEVYXyWqYZqTywDwjfGKtcUGvWuyrLoNuFi8oXgeHWVbKJrswhVOyy8u+igDYLl210a8/mO1DktITcsl28U1uR4/OxeITNJ2QigugeZwMqBB3jg9TDWUAm2rxKfV7olX86McwT/JQM4f32nr2ZLVtUC36Srrbj59igQjQGH7CaEpU4HgxTNYUZl/Majl4BylnUnzJuf6fTKJiBpC4Hx90c/87PQT1ymIi0iRuw2J0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEFUshzLvCD3WoaBe1HXg+kvAmJfN0iQC9/oKOMPCBY=;
 b=Lil/NSNmxE97g5YLVRBRnxMli0WMyrT0rmEmQJoTlgSxPQK6Ts+3XQVjv7yQmUM82oDZAHOwvPasYXL7wWYzxTOSUe8lvhMLcpiP6MEt5US1caNUGegE4nAtFRFBwSySwV2Q7gjWehntaaJVaVPG8bjpFRAV0ONQIsMJ+0xF0G4RdGk6u3lOQv7AeQsNQuMT3jlaLQLl68o/dZ9GS4czh1ZD1jECylKpeYDAd+Jb2eyAmmZUfgVe0//sCVckSWjxqrndRyL8Jc8oS+9vJFXYEWp+rQgxN4biqz3cnzPA5SJSBmcc0YK+dtwNXqGUv8CO6rc1MQo42Aw/D83CizPm7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEFUshzLvCD3WoaBe1HXg+kvAmJfN0iQC9/oKOMPCBY=;
 b=xpd48baGUBvtyBmRDIOs6TsdEztyNFBdZzXjs3RSaWPCGA0UQU7gRRQiyyc+pYDIYlQmgE1MQYzhW72Y33HAmomPLWG5GOVw6olJdcMahI5gwnXfIO5YbjodnptHKSzawzMRaWlJxi1uVD3DsmFKvL+95DKi1ChqjR1hnLEDILQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN2PR03MB2333.namprd03.prod.outlook.com (2603:10b6:804:c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Wed, 21 Oct
 2020 01:08:20 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 01:08:20 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 11/16] scripts/oss-fuzz: Add crash trace minimization script
Date: Tue, 20 Oct 2020 21:07:47 -0400
Message-Id: <20201021010752.973230-12-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021010752.973230-1-alxndr@bu.edu>
References: <20201021010752.973230-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [72.93.72.163]
X-ClientProxiedBy: BL1PR13CA0119.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::34) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL1PR13CA0119.namprd13.prod.outlook.com (2603:10b6:208:2b9::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.8 via Frontend
 Transport; Wed, 21 Oct 2020 01:08:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3274f936-93f2-42e0-b5a3-08d8755dccf4
X-MS-TrafficTypeDiagnostic: SN2PR03MB2333:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR03MB233354B0253151D0C5972C02BA1C0@SN2PR03MB2333.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ltX7EEx3bBjctky2JL0TeQd9VJBqtbqDXeagBkDAQP7NkJWfXNP5eeXmXQA0yWA942PlVkQrQxxwvx2j270japRbHOjpULOayabOED+n84N85rvY8DiGc6YbkoUZ6igSvXqUCrGMLHqjifPM/Rglf6qr7StKdl7NqlpHVQJ9Osag6XLIopT+WNDXq62ub/mVgFCLe/xk5JV0gM9ZIkG0mLQBpMpndHyU6Np7mlT0mtPWjLiMtkm56fBoGRieDLSjNd5FQ1QlxoX9ZSonmFxGpDKVtl8d710HWUSrKRfI2V+vgzpwV2YIWioZzMH6mLEge0XhbsCYAZLuZB/o2eeAtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(52116002)(2616005)(8676002)(6512007)(6916009)(6506007)(36756003)(786003)(316002)(956004)(83380400001)(478600001)(1076003)(4326008)(6486002)(75432002)(8936002)(54906003)(86362001)(5660300002)(26005)(16526019)(186003)(6666004)(66946007)(2906002)(66476007)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: t4rPtQO0umox/sAO8WzFYqFMNlrFdPZAv+pw6Gzq0OuosmaThkaWE3Jh5Nu8CrqnvTaZ213qyzokwoBTTMlWStmmoazilpZ9Jf0R9jt0FsbX2qsYqcxkN6Alud/cEzcT2xjdu5WWbEDLB/Zjt5CGN0Kn5o76/Ju43DTAN2X76C1uc4TnYzYCezholprWqjqHrjKUD63oI3P5u1LvVz6OAvjCTTmySYfO6KtICHxSz0YIhkziCzkhkIGu0LqfCln79SNwtNksFGnOfpxAjp5Fk7/gzAxUSNYdp4UvYMH6ZAJ1ocxrqPAkmLZTSS+Y4s5NBxw362c/jITTBGKP5Y9bjrU7QE4Ox8JhlQv9G33anR8y++yWLJbjLitmjM0y0aXe50a61GgqdhhsPgsAXIHPMvdAQaS8KZw29LYCsAmJbnQZGakZJziitcJdAhRKPKR0RlPn98CDnLp6JA5O4cSlrrBCCckuimMr5c9YTF42ToUe/uuWjHze59uZ9OQfPHIqSmF/2WSP4EXgfedHzaEFH1Pmv84UeGxlxUeVWpRlI5rb/wffKJMtsuesbWaq9JHhWNNyqCZkNNNgF5Luy8Z9Z18R5UV6LCFUtlnfFlSBHyiuQB/8c/4m6FgzJ3gc7rBlX5mxrcUXKZyIjfIvbwNJ2Q==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3274f936-93f2-42e0-b5a3-08d8755dccf4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 01:08:20.5761 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JF54VCzAgWM+edGb9KgfmvibwXwMBcp6dKryM63Ihi702HVa5YARv5eAg3tyXviy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2333
Received-SPF: pass client-ip=40.107.220.130; envelope-from=alxndr@bu.edu;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 21:08:14
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.441,
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


