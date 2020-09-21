Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA94FC43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 02:36:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69E2320795
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 02:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="Co6bpaDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E2320795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKBhG-00013s-Fh
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 22:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kKBWe-0003MA-Sl
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 22:25:56 -0400
Received: from mail-dm6nam10on2102.outbound.protection.outlook.com
 ([40.107.93.102]:19201 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kKBWc-0000aa-UN
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 22:25:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxAYLMlJMSdN+zqUdtW4vCQWWbt5oAgmEOIahq4hwNkTbBo/AmDDAQaXS6/SCi5i021lbCPplU9/K+KJy4DpOze5oN8S3Cj1CT25qDbkhA6COB/HwZcJk6yzuVbD5vitWq26or+YFZSOh7Nsn8cATnauPlpU4ybfentbvYr6Ozge+3/sqVjZeKvUTeeGvk8RxSRYyZDKbcJh2J+wXIjoTY2HJVV5chvUv42LKzhU1mPjksiG6zQ8nVrRfBCLICQZLaMP7OkCPKKBYJy3sunhoFJ3Hla5ZI4HH/kT5Y44e0Rpg6X4raL5jdV2pRZaAXOVEPHhJVneGAaW7pyxsfqkpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTVG0JaNcRK1O8YcQ/w2miabgaspKeTz12GX27XViEU=;
 b=DqhCu6H1ZfIHttz5sdvni5yaG6iGwClUb/IJxfG5vmcbmcegKruzPWDI02kd4RzFZs9k1aAm5aXl7Jx/ZQ3IdVcJvjtwOcdnQST5eB5EetvN2VhKfWYFWGlmYw2uS3c7yn/aBKSmfTcWEfQvLa4v5jGP8DT+v1J1PhQ37hDQ6hcF5v2k6Cfwg0jmgFinutfEn0oGPlcyptgSwWMyyxb12ySOpLURwxRTBKbkJvuws1z0ISfOIriE7zdBoFx1v1pqJdOFxnRNMIXcnYEVcAX6iwd6F4mulVVOzZEsVhbzUw/YdmHGwfJl8Mq28uL3nexvngnYFvgG0APBFFMpeYf9Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTVG0JaNcRK1O8YcQ/w2miabgaspKeTz12GX27XViEU=;
 b=Co6bpaDVFddCnX4p9aXO6dFvNW1qCn+q14BYe+CB+KK2dO2EGRLgElM0F+i7UkqF4qLj3wDqukxEPy3st5ONQnl7e38ippUTT6gffxm6e68G1BcXGQprCRfHGBAjDOcsP8Ft1NbOZYZlQpwjwJxmp+DIQtVSC5hftvQSLi2dosI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN2PR03MB2237.namprd03.prod.outlook.com (2603:10b6:804:e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Mon, 21 Sep
 2020 02:25:41 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3391.024; Mon, 21 Sep 2020
 02:25:41 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 12/16] scripts/oss-fuzz: Add general-fuzzer configs for
 oss-fuzz
Date: Sun, 20 Sep 2020 22:25:02 -0400
Message-Id: <20200921022506.873303-13-alxndr@bu.edu>
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
 Transport; Mon, 21 Sep 2020 02:25:40 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb7163f5-48d0-4918-16fb-08d85dd5a28a
X-MS-TrafficTypeDiagnostic: SN2PR03MB2237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR03MB2237C129ACDF01DDC8DA95ADBA3A0@SN2PR03MB2237.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HF981iGDQqXThi082EAKq+XC1yzL57cTkDaaeCu+2oBagIktg3vRuM0936GI1vV8e2JlcRozikQYvkXiQiRZKXS2W7Xl1d7h3uTjJi6jjLHB9duYqklXiiEuatU057ysjcZO/nGUYtHKqJVOo3mv/AcW3zG64zE9pzVZnfSz9K39xrq0sVlNIz71OZGEJ0dTcq9OozsVIQqFxRE43sUgfEGAI6nrBCD+dt9mg56lfbPQ5JJji8mlKama0VN/ZSB0txdslTfkIjDr5AjunEbSWsIJfh2sM7HrRG6ICimnz00L1IfcvgB9zOmBmBIB3xXkajBY+SXGYyUGuuxvYP0gAmiCMNFts9+sfhL9gRSQShK0WYtzz3Wly/xPbaxRKBeW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(2616005)(956004)(4326008)(54906003)(26005)(478600001)(16526019)(6666004)(8936002)(316002)(6486002)(66476007)(1076003)(6512007)(186003)(6916009)(86362001)(66946007)(5660300002)(36756003)(75432002)(2906002)(6506007)(8676002)(66556008)(52116002)(786003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: A+gQSva0kg9HirgeQ5BEmSgyTwtC45xpUT8ToKRHJmLYel7BZ57MqDGh7m6txMfuforTwBbX1FCNn/ePh3KhhQqg7tSlV1iNeLksGH0+mTymCXzUUJ1Yb3adrK3fUi5P9CFdcUU5uiUmyUU4V4U1PCL5STQnWOMLRDxvicQxmLDcUvAM8MSkdO/APJ8Y2c42rOf3G4eI7E12y/TxuuMhk8YB1hjw7JCD0FajyOQHBKWIRy1rqsia7PZKpiTuv8rMjhpszTmulbDmrOVyjWENlJfda7Om7l7gRJ+MvUN899zdjHiNxRxFTXXGDzh8s/caWqvroWIQGjAjyCmOD0AO0CkNrWFxZxKG1MWu/uUdy93zzYJKNi/D00W/+wCO4oUncWEKQhC1dsnuVm/X8lQhHPFjydmwWyMPvvEz+b2QEKPa286KTZ7Q6b+Ya08YkvHVSZLWN1cHoHcrGQIzKZ3ZLPDTMw/ziMuXdhFonXzgyBv3OXSEofD8LeCTHuXxg3BnCdkHejGwawoAjCVvZTLahg7bIfDC741/hWvbXWaN9ph/C0fAoU4PA5xbNU5bIlRb9cBVlhkAOvaWKA25Zeh60IhVDqYImyDRToEYS47QmOqOyRKjRMm7xxAkp5yBxYfcmq8OEJ3D9WKqIJT0B6DXpg==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7163f5-48d0-4918-16fb-08d85dd5a28a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 02:25:41.4778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lKkU24ds91gZTVRJ9VFiFWFAcUMX3aMcyQMsw26UC5Hx0Ut1Mwgi0NN6so7qbwpx
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

Each of these entries is built into a wrapper binary that sets the
needed environment variables and executes the general virtual-device
fuzzer. In the future, we will need additional fields, such as arch=arm,
timeout_per_testcase=0, reset=reboot, etc...

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
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
2.28.0


