Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7ACFC43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 02:38:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B9E82078E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 02:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="IcwuSii6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B9E82078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKBih-0002V6-9L
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 22:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kKBWg-0003So-Vi
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 22:25:59 -0400
Received: from mail-dm6nam10on2102.outbound.protection.outlook.com
 ([40.107.93.102]:19201 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kKBWe-0000aa-VS
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 22:25:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkgZ6xnRCI2FcDsrDyU00LG5U5+Mcc4FT9fv1NXk5u0IXzlh7FJdBFaLqyuYB+CDuy23lUWjuPDTJhQgyAZc85r41bBj5vUJHiEfFg1jW/AkH4B2CiYsBtQeHoX6HnrzGs6Lsj65jG9eOrLUijAiB78K53PP9lcTdxbdu8TXZJrRXk8keXrEeMGM56+ZHXwno7Z73Q4mjr8TIm3AhzCyxHzEDCTBFsx1BGLuQ3pqZU65EwDmdLiSNDRCQD2A0DLZo+zRS2JgRP8o06WnzWOCsJu8DqYJpl8lUiyYe5uI7XYj33JTm+vLCgnBGIw0JZkkOpr6B+WJaUWU2KghEpihTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7biyK8EuRC5wbDe8xPAiZCZtZWrpN0dJY9gbT8HveA=;
 b=H7YfMFa0hTGMeenTiASvDs4w+MmxTSV31/n7qEm+DpCZ4Dt80lsxN+cSDBdktA9gnbeUfMuDl8UJ//hG27L7n7yz1dk5lA/OBub7Fx0lz+apWMPTGZpl9GCr+T5WOoiUD1D2iuvuWHIlygWiB8xm/z5npvHRg76CTyo1LVJT359xSGQEXRuwwlAd7H+NPOgO3rQqzTvnseyVBPx5iA6Xnd5ahN4VCz423LPtzWCj45k3s6PFL9VPb+Z5Y3kQTOuvRSfINBkPG8FlHa5XLP9WY+ui8qTgZsnMlwaV4AJlelP6H2sAefsNSnaY/XOaDqgcD7PRguDTxKhgSdH5/iJPIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7biyK8EuRC5wbDe8xPAiZCZtZWrpN0dJY9gbT8HveA=;
 b=IcwuSii6YEQ3W6AjRp9pn5lnUVc2N8QW/1xJew3COuO844pMIDrTQJ4Hi3OJwaycfdwuPxcgsItyeKBFOvWwiGI1QjfQMpAN/t1ZQrSxPqYxEo7oEw1gK053H1hj2J7ctdGf06XKVPn7C1aplV0wKQ8GhDokL1EK3xNVjfDOdUQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN2PR03MB2237.namprd03.prod.outlook.com (2603:10b6:804:e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Mon, 21 Sep
 2020 02:25:46 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3391.024; Mon, 21 Sep 2020
 02:25:46 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 14/16] scripts/oss-fuzz: Add script to reorder a
 general-fuzzer trace
Date: Sun, 20 Sep 2020 22:25:04 -0400
Message-Id: <20200921022506.873303-15-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921022506.873303-1-alxndr@bu.edu>
References: <20200921022506.873303-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR1501CA0034.namprd15.prod.outlook.com
 (2603:10b6:207:17::47) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL0PR1501CA0034.namprd15.prod.outlook.com (2603:10b6:207:17::47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend
 Transport; Mon, 21 Sep 2020 02:25:45 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b772435-3b87-46b0-129c-08d85dd5a583
X-MS-TrafficTypeDiagnostic: SN2PR03MB2237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR03MB2237BAAC936BAED75256E09ABA3A0@SN2PR03MB2237.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5pQeylsPHwULbFkkkcMgdw/kq2L86R8MnBvCKnVN2+7ljLGV2R3Eb6ssWsR5QBjnv+8mBM26kbLskva1H/JFScB4ZpI79y6OpJ+q5CdTDpa41N3JyN7lp0XpzGP5WpgEekCWoU+PvxnKfj7ABRxmhVkDUtmlW90rkWKMOVBvj5yAvfBlgNfPmSG1Vr2U8Ju53ENKBUCJKfZ/7Y6Cb6XPYs0dHaL8KqF5Q9WIgkwo6DS99ACqW+WK7RfFORh4ZMlfUAza2T4dNeOeWohWB3HzhDJuulUT10FlIWpSsZayT3uwKkDPLKkpoOQQ+BENpBV+/QQ391UqTdQOOcCdvu/kx5ad1qkCJIxgFBPBGL7wJmDdLXvan1QWblC66eMoPGPH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(2616005)(956004)(4326008)(54906003)(83380400001)(26005)(478600001)(16526019)(6666004)(8936002)(316002)(6486002)(66476007)(1076003)(6512007)(186003)(6916009)(86362001)(66946007)(5660300002)(36756003)(75432002)(2906002)(6506007)(8676002)(66556008)(52116002)(786003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 3nWeC3ZacuQta+VCPqpChCkF9a6/Ftu8FoN2UuCfNtnoPc1PYoXnZ8c5JHQImpepMs8SIt8YJehAN7zfKqK90TI2bC53EB67Zdr6qfsUyhlyEVa1A5yGHy3Pm3qcGOvup24PgonK9ArmDmzby3+UToiu+vkyxDRicwT16u9AGI8ZBeiKx76Jp+EJNZV7mXQRjhYw20qfze6qO6ijNAU+Zw3V93cKo/lvANuTCLdIsOvP9mTeD/XEudimRpwOo19By+PYqYbMDbkMsSQwTtXsYLoUgQLZqb/WrY8uX2PEyFLzZuFo5jkayVeP8zP/4wfDax5YvRZdI6vWue6dgLAqeaKpn8VLMzCrmjJb8M96+eaC0h+Le40+0k5gHIX13l+dnJkR/Rkpnh1SkXVrAIN6IXWreyu6tMaqQmMwHd2p3X4JamUmMxsT79WlSmoC2VLHvQV3YMGwk8QnXpK6W4u2TesHyzDepjIZP7rTD7LKXo1YszfIPbRppUOB0rn3oYZPS4hvFZZjEjxRO5s2boPHPSIhipppUwDn3UrP4TmZJMu6VZnHCDss5RqXHRirnLvXJ8BE0RVsutvIk/6WizlnccIVhlsPgNulc/Uk6hfxf7b4aVXHF1IUZ3TAdVZ8YmH+v1Ujcl1G4x9utAm8iXNISw==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b772435-3b87-46b0-129c-08d85dd5a583
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 02:25:46.7838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N45RZTt0SKZ27WnM2fER9KQfDpE+PeOmA+T1oKJEGwbOt254ZG0e6hkx+v7ysP46
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2237
Received-SPF: pass client-ip=40.107.93.102; envelope-from=alxndr@bu.edu;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 22:25:33
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001,
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
 darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
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
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
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
2.28.0


