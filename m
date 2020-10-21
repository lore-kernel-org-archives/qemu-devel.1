Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB24C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 01:22:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3A9920936
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 01:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="dAnwOdnh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A9920936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV2pp-0004eI-V9
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 21:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kV2ca-0001ou-0I
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 21:08:56 -0400
Received: from mail-co1nam11on2130.outbound.protection.outlook.com
 ([40.107.220.130]:28640 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kV2cY-0004s9-DF
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 21:08:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYHvVTs+bGE5IK+1pCNsJXmnWqK8fJmexyMim25RjEnw84EszUPu53eH4wp5J9vpbzEKwdIX08CdEwp1KGT0v6pGC1GvP7RcFVQ7oWZfpHsOs/0i0Di77c8B0wKa8hbeT0t9SYbYFboWh3KTITkyTThDhlMVnvpL+ttxOrX4c/GuhCYHHCBkJk8SYLmZUlq0o01gca8xA4Kl4MnRYjRFpMXFwmnu0R3bEeDG1NFJDeieke1CF6hqJ885jyNAyM3RM3uET9szEnOfE3y2SiwcYzoXvPQY1GJ75lJs2kP6mOe3Ot3QFrdsoXNLhg+hIb/hTsJR879qgjfFb26+02FcCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDTJqGKM64aaMzk3wc49Mh3OiMmPjRoJGLGBFubJf7o=;
 b=HwtkTLrJvDIvqi0IqjxBrrcRMJK7nmses/CiKjWJzxMTUSAG2J9jQqwBz/pKC+RtuzzCCPLkpPwvRytHUryZLnNGLcpbw5LCAp3HdFDUzY0zT4O+sr/QwezESe3NjnYzg89kQqdqUZFnsK3WeRkSEOePKhNgqBzb7/lOUBvO9m8NXakfyfzUzbrK3av10TeYh1mHruIfvQEzzow1d+HIimbPKIG9YaQHXvwmO1q7weB2PhJX7jebuOCTeTB98h3n7a9PCcSXvl1Rv5RrnOBpYzmvmNVqKkx+pFelRGSpQPJQg6aJbXIPhAapNlnNB3053ulBiR94Xztcd6Kr5An49Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDTJqGKM64aaMzk3wc49Mh3OiMmPjRoJGLGBFubJf7o=;
 b=dAnwOdnhgd8qida4RrsxoWUZvHmD+ZFKjWWVgsaF4k7RBALu4Ifrp8lpEKMBNrvMbuWH0K1tom0jHS3wZQhR8O6hnJpgrwvR6U3rzipq6wClIfTCPy36K+2w6xBhl1rpxqsZ4rkGrhd49goa/RRwkFDypHqFOZWwBhyOGDwUN+Q=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN2PR03MB2333.namprd03.prod.outlook.com (2603:10b6:804:c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Wed, 21 Oct
 2020 01:08:25 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 01:08:25 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 14/16] fuzz: add general-fuzz configs for oss-fuzz
Date: Tue, 20 Oct 2020 21:07:50 -0400
Message-Id: <20201021010752.973230-15-alxndr@bu.edu>
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
 Transport; Wed, 21 Oct 2020 01:08:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d869fc95-8c91-4803-f213-08d8755dcfb6
X-MS-TrafficTypeDiagnostic: SN2PR03MB2333:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR03MB23332B54EEBAB55539039E00BA1C0@SN2PR03MB2333.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vdCqnpuWPdt9VlyAoLhxj+JBdRnpLzaiokYsAs7HSlk7dOpuhn7ENZvZ/5YHY3scaV2JxRm0HAr6vxU1KP/tIJVKWCWbTHWiAScHo7iyxkCXOecKXkfCv0byc1c8EozTHoli7x95FD/pM776tH8/GNNpdS0soKdqTyFpvdfbdohU+yTRUHHU8agzkUXjo/8s44E7QovDiYNSz0dd4O3okSU05UpKGxHtAyQPU+evIl7dmHf+H9xGu7AvvGBpEOJGtjpS4NmKHfwmTw1EdcCg5Cb2dyYFtT75zmXL0UR2mvmnW0TTuyo8cbaknoQ5CtMc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(52116002)(2616005)(8676002)(6512007)(6916009)(6506007)(36756003)(786003)(316002)(956004)(478600001)(1076003)(4326008)(6486002)(75432002)(8936002)(54906003)(86362001)(5660300002)(26005)(16526019)(186003)(6666004)(66946007)(2906002)(66476007)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Y5wFmgmCFoTJcsxW4bXlR1NGQC84s0PTJbgtUv7yA7FZjZ8iqGsRA/1vWCbM2cyJT/Jnvo/eQJKPLpP7jBqlSArwLuLAiP+DfC0Fugk0Cq5VGVAjmfu3e2F5wd2uc3kT/wXHsJU2NM3B4EzqiDhuvFx9FoDbD8odiDo7ffunjqrlI11V8ZOSV0+Fn4tpipb5PYIKzbgthw+5XllJHIT/U8AMcQ4TVGvMG+GmOwejFfkIqkwhoA2X0BoVv4tPDHerEReFKD427cX1AXpixZ/g8ZbDrgXFYfOZLWn/FUMLqrdY4TUL5hWOV389K54kELX27Q/+onyKk41TZCjTeXpTVUmf1m6BTn3Ww+O2vLge6JYPmX40KTDz5ZnxXqAN7D2+BfqH32N8A2Xx8BE/FvnwvMjpUjWLhS8giF2Z6ROD9+io14fBl9HU8QgVZ7RrWIPU4Ut6ZGBsTyspLpdAgSE2m2YAtyniHkP4yyYU/h+Bt0VZuCNS/89MbKirMraEwd8AFSIAFvjobxwfzQJMZqVGe8BrnT++Ulkw2xI5wXgwOWhoknJUbpT28L2d3sYTBN4d5KxpTuCegtQSJMUgkXEpMDG1iLXZdN4BG32bnvQUR8usctAqGlJAF3YNyWHyv0bbEO7W7cgdaiBJhtWzfMz6iw==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: d869fc95-8c91-4803-f213-08d8755dcfb6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 01:08:25.8212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UPf/N5uYbzRuOaUKvaIxj0lbFvqzNMO3TGc8ayxRM3MXqBUbemxn9Srtk8ce/RVc
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, f4bug@amsat.org, darren.kenny@oracle.com,
 bsd@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Predefine some general-fuzz configs. For each of these, we will create a
separate FuzzTarget that can be selected through argv0 and, therefore,
fuzzed on oss-fuzz.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/generic_fuzz_configs.h | 121 ++++++++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 tests/qtest/fuzz/generic_fuzz_configs.h

diff --git a/tests/qtest/fuzz/generic_fuzz_configs.h b/tests/qtest/fuzz/generic_fuzz_configs.h
new file mode 100644
index 0000000000..e1a933f18d
--- /dev/null
+++ b/tests/qtest/fuzz/generic_fuzz_configs.h
@@ -0,0 +1,121 @@
+/*
+ * Generic Virtual-Device Fuzzing Target Configs
+ *
+ * Copyright Red Hat Inc., 2020
+ *
+ * Authors:
+ *  Alexander Bulekov   <alxndr@bu.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef GENERIC_FUZZ_CONFIGS_H
+#define GENERIC_FUZZ_CONFIGS_H
+
+#include "qemu/osdep.h"
+
+typedef struct generic_fuzz_config {
+    const char *name, *args, *objects;
+} generic_fuzz_config;
+
+const generic_fuzz_config predefined_configs[] = {
+    {
+        .name = "virtio-net-pci-slirp",
+        .args = "-M q35 -nodefaults "
+        "-device virtio-net,netdev=net0 -netdev user,id=net0",
+        .objects = "virtio*",
+    },{
+        .name = "virtio-blk",
+        .args = "-machine q35 -device virtio-blk,drive=disk0 "
+        "-drive file=null-co://,id=disk0,if=none,format=raw",
+        .objects = "virtio*",
+    },{
+        .name = "virtio-scsi",
+        .args = "-machine q35 -device virtio-scsi,num_queues=8 "
+        "-device scsi-hd,drive=disk0 "
+        "-drive file=null-co://,id=disk0,if=none,format=raw",
+        .objects = "scsi* virtio*",
+    },{
+        .name = "virtio-gpu",
+        .args = "-machine q35 -nodefaults -device virtio-gpu",
+        .objects = "virtio*",
+    },{
+        .name = "virtio-vga",
+        .args = "-machine q35 -nodefaults -device virtio-vga",
+        .objects = "virtio*",
+    },{
+        .name = "virtio-rng",
+        .args = "-machine q35 -nodefaults -device virtio-rng",
+        .objects = "virtio*",
+    },{
+        .name = "virtio-balloon",
+        .args = "-machine q35 -nodefaults -device virtio-balloon",
+        .objects = "virtio*",
+    },{
+        .name = "virtio-serial",
+        .args = "-machine q35 -nodefaults -device virtio-serial",
+        .objects = "virtio*",
+    },{
+        .name = "virtio-mouse",
+        .args = "-machine q35 -nodefaults -device virtio-mouse",
+        .objects = "virtio*",
+    },{
+        .name = "e1000",
+        .args = "-M q35 -nodefaults "
+        "-device e1000,netdev=net0 -netdev user,id=net0",
+        .objects = "e1000",
+    },{
+        .name = "e1000e",
+        .args = "-M q35 -nodefaults "
+        "-device e1000e,netdev=net0 -netdev user,id=net0",
+        .objects = "e1000e",
+    },{
+        .name = "cirrus-vga",
+        .args = "-machine q35 -nodefaults -device cirrus-vga",
+        .objects = "cirrus*",
+    },{
+        .name = "bochs-display",
+        .args = "-machine q35 -nodefaults -device bochs-display",
+        .objects = "bochs*",
+    },{
+        .name = "intel-hda",
+        .args = "-machine q35 -nodefaults -device intel-hda,id=hda0 "
+        "-device hda-output,bus=hda0.0 -device hda-micro,bus=hda0.0 "
+        "-device hda-duplex,bus=hda0.0",
+        .objects = "intel-hda",
+    },{
+        .name = "ide-hd",
+        .args = "-machine q35 -nodefaults "
+        "-drive file=null-co://,if=none,format=raw,id=disk0 "
+        "-device ide-hd,drive=disk0",
+        .objects = "ahci*",
+    },{
+        .name = "floppy",
+        .args = "-machine pc -nodefaults -device floppy,id=floppy0 "
+        "-drive id=disk0,file=null-co://,file.read-zeroes=on,if=none "
+        "-device floppy,drive=disk0,drive-type=288",
+        .objects = "fd* floppy*",
+    },{
+        .name = "xhci",
+        .args = "-machine q35 -nodefaults"
+        "-drive file=null-co://,if=none,format=raw,id=disk0 "
+        "-device qemu-xhci,id=xhci -device usb-tablet,bus=xhci.0 "
+        "-device usb-bot -device usb-storage,drive=disk0 "
+        "-chardev null,id=cd0 -chardev null,id=cd1 "
+        "-device usb-braille,chardev=cd0 -device usb-ccid -device usb-ccid "
+        "-device usb-kbd -device usb-mouse -device usb-serial,chardev=cd1 "
+        "-device usb-tablet -device usb-wacom-tablet -device usb-audio",
+        .objects = "*usb* *uhci* *xhci*",
+    },{
+        .name = "pc-i440fx",
+        .args = "-machine pc",
+        .objects = "*",
+    },{
+        .name = "pc-q35",
+        .args = "-machine q35",
+        .objects = "*",
+    }
+};
+
+#endif
-- 
2.28.0


