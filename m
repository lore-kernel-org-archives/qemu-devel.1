Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30E5C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:58:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E37C82223F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="mNiNGka+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E37C82223F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT3mK-0002F6-U4
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 09:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kT3WX-0007hE-Pn
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:42:29 -0400
Received: from mail-eopbgr750103.outbound.protection.outlook.com
 ([40.107.75.103]:37594 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kT3WW-0000mT-6p
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:42:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdYNc8ChLH57Rq/wIbESDMGm+Upac67fjDKa/PLwz3O+QNF7r1fZBq6+8nUbFiZ/YTeE2jdu5++r6S7wlNb0KJZlcu/OVFAaZ9ghkBgR3uo/SNKZgu8lSoVl9awMsMgWn+ya4BIced5FxJyohrL5WKRMx3p4Aecdp2NtFCa7kc52y9QfXjy0ReoryacO+O/B4c11dZt//Oewyyf2WejK4e1di868bxCBIw4Z6SOp5OGJUI28gJ/BopG+VQjuEKoIpD0f01SwZYCBxMAMAVnKEMEAcvPL0I+Gv19jTHGnJR00MrIgVI7SWbbRnF6UJz4gyp1OXWLX+wmgmLuU1Dxw0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkPtyz+s8b1KH6hKK/ioFOQE62kpgItYmb7x6kdTH/8=;
 b=ZOqx5lK1k+HTPkF9lyTOKtN7doMh6JAEZgHqvjA4qmXqrwiwWAgB0Or6jf/IOzE+XNLJ2u4f0aQBfQqtSs6auFljtQDrBLwbkQEQNVXWfUgoz2SZsezynQqTOLvhdxIQlavMUkXSNObabwqvpaYj5iMAYOJHKC8m+dOEfOIWXlPPrpf4ruDmf0wCx6XBW4MbnpZ+4opEQ5ZE5wtEwQUZ84ufZCW80CUuDPkXiMN6wyPCwmc9fzMML1a9b5bqHpzqvlYRRgD9d22tDCuTG8OS3XZmpQSaP88t5Etpub50mpsa3G4HnAcXdgLG5u4AGvGk9U/JPQyqJIrJgQmhgn/LyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkPtyz+s8b1KH6hKK/ioFOQE62kpgItYmb7x6kdTH/8=;
 b=mNiNGka+soHEWi4yn3ZLGhYt3YyA00n7OHE/hKHvgePlltj1JNtQ3eyT3ulDRHMpsLb5Crr5bqQUffm3HbEO3/6DltgYUapLpk1r8PBUxwXA2W3eMFd0KxvhoFxuFkLTCwO3xpJLD9zC/GQa/DBcNylITAtSNCF+X70kJaYJxds=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SA0PR03MB5465.namprd03.prod.outlook.com (2603:10b6:806:b5::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Thu, 15 Oct
 2020 13:42:11 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3455.031; Thu, 15 Oct 2020
 13:42:11 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 12/16] fuzz: Add instructions for using general-fuzz
Date: Thu, 15 Oct 2020 09:41:32 -0400
Message-Id: <20201015134137.205958-13-alxndr@bu.edu>
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
 Transport; Thu, 15 Oct 2020 13:42:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fa245b4-8b42-4d91-c7f9-08d871101daa
X-MS-TrafficTypeDiagnostic: SA0PR03MB5465:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR03MB546558AD5F14ECD22BF2D82CBA020@SA0PR03MB5465.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VhOJdYAFO9kLpzVO7516s+EntXYg6fTsj4qpF8MjnNU2V8i5YhiX/LtR+pdjOTzlyNETHf5Kpb7Fy2toqKu4mMiaLnr51ACTPGuvAea9nrgOP+nmRRZchEWYafscLfe7xAC450PUi5eDLWkw0rUAjVsETfp7nXVS5ZtEt6likhTqiNaMrvmdYRTPRuG2ugmvAhinad0Qc+tyCOpRu/jZk5AZuzbJn76b7V7WnkbEvQg0YmyoDFlGDx9n1EboJq6bD3K+t/S2EJTUz9ZnHXNTEV+vlkghGZuxfcNLuZup5UuXQ2/2G++dSpf5uHvKejmx11VCP6Wz41w6+qTvnovnHfy7RrSwuvpblMCRm7/sNoi7SDNsedT8z3OUGvh7Fdd1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(5660300002)(54906003)(2616005)(8936002)(34490700002)(1076003)(66476007)(66946007)(6666004)(83380400001)(956004)(4326008)(6512007)(6486002)(8676002)(75432002)(6506007)(26005)(6916009)(52116002)(2906002)(86362001)(186003)(16526019)(786003)(316002)(66556008)(478600001)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: yBYdZCoyCxkXw5sDIpdVGZIYhpIdaCmXsaChMjlWY9Q5s5XXLzLWVdAypziY8d+cmfq2hIDo0ADqFtKVPensjJqixehLPeVpxsfOZ4SHsX8YKA3EXQ09Wf2d7luG+GQq8o+jVIk8nJE1hvgCB0p5HBqfPsY+b7alEH2QhVrPdyD+Sbg6xGTddaLpEHP4ZeI/kZOnc0I7dXA1WoQvdu5t3J2o+mXndm7zYmKwVuEfSbM1v85aON2tQV6rq+nM5V/mIzArSrBxfhmm2rkZVJ9HbsRMJDJ3V1PnZKVgum19uQJjj3UaL+Lyv0D6sVJ4SGDzQJ/cwuuFnvHxdNquYoKslA5PywZ33ssp42yj0Pem0lcErdVVuxHHWZCEgBueMeWwoCXmou5DMbDCsNBvIr/S3Xee6qFO7+IYWevkoMV407vKzPKVswdVx9Aj2s0BGNzBrRNqwltIrd/LghQPDSQrHKDv590ESywa7ats67MAZ4bb1qXbKiJX6hYK+TaHVXDh1FRT78BEkxq4UfKmT1i8sQbfApMoDPRLYqVvoE/OW96m7pxU4bsE67zz0fiFp01qO0YZy9+RLzw6elN/FuNT3Tvi0XuWExEbFMXj9z2vZRQHVQi6jM1+tHEqO4IwJFLGdAsBYTkMuMDqyey9EQyXKw==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa245b4-8b42-4d91-c7f9-08d871101daa
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 13:42:11.3746 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v5oszfliUMJj34ciJVjMzu8JfH8RfKFc5c23arhWvhx+u4TvMBSC+YGmuP0T8HwX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5465
Received-SPF: pass client-ip=40.107.75.103; envelope-from=alxndr@bu.edu;
 helo=NAM02-BL2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 09:42:14
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


