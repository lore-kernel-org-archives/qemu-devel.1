Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B85C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:17:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7A7120770
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="X+Emmj9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A7120770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVypB-0007fM-ID
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVyfy-0003oS-A8
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:08:18 -0400
Received: from mail-bn7nam10on2139.outbound.protection.outlook.com
 ([40.107.92.139]:64992 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVyfw-0007AB-D2
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:08:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdfM70DzKnFolijpmWnkk9tEsHhShlKHXDXpnGRXPm+ibW4FMBtONLsWzSs95m41BTmoZIZIH/BxQJ6yjmM/FxCT+Qt+MGwbc5QFHMGb9EJHr2141gKctu+BxEMyw8wqdn9kL6MIyT5k1RtdylliWXawZ3l0movi45PzyYestrnOq1lZkaHIC/ghzRUs7BJn9VGYJTgwti6ZD+Vq7zeU/vaIpfEtFqTC0hx845a782O/MqdBSko2rs6y299l0ck8/fc5CifzmLUd+o0Fb7lFgveXdDHzVfW4yIcpngh1BRbKwCbc8X06YDwFfp8Lj2l4vaj3CopSGWU0jBM/HHo+wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+XUaLwe1R5Fqm7MRcPnIpqJcZJrniiyxg7bx88+/2Q=;
 b=XD3NZTTCcoSF6I9yTDfpAl15+jM6pDAispeUMheSDdI+3pqvcThQRtkcneJLTILSSIwsGhfgi64/7QmtMQbRVFgn1R266HnZpQ/sa/s+TxNGEFmKK14wT2rH3QDxEdPUDbedXcgGGY6nV9m8n9njoNzYQpq1Esz89DjWIdKzvALA+QQviOwbq4xDTsqzbTwurzo1M/k3Wsa/SIdiGomgP3jkxPsfGWs4xe2U2NeZ69UX6J9zrJu0EOBOONo/sXrvQSu9LR1ULZTU+R42q8mgPmgbTlCNn6LNKi5X1DIkhq0qmQd9D2HyS6BYYgtrPuFSPApvgU13cOfGAkXSOgMlew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+XUaLwe1R5Fqm7MRcPnIpqJcZJrniiyxg7bx88+/2Q=;
 b=X+Emmj9YvF9T7BC1dbHQZabuH/RCyuAI/PFMAECEEhGJ7j0jOrNHniJZpCSK6YcmcIRzYaV9AWiA6BWrzzhe4+aVjOvPYjuecGXUY07hJQjhG6tM6M5Ycpi54xZSHuw6yuEIYdPwIE6lOmemqSh/P6KI/Sdfd/X58Y8B2cv79nY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SA0PR03MB5516.namprd03.prod.outlook.com (2603:10b6:806:bf::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 23 Oct
 2020 15:08:10 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 15:08:10 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 10/17] scripts/oss-fuzz: Add script to reorder a
 generic-fuzzer trace
Date: Fri, 23 Oct 2020 11:07:39 -0400
Message-Id: <20201023150746.107063-11-alxndr@bu.edu>
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
 15.20.3499.18 via Frontend Transport; Fri, 23 Oct 2020 15:08:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cecb9230-c4d4-4bff-2da1-08d87765748e
X-MS-TrafficTypeDiagnostic: SA0PR03MB5516:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR03MB551616AE088BD00BB052CED3BA1A0@SA0PR03MB5516.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OOkJFBdY6TrKEajvAL/+5vUEpOJoNDU6FrvV6kQjTC9qHLt3MLNt/jtivLGur7KFME9sIdde6MWIb6x6w6tnALT7tD9WMFi1F4lc5LASSM7L6/8aaG+wkhyZek2vnfzCM3dWd2uWKU5mrBkoa/kRSCDWnmuKElbkhMwgxvkuq5y0jMW3LaQ9H3lojOH0lro47GAIFoceOWQ+yCJikDetm3fH3CMI7Lz7jTToXqIrUzSMWMCvi7h1vPneS/M6NxW/zi5l9RntrqLluo8UYzTwFeYP+D+mFsfT8mxMZdxfStkpnvcYJ4K+1VEPeK68DC2y0yOI+hMzz1Y3q2qMcdbNvl0NvQVWn52pXPrAMiJBzgRRHCGSaDu++2HaCalSC1EN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(2616005)(4326008)(1076003)(6512007)(478600001)(5660300002)(83380400001)(8936002)(8676002)(86362001)(2906002)(956004)(36756003)(6506007)(66476007)(6916009)(786003)(66556008)(75432002)(66946007)(52116002)(6666004)(186003)(26005)(6486002)(316002)(16526019)(41533002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 3xD1NfmaPjAAabABxkXtj34jD84fAQBpALAAXp+Lmo7dxL2FJ5BqAgOxT5qHOtm3/MMUYGxIj2LbhDJj+7UWt3stIuqX8JOa3w/iSMairk34l5FPavbqrTO2TA+5jmLXjmVZiToQBQ9hnt3Pfq49L7bQAPLDKNJCO8DXwiwHIM/nK5qDSmFmu6+F8g+NBFCrTlIbIcFF0sp3UTF2XNhDmIrVZdYfqDrt+T27WxeZcG0Ck/K9YdxUuJcFTKKXX7tWG2npGjMqUZJKGwtO/U1biLy52re2ihCQNXtBt3AMl8RdRgn1y5AFGfD8XS9Gq+ftN7T32Cpx8tG2XbzjRcqA4TvoJ1XSjceTwuixiCYEHS9einJT/nyTdpYqCx20L+BAdgfaKvYdUsfcnEdQm+7Y05W1JvH/gKC5gF8Hm4PZu95CRTCgrCczLhQC3+T/A8u50kUqhK82YZhoUo385M/3B+lGG5OB4hVbV+broSDXJ+4lTD2ivKtYQe9NFE7DAiuu1+JP8w0nntlNYNF8rH9WWdpwdyYZU4VHTvgBnC+o/ZCBp5hKgk+wXd0u6elJwCKh951g2UGXeeW2MS7bIyeP1Ou5Eyusv9S+N6UFcFcfJiuYmnx9FMRaH3jCML9wX8i0JcM3FJ1cWfFjcLbWFW57Ww==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: cecb9230-c4d4-4bff-2da1-08d87765748e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 15:08:10.5911 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7iG9woAVUBHQNaKnLgZzD06tohsF3LUw8UEDsZ22xOxO/PgJPyPdLb7jKTYSdYxk
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

The generic-fuzzer uses hooks to fulfill DMA requests just-in-time.
This means that if we try to use QTEST_LOG=1 to build a reproducer, the
DMA writes will be logged _after_ the in/out/read/write that triggered
the DMA read. To work work around this, the generic-fuzzer annotates
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
index 0000000000..890e1def85
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
+        ./i386-softmmu/qemu-fuzz-i386 --fuzz-target=generic-pci-fuzz
+# .. Finds some crash
+QTEST_LOG=1 FUZZ_SERIALIZE_QTEST=1 \
+QEMU_FUZZ_ARGS="-machine q35,accel=qtest" QEMU_FUZZ_OBJECTS="*" \
+        ./i386-softmmu/qemu-fuzz-i386 --fuzz-target=generic-pci-fuzz
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
+                    sys.stderr.write("Warning: Likely double fetch on line"
+                                     "{}.\n There will likely be problems "
+                                     "reproducing behavior with the "
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


