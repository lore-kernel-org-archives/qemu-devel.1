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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEEAC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:44:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2960720825
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="FvR1lSH9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2960720825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jySA7-0004SL-Bp
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 23:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jyS66-0004gd-Pw
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 23:40:42 -0400
Received: from mail-mw2nam12on2114.outbound.protection.outlook.com
 ([40.107.244.114]:16939 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jyS65-0002Ew-2A
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 23:40:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BsmjxK0AM4mjmaOopw88yYMKyCiii/alxaC9cOppgSJTZm/4eRyWXCFkou2sbOvqZw4HIVBONLzcmrf7x/cKo5h6TgOrRhMJ7WxlPHymnrvjP8vkOBU69BZMdCwRgqDpN1/YWxw9s+67YvC5sg0PfyhdWEU9XzjUgumCuL6lprTJzhghtH/jmkqiLaihUCSbJ+J2I8OwWr9uloTjuOzEcSuTz6P5SQUjQH/dXy/6q7Su0fEdCmpE5W1vZYGHLYx1d1+qnUw+yBN+ZqArq/TFANmKD254qVPhOyvyrEfW/qnqqG1fdnMNklkFkRZYwbCgtqT7i4wDR62qFaFRw4OW1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KM79cPkTvUzrM+zvLY1mMAUOTr71w0mWHKq6fqwQWw=;
 b=mlj92S42YRDjsWWXA7zWL75QSn/CuvV6fm4TyylbY348YGyydoIL4Jt/k5VkyOaBwRupaNd77R/Py6x13sLhFeGAU0kAKDTIhSoT81sPsWQ0NLKgMOfSGItH3H42tK1gz82Rh8SZhxr4LVm5EQOSMjCTai0C8kfCtU309oxOZSEzH745JUgAwSRSN5lJ97mFysWDyErtr3O19YtWv0ckWhMCab3cZpxd4dL+DmdccWWpTQXGoLPzqmkuWHs0HUoOnxSzm68tjUDNSwPZaKmZsPWlwQSjbuQOfpYtscRoab7Kqi5SUpJh6QVd9dwHulp3TzfsrI9o5qAlRkS/c0P2oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KM79cPkTvUzrM+zvLY1mMAUOTr71w0mWHKq6fqwQWw=;
 b=FvR1lSH9mDmGaRvBNBzcFsuuZOGJHNYZ7gYJ9qpZlgvDjfPa6vQNLInR8Y7i9m9uAz0GuHtzhb8Vuwo6L73GAbiymxpQuqwVeXSSkchPoUAPAd3Qbx48FaNLwMcFF6cwKfvSmLYTuV7ETQ6kNMV3sEKgDlUbFThn/dAiJafG5+k=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3982.namprd03.prod.outlook.com (2603:10b6:805:67::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Thu, 23 Jul
 2020 03:40:24 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b%7]) with mapi id 15.20.3216.024; Thu, 23 Jul 2020
 03:40:23 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/12] scripts/oss-fuzz: Add script to reorder a
 general-fuzzer trace
Date: Wed, 22 Jul 2020 23:39:32 -0400
Message-Id: <20200723033933.21883-12-alxndr@bu.edu>
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
 Transport; Thu, 23 Jul 2020 03:40:22 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c240f8e-219b-488c-6ffe-08d82eba2158
X-MS-TrafficTypeDiagnostic: SN6PR03MB3982:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3982AB8753CD856CE4D0579CBA760@SN6PR03MB3982.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k/kt2h0zEIUU6If7V1DGZnhkn4FLDMTV2UyaRoCDuJOUm1Z0/cHTY/UQdWvPdrofW6MWniVLCuPqnzza+sD85A5iQH7vNulqxeLnofgK+vJxXGhUNpw7/UOQTPoJFdigqmUVhYwfT6GGqPcqrhzc6KK4bGOBq94SIGJywah1EyxzVxB+xL9Jg7GWAPYj8Dp21g37faqimc0TqlVWy0H6kDEdy7ur/PkIA0oEeh+zJi4TcK/Qe/LwlyORyLNQmcFSyA5KQopBgiRd3RcRt4BXVCK8Vy7q7OCXOZDukwHH45GHTFyQ0aGCdMl+JeTcdMHrOxvnEorvkqRcPj/VFNEoBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(6916009)(4326008)(36756003)(478600001)(83380400001)(5660300002)(2616005)(956004)(6666004)(8936002)(52116002)(7696005)(66946007)(66556008)(66476007)(6486002)(75432002)(26005)(8676002)(16526019)(54906003)(86362001)(186003)(316002)(1076003)(786003)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: qV+YQ03xWRKQ1p/RWhZtCTUnMpQphjWDQPVJeoffPDFcmwKucPu5T5PffeCQ5iArZ1sYGtLWXj6TO1HX5oJ1WuX14lWaMNDZcOf68hDdz7Kh0X34cPF4cX1HYg7gY5khvRu2G8p3ccKx1NTqiYyWwE+mWx1f/ObVTqp+Z18QZebNJxiYioirny69/sEdykdQIpT7PTfjJZZoN0K5OfkP0bOSRwS3Y5r+6QVZxBBNqZcMffFiTORYoXli4j0YhL5CJqYzWAhYGLE1jwYxEvTr4tqIC3oDmc38qNXVq2/5hTRtuHP4YGXwXuLz36eLgXxc0UMHJr3hmNGjeshcZPs0TGHMbcNelShEQ2txL2nhXR3O1mIxNHzDgjW8tIo+LyTh/mooHofL7cTiuD+E8D4OxPdSjVMYRo5c/fK6cYFJRxhE5jIT6vvVfBMmqyb5FG/aCWK2ygiIiWvNASPC5VnVlSOCAg5V2U2KLl9mCQKFh6Q=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c240f8e-219b-488c-6ffe-08d82eba2158
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 03:40:23.7630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCd3qkVFVlexl8dqAcqxh4ExTQ5bnWXdUJ0HalBM2ftQePgR92RWolcxe8hGy7NQ
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


