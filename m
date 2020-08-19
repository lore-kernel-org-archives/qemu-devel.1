Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0678C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 06:14:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A05DA2063A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 06:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="Fa1+gooT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A05DA2063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8HMc-0000bG-Rl
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 02:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k8HKF-00047v-04
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 02:11:55 -0400
Received: from mail-dm6nam08on2119.outbound.protection.outlook.com
 ([40.107.102.119]:43040 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k8HKD-0001Ya-9b
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 02:11:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nS0wZ1vxXFwH09cMUPT6hfpFt9y4hrDMV0DQSqNO5E7rvbcyqpq1NoZyy05xHXsLRUoS49lDtXj8ZJ9MdBu/s6/hvVj374MeUivu5xTIB2Ztj22qFUTgzM2Rohxa8prqpHyabF3fp/KXpJUnXIbC7/dbhJzutsspOAVmJ/6pNdhEX3d5n9IkY/WN4Q1YZpDyUTACVLULkE4vs7W/soQdxnEdXSuNhmdpeXeI8iwkNZSSYFx1AkagVTdda8wCb33UPuwMU8ccB1gmVrBeJeXHDMMAkiQdUKJDEJ2dLzcQKY3jKj8BqdMa6IUKWRkL8ALiTl2Bm1VIpfn0+FissJP1tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsvnYrqrAnVDB2Zr7IRC0dE3StgyMFquvqkkkQsDfAI=;
 b=MY5dGPDP+ZqCr/znFmT9Pslx+H8/Fo14+F4jysEGQThmt4o98bxI5embLpo4cwOhyo2oHFrubIr2Oid5rFf8uOnm+GcGGvPQCCM7pjV4voWQ3QtLGbvoZWEu6dyVOeZezFccRupdRnXqG+OCBife/MQOwhfxGijUdt6ip5Rf8P0tpEbG12++F23zc9zPtQqEeQaV9fYvP6NbCvpdBd9d5a018W8vSzrxDemKrBtqLaxUb3bRQSeJOI9lRYn60ln8EAFYtSOJs/v0STZI+hE5z09s5AW7ank2qi+G4vNThGYs7j0r/D/ecirk9+QlOMovpJLI5w2WM2b+LGRZajX/sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsvnYrqrAnVDB2Zr7IRC0dE3StgyMFquvqkkkQsDfAI=;
 b=Fa1+gooTNcRb2xwKtNwehWBVULFfCdYDkxp2UwQ1jjS8cR+RyidxO6tJsFfOh8gjZJ1kB1w/HPF1j1KGDGOi7T4tK3opiPrjhmcSaGWFD6lqLdk0cKqPvY4RdBGbkyg7PKDfntIgttaEKubJr1ta/4lbk08Zlyi2EbUrXJb9zek=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3486.namprd03.prod.outlook.com (2603:10b6:805:44::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Wed, 19 Aug
 2020 06:11:48 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 06:11:48 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/15] scripts/oss-fuzz: Add general-fuzzer configs for
 oss-fuzz
Date: Wed, 19 Aug 2020 02:11:07 -0400
Message-Id: <20200819061110.1320568-13-alxndr@bu.edu>
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
 Transport; Wed, 19 Aug 2020 06:11:47 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7565a8dc-5ef7-437b-5e0f-08d84406c15a
X-MS-TrafficTypeDiagnostic: SN6PR03MB3486:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3486FBF4D01CEAB39FFFC8A1BA5D0@SN6PR03MB3486.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zYMvHCtUvLYVUadrZA9IDaCWWi2XFy4ShZnUGJ9fPV3W/esOVUj+cyZ15/OT+zhbnMoWPBSv7NYHNdUMcvwgg8ewV1RisXBommJCvN88QGmZn9B8WCNDfH8eQBoIgAg7X9HnCNgFD3B9w1/VfJxid7bEYDtMWdD3f4uUrzyOdyQwgpvYbtVFwi8E5IIh5bXBd3P8eM1AvBjcVhgeGkZwFe7Rdoje2a15b/MnzLDK3AxgO82O0gBBqC8/ubqI9gb7FgIS828Zq+ozbWDCrXljhf2sUK9v0C+gJtnFLOvvH5yckI3UEzDysQQyzHupnX2r
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(5660300002)(66946007)(1076003)(6666004)(66476007)(8676002)(66556008)(956004)(86362001)(786003)(54906003)(316002)(2616005)(26005)(75432002)(4326008)(6916009)(6512007)(6486002)(8936002)(36756003)(16526019)(186003)(2906002)(478600001)(52116002)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: C4hSQz4XsXda+HAM3hsB7asBg2XeovrNArEdXv7P1tfuIX3VhmGBsPR/iIitBEt9Lpdt2A1lZhge9aY3ZtKMJEP75b5pOfVq+VnyXke39338n/76XRkK6gdvVzL/QkhyoSVln/1LZ3S1cyyqZF76r3JLeZtmEUEEGgGqcG9QK0YiyOfEDhPkQ+itb3zCjXox2WTOUNfKmos2LUQ7yoPfOpaBKvUGAZML0l/nbSyCb9/5fYJ8dYdzz5IxuaTlpz9nSPA8SIlNDnKH1qgh2c7W+viat6kIyXyK9sjIR4rgjePdpv//xOqE/4Yqx00cBIi7Ah00eTj3ZoJQxx5jkSYx19ZYurNW8fZw/Ezm7J6SOekee2eORUz7br3mSFje1gV0hZ3vdVISMwg93xhPY5ovJO9I+Ss5qovjChPY8p6YlqLzJG0QgVqHEpi7Wly2/76VcldzGHMv9Tqr2w5iQQhPI6X65FOCge1ID3YJGrR5KiRUUA+2bTZ7sSYq3Z+U+eYrfTj44/u+7z6YX+btC7M4T5EFEGXFzCqtJEJqeaofPZWuKt8BOvlfSriHqfTX4WgjKjmOqCgt/sGIlru/3LVBO/y19RsTPkkhF/VQaDzOVuvK54YwfOMDZJSK3kLkFWh3QeKUEe2Yl2VpVPsRe63NZQ==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7565a8dc-5ef7-437b-5e0f-08d84406c15a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 06:11:48.0950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z4n7+Ou9j4UVJBJGWu6AzUGX2nx0rNO7OglZ0SPgyHVc4C/4PE2zB/2KMEiJ29BL
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

Each of these entries is built into a wrapper binary that sets the
needed environment variables and executes the general virtual-device
fuzzer. In the future, we will need additional fields, such as arch=arm,
timeout_per_testcase=0, reset=reboot, etc...

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 scripts/oss-fuzz/general_fuzzer_configs.yml | 103 ++++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 scripts/oss-fuzz/general_fuzzer_configs.yml

diff --git a/scripts/oss-fuzz/general_fuzzer_configs.yml b/scripts/oss-fuzz/general_fuzzer_configs.yml
new file mode 100644
index 0000000000..010e92a2a5
--- /dev/null
+++ b/scripts/oss-fuzz/general_fuzzer_configs.yml
@@ -0,0 +1,103 @@
+configs:
+    - name: virtio-net-pci-slirp
+      args: >
+        -M q35 -nodefaults
+        -device virtio-net,netdev=net0 -netdev user,id=net0
+      objects: virtio*
+
+    - name: virtio-blk
+      args: >
+        -machine q35 -device virtio-blk,drive=disk0
+        -drive file=null-co://,id=disk0,if=none,format=raw
+      objects: virtio*
+
+    - name: virtio-scsi
+      args: >
+        -machine q35 -device virtio-scsi,num_queues=8
+        -device scsi-hd,drive=disk0
+        -drive file=null-co://,id=disk0,if=none,format=raw
+      objects: scsi* virtio*
+
+    - name: virtio-gpu
+      args: -machine q35 -nodefaults -device virtio-gpu
+      objects: virtio*
+
+    - name: virtio-vga
+      args: -machine q35 -nodefaults -device virtio-vga
+      objects: virtio*
+
+    - name: virtio-rng
+      args: -machine q35 -nodefaults -device virtio-rng
+      objects: virtio*
+
+    - name: virtio-balloon
+      args: -machine q35 -nodefaults -device virtio-balloon
+      objects: virtio*
+
+    - name: virtio-serial
+      args: -machine q35 -nodefaults -device virtio-serial
+      objects: virtio*
+
+    - name: virtio-mouse
+      args: -machine q35 -nodefaults -device virtio-mouse
+      objects: virtio*
+
+    - name: e1000
+      args: >
+        -M q35 -nodefaults
+        -device e1000,netdev=net0 -netdev user,id=net0
+      objects: e1000
+
+    - name: e1000e
+      args: >
+        -M q35 -nodefaults
+        -device e1000e,netdev=net0 -netdev user,id=net0
+      objects: e1000e
+
+    - name: cirrus-vga
+      args: -machine q35 -nodefaults -device cirrus-vga
+      objects: cirrus*
+
+    - name: bochs-display
+      args: -machine q35 -nodefaults -device bochs-display
+      objects: bochs*
+
+    - name: intel-hda
+      args: >
+        -machine q35 -nodefaults -device intel-hda,id=hda0
+        -device hda-output,bus=hda0.0 -device hda-micro,bus=hda0.0
+        -device hda-duplex,bus=hda0.0
+      objects: intel-hda
+
+    - name: ide-hd
+      args: >
+        -machine q35 -nodefaults
+        -drive file=null-co://,if=none,format=raw,id=disk0
+        -device ide-hd,drive=disk0
+      objects: ahci*
+
+    - name: floppy
+      args: >
+        -machine pc -nodefaults -device floppy,id=floppy0
+        -drive id=disk0,file=null-co://,file.read-zeroes=on,if=none
+        -device floppy,drive=disk0,drive-type=288
+      objects: fd* floppy*
+
+    - name: xhci
+      args: >
+        -machine q35 -nodefaults
+        -drive file=null-co://,if=none,format=raw,id=disk0
+        -device qemu-xhci,id=xhci -device usb-tablet,bus=xhci.0 -device usb-bot
+        -device usb-storage,drive=disk0 -chardev null,id=cd0 -chardev null,id=cd1
+        -device usb-braille,chardev=cd0 -device usb-ccid -device usb-ccid
+        -device usb-kbd -device usb-mouse -device usb-serial,chardev=cd1
+        -device usb-tablet -device usb-wacom-tablet -device usb-audio
+      objects: "*usb* *uhci* *xhci*"
+
+    - name: pc-i440fx
+      args: -machine pc
+      objects: "*"
+
+    - name: pc-q35
+      args: -machine q35
+      objects: "*"
-- 
2.27.0


