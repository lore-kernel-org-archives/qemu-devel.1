Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4805AC388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 939B3223C7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="RbrbDAqh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 939B3223C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVLrC-00007o-5t
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 17:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVLN5-00040Z-Sq
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:10:11 -0400
Received: from mail-eopbgr690098.outbound.protection.outlook.com
 ([40.107.69.98]:60229 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVLN4-00087u-3e
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:10:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkZmOKZoQ+7y+ds8fZyvr7eCcaIxil6FbrYI+N65serwRWb7yb8klbYc6tqGoaYAYvR4ykv7OUFi0JoiT018CQOF1GuG9m9tJjdk/dXd2SFQ+S70sUdMiZF0Pa8mgjQyQsYK4pJ9mToTKL2ljKkCXwZ2wdm1qJmNa5U4QrT1+uQtPaBp8diur7wI4Zh6EUmTBRq5Masg9tXyzWLY+iajs/VFAmMPh9n4yZZ8cvAGRbJymn36X005wERPuBkxPG5KkXskXybtZTcR5eel9e9mw/VmpMHiIx8mF/uwvWhsaok/VW1eVK0orrf+JdGr8+NjGPXoJmSGLNyoF9Bg485hrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BK40eN1KuFxJSGsahq66EgtM3CjPt47xb8vSELlLEc=;
 b=iJsW2/YFoDaejgpoP9Dx7Ja/XL6HjvhfMC7F8mbo7IrXX743WOA51YLIsvL1FofK0+yhwVtk2H3enjVAn/A6e0erzFNJ0xSM4cA0hTRbvonacygHYKm0TZ/Kc0Wk+W47kat1d07h5m2mkpDXrsSQxznmlQ0Xi5Y+JIK90z5gHcf2bjXwEb+tT6ejvZ1UV4N4pBtsI96LpXLkNeOlAo4lIWAKKJUbKZdCOFBq/sPXMLpq0IT3jsxbYw2E5V8BOs5j+JxfB4I9IuPwhalcQ6i9wprDBCU1eotsPwFgqAzWkVCjT4tN0u4zIoydgCjZnNLofoZsM+k0Aog1wX6T87muVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BK40eN1KuFxJSGsahq66EgtM3CjPt47xb8vSELlLEc=;
 b=RbrbDAqhQW12W1SSWpr9l10CNhidHphlHpWaHl6j7vwcxuQa6bEdYNC1AFR7nsHf1GfJNejIs3PD7/cXrjG+e9XkmgBNOLwQ0h1LnlPFRjoN90Ol7bEA7yXI7HBswC2+igCjwzJykCInDUE3/v8/eZn10sYFnVJ2jy8+aPV4mcU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4045.namprd03.prod.outlook.com (2603:10b6:805:b8::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Wed, 21 Oct
 2020 21:09:56 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 21:09:56 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 14/16] fuzz: add generic-fuzz configs for oss-fuzz
Date: Wed, 21 Oct 2020 17:09:20 -0400
Message-Id: <20201021210922.572955-15-alxndr@bu.edu>
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
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 21:09:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b22e0450-763f-4429-2058-08d87605a948
X-MS-TrafficTypeDiagnostic: SN6PR03MB4045:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB4045471BE611D75B654C06A5BA1C0@SN6PR03MB4045.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KI+1W1oXDTDuAeV7fNzMSo9LdSmM9NjJSX6Ay+nSB0JlIDRi+KJQIqC6ZEfDOzFCUf5FG0VCOiofbKfigsKEghZJqUK5lXwAqQ4Tx1kLlgj4Zp7kjQwtxkDPA8RyqUCBN3+RQmGbg2/qjDH+lxfW9mCCN4WYP3kGrDj0O6k7nhTyCSxOF3I7L1hzJnQfq7qzCBLMhJ3H0Y/BQLzcQb1d2g1LSJ7eAztasyXgGJ/qDlP+bwSz8jQ9LIVKIcyJW6trA8l0obfAwwiri2B8ePhsWN1D0FPoQESYU6dd433sRteSwmOHiLaz6p2dETxn/XiNl+Zi1nXGBnSVKSOq4H+LhhSbBCf8Vnks10/zMAdi6POTOhrM8tiEkevLIJ2ycECP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(86362001)(6506007)(956004)(6666004)(2616005)(52116002)(5660300002)(316002)(75432002)(54906003)(786003)(8936002)(6916009)(6512007)(16526019)(36756003)(26005)(186003)(478600001)(66946007)(6486002)(2906002)(4326008)(66476007)(1076003)(8676002)(66556008)(41533002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 5AmPLioJaGc0WSalbPM3H4dFkVI6qDdgkKU3J6Cobac5HIL2GXdrL55S8aaB6Qg4lhXTa9gptR/RVt/YAvYJ5Hm8y7G8jLzZkx/RwQaZxqP1cQbrypjU+pQHFk/pHqwgRS0j7YoijMewyvHnQMaqMfx7mlWsh6Fz778wg/lJ8PyJx/pameGetWyUsMlgX7CSLLKIRZo/WRS2VhfWs91G/85P4pFXEbB1iqsGTM13PFXkCsVy8jWF0lHfkALmNz4Wv1fdRjYpI+zVOFSpJpzxRsHGOuf/A61hZvMgrIPNJRkuMv5L4wtU9EL7JFlh3r1M53JfS5uGw/TSB2sipLmn67fyx8f+ad8C+ftA7ev9Gzls+0UNRqon8nHQBAupAxEB9iZx9iaWif4XSUlvleUIrcRPLbdKp5TvLLd2eGCVA41tP3eZF48Uyvc/D8j9XvjXoiT/bsSNd1AclGSCneiZgdNoZdcAbBs8U+RpTwmBo1r0WXOsT/1uByMO4howXodd6ecEk60mBdx3kZnmVEx2kONNy4XRJOHsiyM9+qciSUETQIuIiivNuD1v54nLcKDENmjc2N0tpQ4kZZ8lNAHxK8ULmiPz4ziilkvXdmZbs7zvhJZ/iYk52wMeqZep2YXP/Y9XxFI84ZuVf+zWGA3LZQ==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: b22e0450-763f-4429-2058-08d87605a948
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 21:09:56.3323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYhM0swC1Y2ND02MYQRJGm769JV4OHI35gMgfR99b5IdWgoB3ntQ+gZFzkM5UA7t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4045
Received-SPF: pass client-ip=40.107.69.98; envelope-from=alxndr@bu.edu;
 helo=NAM04-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 17:10:05
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.454,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, f4bug@amsat.org, darren.kenny@oracle.com,
 bsd@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Predefine some generic-fuzz configs. For each of these, we will create a
separate FuzzTarget that can be selected through argv0 and, therefore,
fuzzed on oss-fuzz.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/generic_fuzz_configs.h | 121 ++++++++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 tests/qtest/fuzz/generic_fuzz_configs.h

diff --git a/tests/qtest/fuzz/generic_fuzz_configs.h b/tests/qtest/fuzz/generic_fuzz_configs.h
new file mode 100644
index 0000000000..c4d925f9e6
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
+        .args = "-machine q35 -nodefaults "
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


