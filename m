Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E8EC4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 01:21:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73AEB22253
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 01:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="qiaKGZpM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73AEB22253
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV2ov-0003W8-CO
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 21:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kV2cM-0001Oy-5R
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 21:08:42 -0400
Received: from mail-co1nam11on2130.outbound.protection.outlook.com
 ([40.107.220.130]:28640 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kV2cK-0004s9-CI
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 21:08:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dj4g7y9vkr3x2D3+VfPbyfbrkHyzwQIgk5LMzj8ct6sOw2nkO9b1dVIej3VewNgGCCS7GRjlnJAXtc3N5ivjri7Cz7UTc2N5LwtP4s29Q+npC1BXtOjPRZDdYzPcOah/sWRl67dX7YyODdvtyPyql8M/Bo5afcok5l8awkSTZ01P/73WGd53QuwcRIuQS2r2L0EKXSVllMizlwX/PV+qTOUwj6JGw2ieMhTeqZ9toMhJWMzasYcn0HZASCZkh7GmUvM7aNEua5ZtXpKOuPTnHzZG3hhJsXTfZGfXHlZ5zoecsYgUXLHcl9iEok/6SrLRzL5UFCsgsqt+bx42/GsG2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkPtyz+s8b1KH6hKK/ioFOQE62kpgItYmb7x6kdTH/8=;
 b=Ykh78gKom7bQiYg8Pz74Hq518iSZPz5pgZ6McJWeaKaEBfdE8iqDQojfyXWqOjSSeuwRMpDK1kwReUKhS25s6EBzz521fkOmFgpEXQ6mHsMDKv0+PfHOtsPSRxOVQMdFpZTcxbxPTwW6+8E277JajpAbf7U7Vkab9b32/r7oW0Yxh5+REUy3756k7QrdrSQF+Ji6gCCk+V0Ap4mHlhDwwIrH4J7xqx1nNoGH6f1J2rRbJbdFTgoNvTCvUsuiViorYS/0OcPIyDXjQqE4qOtn/ZCHMA/FaYwZNd+STrpEef9LOZ4vKJKS7eGzSznn/7hphE+l0BepdMY+5RyERY7Gcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkPtyz+s8b1KH6hKK/ioFOQE62kpgItYmb7x6kdTH/8=;
 b=qiaKGZpM8rZGHO65cimlyJAsJgcCRmHPbRyXxEKf/q2rh/pHpMwctq+NJdBIQVWuiJ5+BKwI15fTEXMBa3d4PvjWTwKRsaaKA9NHjUA8XgEm+kKeYkdT6/HnW1PTxVLFHlbmAGOHG89atUpjcZ77AfUy6N36hub3kG2YFNNXEBs=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN2PR03MB2333.namprd03.prod.outlook.com (2603:10b6:804:c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Wed, 21 Oct
 2020 01:08:22 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 01:08:22 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 12/16] fuzz: Add instructions for using general-fuzz
Date: Tue, 20 Oct 2020 21:07:48 -0400
Message-Id: <20201021010752.973230-13-alxndr@bu.edu>
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
 Transport; Wed, 21 Oct 2020 01:08:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afcda1f7-3c63-4eff-b6d3-08d8755dcda2
X-MS-TrafficTypeDiagnostic: SN2PR03MB2333:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR03MB233374ED2BC66A943D63EB5ABA1C0@SN2PR03MB2333.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gozRIvRj7eMjv0qFtK/wotV+0ihQGiMjmpILyq71uFVg/Tw+UaNTrJr/h080aR0A8qV/uYODsJ9X1qnHSx5fyocjqYqcODcrC09R6uGr81JFW8/DaFRuhIr1jItDqJ+ARAdyZmdDCMEikE4SHSO6MNlBi9ErU3kBSEpPK6QtYE5xCOSsd5Q9wWKX5Sk1fXOsXNHzBodgGd3MA0+uZ9Y/fZgQS+E/m67dMy+pw7GGedPMWN7O5/IOmh2fwy4cX/aWQ7F10z69UEJ+slDD9REkuIndYnWkk7k+xSBC9/apstJiYRD6kquz3VnmhaBQqr4GEkCzX6MM7ehnvQ6t3KHZKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(52116002)(2616005)(8676002)(6512007)(6916009)(6506007)(36756003)(786003)(316002)(956004)(83380400001)(478600001)(1076003)(4326008)(6486002)(75432002)(8936002)(54906003)(86362001)(5660300002)(26005)(16526019)(186003)(6666004)(66946007)(2906002)(66476007)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: JjsSoSkKm60p5OlpwiOxbyIgNUpOsMiPyYeVJfJXucVdT4CLyQ7dANFSBBlYJi/cuDbRC+lZMkPTZmYCgjW8sLqIguZYhWq1Xzt8K8BuObdroQ/pV9xiBXB9uWPnZy+5Cy1YwbDJamaL4SeSWvQGbTF32x6UiaY4onTF1OMBB0NL+IxfaHjadiMYTHAOdSiEi3CxZ1nfU1ckhCLsw1WB6UIRJHPVh9osYzfu2xyF0hfkLiiN8a9GzbxrMsDDThMyQErARipjlRiKv+j2aS/8YWPmYKw5QOCXHElI9iBePDk10dsmBy/5GTcZQoh1HIV0++IO5UdbOIq/gy5HlttMQdKMYI2N9UHllqWr00EtpYempnl2zpkS/00oY/31kZ1APGY7uqAPrkHa4clsF8kGb/TdIAeKhVho8HNmd4nGL3A3wEITMxfuGiE6X+HKz1+0O0mfVEMhcoM/8rY9sNP5ltacOyw/oprakFz6V3a7RAcmtBf2IaU2ep9Kiy6MrD9CWz/KVYSUoPncAGnFWegv3mrBX3g21OGHktPVLoMazoLxl7lLgvze//CDDQZ1ZeV5kNWk1LGOJLCFGQhRTHxsaTvEMRlUVKk3YJ33S+EumO5lu1woatNjk1jHpz5jNIWiPwAwG9FqdWcVDRggrmT/4g==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: afcda1f7-3c63-4eff-b6d3-08d8755dcda2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 01:08:22.3451 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E1JAWDBAjwobQbq3nCVT1vrS4Hyf41KOG8pqNANQh/Pu8SeMo5YycAZOCD0H0vsJ
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
Cc: Thomas Huth <thuth@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 f4bug@amsat.org, darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 docs/devel/fuzzing.txt | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/docs/devel/fuzzing.txt b/docs/devel/fuzzing.txt
index 96d71c94d7..c40278fe0a 100644
--- a/docs/devel/fuzzing.txt
+++ b/docs/devel/fuzzing.txt
@@ -125,6 +125,45 @@ provided by libfuzzer. Libfuzzer passes a byte array and length. Commonly the
 fuzzer loops over the byte-array interpreting it as a list of qtest commands,
 addresses, or values.
 
+== The General Fuzzer ==
+Writing a fuzz target can be a lot of effort (especially if a device driver has
+not be built-out within libqos). Many devices can be fuzzed to some degree,
+without any device-specific code, using the general-fuzz target.
+
+The general-fuzz target is capable of fuzzing devices over their PIO, MMIO,
+and DMA input-spaces. To apply the general-fuzz to a device, we need to define
+two env-variables, at minimum:
+
+QEMU_FUZZ_ARGS= is the set of QEMU arguments used to configure a machine, with
+the device attached. For example, if we want to fuzz the virtio-net device
+attached to a pc-i440fx machine, we can specify:
+QEMU_FUZZ_ARGS="-M pc -nodefaults -netdev user,id=user0 \
+                -device virtio-net,netdev=user0"
+
+QEMU_FUZZ_OBJECTS= is a set of space-delimited strings used to identify the
+MemoryRegions that will be fuzzed. These strings are compared against
+MemoryRegion names and MemoryRegion owner names, to decide whether each
+MemoryRegion should be fuzzed. These strings support globbing. For the
+virtio-net example, we could use QEMU_FUZZ_OBJECTS=
+ * 'virtio-net'
+ * 'virtio*'
+ * 'virtio* pcspk' (Fuzz the virtio devices and the PC speaker...)
+ * '*' (Fuzz the whole machine)
+
+The "info mtree" and "info qom-tree" monitor commands can be especially useful
+for identifying the MemoryRegion and Object names used for matching.
+
+As a general rule-of-thumb, the more MemoryRegions/Devices we match, the greater
+the input-space, and the smaller the probability of finding crashing inputs for
+individual devices. As such, it is usually a good idea to limit the fuzzer to
+only a few MemoryRegions.
+
+To ensure that these env variables have been configured correctly, we can use:
+
+./qemu-fuzz-i386 --fuzz-target=general-fuzz -runs=0
+
+The output should contain a complete list of matched MemoryRegions.
+
 = Implementation Details =
 
 == The Fuzzer's Lifecycle ==
-- 
2.28.0


