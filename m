Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F69C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:13:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5658208B6
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="pJOBGvDY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5658208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVyl8-00023s-NN
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVyg0-0003t3-Ab
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:08:20 -0400
Received: from mail-bn7nam10on2139.outbound.protection.outlook.com
 ([40.107.92.139]:64992 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVyfy-0007AB-Dj
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:08:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=feKwHl4AQ9I/pIs15ID59GlPmcQhafO5O11jX1yyCYGnrsCzU9GDOdiYuLuismSgD9fA6dvEJyaWSkbmQ0tWWoIgAf+G7yLI3GInfOwlQ/RCAh3vMQEx63r+WtWr3aCmrQ038C8wOwVhPccM0zbCJNWIWk9cs9817bcXMt3E/dFiGvG1oP7tmJMWk3ehbO+PIoAM147nPZcl0cBtvFR5E6PZpHFhFkcjZy4MyZ41FVfVg1XZjFBsKLCOYR9XhRcw+UvzZdeUepkdjow4Jv48FLa/b3URgNr+bX87FhsHM3NtLbZymIqWe+5mmnKmiwxtSEwnB5HPFtTzjZNzeBvtlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEFUshzLvCD3WoaBe1HXg+kvAmJfN0iQC9/oKOMPCBY=;
 b=esYDQ+yH++FHDqLUoL3G9yF8fTWCuLAdP7AheGfxkDsFYH2Sr/ImoWN3rTOid8Qcp8bn/8MR5VyJorsUlsGXrxGuzLY55XSrIGcRhXp80EHGduMUpl/qwhEL7CRyyvv4mjI5mv+LJuXlzBk1MNJnBYt2KHf4Fd6oiiCoS59NsvbFjvYYL9Sw3NBNHLgB2zk5Ix7ADzAqbEWgBLinswID5ATx3MFBCawwQQzkvbL7djJBLJ2aQpr/pP8c4dFlxs3P1XswceR68r3TXUl7hyJ/pS/UvY7GJHsstR300ZUgMSuKsBPn63zex2ebcJnziKHbmdd8kf6GZzwrrZNlMv79Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEFUshzLvCD3WoaBe1HXg+kvAmJfN0iQC9/oKOMPCBY=;
 b=pJOBGvDY1eGIirvH5CivGG06cZAjOJLMcsr/467HWnTc2lTSXN46joqQNiYxesSGEJvz36+O+xHQWOWVbKUKhvmfQ9pQpae4w2TTJ2dMkODtXZNESFEFQeXa2YK2L74KxA0YnVACCs1x0qJ2+Fm+PNdo+lDeO3Qk5QBohylB/ms=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SA0PR03MB5516.namprd03.prod.outlook.com (2603:10b6:806:bf::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 23 Oct
 2020 15:08:12 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 15:08:12 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 11/17] scripts/oss-fuzz: Add crash trace minimization script
Date: Fri, 23 Oct 2020 11:07:40 -0400
Message-Id: <20201023150746.107063-12-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023150746.107063-1-alxndr@bu.edu>
References: <20201023150746.107063-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [72.93.72.163]
X-ClientProxiedBy: MN2PR01CA0065.prod.exchangelabs.com (2603:10b6:208:23f::34)
 To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 MN2PR01CA0065.prod.exchangelabs.com (2603:10b6:208:23f::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Fri, 23 Oct 2020 15:08:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f34b559c-9858-4c94-1723-08d8776575d2
X-MS-TrafficTypeDiagnostic: SA0PR03MB5516:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR03MB55166698BAEDF5D0BFEDA6C2BA1A0@SA0PR03MB5516.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: loTf01Pq0dKG/d5ml4kNQu+jOnEk+UILGjbTMmD4QRfDQZMmBIZseeVAiOJCDt36h0v6bcQV/FuWa8by5dmJjvCLr/No6Tioctunudqo1c2fcAcA+wbuEZMrsGsaE6UU40qO1s2v3rh9fB7bQwS1NFwwaMu/+d5Y4CP6MS7/34yUccA1Sku1lch7cVRTklnfeCGFIbYxN5tM70vLq03xJCrk7OgL6bWeqXgGERzBx5u/+fbAUmifgDhVNc6Eu5XMasp0YsY3md/lI+nsMXQdOjMgoa9KQKwUvUE5x+yN5EbswxMK70TRbF6tQ3JWV65GyqaHDY23Z4TeQq97J3isHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(2616005)(4326008)(1076003)(6512007)(478600001)(5660300002)(83380400001)(8936002)(8676002)(86362001)(2906002)(956004)(36756003)(6506007)(66476007)(6916009)(786003)(66556008)(75432002)(66946007)(52116002)(6666004)(186003)(26005)(6486002)(316002)(16526019);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: mpvV3ZXZABem/WIQl+GnDn2bjnpADfDyADs19jwOmUUvccxZfDvTj+yT+OOkmoYmGOHO55KJJ81il/mS8olorcsyyP+owz1AhACz33QyCLEHgIVLYCuNnx2UeF9mKBluhmwOW5rpC9/fdY0SQiyIk9HHRb6HgDvMDyQwpWLxsB3IidYzvVKRNpNDgkXGYrj7eI/GqvLS+Um7donxukBZxjqWlTvPkacpfPZfw+WVhRfc//+xZheFuZ56zEYMXbzdu51dobmmXnN/BO08J6CT5Au4pTWdufm7vJn1U9vnO/KrHnfgMVygxPzo9pp0w8PRBQah/bTv71kg+xjWlaza/tXgM15WA31EmfPAXUOpGJQAEC8hrvMLB6DYY/gKOI1QTunq+1JHuKRLSpJpiqAO91aLA00b3HJ3/9dU8egsIWkntVRzNrQWexwU7RvgKd9D7ckRwt8BSFWtkLYxFrF2c0iso5lj1CBioV/YXakrDcJUjQpZdlqI12KaqvTbm85FUP0beuLk/cM8obm0OFrEoGY92KE1hkLxqSe21mjrNNbKGktsiLJYgymwtrdmlNSAMWAvtsqdAFiPHwj7+0NRqG2ieWMk2MHH/SudKzz1WaKnjbqBqBIngXaBHt6ghkCF7hYQqhxhIlrttlQpzYU+fg==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: f34b559c-9858-4c94-1723-08d8776575d2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 15:08:12.6679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H84UwE5HdFthB6mvAcOYJxC67Rpl7cs5LWl7RbZzfVOlMvjSd4NWYO0uLfkmp8CJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5516
Received-SPF: pass client-ip=40.107.92.139; envelope-from=alxndr@bu.edu;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:08:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.63,
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
Cc: thuth@redhat.com, Alexander Bulekov <alxndr@bu.edu>, f4bug@amsat.org,
 darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
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


