Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A60C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 06:18:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A8B620738
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 06:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="qUa3wlSF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A8B620738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8HQF-0006x7-Se
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 02:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k8HKJ-0004IC-1r
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 02:11:59 -0400
Received: from mail-dm6nam08on2119.outbound.protection.outlook.com
 ([40.107.102.119]:43040 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k8HKH-0001Ya-5O
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 02:11:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6Yx/XrmB3PrpKpKD4zfnIRXjuu2p+/1lh8s81N3jDwcc7HqEI4HkDQ7k5ZLoNkwyQBx85ABoj3qxSEsp9WUGiYx0lGufcQtCXuSybUwFEf5LrphVmt+h5QeS4frSUu9WU91SDFifzhl53gUbsg/T5w6Ek1UjmIDjAx6z7IO+rGdrQ/iXSbLgfau5wY++L1G4tcssgFkggCZDSLu9xQlYSn0/EE/2+1VkHEjDnMKN1+sCmwAtXOxQ3gqNQ4BYZsey/vasd9VFiNWa1+cADgd1aM1zxsn+iCNw/37OfL84eOTA5GU4JCG1RrvB+2H/TBMOXufDFOy0noxbqpTF1L/sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KM79cPkTvUzrM+zvLY1mMAUOTr71w0mWHKq6fqwQWw=;
 b=JJqzjwK2t+79Bo8d7WB4XFGjo7oVQBACwrI+ddwTQVx3zEvNJLoUVqCEKpD7EC0qYuNhXtb0wsL40VCwIcjy3PxRKNq8Yokn7x6avu3n5G1s3IbZSMj0jMEvpJw/MqJyv+0PrmS79JwyEDZE9txhhforK2mMCXYQwef5gssYvdj7bpVQbqTZjj0kp7jyWbzTuGbpUWgGyx9FWio+0qI46gE6iazXEFTaJkQ4DsfctpphYUx/GeuYOn67m4/P7Sj+SW09czwCYKHksDpE2eSiyo7DjxfH2EMbXsY0JpJiWLYhjwgPIjHkLx+sulHxxBhKHr55L2zUlDYA99xjUaElIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KM79cPkTvUzrM+zvLY1mMAUOTr71w0mWHKq6fqwQWw=;
 b=qUa3wlSFnwbCMSIa0i7WdkwTwBAcWDWaK7QfSkv+fY84+w7PZtQk60xDwHMAACIDomrHQEEGmxqPATQrQtIYlf/BARkzL4+1U9OoS3wPIRBxKGzUFMdKFLaRiRBfOo8UyOuoBxKhYZfMFzGhKP7pRVcKWH8OY1X4yTWimFInJDQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3486.namprd03.prod.outlook.com (2603:10b6:805:44::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Wed, 19 Aug
 2020 06:11:51 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 06:11:51 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 14/15] scripts/oss-fuzz: Add script to reorder a
 general-fuzzer trace
Date: Wed, 19 Aug 2020 02:11:09 -0400
Message-Id: <20200819061110.1320568-15-alxndr@bu.edu>
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
 Transport; Wed, 19 Aug 2020 06:11:50 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0c63674-3735-4ccc-4c69-08d84406c35c
X-MS-TrafficTypeDiagnostic: SN6PR03MB3486:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3486E66A94BEB2A7CDD1DA28BA5D0@SN6PR03MB3486.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2xQVtJOj+gNJ782IzijDZRkydV9CdWJrb+40nPmXoSqODv4d8xUlpsRe0BtBC3BxVN0LPy3exdOkcj8ohGrke+n98MDAXDvDLjv6GUoexP/x479WYh3qtfstAMRyHZDlWcntE0B09VL2OfMN169TH5ZROrHipJ+FXtPQ23mI6Z7m0WN19F6ahHAl+19HY1tfLOKRrkQUWcBNjh/5L+Q/RMC0D5w3LvQQUK/5HW+s6ZDQv3QTZwufxF6etUkpfuJdETEr8BDZHavL40Ol0TixrYVa/VJ78BS15OWrTwKxgz99lkLmdtO7bBgQE/8seDPS/UjCVEiTEdrAKZiPuSMLKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(5660300002)(66946007)(1076003)(6666004)(66476007)(8676002)(66556008)(956004)(86362001)(83380400001)(786003)(54906003)(316002)(2616005)(26005)(75432002)(4326008)(6916009)(6512007)(6486002)(8936002)(36756003)(16526019)(186003)(2906002)(478600001)(52116002)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: RY1qzlb4O7BNvljhlAtqc+MPWPaUses6oRI7/2tXT/cH5krkA4O0Hp14j45p+WmHW+Adv/mT84YGsLD/Pf0VCHrmPC3MdJqwqjdFWJ9ehxK5sjqitlukmUttVNzgOQU94T0yKc+hsLsiqVBXBsct8S6mqCLlJjaoJ2Sk4d7YWmAzbhRmmKQiKIRnxlKuIWkEIU3sARvTemxceY4B3x8sLjJPdFwsMEIlfmEqB3q4z3aI3LLtkgyEi19isIJdn6cZV2btI9/siSfYFmQhn5RTqVd+uBLYRokuX/MzPRuKaMFukMqDVaE3Vl6mfuz2zLiDWA5NhmJp26UlpqFShjWBTm0ZPNeoJbGOFbz/PUMS2E9ffkzXacH2MV2mRma+797p1ZJlYTXj79ZL+NvKAAqG5utf9bua07ml/iPw7W3Ib3Jhtq1nG/Jex5At/ssb8UvZRcfsjGhKIoizk3ku0W/9BhlttB+7HFYKhzVgCg782QgKirDR1NeeN9OiQgNdtsCkN2LYG9Hn7SSDQT3nX/aPaazTPc6avgI3ogwIZ7QmlzxvF/frTgMcS3r/S7grsFZ8jt8o7hSyd4GBh3U7GmczyFOdsElunQ1CrgxVJZjdOQBc9ECUIljaHzfO5fIjMJ6IWE/kwxrKAQb/AIqZXBUf8w==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c63674-3735-4ccc-4c69-08d84406c35c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 06:11:51.5361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dS/WMfl2u+xLsTeZlZji/0S9nBoENYaothUZt0ZBf59FQ9xJ5KJCttnILDSbPLGl
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

The general-fuzzer uses hooks to fulfill DMA requests just-in-time.
This means that if we try to use QTEST_LOG=1 to build a reproducer, the
DMA writes will be logged _after_ the in/out/read/write that triggered
the DMA read. To work work around this, the general-fuzzer annotates
these just-in time DMA fulfilments with a tag that we can use to
discern them. This script simply iterates over a raw qtest
trace (including log messages, errors, timestamps etc), filters it and
re-orders it so that DMA fulfillments are placed directly _before_ the
qtest command that will cause the DMA access.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 .../oss-fuzz/reorder_fuzzer_qtest_trace.py    | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100755 scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py

diff --git a/scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py b/scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py
new file mode 100755
index 0000000000..9fb7edb6ee
--- /dev/null
+++ b/scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py
@@ -0,0 +1,94 @@
+#!/usr/bin/env python3
+# -*- coding: utf-8 -*-
+
+"""
+Use this to convert qtest log info from a generic fuzzer input into a qtest
+trace that you can feed into a standard qemu-system process. Example usage:
+
+QEMU_FUZZ_ARGS="-machine q35,accel=qtest" QEMU_FUZZ_OBJECTS="*" \
+        ./i386-softmmu/qemu-fuzz-i386 --fuzz-target=general-pci-fuzz
+# .. Finds some crash
+QTEST_LOG=1 FUZZ_SERIALIZE_QTEST=1 \
+QEMU_FUZZ_ARGS="-machine q35,accel=qtest" QEMU_FUZZ_OBJECTS="*" \
+        ./i386-softmmu/qemu-fuzz-i386 --fuzz-target=general-pci-fuzz
+        /path/to/crash 2> qtest_log_output
+scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py qtest_log_output > qtest_trace
+./i386-softmmu/qemu-fuzz-i386 -machine q35,accel=qtest \
+        -qtest stdin < qtest_trace
+
+### Details ###
+
+Some fuzzer make use of hooks that allow us to populate some memory range, just
+before a DMA read from that range. This means that the fuzzer can produce
+activity that looks like:
+    [start] read from mmio addr
+    [end]   read from mmio addr
+    [start] write to pio addr
+        [start] fill a DMA buffer just in time
+        [end]   fill a DMA buffer just in time
+        [start] fill a DMA buffer just in time
+        [end]   fill a DMA buffer just in time
+    [end]   write to pio addr
+    [start] read from mmio addr
+    [end]   read from mmio addr
+
+We annotate these "nested" DMA writes, so with QTEST_LOG=1 the QTest trace
+might look something like:
+[R +0.028431] readw 0x10000
+[R +0.028434] outl 0xc000 0xbeef  # Triggers a DMA read from 0xbeef and 0xbf00
+[DMA][R +0.034639] write 0xbeef 0x2 0xAAAA
+[DMA][R +0.034639] write 0xbf00 0x2 0xBBBB
+[R +0.028431] readw 0xfc000
+
+This script would reorder the above trace so it becomes:
+readw 0x10000
+write 0xbeef 0x2 0xAAAA
+write 0xbf00 0x2 0xBBBB
+outl 0xc000 0xbeef
+readw 0xfc000
+
+I.e. by the time, 0xc000 tries to read from DMA, those DMA buffers have already
+been set up, removing the need for the DMA hooks. We can simply provide this
+reordered trace via -qtest stdio to reproduce the input
+
+Note: this won't work for traces where the device tries to read from the same
+DMA region twice in between MMIO/PIO commands. E.g:
+    [R +0.028434] outl 0xc000 0xbeef
+    [DMA][R +0.034639] write 0xbeef 0x2 0xAAAA
+    [DMA][R +0.034639] write 0xbeef 0x2 0xBBBB
+"""
+
+import sys
+
+__author__     = "Alexander Bulekov <alxndr@bu.edu>"
+__copyright__  = "Copyright (C) 2020, Red Hat, Inc."
+__license__    = "GPL version 2 or (at your option) any later version"
+
+__maintainer__ = "Alexander Bulekov"
+__email__      = "alxndr@bu.edu"
+
+
+def usage():
+    sys.exit("Usage: {} /path/to/qtest_log_output".format((sys.argv[0])))
+
+
+def main(filename):
+    with open(filename, "r") as f:
+        trace = f.readlines()
+
+    # Leave only lines that look like logged qtest commands
+    trace[:] = [x.strip() for x in trace if "[R +" in x
+                or "[S +" in x and "CLOSED" not in x]
+
+    for i in range(len(trace)):
+        if i+1 < len(trace):
+            if "[DMA]" in trace[i+1]:
+                trace[i], trace[i+1] = trace[i+1], trace[i]
+    for line in trace:
+        print(line.split("]")[-1].strip())
+
+
+if __name__ == '__main__':
+    if len(sys.argv) == 1:
+        usage()
+    main(sys.argv[1])
-- 
2.27.0


