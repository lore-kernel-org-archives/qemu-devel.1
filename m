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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40C8C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:44:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF04F20825
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="E/21dgEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF04F20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyS9w-00040i-T4
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 23:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jyS62-0004bP-R5
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 23:40:38 -0400
Received: from mail-mw2nam12on2114.outbound.protection.outlook.com
 ([40.107.244.114]:16939 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jyS60-0002Ew-Uw
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 23:40:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGatZOt3fRqbMdK8YmLqDYgNDJVjMKc2HLJEtv4EjvWavIMdYH1bNnojqBVNQVpNhHB0+CLUgbB8WdtuKthXaFQmhTtDci3sSwI6+eeGTBlB+4mh/sNCGN9kHAPfDWeK5QFwI7fON0gIhQxeEcVb+G0u5nVFYsQ3ovP/K7Jg6fyATutcC4JS1qAqq4gx04dRa9FyWBjlFdcJU5/CnyhgtkGA4XhqN+0d8sVGNSjEtdlfObzMGJnZUw8/iSvf+t2a47+zCTjnS5NAT6bkDEywlhImE0OTw7ByJwLjzohhzxYAhuDQ5RSPRTej4PJMpnZiKuKdfSPgzWjiZijEG+kugw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzqW7uPsjLhStWhqv5CwHqpQiOHX5JqNR8rT1el2Rs0=;
 b=h8fvNk29+CPr9uWZVEWSaew8PORCUVRMajPr1Q1xe79zhUScTTSbgYwmGJ4GRIkLLzhDCuv76aCzJ6ChNRpErgSDpFwWmaGrjiaOpk1mKU5Pg7RFak/qZCe2E/c3O2L5O4Q1FeLeRmjSqWIJKlCdvrriL4sl9NOHRP7EvRYCpoz7vlnZ4qVtLgRZfBp7k+663wnpFuCMPqltdWQlDDIrNFeMiDXQ3PZC9AuVL1lSR4IuanG2JhNV32dk4pdjS300u+x9Co08vQ/G7rOXsMkut0k+UWXYo0BRG+9Z99dRNDdybHkfVLadXgEzwrRWfch3c7TbNRclM1UVpxtztuU6Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzqW7uPsjLhStWhqv5CwHqpQiOHX5JqNR8rT1el2Rs0=;
 b=E/21dgEYMLt5s5nlyoTC+7WxnttQnEaFSUauA79C5pg4cterzXgpfhYVeoedoIpXjaHXojXdj7xQWziVOzCP3Dto3HCUe+GwHVBfsxbzz3dx4UR8ObzbyeBnHDUgy5VLHqBMc+ccXd8g7pazAsh0u48oN7I1RKOXcncXcI3J91w=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3982.namprd03.prod.outlook.com (2603:10b6:805:67::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Thu, 23 Jul
 2020 03:40:20 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b%7]) with mapi id 15.20.3216.024; Thu, 23 Jul 2020
 03:40:20 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/12] scripts/oss-fuzz: Add general-fuzzer configs for
 oss-fuzz
Date: Wed, 22 Jul 2020 23:39:30 -0400
Message-Id: <20200723033933.21883-10-alxndr@bu.edu>
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
 Transport; Thu, 23 Jul 2020 03:40:19 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a2b9ef6-f7cf-4ce3-3dec-08d82eba1fba
X-MS-TrafficTypeDiagnostic: SN6PR03MB3982:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB39825682112C02571954C977BA760@SN6PR03MB3982.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: URr/V7I4s4tRLDJ4QQSg2gg7dBUDkR35jI5MfelIR3EMPHrtzFgh1Cn9mjQ/XW3IbYeMJ+53oUWgjpdR0WUzRDqu35eYvxeqFrS0/jlzJVFe4bYJNdnNa5jCPcn+ORjMPDjz/u3bdSqeetT9P3AjHdTaG3SO9n+h0X8BGZzLOjb5Mymn4ox4f1Rm0jmlp4hTQ1byAmOdSKGxuNfGVn7tTvhRJPrVhg1Y4LJIziAxV2ncoqyJVk6wTWfbCqYGM1HP8AKupW19hAHRvNPZbR6IaiOJdu96GVameFvSSP3YIaPs8eNc9GxnNImeu+PZt8NB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(6916009)(4326008)(36756003)(478600001)(5660300002)(2616005)(956004)(6666004)(8936002)(52116002)(7696005)(66946007)(66556008)(66476007)(6486002)(75432002)(26005)(8676002)(16526019)(54906003)(86362001)(186003)(316002)(1076003)(786003)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: yGH1vBgyOc4aYpl1C/+nAuyKI9M3jq73eTR+p8OgldPtdazDlZ1nRk3IylBkRHnHLOp6nWJfJTirT3ffUhhkkGWn3WkHSeeS/lux0n+xYIr3f4eW3G2UReDWhPJMN5tDGpn+g2m1vn20UPmFG24ILzmgvReg/IYwk3dFZPMVE0YuEQkhCTzZJv1TaGMnkU/fSiVzx0R3OQnmCfQ0TZph/oGHprW1DUSNFJdu8fxTE69dopXepZGe1uIHyYxreiUSsopnMOMN71Z5GWLJUxMx6Ma/qt+rHl82S74fW/ZfRz/FGKoRCK9w9EjAwwmGVKckPxRzNWAE1S/q5HQF/Qspet3lO7FWJk86y07R0/rXl6yF5oomT5nD52RgEZDyBXupWxKtWsiqXRWoQLHlSx4xqo/DCkaWIZvf3r1INoaw0EDNobM+bFWa/Wipd2hCzCKyvwAjSJmfTinjof+2lqIidkP2SBf1eIkGUaNWmOakeA0=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2b9ef6-f7cf-4ce3-3dec-08d82eba1fba
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 03:40:20.6767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IdhqHey08a6UIpjqGCXhBVj1iPw/NT8tOP1H3cXE5Ca9a7OamGCg7jDCgW8zySgt
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
index 0000000000..748f4db075
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
+      objects: ide
+
+    - name: floppy
+      args: >
+        -machine pc -nodefaults -device floppy,id=floppy0
+        -drive id=disk0,file=null-co://,file.read-zeroes=on,if=none
+        -device floppy,drive=disk0,drive-type=288
+      objects: fd floppy*
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
+      objects: "*"
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


