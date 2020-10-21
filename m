Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51BAC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:21:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A34E924198
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="jv5OnELh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34E924198
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVLYA-0005C2-Io
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 17:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVLN0-0003s7-Eh
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:10:06 -0400
Received: from mail-eopbgr690121.outbound.protection.outlook.com
 ([40.107.69.121]:59894 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVLMx-000854-FH
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:10:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1ns0SXcpTQuNSbxy+EDmcX2AI08cTcNRCg4IcGGuzMLaMnoc/dJss/NyAADcZ5Q5/j8DnT/56G6tjWS5fUOSUeMXj2U3e8lAKS+j1Eg8l1F1BI7GRfdhcUso4RoRoePx1dy2iN3gXYm0ApBg3BDrwwHxB5x+tRcC26khTJslrgHukx8w4CxaAucQ5DNlbEOz/wZKLeH8sY7i65I1lxxZUpBx9fja7Mwb6BUWAXqT+XIZ84h8xlf20+Nh8uW5i7lz7EIeWpsGastmUWhPzxx515rLgkSs9vJE3yv7wxGawKAT/vGyvpBukU97C8mrGTT928AX+lXTUoP/L0SsZQgHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEFUshzLvCD3WoaBe1HXg+kvAmJfN0iQC9/oKOMPCBY=;
 b=PfCjRvO5dWo6w8rmj2GOemCET8su2yi8elsQQcNhtfyFldmkoK/NY6i+flyLMHk1disZUY4UnCoGjPlH0vErdtWyoTZwhe7Bk5hwob6hDZugATGN/njmGfCRLunBZUSStvhRYoSmr6zHNT1xAPIlAeikkR/zdeoPT6R3DvHstMxgwhjjacIAeYz0meWCpjZeNkcG7KVZmmC4w3vK9wny/ah9mTgHIq3lOnweFsC/UE0HHOXEABKoVl4ACpu+pI2D3BYfWOjDRBrPbtAE/X/Kq5sO4cEmz3W00on0eGDQGbPM/aZHfZUQ+GT5fvqxv85BA6Jdv9MrindwyPCG8R2efA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEFUshzLvCD3WoaBe1HXg+kvAmJfN0iQC9/oKOMPCBY=;
 b=jv5OnELhG5vVWpURyM6IupZ5MkyjL4dMTkj1ma/FVL9D2WrJ47Cbg/ky2c50maALD5P568bkKLsbtf8BAfIiTDtbTj3oeLkbFYzxrOW2b1tsbdY4NS5uAhFuzEIGcNPWcVcG1KZJqYHCYqizuJzjhXTr7yTTzg4HT+VsHN0KYDo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4045.namprd03.prod.outlook.com (2603:10b6:805:b8::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Wed, 21 Oct
 2020 21:09:52 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 21:09:52 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 11/16] scripts/oss-fuzz: Add crash trace minimization script
Date: Wed, 21 Oct 2020 17:09:17 -0400
Message-Id: <20201021210922.572955-12-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021210922.572955-1-alxndr@bu.edu>
References: <20201021210922.572955-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [72.93.72.163]
X-ClientProxiedBy: BL0PR0102CA0064.prod.exchangelabs.com
 (2603:10b6:208:25::41) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL0PR0102CA0064.prod.exchangelabs.com (2603:10b6:208:25::41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 21:09:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f8743ba-9208-4158-4890-08d87605a673
X-MS-TrafficTypeDiagnostic: SN6PR03MB4045:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB4045C757A76BA517516188FFBA1C0@SN6PR03MB4045.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KkX2YSJo3v/vV1OFOxmRWbU21lUfpF8SucjwnsF1na4/ApdMUXgstYHmCo7ZZ+5NDNdhO8dMnuXhzDWwG88ptqkQAFaBejsJ+IZmgo5k7lhtCTtKUla3kxzJqTrWI+qRMEH2e6s5M3+ZppCCmpt3D15cO7q//gaj/6NGtqQiMZAWo3E3IvxwxcIrfv4LQ/43OudgUlZr7R4/MRLiCBthNzOzgWAsfr3bC8CNlLN2dv0PoAnOLCJkEWh3cOHKkYHvXosqHJS1Tqnm3ow0zKpvwL9fQVb45CewNCPbzzMDZJGKXL9fqzGuB8bgrXOgRAtkPEAwVFdSExpO3pY4U9BIuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(83380400001)(86362001)(6506007)(956004)(6666004)(2616005)(52116002)(5660300002)(316002)(75432002)(54906003)(786003)(8936002)(6916009)(6512007)(16526019)(36756003)(26005)(186003)(478600001)(66946007)(6486002)(2906002)(4326008)(66476007)(1076003)(8676002)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: JASsFSwMZ6xLAnoryZldX6eOcp+qolKREKQ1Lxx6J65NteVW8ZOTxuuCxJ15HhaCSpxZoqDIDgns4qeynsL1e6RFttiqvxIlyv20rGcOoErGwj/aYBep2m60cvCsoIcRDTrEPmZ2GWUEvWpKyMlbekmWB9EMGUkyQK857ZR7gPhbbO9AhuB+xkODRHCgSSDseSvrcMxNmR0XJGug+4w46UlSN+T7g7L9lSCTn4g8JS3yg+5FkH9mxDwdE2pyYTl9puLCh9LEdZmfFnylZ89Dqd7RrLSgi6alrGb2j74eo0X4UwwChN3Y6xe62g5LFB0KFxPGcmq8qTpGYwT+jZVdMyplzRPbIonQfSyV1FDFfJc3OK7bMDzxUQkYaCEw6hWOQftQ14j96O2TP5JGKNwQcmwSR/RC+P6Mc7rhv44Uy/8cdut/1qGUwHdqfZ/5trksQaC5jX50NIIWwrGCSIDi1BtbpqCLPI/fZkhkAM254Bh7txE3w8N5wDftKZHLZW/QsVyTfSLxjgzSBAKl7p9+HCr49JR9+jvP1zZOHqlP3KVS/lYmbkC4wTFMhpkw99IUT9/thtbUvQpVmgY6TOsw8CCsFfpFESX12WpXykxviGAFvTlkuOvkjhPi0fBM1ru1NOelK0js1TfGMmZQQbAZ0A==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8743ba-9208-4158-4890-08d87605a673
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 21:09:51.8528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /yuswq9e09MIY9fuNgbtqmhvbyzyVfXG+MC8SZLwV/g+drnSXuMke72PJ1RQtk4f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4045
Received-SPF: pass client-ip=40.107.69.121; envelope-from=alxndr@bu.edu;
 helo=NAM04-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 17:09:54
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.454,
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


