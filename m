Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB7AC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:13:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45DE321D47
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="HUMTv+r/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45DE321D47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVylD-0002Eg-47
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVyg2-0003xy-Mf
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:08:22 -0400
Received: from mail-bn7nam10on2131.outbound.protection.outlook.com
 ([40.107.92.131]:42497 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVyg0-0007Ao-Ka
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:08:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNswOKa+u/ULWNV4A1dBic6eAI9XktuN3QcV0Or6tuMF+bkVnW0AmlPpLkd2QQLffzNmTf6umw4o1syD0qd68cxLozNU8MvAmZC6CXrQZfatFes/vJNJaqhTQpOZkOyUwknbcCM0SuP+ngr1vRTVXwDUBBfuQDFM37VG4uT6im7ZwOrUZBCkFQqt4VtsA/OxU7EOiFM1a0ExEMGA34vfHx1JSJbzk+WkhvPlYcltBKv06BU980euk+DmPWLS7ny3PSdYqpZBJohPLKX3QV+Ir6MZ6ysWeb20w0sfOD+v36sjyC3fkXpmX9mdWDovt3vZQxK4/20xkR8qplzK4ttBlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrRR7nYIMtECdJdBZYUDCaRERiVxsTzNuITF8efYZ9Q=;
 b=Fb5GLXSP6TVeTbvgkvYZfC2PGNrY1gkFuP+wcwxxtX2DGGuykNmXeqxGVDSQMKoS6MG9w0MYXmOX0PM8aKyk++vszfBAqnW1Cdfb0eVAlU+Vq5R7FGkvIX4VsJMSFtWhp00QrgDUOPdwxzbBnH5ZIM4rVVnOfml42WLX/Xt4TvvLHezK/nMn/GM5MQWNicpADYvWwp9ke+TGHdF8QXTJ0g6FLevOWU6jUADGW2eaSRW6YxzI62q1BshsEHJEYhsnDSt4VR/c/FyeW8+ReGm9V9cufe64yBg5M6rlPl1xIfMyh3W3aNvmZOz8Ll4rUU1rQk8gL8qkydH+s+KLGW/ONw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrRR7nYIMtECdJdBZYUDCaRERiVxsTzNuITF8efYZ9Q=;
 b=HUMTv+r/564bHede3nOGESeM+kOyW7c7NnjLxOm+H86h+h43n+jadKH02dzkRHpNJQS2JOw8ZQ9OgtRw2X11gZArs+OQOB3XTc4VCuZhw3u6pAul3Bc2DYQ7VGlXB7rTOU+Hd8InbjboNy1xxnmLvKnKoNTOJlnj782EYn5Wcdw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SA0PR03MB5516.namprd03.prod.outlook.com (2603:10b6:806:bf::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 23 Oct
 2020 15:08:13 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 15:08:13 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 12/17] fuzz: Add instructions for using generic-fuzz
Date: Fri, 23 Oct 2020 11:07:41 -0400
Message-Id: <20201023150746.107063-13-alxndr@bu.edu>
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
 15.20.3499.18 via Frontend Transport; Fri, 23 Oct 2020 15:08:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ae08ec0-7391-4b72-96c7-08d877657673
X-MS-TrafficTypeDiagnostic: SA0PR03MB5516:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR03MB5516B8BB11A78B7E5B28E87FBA1A0@SA0PR03MB5516.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cGtc6QM7zWmI5CJ/cEn2sz73K8eq/uIjHZha/2fiCDs6kf/e9s4eJNxiFdudesyHO5OFIGJX5nae5lwes26iAqX23ztpfZoQI5MMortmJ9Iic9JUOYh6oe68D1ZfsqEeW9XZYIEea+spGzTb2Sv17RFxxGnvGcRdag6KKRCZ9L/nI+oOQOWHC+qtlP+Wp7XuaXfze+VMIStG8wmqy1lQ3hhcIGlLLaYpwrhxh72fCTqdnnu4s6ch9I3HJPTPotyXceEsOdFKQqAOmBXA/tqLfrUMv8qIJ4a+Ec2XyeD5Kd1eqlYdO8/3y5PBt/N3bsWwk4VuTINxIi2YTRshzA44hSR09vG3dEVx5pXrb5jbcGSoHkPLw0RTlT/VmRzruaop
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(2616005)(4326008)(1076003)(6512007)(478600001)(5660300002)(83380400001)(8936002)(8676002)(86362001)(2906002)(956004)(36756003)(6506007)(66476007)(6916009)(786003)(66556008)(75432002)(66946007)(52116002)(6666004)(186003)(26005)(6486002)(316002)(16526019)(41533002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ceiBp9RqjWopwCvRJKqYVRTKbrpJAfVJ23o0rv5aDQ0zYl1HwSkYQQPy4HvJMFnt6C6mWTlpLZC9lymEvrVnshdXDDaOUqKcHU7eP94cDsjr6Tt1Y6BFIK/m9FH01f7jMCsWuZN5hWqqNzYoGJyyddbEpBHLfjmsvjh9U9j5jXA1umXmj5+bkmL1IwBhDCXsr80J3P/KwTFIJSuHU4PY6ND6iTupyvS06GbhhfK6iC2EVU1UPMB0fgRQo+UwWinAivzB84+frvricHJPtswNCsDRRZ/Vsb8LAPVtUJJHLPJJcaRikowWaAwL61VcaU4adb6pKx1QPK8XCDoMZtLouOz/z5Qiq5cR/Y7NuM0Pj6CdyDwm289LxdOGvE/f8Gbgi0lpUOul8PvtDjw9OTHz3I4oWyPxl5hDaSoW9Itl09vhcdaG91e9K8tZ241aTYAuNjyR2LSmVqKGdLwawkR7XPPHeEppoaWdDmhcmH1by95QisuEWuXPjWLKeEM4DqtIGINkiSzdO2V/8kiG/8YxjD4Y9yRigToqlUqsF62U5KCRbUCGGETU8rpB86+3TlAVPYWmqD/ZkQOP9Ul5ppFU3bALAxOGNuSKqofgM4CCwMUtzQhC04QoEHJFaGfQ8vMKB6qIHZqakzsYKhUoHPk1yQ==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae08ec0-7391-4b72-96c7-08d877657673
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 15:08:13.7263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /EU8OLjeX+UAkWIliD3m9FwApqNOXabA/CPhE9NHq8ozVxin3JsfEMeHtEGlOCtc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5516
Received-SPF: pass client-ip=40.107.92.131; envelope-from=alxndr@bu.edu;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:08:19
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

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 docs/devel/fuzzing.txt | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/docs/devel/fuzzing.txt b/docs/devel/fuzzing.txt
index 96d71c94d7..03585c1a9b 100644
--- a/docs/devel/fuzzing.txt
+++ b/docs/devel/fuzzing.txt
@@ -125,6 +125,45 @@ provided by libfuzzer. Libfuzzer passes a byte array and length. Commonly the
 fuzzer loops over the byte-array interpreting it as a list of qtest commands,
 addresses, or values.
 
+== The Generic Fuzzer ==
+Writing a fuzz target can be a lot of effort (especially if a device driver has
+not be built-out within libqos). Many devices can be fuzzed to some degree,
+without any device-specific code, using the generic-fuzz target.
+
+The generic-fuzz target is capable of fuzzing devices over their PIO, MMIO,
+and DMA input-spaces. To apply the generic-fuzz to a device, we need to define
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
+As a generic rule-of-thumb, the more MemoryRegions/Devices we match, the greater
+the input-space, and the smaller the probability of finding crashing inputs for
+individual devices. As such, it is usually a good idea to limit the fuzzer to
+only a few MemoryRegions.
+
+To ensure that these env variables have been configured correctly, we can use:
+
+./qemu-fuzz-i386 --fuzz-target=generic-fuzz -runs=0
+
+The output should contain a complete list of matched MemoryRegions.
+
 = Implementation Details =
 
 == The Fuzzer's Lifecycle ==
-- 
2.28.0


