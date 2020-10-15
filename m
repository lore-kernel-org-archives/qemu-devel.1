Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DB6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:49:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BCF22222B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="wtr72CB7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BCF22222B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT3dj-0007lB-Ut
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 09:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kT3WV-0007fv-7Z
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:42:27 -0400
Received: from mail-eopbgr750103.outbound.protection.outlook.com
 ([40.107.75.103]:37594 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kT3WT-0000mT-4Z
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:42:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DseWEtVhlFicVvxAXqJr9l4HkFgjYKWa8xBSphHH6TOfKKwCTAVdkdRZNMHjNMtGc7EULg1HsAvkPXOat72kWYSaNWzMHlVZV4OIZL6M4E42wpGw3RPYfS70CFxNLNO5nRmcGyhmmXcNPJ1v92klWSIJKn0SBoeVZnnbyeEahqGEL9YaZCkCinKiB8cF94yfncCagC6e0ku6sEN4UBg4iRI3OQuPlE55QrIkNPNAYeh9PkkAElz7VFFJdqluN0RTewZwD2wztdBvs36tbMaXnIzs/IACjqQMsljXJHMZS+BzraW4TjjpK12pw+ug2z9NghXUkavPmMfCvFHpXViPUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WScjuUzY/vo2bUYGzpalJuKASEjOyJefrye5Ye3R9Ac=;
 b=Be0BfydF1U1hb22mE8kkvqa0c+lzmmJHP8UJSurJy42Lv0KBALAAP08yW8O84JuLaoMbwaAWXrH7KYPeEZ5LAZnqDfc9AVn+EthwTIvgC8FwO0qX5P+DMa4rE0m3C5gpdmkC253l5ZsTtcm5mAcNgiiVDYfPxohhFHB/lulgXfxGOBZmYSr9F9eldD88WVPKEhLZdoU8L9nv6XAL0GZQwt5odRfYeg2V3XYIHD/1GOxnduYEGIoUMuEux7BJd/O1TCPnm3iBYROOdHJFYEAIRMpRRyPXeeQHehrNwRLIxPENNmewMBdFXJTJGnqXZlpPXCyXA5xE+WFeQOum0LIi4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WScjuUzY/vo2bUYGzpalJuKASEjOyJefrye5Ye3R9Ac=;
 b=wtr72CB7W2fakUECBXAIpOFDSdXzWmtvvjTwJTcQDwxTWeXe6x6AoTFb3AxCduZ+1S7AXVctblfi78buMU3LzbvFVaXShTw6IR6eU3HKdOAQdnLaO076gFfqGaqr/OhylJd1sT64R8AlPL1RK1iImujHTDe7IpOrFEbhtV/OFM4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SA0PR03MB5465.namprd03.prod.outlook.com (2603:10b6:806:b5::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Thu, 15 Oct
 2020 13:42:08 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3455.031; Thu, 15 Oct 2020
 13:42:08 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 10/16] scripts/oss-fuzz: Add script to reorder a
 general-fuzzer trace
Date: Thu, 15 Oct 2020 09:41:30 -0400
Message-Id: <20201015134137.205958-11-alxndr@bu.edu>
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
 Transport; Thu, 15 Oct 2020 13:42:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddaf4fe6-4729-4f3d-1233-08d871101be7
X-MS-TrafficTypeDiagnostic: SA0PR03MB5465:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR03MB5465BA83283506A5AEA9BE12BA020@SA0PR03MB5465.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0n/JIjT84PRew0UV+Rugh+0txiA8OJrDP6WrtpXH+OjYV2BLhmTrFQAhjxMz57XDOeqvKwlLIO76USTu1QWIz4nA6raFy3upk5ee5NO89gSfoonqn/GiEJovS0kvprVWkox//LINDaDJBRY5AJViiMYnCftpMTbUbAQRTO9NIruecTSqnPvgUURrtCqGvghvIs+xq9wf1/ALO5R0Jx8/7dW0tAZTDAewz7tn7mq+51rUWZsp21git2n67reJm+YcOI3xdkCZvXasZkQ66McMQQqrKMH6oTMSDZub1yVFhlAyR1UHxhq2O5DCtzrm2/I+oUpFqnQeUlJSFYXUeeOf3PrmlE2QaHF5FhS1ODU22eksmBybeHVrTViWkTNSlbXV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(5660300002)(54906003)(2616005)(8936002)(34490700002)(1076003)(66476007)(66946007)(6666004)(83380400001)(956004)(4326008)(6512007)(6486002)(8676002)(75432002)(6506007)(26005)(6916009)(52116002)(2906002)(86362001)(186003)(16526019)(786003)(316002)(66556008)(478600001)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Q0i0kexkOo5ujkeEA3dZs8Tz/Jlzead1cmO8WeyqGiD/RJmOlKCCSh7XSxpxyDOuheIuIp48kIDNrNEaOwKNxIVba4pbCjQyVi3+kGxEf1PP/QcfFM+mgoLxdcrpFxo1BMoqzMOnW++wY+PkrEVOgIEw5+e/FPwGWHCtJ1H7R0P53pw+g/4+uksfrvAix1mDbvK/5Kt600qmKmQnmuYVGbeMxV2xfQTv3r05k2b564pqb8hcWHGrBstwh66RKqSQastxXeu+HTsUs3sDABLgtTWqRFd/X532JQDCGT6+y64jdbQ5eMgFM2T9aqJKqqMx+7HAEh1OhQjU2Lj4GJJfoCj8PlY+MulNi3gmtBu/fdr6P5nGNfDbDwCKr79lK/y6LyrJo9+CYitvw6zFon5HpHoXgTEXaiHGgFrhiETFUnAGDO66BPv2TZruwfYu9jAFfupvZAx0iwyqyF9zupdCu0u3fjFRXv+5Lv4ossAWmfBEXzTIqFDqcHnkU26tsLiKc+ki1AljXA6ZkakoH5BDq3kbG7yyUfK10D8DFzzF7j0URv91alazo/0V3gALEV1S1dH9/mSUQJJ/Awfajh0fvMJXzEq4076urK157E3lVGrKDthqaTThvNgcCdXSqzjEIcobkuhaTTUDzt2WHTS69A==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ddaf4fe6-4729-4f3d-1233-08d871101be7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 13:42:07.6287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m1TA0zzZ/v3jx7+A3UQN4MBQZOYVTUQepXBqsL1WpwIfRA2vpl03QP1wfU6pavsV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5465
Received-SPF: pass client-ip=40.107.75.103; envelope-from=alxndr@bu.edu;
 helo=NAM02-BL2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 09:42:14
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
 .../oss-fuzz/reorder_fuzzer_qtest_trace.py    | 103 ++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100755 scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py

diff --git a/scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py b/scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py
new file mode 100755
index 0000000000..be54de961d
--- /dev/null
+++ b/scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py
@@ -0,0 +1,103 @@
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
+
+The fuzzer will annotate suspected double-fetches with [DOUBLE-FETCH]. This
+script looks for these tags and warns the users that the resulting trace might
+not reproduce the bug.
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
+                if "[DOUBLE-FETCH]" in trace[i+1]:
+                    sys.stderr.write("Warning: Likely double fetch on line {}.\n"
+                                     "There will likely be problems reproducing "
+                                     "behavior with the "
+                                     "resulting qtest trace\n\n".format(i+1))
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


