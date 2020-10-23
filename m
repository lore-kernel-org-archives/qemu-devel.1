Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC2AC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:19:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A276F20770
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="FJWeYDtM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A276F20770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVyqp-0000WR-NX
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVyg3-00040M-TF
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:08:23 -0400
Received: from mail-bn7nam10on2139.outbound.protection.outlook.com
 ([40.107.92.139]:64992 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVyg2-0007AB-50
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:08:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8AUbgaGxsvkYYXJNC5xpcg0THrZwE6n3FGaiCOHqGEOj4XV/DOj56xxThbsGJ7rRfkTmiBsAm2bceE4H3r86OcAaMXXJmWvznLptnj152680a7K6gZpK4Bb8m2Gg1ZWEsjUI51lHH4uo5/CXjCYE/+RqIv8uAOO+QSo96wgF36iJ79eFPYNQAJc5vSU3gmZatA2KPHFP7kYlksu7aF2Qb/F4TeRPTdo/uLUKU2IcUXOce/vlsfJqH8ThBet+hVOU+7hsZaFyi0uZcs1xpZKIF6xyTYYM7l1ju0YPxTRH8zjCH/QPrG8GkjBsx/Bu0SjaP7NPoaQBWxMAGMZlprFGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hxvvmoN0/A/Xlg4izaGtkZCY1hDif4TQgLt+baD4u8=;
 b=MmcnEzn+hcR5hKoEjPUSkthWH1MWH6vwbmDA+JLmusY2TntV3fV9AHVHr5V728bNd3QApLvXxQvSJNQuTX2UIswAT63MrzdzDSiWPHKFZIFXu32fAvhbXMkzx01ZAmLZyHW1t/gQ2P/lvS7MHJi7kZDvARNNZwxV04YUbyye7f3o4huCvtwA3uZ5WDP6q5BzKHQLIfM5e21dIR5QUTLwl6qsQKiFvsQnAcAU3oDOfajnh5zhjrW7KN0vGPw9cwzuVjyVSQ0If5sjUjUBjA0ekx7w48JIVoS/fScddHDkuv8as2lMH2AtQBLCm7qp+/if8P1LElLOZCpu5FqUQvv1Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hxvvmoN0/A/Xlg4izaGtkZCY1hDif4TQgLt+baD4u8=;
 b=FJWeYDtMBI2/BvC+0xgVaCFok2xUINuynpEQZdQ2bIVNtP856yGRv2uiImH1et4Mya5MTmvRh7wRM9nNgIt7DrPLB6AImYVfhc8ijCwM2V+ygRdMUDxc0R7WLiD5YqEEEjolII4CJio0PzVuGobXWQWL1pJjQp6VrIZ+TAsUOuU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SA0PR03MB5516.namprd03.prod.outlook.com (2603:10b6:806:bf::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 23 Oct
 2020 15:08:16 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 15:08:16 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 14/17] fuzz: add generic-fuzz configs for oss-fuzz
Date: Fri, 23 Oct 2020 11:07:43 -0400
Message-Id: <20201023150746.107063-15-alxndr@bu.edu>
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
 15.20.3499.18 via Frontend Transport; Fri, 23 Oct 2020 15:08:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa9265e7-93ef-4f4a-cddf-08d8776577fd
X-MS-TrafficTypeDiagnostic: SA0PR03MB5516:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR03MB5516C5DAC699857CAFB09E48BA1A0@SA0PR03MB5516.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ITDh/MHOmPBkt335Biz84uHmWbJiOnpuYuYoBqhx2WreyPZfJYSR8RBEIWRNx02/smFV0LzgwZPU6E3YOPyVv194SREak6dxCGvYPhs/LWNwZw9itvUmgLnPd/ybTU/EvCQ4FOEWTOkroI8HZIyHq6y/O05ot2Kw5sTFXKXTBQl6O71xeJD+IQJkrWvL43lV8wpLiic+wa0lTdNkZqomZEpvxKzy2LSJQSQc6VOUYaao8goDmO2N1bzRyiQQ6fzTNPL9YIYors+CERuHuFYiiEzkLeQCkTHgD2VtNWSUynZdjX3xUerM/UUGF2Sr8sz2nNkZR7HuFVeODBX3jQOoxkm+8B772Habh2JvWkc7Lxeoc71M0E4FWaqoRy/HYc08
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(2616005)(4326008)(1076003)(6512007)(478600001)(5660300002)(8936002)(8676002)(86362001)(2906002)(956004)(36756003)(6506007)(66476007)(6916009)(786003)(66556008)(75432002)(66946007)(52116002)(6666004)(186003)(26005)(6486002)(316002)(54906003)(16526019)(41533002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: lUFFaaC5PvXpWA+p2MYEEyuF35x5YoYUCA4iNiEqqz1rBApIpZhu8IqfqUnKBTtcNGAoqIfcjuwopSIifR8ctJWGFrjJQJSZWraQ9YOX5YywhEh0Vp5Il1ol6qYn5nkoKIUkVE/TfUj10BQ93pXl1fFIoQc6ReOrlozlhx8rvssE0qQTL/D/bDckxVpoH4sS2uV/iSOZxH20uGMUWfYrQ2Ox2t4yXHzsB1nR7Hm1hPs9BGCiUgTMSrjoySEXAk0vDaRKv43k7yWrIfwNpKD2Wp9RReY1y7Kc3zCI51m6qdl3q1C6UubRYI0Nd5J8HrjdD7lA9mrOeo6wy00vZC67xXFbkWbb4B7EmVV0WjOrHK3+EHTw3/+KXOZM9n0dxOzJpyDg+bqM8GS7CJkoSFFRlVmv4KFps9Q7kvjvcnhGQc4TVavErf5m0BdqO7uAwi8kE9N4wDaXTcLIxFQJBINp8kuzuQkWdUkNV8WweipY0usfEyBNJSEiV0DWJTaAdWcm1F43XkI4SVrgs8LMADIpm517LBWhLj1hicR3kwWsSG66P9UmKB4LKYQ7ZJSdBMYDiFR1rpcMUlAsmT/hkqSTF3ick2ABf+4mQfIZow/W8wYYttwk8k1vKA+nMoniDR3PDi1ZQxcHwg1mjROCD90zuQ==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9265e7-93ef-4f4a-cddf-08d8776577fd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 15:08:16.2718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8rtzZYmlPMcNmAwBv2cC3x7O6kObpjBbAZCqVheG8r4m1VcqUdoHUGD1evyN18lb
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
Cc: Laurent Vivier <lvivier@redhat.com>, thuth@redhat.com,
 Alexander Bulekov <alxndr@bu.edu>, f4bug@amsat.org, darren.kenny@oracle.com,
 bsd@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Predefine some generic-fuzz configs. For each of these, we will create a
separate FuzzTarget that can be selected through argv0 and, therefore,
fuzzed on oss-fuzz.

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
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


