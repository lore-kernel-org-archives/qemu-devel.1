Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5CEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:50:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDC6E2222B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="355ibJgk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC6E2222B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT3e2-0008EJ-Hn
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 09:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kT3WO-0007cU-RI
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:42:20 -0400
Received: from mail-co1nam11on2103.outbound.protection.outlook.com
 ([40.107.220.103]:1568 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kT3WM-0000mo-Lt
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:42:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naLuXTNA0wqWaVu1WwPZUvvXrOFTtf5O5+CiCzJiYwguzitJvlhk9UD0xygrRHZIaJHoKP7KmRnnul9ds2wy7b0mS2HytfvxHIvbUGh0CaLBLvieX5JvAm8lvkW+0DLx8ehPz8SjrlWPjRdgjZhyzfcfAX5qqJcKk6/Xm1yS05g9dZVvJXrmltTQzGUUWYnlKA5IUhktLXWeK2V72egE0BrdNEXxY8oQr+43hT1Y2H4cdrss7c4IG066s+SO9vx7D6X1E+JKfpWnyzQcv9T7n8trKu7dWPRMJrlqbERp/9AWvi2j58O8caaII+qBlX1hzIW0DZvce0ZVi8NDEviQuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCBBGrfWvyFwZfMWdP1r2U1LXwYwMfU7hllKV3ukG2c=;
 b=YU+AsaZjm0k0X6ifHR2xRTKaFwdh2y4M/IEQKlwNcCTTlXQc3Phoiuk/QfyhKVOgqon22ATeuqBuDVpN2Fzck+q4ZeyEXmYvtZv7WpY6NOs9UJqKUEbbW/9sq+GVLeaI+Jk3gtzzZPLa8D2N1FQLIKjVwbPEvj2Zd+mJj3PxdPiTde7AwQcJGQnMh8GaafsqbJN4XddvR4np7cIddw11AbkWSdAvcUw4JIJ2Ce9QdsF6Q5zBgLysK4LvepDSajoCR4wUWa7hbtXlu5YzDe58yXV2VPjkAyugb45BPyqySUj4h59XFKYvvGzNJKJDnnaB0GOEChLdQyq/wN7pzz8J0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCBBGrfWvyFwZfMWdP1r2U1LXwYwMfU7hllKV3ukG2c=;
 b=355ibJgkQW+3Sr4/kEDZz1n974x7mXLXUrh9f5T4gfGsBew7vsAyR/fzBnBe33hwQD/P+8obu5J5B/Vrcdp+YqQcZnW7ii8aSG2A8ujBa+qNG2wlvWlOHAyV9AQZ3IHSj85OJ45e+RhQN85PJNVVMrY+gHNKEnolAyHQ9Hh4dPY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SA2PR03MB5721.namprd03.prod.outlook.com (2603:10b6:806:117::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.30; Thu, 15 Oct
 2020 13:42:15 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3455.031; Thu, 15 Oct 2020
 13:42:15 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 14/16] fuzz: add general-fuzz configs for oss-fuzz
Date: Thu, 15 Oct 2020 09:41:34 -0400
Message-Id: <20201015134137.205958-15-alxndr@bu.edu>
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
 Transport; Thu, 15 Oct 2020 13:42:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e848cf6-d599-4e42-4d10-08d87110203b
X-MS-TrafficTypeDiagnostic: SA2PR03MB5721:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA2PR03MB572185F3AB34A62311DA5377BA020@SA2PR03MB5721.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eGeXTsxs6MLssZ17rtVvnVTVb5VDkrFZg7ceBk+O9KFigBotQ0XGR4zAcdiG3LVY3pAbc0ko60h7hc+G1G5C9jHO01yFZi5SFlRgGOApb1nNUn8fVDY7hlYMejcjLLJybJz4xbLZZ7YHdVsgYU07eT9Vrl4s98uykStiF4pcpNU4dLq1JDWMWq78JHpwmt5lPh5bW/WS5iO/ui8UAcI7vNuOlF+lgnqvyxz3QcOT1Wz02merfEYriER4BpTdHa7zOv5NQPlLtxtXunWpo/TjuFAJZ9T+XSo9BfgiOhkHdOIkcoOHkYePrYSbcaz3BUm9UqYSt6AcTEbtIunOI3+eIMtZruQ/WW8fOnbzyKvdogCnPF68AhgDEXFFay7Y1+Ey
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(5660300002)(1076003)(34490700002)(26005)(6486002)(66556008)(6512007)(8676002)(86362001)(52116002)(6506007)(8936002)(66946007)(83380400001)(75432002)(4326008)(186003)(956004)(54906003)(16526019)(786003)(2906002)(478600001)(6666004)(36756003)(2616005)(66476007)(6916009)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Q5fg4VKCE4ycd7zgiQxZnjKQmdFwqFCqCNisRw9C6wNMyw6mcbYXrEwbdq6GOvpw+qXUi1P4j0TMq57T72uAvj/T6f3kbVl6z4Gr/NTshNI8UAvr5qVrTdY+Q94ZE6YwFHidyJqKBvGgZ0XUUi55jIvRsy1uH2StasK5jJBeEXusPTD0YxBclczflcFwTQ4Xo4NEVUsZw5LJ8X06pTxVhxP36E05MBzn4Got1Oulc5UHLIMG1bq3KRI44EjPEF6tUBCUoz4ajnEYsIuq3dZ2TD1p5m9iCOiHxuVzx/+yUl3DLvmF1FbeqJV6nxqBCQNM95i9JLK4wuavh1Vi6XGOGc9d484cuiqsp7XJdSrkZjKcP6Gl3wxfyqLdzz0bxMCu83/YrfNk7pgN0HXgC4rs2rdcGOMkRr6bpkP9CR2KGrvtD3XdOKWGrbGKM+3BJP/tihNRuvF0w2iyW2tnfcv59qVoeQwRrJprjtJs9OG2bedo5VqPb+H1+sGPRrBLtROtwaowHZLzupF7JMic2ergqucmDA8fhmdsxYqLg4z24YU2C6mMaxkQ5nVgQptqq6OA/DeqOmY2v5avZWABft3A08nd2lKYOzvFZ82WffTrcGQmu63OH/D2mL5AV5dDlPEMHtVKeuUV9/QKHZmRbLugWg==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e848cf6-d599-4e42-4d10-08d87110203b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 13:42:15.3734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6TUi9sBBZ2Aeb2XEhvhZrJw17Z1oQ01S565ykIBb9P40jJr4MVYGF7cx828fonz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5721
Received-SPF: pass client-ip=40.107.220.103; envelope-from=alxndr@bu.edu;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 09:42:16
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

Maybe this isn't the best way to specify a list string-triples. I saw
that some files use QLIT_QDICT for purposes that seem similar, however I
don't think that plays well with multi-line strings. Does anyone have a
better suggestion?

 tests/qtest/fuzz/general_fuzz_configs.c | 140 ++++++++++++++++++++++++
 tests/qtest/fuzz/general_fuzz_configs.h |  24 ++++
 tests/qtest/fuzz/meson.build            |   2 +-
 3 files changed, 165 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/fuzz/general_fuzz_configs.c
 create mode 100644 tests/qtest/fuzz/general_fuzz_configs.h

diff --git a/tests/qtest/fuzz/general_fuzz_configs.c b/tests/qtest/fuzz/general_fuzz_configs.c
new file mode 100644
index 0000000000..5364976517
--- /dev/null
+++ b/tests/qtest/fuzz/general_fuzz_configs.c
@@ -0,0 +1,140 @@
+/*
+ * General Virtual-Device Fuzzing Target Configs
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
+#include "qemu/osdep.h"
+
+#include "general_fuzz_configs.h"
+
+/*
+ * Specify pre-defined general-fuzz configs here.
+ */
+GArray *get_general_fuzz_configs(void){
+
+    struct general_fuzz_config config;
+    GArray *configs = g_array_new(false, false, sizeof(general_fuzz_config));
+
+    config.name = "virtio-net-pci-slirp";
+    config.args = "-M q35 -nodefaults "
+        "-device virtio-net,netdev=net0 -netdev user,id=net0";
+    config.objects = "virtio*";
+    g_array_append_val(configs, config);
+
+    config.name = "virtio-blk";
+    config.args = "-machine q35 -device virtio-blk,drive=disk0 "
+        "-drive file=null-co://,id=disk0,if=none,format=raw";
+    config.objects = "virtio*";
+    g_array_append_val(configs, config);
+
+    config.name = "virtio-scsi";
+    config.args = "-machine q35 -device virtio-scsi,num_queues=8 "
+        "-device scsi-hd,drive=disk0 "
+        "-drive file=null-co://,id=disk0,if=none,format=raw";
+    config.objects = "scsi* virtio*";
+    g_array_append_val(configs, config);
+
+    config.name = "virtio-gpu";
+    config.args = "-machine q35 -nodefaults -device virtio-gpu";
+    config.objects = "virtio*";
+    g_array_append_val(configs, config);
+
+    config.name = "virtio-vga";
+    config.args = "-machine q35 -nodefaults -device virtio-vga";
+    config.objects = "virtio*";
+    g_array_append_val(configs, config);
+
+    config.name = "virtio-rng";
+    config.args = "-machine q35 -nodefaults -device virtio-rng";
+    config.objects = "virtio*";
+    g_array_append_val(configs, config);
+
+    config.name = "virtio-balloon";
+    config.args = "-machine q35 -nodefaults -device virtio-balloon";
+    config.objects = "virtio*";
+    g_array_append_val(configs, config);
+
+    config.name = "virtio-serial";
+    config.args = "-machine q35 -nodefaults -device virtio-serial";
+    config.objects = "virtio*";
+    g_array_append_val(configs, config);
+
+    config.name = "virtio-mouse";
+    config.args = "-machine q35 -nodefaults -device virtio-mouse";
+    config.objects = "virtio*";
+    g_array_append_val(configs, config);
+
+    config.name = "e1000";
+    config.args = "-M q35 -nodefaults "
+        "-device e1000,netdev=net0 -netdev user,id=net0";
+    config.objects = "e1000";
+    g_array_append_val(configs, config);
+
+    config.name = "e1000e";
+    config.args = "-M q35 -nodefaults "
+        "-device e1000e,netdev=net0 -netdev user,id=net0";
+    config.objects = "e1000e";
+    g_array_append_val(configs, config);
+
+    config.name = "cirrus-vga";
+    config.args = "-machine q35 -nodefaults -device cirrus-vga";
+    config.objects = "cirrus*";
+    g_array_append_val(configs, config);
+
+    config.name = "bochs-display";
+    config.args = "-machine q35 -nodefaults -device bochs-display";
+    config.objects = "bochs*";
+    g_array_append_val(configs, config);
+
+    config.name = "intel-hda";
+    config.args = "-machine q35 -nodefaults -device intel-hda,id=hda0 "
+        "-device hda-output,bus=hda0.0 -device hda-micro,bus=hda0.0 "
+        "-device hda-duplex,bus=hda0.0";
+    config.objects = "intel-hda";
+    g_array_append_val(configs, config);
+
+    config.name = "ide-hd";
+    config.args = "-machine q35 -nodefaults "
+        "-drive file=null-co://,if=none,format=raw,id=disk0 "
+        "-device ide-hd,drive=disk0";
+    config.objects = "ahci*";
+    g_array_append_val(configs, config);
+
+    config.name = "floppy";
+    config.args = "-machine pc -nodefaults -device floppy,id=floppy0 "
+        "-drive id=disk0,file=null-co://,file.read-zeroes=on,if=none "
+        "-device floppy,drive=disk0,drive-type=288";
+    config.objects = "fd* floppy*";
+    g_array_append_val(configs, config);
+
+    config.name = "xhci";
+    config.args = "-machine q35 -nodefaults"
+        "-drive file=null-co://,if=none,format=raw,id=disk0 "
+        "-device qemu-xhci,id=xhci -device usb-tablet,bus=xhci.0 "
+        "-device usb-bot -device usb-storage,drive=disk0 "
+        "-chardev null,id=cd0 -chardev null,id=cd1 "
+        "-device usb-braille,chardev=cd0 -device usb-ccid -device usb-ccid "
+        "-device usb-kbd -device usb-mouse -device usb-serial,chardev=cd1 "
+        "-device usb-tablet -device usb-wacom-tablet -device usb-audio";
+    config.objects = "*usb* *uhci* *xhci*";
+    g_array_append_val(configs, config);
+
+    config.name = "pc-i440fx";
+    config.args = "-machine pc";
+    config.objects = "*";
+    g_array_append_val(configs, config);
+
+    config.name = "pc-q35";
+    config.args = "-machine q35";
+    config.objects = "*";
+    g_array_append_val(configs, config);
+
+    return configs;
+}
diff --git a/tests/qtest/fuzz/general_fuzz_configs.h b/tests/qtest/fuzz/general_fuzz_configs.h
new file mode 100644
index 0000000000..afea8dee92
--- /dev/null
+++ b/tests/qtest/fuzz/general_fuzz_configs.h
@@ -0,0 +1,24 @@
+/*
+ * General Virtual-Device Fuzzing Target Configs
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
+#ifndef GENERAL_FUZZ_CONFIGS_H
+#define GENERAL_FUZZ_CONFIGS_H
+
+#include "qemu/osdep.h"
+
+typedef struct general_fuzz_config {
+    const char *name, *args, *objects;
+} general_fuzz_config;
+
+GArray *get_general_fuzz_configs(void);
+
+#endif
diff --git a/tests/qtest/fuzz/meson.build b/tests/qtest/fuzz/meson.build
index a59de6aa8c..42f97555bf 100644
--- a/tests/qtest/fuzz/meson.build
+++ b/tests/qtest/fuzz/meson.build
@@ -5,7 +5,7 @@ specific_fuzz_ss.add(files('fuzz.c', 'fork_fuzz.c', 'qos_fuzz.c',
 specific_fuzz_ss.add(when: 'CONFIG_I440FX', if_true: files('i440fx_fuzz.c'))
 specific_fuzz_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('virtio_net_fuzz.c'))
 specific_fuzz_ss.add(when: 'CONFIG_VIRTIO_SCSI', if_true: files('virtio_scsi_fuzz.c'))
-specific_fuzz_ss.add(files('general_fuzz.c'))
+specific_fuzz_ss.add(files('general_fuzz.c', 'general_fuzz_configs.c'))
 
 fork_fuzz = declare_dependency(
   link_args: config_host['FUZZ_EXE_LDFLAGS'].split() +
-- 
2.28.0


