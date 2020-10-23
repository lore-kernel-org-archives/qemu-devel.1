Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218E7C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:11:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A92D208B6
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="7+ZqbfJH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A92D208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVyio-00075H-KC
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVyft-0003cZ-O5
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:08:13 -0400
Received: from mail-bn7nam10on2090.outbound.protection.outlook.com
 ([40.107.92.90]:50400 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVyfr-000767-Pe
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:08:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ij7LTS8b55G/VBLyZkcwpAqPsJ+S2DTiw+nH6/DFbnjXEofVzcEtvf1Ike7b533v1EgeJ453NI6XbbV9OyF9681g7bJF+HVGX0G8CGtbkOR/tY1BH4Joc0yYT3M6tyt30UCjxBqkb6KcXRz9f1p3EpvuBZ18mQBIlBcYH2QLyX+jAo6INF6wL4AhFHOmJWoAYqtC+6W42LJ8viDKn81zVBR61OjVyY60nPXsnj80A6aGiyx9PzAcjeoKbo4n1hJ4wNnrLHdCGXb1+5w5UlDY/WS5Fw3ooS4aepe4jSzxi6gQ7a7akbcayNAprFSqv3pqjYCCgnjz7uLlUDoTuQC6+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwIF3gf92vZDxFBP03YeyaRybQtRjP+EanamgiyoT6U=;
 b=jDFXcQCl+WRgmdZ/JYummOO7/xV+S0b1bmnSLibRbRix7Hwh8RGsJwWUhIjcUy3FL0xqw3clmThE3wEUdzEmhPL733amlzEntbphg9JHtpMIfW0ID723VGiuivh4UoXbRtYkFPwJW9HMgh6jW1NctczdZhk7PN3yfamqlvDCJlMKgaygjoQVsRRFA42LUz8FLfDZ0cwlA8XTmP/3Xp3mfB27PuZNs2YGhALjSPliKxGzyJ5uA6kD6XebJ9KHFdqfsBxCV+kjkJTjbMrwFKN7ZDLIZuoXYpdsF1BLXzFWURwoZqf1/d3JvAF95lk+nodbtkKL8aUKi0GoCpEndsa2pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwIF3gf92vZDxFBP03YeyaRybQtRjP+EanamgiyoT6U=;
 b=7+ZqbfJH3AVJWP6GheaX1mE5d7O3+imlQPJ8DPufkOfMf42F3OQNkfHLW6HvgdXlBDYox+qsqV/m0lLTTH+bVqJEJ8MhSiIYdfBoWs2nK0dwdC1wHmjpzSVjxeZ2U+WxBq8fQJj9u/Z2ME+I/IvBcRQJLKOCbjK7VkEJWgmkVMI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SA0PR03MB5516.namprd03.prod.outlook.com (2603:10b6:806:bf::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 23 Oct
 2020 15:08:08 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 15:08:08 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 08/17] fuzz: add a DISABLE_PCI op to generic-fuzzer
Date: Fri, 23 Oct 2020 11:07:37 -0400
Message-Id: <20201023150746.107063-9-alxndr@bu.edu>
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
 15.20.3499.18 via Frontend Transport; Fri, 23 Oct 2020 15:08:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f54048dd-6fbb-4d52-eb17-08d87765732b
X-MS-TrafficTypeDiagnostic: SA0PR03MB5516:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR03MB55160011E2889A674B27C501BA1A0@SA0PR03MB5516.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:40;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pTvhuzz+gzXajfgm023fp2VbImuGmvQNXwKxdXwDtNQ7z01nxZQqDZkV5tJHeyF4P+EhIG+lCk8O/hvfljfpmkGYyFjVSfKDJGqmYXCBTwsbN62dIL8EC7ePpPedljjtdl+uLLF3UiYuXFpOvqtLfkQX3llGRbzMkYAOgWqKz2L8OKH0IpGWtp+OYzUm4ARd1YumuAtgF1lc5DAIksr/Ro0whNJmoTmtTiGXNk3U0Sja69EaEphMZ/eLWXIrtqabb3GjRZgaet6gwIgcwtpyob+zOxIID7kUBRxcgP0Bxt7TwiVI0LcJ4XqpkRB0Bu5ap0gsa8JfpUjZF7FYTNqjBFR9EqvT4yIuLkV37A1rAaZ0PEQpO/JeTQ0N/gs0RRPn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(2616005)(4326008)(1076003)(6512007)(478600001)(5660300002)(83380400001)(8936002)(8676002)(86362001)(2906002)(956004)(36756003)(6506007)(66476007)(6916009)(786003)(66556008)(75432002)(66946007)(52116002)(6666004)(186003)(26005)(6486002)(316002)(54906003)(16526019)(41533002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: JJy2YBxsfIfCVIs9mbrSr+m8XWvGBwMmKVv+QJtSphEArAG9I+q9oXJ5JeJJu1/9WDfzCnZi0exUW+XTVN37SqsjyWI6q5Wblwm0cZzwqaat2F+uoeddd+ETnhozLdcVXFD66Hm1lXT6e4YCfM3fnwXh0oYo5FCrzJPrRZSZ6NZMyyejmeSXjqYLhNtGti3SEiRTJIj3EonhSENXOKor+a1eczIhMeYi8i3Vb7EFm3n8ffOwdpbVDpP+fxT5/tdJzCVpvex+IyuvKwO5yONeb/27/FSXZP2SwPp/8tVNZeC3Tu9o9GJVkWnrlkv+ITfDBKGptvn3RyOXN25V1f4j92dFacjaBgP9iiz4QfA7Br+xzfsG7TDX5S4u5j/TyEIn0nmgqr8Uv58fPiZTj8FYo9n9cqRwdbzw4PG3WN1c+SXoEiGLLbv9oempW+jfQBDQPXPJxCOh+P2iVyNOVXE/TvLUCdKpBRCSxR+YbxS3JwUzMfQmEPBpvs57HCI/412vpLXof5y3n05XtC8nXxeExN4vy9Qzne3OwgPdEZ8w9peLtz4ANqOKgSWQ/fkreFPDAZSQ1Xgh3sMmy2p1LuBGM7W5TnUHH2igs3cT6nAIzzWLQTV5/ubxoDWQQwXKsLufNkFXyn0vorwMzzkjA8WbvA==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: f54048dd-6fbb-4d52-eb17-08d87765732b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 15:08:08.2114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5gszpib11gVgr1BoAgPdX9qiR3eI1EZqf2xLvjPDw/Miz8iXbDmBiCCY8QD/KUu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5516
Received-SPF: pass client-ip=40.107.92.90; envelope-from=alxndr@bu.edu;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:08:06
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

This new operation is used in the next commit, which concatenates two
fuzzer-generated inputs. With this operation, we can prevent the second
input from clobbering the PCI configuration performed by the first.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
---
 tests/qtest/fuzz/generic_fuzz.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
index e6b18e4276..d8fb78d13b 100644
--- a/tests/qtest/fuzz/generic_fuzz.c
+++ b/tests/qtest/fuzz/generic_fuzz.c
@@ -39,6 +39,7 @@ enum cmds {
     OP_WRITE,
     OP_PCI_READ,
     OP_PCI_WRITE,
+    OP_DISABLE_PCI,
     OP_ADD_DMA_PATTERN,
     OP_CLEAR_DMA_PATTERNS,
     OP_CLOCK_STEP,
@@ -116,6 +117,7 @@ static GArray *dma_regions;
 
 static GArray *dma_patterns;
 static int dma_pattern_index;
+static bool pci_disabled;
 
 /*
  * Allocate a block of memory and populate it with a pattern.
@@ -482,7 +484,7 @@ static void op_pci_read(QTestState *s, const unsigned char * data, size_t len)
         uint8_t base;
         uint8_t offset;
     } a;
-    if (len < sizeof(a) || fuzzable_pci_devices->len == 0) {
+    if (len < sizeof(a) || fuzzable_pci_devices->len == 0 || pci_disabled) {
         return;
     }
     memcpy(&a, data, sizeof(a));
@@ -512,7 +514,7 @@ static void op_pci_write(QTestState *s, const unsigned char * data, size_t len)
         uint8_t offset;
         uint32_t value;
     } a;
-    if (len < sizeof(a) || fuzzable_pci_devices->len == 0) {
+    if (len < sizeof(a) || fuzzable_pci_devices->len == 0 || pci_disabled) {
         return;
     }
     memcpy(&a, data, sizeof(a));
@@ -567,6 +569,11 @@ static void op_clock_step(QTestState *s, const unsigned char *data, size_t len)
     qtest_clock_step_next(s);
 }
 
+static void op_disable_pci(QTestState *s, const unsigned char *data, size_t len)
+{
+    pci_disabled = true;
+}
+
 static void handle_timeout(int sig)
 {
     if (qtest_log_enabled) {
@@ -622,6 +629,7 @@ static void generic_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
         [OP_WRITE]              = op_write,
         [OP_PCI_READ]           = op_pci_read,
         [OP_PCI_WRITE]          = op_pci_write,
+        [OP_DISABLE_PCI]        = op_disable_pci,
         [OP_ADD_DMA_PATTERN]    = op_add_dma_pattern,
         [OP_CLEAR_DMA_PATTERNS] = op_clear_dma_patterns,
         [OP_CLOCK_STEP]         = op_clock_step,
@@ -654,6 +662,7 @@ static void generic_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
         }
 
         op_clear_dma_patterns(s, NULL, 0);
+        pci_disabled = false;
 
         while (cmd && Size) {
             /* Get the length until the next command or end of input */
-- 
2.28.0


