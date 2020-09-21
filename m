Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE555C43465
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 02:34:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87E1D2078E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 02:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="KGC9SMDc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E1D2078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKBej-0006Ud-N1
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 22:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kKBWi-0003Xy-RS
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 22:26:00 -0400
Received: from mail-dm6nam10on2102.outbound.protection.outlook.com
 ([40.107.93.102]:19201 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kKBWh-0000aa-4m
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 22:26:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKy+uXd3TrvV2GYIqTXcJAeK1Zmnfk+yqUkFChcUpqxJg3NnMOq+qlwESjvChLMIK10TURMXt4hqyNWsXFgA2AlsTwUnYg+Pfzwuy3OonJiZdDxlzyoLDQ0S5y0cailrQzhItjIysVBwzPFhnDzWlD/dSBkEWAsclKGL8nZsC3V9yNVKYcero7kpOJU618/gfYSxQpk3FZvUQcAwnjnpYnnVXXyXGLsrx59OFHHcamS5etFBJVitPBgI8tVYlGPP8s+0jJ9aBGNQz1aUhFTl+0ID+0/Ab4O1rCeTIH6KSYvMehe0Q8mJN9AmrL40FEKGl6bW56GrQv0wHg2w4/AqNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJCe5oqAIP3HXw+8Z68yrHbiF2LvbPR7sPrF0eRbeeA=;
 b=jZuvaAA5Q2psn3L9vYkWvM0EncBsMCxLcdNEoWRVsmpo4blT3zyN8qxQtlheEALluSYlG6kppo7VoaMrG8muzkEII/eZzmo4ewH3QBbYK+VVnJlxe/ZxS6BxiGHz/011wPOImzcI2yNIIRwJBgZqbvRNVZPBxJUc1GmtBZcw/EFNLe+i/Hq6p/YBTxsiAtpECvT6lMq4Dsjq64xKCLgFPjahbodXpI5Qh7cWdwac1ed/zhp2WuoLypswI3vYA+Yd9/qoV13YZzFQdYYz5cOgv13YpIDrmOF14KQ8lucK5VDTLJ/1RdGcyo01gIdTPJlW30QSeuSXzOPEPqDbwCtfaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJCe5oqAIP3HXw+8Z68yrHbiF2LvbPR7sPrF0eRbeeA=;
 b=KGC9SMDcMuF2E09OesykARUbvTmg3BSzeQyHpt4X0cxx0/xCzA67+6juBQ4MHcavGwaaMc8awKdu6WxIgdyu3im1Y8ZHMWtMqKTlHvXDRSNQwiVvwHv6eI52hpPLWlHj9ooAF/lzIwDibmXBr6zcXjPNio0UysqIeMi85CFAgXc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN2PR03MB2237.namprd03.prod.outlook.com (2603:10b6:804:e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Mon, 21 Sep
 2020 02:25:50 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3391.024; Mon, 21 Sep 2020
 02:25:50 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 16/16] fuzz: Add instructions for using general-fuzz
Date: Sun, 20 Sep 2020 22:25:06 -0400
Message-Id: <20200921022506.873303-17-alxndr@bu.edu>
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
 Transport; Mon, 21 Sep 2020 02:25:49 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0c6f634-cee5-4dfa-944e-08d85dd5a803
X-MS-TrafficTypeDiagnostic: SN2PR03MB2237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR03MB22376E5DBC0CCA75831C6F30BA3A0@SN2PR03MB2237.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8W09fBUsKPFJm/XO0bNuOVp6fBtP+BJCWzRXuOI9osXC7zqL+Z1QCcxBGr+Y/n2/ymGL4mogZw8U9ubiwCGNiNob4MFCINXi3PF8FMi9wC8lU+6+2thKt2Dp90RWqpHE3E0RH/SYz7dQmdYHAntPW7AHWT1B8HP74PekDoT/TDLoEMh2bMM5yFgICbeEtX85aOd209TNjCS/rjBmlXaLqYI81tQCEEJdRcC8KQSGOmYR1C/r6f2nbSn8pWybgCZPLbQ8XvJFO//FXrJ5wn6CaB5PS5yAbEnkz8FY/ayFK89b2jahAON65786JHskZPgav4QO8Y1xrR//2pgo0Kxbd2DuDMoPAVvIyDRpxNYTTYnF19UpM1P5xuqx4LBWP8Kq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(2616005)(956004)(4326008)(54906003)(83380400001)(26005)(478600001)(16526019)(6666004)(8936002)(316002)(6486002)(66476007)(1076003)(6512007)(186003)(6916009)(86362001)(66946007)(5660300002)(36756003)(75432002)(2906002)(6506007)(8676002)(66556008)(52116002)(786003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: VbaGiGVEPBBRKO1V/JaYN0i4QY8sXJJnX7R3aw4lwHDkW+Dc7wFTJvQsJuh4JKPCtouv6ElAlooIXFDXAa5q0DcrpSKJDx9d12wpUtwmb5Cv9giEOEfh8SAvu7hjSXXyeMMJ/qcZdtQ11/eswOAiWCo7iANdmapY5qk1Xw24J13bbJEt04Z5P8mHv4aPxQSmk+RM0CmDLnrlvqYa9YcMbSMrmNGH6CY8/r6KXZJQaGidM5rHakp7fyUef84xUhAFsieg6lw2+uhREESg0awU9qJX0v+3uoUocBPPFsbMQ5wF7jQEhxbuiewsfBlH/Q6sMAy3vPJIauNLa+TZSSPvgwWEmcxscYZ85WW/1F/Ei35m9eaX1ucMg0gRmIf1tHEOYvF0lqy192E2H1pMPuYD6ijonz/ZaMnifizHRQTTS2smYRHxKTvWQlK1IJ0RZ/n/9dEfFm8KdUalVp0anuJwd5xPo7SnhVgl8ue+lydjecg/bqPqRZqiJTYn9JI1gQgjcBOxZ+hUCP20Num0WeIpFm1Dg1yBcakKHJJBmbs75LPf7LiqpcNfjFT4wC8amSxEbqsxfBnkMeqhm3cIFk+N9Jwtf+ztYN+/+B59sspUkXWWJ+nr6AnOxiym3KBNAIccej0I348UucJPl+wYyQ2duA==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c6f634-cee5-4dfa-944e-08d85dd5a803
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 02:25:50.4007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lb92QPyfLQJSdT6By+SFC5NQQRU31ndWDMhWYhoXREpHKR37vDoHSwosgu+/LDym
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

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 docs/devel/fuzzing.txt | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/docs/devel/fuzzing.txt b/docs/devel/fuzzing.txt
index 96d71c94d7..208b0c8360 100644
--- a/docs/devel/fuzzing.txt
+++ b/docs/devel/fuzzing.txt
@@ -125,6 +125,44 @@ provided by libfuzzer. Libfuzzer passes a byte array and length. Commonly the
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
+virtio-net example, we could use
+QEMU_FUZZ_OBJECTS='virtio-net'
+QEMU_FUZZ_OBJECTS='virtio*'
+QEMU_FUZZ_OBJECTS='virtio* pcspk' # Fuzz the virtio-net device and the PC speaker...
+QEMU_FUZZ_OBJECTS='*' # Fuzz the whole machine
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
+./qemu-fuzz-i386 --fuzz-target=general-fuzz -runs=0
+
+The output should contain a complete list of matched MemoryRegions.
+
 = Implementation Details =
 
 == The Fuzzer's Lifecycle ==
-- 
2.28.0


