Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6281C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:37:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8DAE223C7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="wgzKkVnm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8DAE223C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVLnu-0004xg-Ry
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 17:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVLN3-0003uO-1t
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:10:09 -0400
Received: from mail-eopbgr690098.outbound.protection.outlook.com
 ([40.107.69.98]:60229 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVLN0-00087u-OZ
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:10:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cmk79XyK9at51ZYYrP9J3D6sBWQAC2dS7hV2YB817vQjj64ncd6YkGVdICM+BonCcPoTGEp3k34whAYdeqjeljKUw1ctNDwfKpfx+EoJQ5x5dlxBlcm75LvB6YwXi7KBccZCRLc750VS2mUMcJAp5qPERhl65sYSorLMvp8lF/FzEW42KUlG4siGZaS59E18LsjGdj0zqpOmEHjv1QZllG7dg5MBgiT2hVSNiERfgcfR56grZgpiLDvKCBcAa8d+NlUiegJU7b8F6hWhub5CFhKFpd3Y8QkwdpScTOrzJ4UJn0qUh1jhKIJLAzvifa/RclMQzI+fAZ8Ky7SCrNm8gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrRR7nYIMtECdJdBZYUDCaRERiVxsTzNuITF8efYZ9Q=;
 b=jtzeqaqlADKFVGEU6BD9iqX6b1dRFSmOFbE1Z4kUXnrg3qSPaLpuf85PgueUkXaPVp6HMKfhbhHhB7XloP+6A6K4J6f9nc5HWOcpC5RrtZs+Bc4059Drdehy6LN+2S9Rx5+yTItXw652RRLhGogDS0cf06O3erHgfNpmZU72YfkdYKTVRY8MQ91QOirKk8pZPY7F3S9u6zpDjMh63Gtl8Z8iN0DdoMuyjf40UPPx2Px2YoCNSdvPviSI696IzE9S1ukTO3lIy5XV9sB/p1NMKHzsErjM3FXDV9lmOOToH4bFjCqswBDMmP+tvOHiLavrCt5jAr6LYE3QeOCfC069sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrRR7nYIMtECdJdBZYUDCaRERiVxsTzNuITF8efYZ9Q=;
 b=wgzKkVnmiXt9yAyACiTLPvDHhkEYXsK6hWrgleVY3phOI651vm1kqiQdHNqjGw4PFhjx2m4yXyTcpKX4JPn8nQpJO84reWijP3Bbbl7mb+kZ+2ON84x/pF3SBmv0EbhxAWqnhm+zceqDKcKuL8vJ7FW/vM2XIn3vmS0/fHvY/Xc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4045.namprd03.prod.outlook.com (2603:10b6:805:b8::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Wed, 21 Oct
 2020 21:09:53 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 21:09:53 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 12/16] fuzz: Add instructions for using generic-fuzz
Date: Wed, 21 Oct 2020 17:09:18 -0400
Message-Id: <20201021210922.572955-13-alxndr@bu.edu>
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
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 21:09:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03f08d27-8152-41f1-cb66-08d87605a76a
X-MS-TrafficTypeDiagnostic: SN6PR03MB4045:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB4045517A25A03119232371B7BA1C0@SN6PR03MB4045.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YG21RJVF8KyS7Am8rM3dbjQvdL3BpwdYY/rM0CKrH4U2HZ5jmToMm2m3tWbRNYtP4nw2MI/F6e6oVfhL4iV/UYKgkE9xq8bMoMW0A24KhqM8D3vi38McRe+bOEmGOqwyP7uAhNi+K5D00bs4v0+Odq9BbLNR6oBplxMvm0w0YiHbviqLv5zUeEKCt5Ux8eIMMa9xSdoePdPigizSsD/L1Ag4VnkaLRz0u8TGE3YSXIzjBF0jDwSdTlWlPRnR73/ZMsbFV/xl1VdtIXvdMKxdWUZQKwVOLJTxRIQ13N6lPRynqXdwTeyiIDdvvQbCFwnXbKqq9T1Ht+wV4wsw1mjuCrOm6e1LnGrbWB//TppupUqxkbDONfCAr7U6hgJZzI1r
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(83380400001)(86362001)(6506007)(956004)(6666004)(2616005)(52116002)(5660300002)(316002)(75432002)(54906003)(786003)(8936002)(6916009)(6512007)(16526019)(36756003)(26005)(186003)(478600001)(66946007)(6486002)(2906002)(4326008)(66476007)(1076003)(8676002)(66556008)(41533002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Chd9jt0Tu1obzZvWuWpGA//pqPJGP5sPjH90YCtf296D0vPDiJUw98N0krcf5IsGmZcWz3qOamBlKoENiRF/J0wsdtK64e+s3lcl2gNKe2y3iponrPvvhR1IPqrSpScYW11fY2EzcL27O0VTlPp0piD+KiJKuwkur6wDI92Je94UmEKVCeSGjXUYZOzgyw3NwhmjDQgu05ppoR6/KWA0ZB7/93Z1HCZHmDe+KJpn9I1mmJYqNv4l19HXqjj3eG/q1iogucxF++RgGPKEVWVba1m1yOcqsUwNOWghGBff4EZUyi5Lv2TXO+CRnT+5nsJeYtcfrhkSgxwyLrOXIWSgngxRZo5XA3D9nnUFGib7kETC4YSB8EJm/AMsWhugFxfNvndIlPSxZWPDxPQ6a3U+IK6tk5n+R0o9k0LVyhxG/BVHaR/C3DzOh1EpEox7Q8Tmjcvcg+zEkZDmA+OdEIZgUJ4X5dZ31Quk6bnQW1lfcmXoIQfAGjyglWhsuETff2JMhtAzNrilJJN5NXWjN87UfWPOU6gbrp+lzUbu59tT0Zbo/89sXTHxI1nhO40za++JkuI3bfzlTwXj4q7/48D5rwVMX11w8izaviGM6MIirrBePDZDJ2CdvEXB2WY+UnjJ2YBg1ERv3LsqzkCSlsm1Mg==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f08d27-8152-41f1-cb66-08d87605a76a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 21:09:53.0232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MzLaZj3W6mVvTndlMfFKSrDENCwaszXCQk9Qdg4sl+lTJPT6bTIhQmTUStNINCSg
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


