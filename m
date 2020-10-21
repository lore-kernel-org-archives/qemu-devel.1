Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6955C388F2
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 01:18:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2299822253
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 01:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="55FsZvUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2299822253
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV2ld-0000vT-3p
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 21:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kV2cF-00018t-MS
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 21:08:35 -0400
Received: from mail-co1nam11on2130.outbound.protection.outlook.com
 ([40.107.220.130]:28640 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kV2cD-0004s9-Rw
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 21:08:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIlAFYas3jRDxvuPwmRUR013i3wBshX9onF8t2X83J+5prwa665eoppypKqYqT3CX1rRMX1Vmw1kiTf102IKAHpaWdRl3yOfNuBxuZetPVG/sZIZjmtGIXg24NiuPauNMFoE6VExmEb032Y4vgTIsxWzFgbtMdik97YqR8/dD1KNzjCWSQFjYR6UQsO4PtWuuzkp36gHMhxsXafJCK0TRA2uaiyPYbNbja0awCeHopLA3UjHXUJFbz7gtHi+eqdotRIe5oztjzu7ttoWX29MMurhNdbH3nBtDWjX8YSwotV/9tJvYrcX47GpjZvNoj9/KVtylF5K/SUdX4uwNnKNEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suH9REkuZLTDDMTO84INf7b5sOMP9r7ertN0K+0wW7o=;
 b=h5jyiNhRpoX7Lk4TGeeehebSi89vLE4NOzZTYyvOYNaTv26Z1qGf2N436rlmKDonjDgMOtwlqnUb8NZQh8S7bs80Q34qMQUFjCkY0+vIv3eoDYA3v9zaCClJ5EIiuGHsjBakO6ppOR9dQrZnt8Ab5lsTkk9X3C0FZlHAW9aYe9e+Dre69o+Uiln3v4gNQ0cwd/ONPPP8ZSPJuw8xoOOE1SnhK4SueANMfDVLN5Ry7PmD4uZH22N3aR9IoVOydXrdqFnsuzyKjHNBbJvhqZ1x7tnNDfVeVXxPoB4b7AMDHPTaQXcudAQffJrphpQ20UFoqkLJ2Sl/GIeFku5LUDwIMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suH9REkuZLTDDMTO84INf7b5sOMP9r7ertN0K+0wW7o=;
 b=55FsZvUSTxE+BOK7oMSymoJJuoYHPid2LEMClY3Uq8Lrd4hU/22UW3OGVwW6VbK1J4/Z9gnD/xkmWWhvsteV5+yWG/pmUVTdnbqoIB9thHAEfCAREFF73hBgYaX1Bvi/nalB80jRifHI+cOy+IzH5Xa6vkITuvaNBoK5CHIVBps=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN2PR03MB2333.namprd03.prod.outlook.com (2603:10b6:804:c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Wed, 21 Oct
 2020 01:08:16 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 01:08:16 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 09/16] fuzz: add a crossover function to generic-fuzzer
Date: Tue, 20 Oct 2020 21:07:45 -0400
Message-Id: <20201021010752.973230-10-alxndr@bu.edu>
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
 Transport; Wed, 21 Oct 2020 01:08:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddac3663-5b90-4287-65a9-08d8755dca92
X-MS-TrafficTypeDiagnostic: SN2PR03MB2333:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR03MB2333CF33F7382102BB0827D1BA1C0@SN2PR03MB2333.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: okHzYEZXcKxdZwgMZDjK3NLZN6BpJVrh+RyU746UnTJQBmaEaRwprf2OeifzCdrzmCP5Mpz73b1uRUZlQCn0CWgYxcF1F2Gh8qIHH8yLGZYIdDl5ZO0tWz4H287v9gpjlwyY9r6a5NY+7Cbv3jwSiRCKROfLzfEzeLPrPZwFjfwc3DrEtK8jbNTWhywslHFCdUZo02pcb5xXkqrczAmDyHb+lxdiij0Cd5ZbpUul1dVg/5GG4n2+rfsS0JsngnofHBfe8wO4J4tGtMGtAHmdeve+bPCL/AbXizfh7Xs64NHyGtmYiLRQU2AS7DWHF7oMCg1X0FQJsgEm0bqdHhBEBI1XV0V/89qKv8LN3IIjmWOVnYrPPqfg0cWRmFoWHOni
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(52116002)(2616005)(8676002)(6512007)(6916009)(6506007)(36756003)(786003)(316002)(956004)(83380400001)(478600001)(1076003)(4326008)(6486002)(75432002)(8936002)(54906003)(86362001)(5660300002)(26005)(16526019)(186003)(6666004)(66946007)(2906002)(66476007)(66556008)(41533002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: eSh2MWYziB8b6DrSgjYlbYIq9df3mz7O/5tDHr6D+IRLGC+eU684yA3Jr5GNSNNXZat7LMcG38n1iPUD9kwBUarUorj2vVRBbmX/oAyKZT8/NTW4lvHMNl3L+90JSTq4OhFnLH+2sFBPh8aAF3x0y+xrTURREN6Wu2Y5CmrNpS9oRC6+PcvJXRf+dIGAuOrdcIH+Jkikbtl9lhqjuY6Uf3VtYr7pcbFvIW97UKhqaL/ZC6/2VdRdeOE+PVbxkfWuV73PcRCisWlwmAsS4DX06olKCBQq5G01wuUg9Hvyh9rZu2Gdabp5oOwGY2ivzYa0vGEaEAZYPtOg1qNzRy11Vroyj1bLFRgaDhv7nDPns/byItDrsiJs/iSt0ZDueyGq1O44HUjXnhmKc93zXvv8vRZQCAQuuG+xAHHcRLzmQEnAi/1gbrcIw5XR3TwOEBSYwUUYQcAo9nr/2ItfKes88HHnkGhJulnE1G+6c60yDrgh7V31UcjSMSd2Pqv2OJYVup6Hv/bx/cJ03F7CPve8KY+bmY5tmN4JWRY3Sq9J7SueJF6Ln7VXksyCcTBNkqQlQi/5+quUMC2cYGL6oYMJu2LMRcx3B9wmZEMPdY2su/NJli3Ag9csdU9i4m6MtE95fGekDi//RVPN0Lsy7KO6sg==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ddac3663-5b90-4287-65a9-08d8755dca92
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 01:08:16.6424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L22tAV9wU3wfaxfihbj83hv+LY0+Emm8txp+7jykn4+FHFK/7+N/YvCLdt06MX/h
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, f4bug@amsat.org, darren.kenny@oracle.com,
 bsd@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/generic_fuzz.c | 93 +++++++++++++++++++++++++++++++--
 1 file changed, 90 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
index b1254f4e63..356d171c65 100644
--- a/tests/qtest/fuzz/generic_fuzz.c
+++ b/tests/qtest/fuzz/generic_fuzz.c
@@ -804,6 +804,91 @@ static void generic_pre_fuzz(QTestState *s)
     counter_shm_init();
 }
 
+/*
+ * When libfuzzer gives us two inputs to combine, return a new input with the
+ * following structure:
+ *
+ * Input 1 (data1)
+ * SEPARATOR
+ * Clear out the DMA Patterns
+ * SEPARATOR
+ * Disable the pci_read/write instructions
+ * SEPARATOR
+ * Input 2 (data2)
+ *
+ * The idea is to collate the core behaviors of the two inputs.
+ * For example:
+ * Input 1: maps a device's BARs, sets up three DMA patterns, and triggers
+ *          device functionality A
+ * Input 2: maps a device's BARs, sets up one DMA pattern, and triggers device
+ *          functionality B
+ *
+ * This function attempts to produce an input that:
+ * Ouptut: maps a device's BARs, set up three DMA patterns, triggers
+ *          functionality A device, replaces the DMA patterns with a single
+ *          patten, and triggers device functionality B.
+ */
+static size_t generic_fuzz_crossover(const uint8_t *data1, size_t size1, const
+                                     uint8_t *data2, size_t size2, uint8_t *out,
+                                     size_t max_out_size, unsigned int seed)
+{
+    size_t copy_len = 0, size = 0;
+
+    /* Check that we have enough space for data1 and at least part of data2 */
+    if (max_out_size <= size1 + strlen(SEPARATOR) * 3 + 2) {
+        return 0;
+    }
+
+    /* Copy_Len in the first input */
+    copy_len = size1;
+    memcpy(out + size, data1, copy_len);
+    size += copy_len;
+    max_out_size -= copy_len;
+
+    /* Append a separator */
+    copy_len = strlen(SEPARATOR);
+    memcpy(out + size, SEPARATOR, copy_len);
+    size += copy_len;
+    max_out_size -= copy_len;
+
+    /* Clear out the DMA Patterns */
+    copy_len = 1;
+    if (copy_len) {
+        out[size] = OP_CLEAR_DMA_PATTERNS;
+    }
+    size += copy_len;
+    max_out_size -= copy_len;
+
+    /* Append a separator */
+    copy_len = strlen(SEPARATOR);
+    memcpy(out + size, SEPARATOR, copy_len);
+    size += copy_len;
+    max_out_size -= copy_len;
+
+    /* Disable PCI ops. Assume data1 took care of setting up PCI */
+    copy_len = 1;
+    if (copy_len) {
+        out[size] = OP_DISABLE_PCI;
+    }
+    size += copy_len;
+    max_out_size -= copy_len;
+
+    /* Append a separator */
+    copy_len = strlen(SEPARATOR);
+    memcpy(out + size, SEPARATOR, copy_len);
+    size += copy_len;
+    max_out_size -= copy_len;
+
+    /* Copy_Len over the second input */
+    copy_len = MIN(size2, max_out_size);
+    memcpy(out + size, data2, copy_len);
+    size += copy_len;
+    max_out_size -= copy_len;
+
+    return  size;
+}
+
+
 static GString *generic_fuzz_cmdline(FuzzTarget *t)
 {
     GString *cmd_line = g_string_new(TARGET_NAME);
@@ -821,9 +906,11 @@ static void register_generic_fuzz_targets(void)
     fuzz_add_target(&(FuzzTarget){
             .name = "generic-fuzz",
             .description = "Fuzz based on any qemu command-line args. ",
-            .get_init_cmdline = general_fuzz_cmdline,
-            .pre_fuzz = general_pre_fuzz,
-            .fuzz = general_fuzz});
+            .get_init_cmdline = generic_fuzz_cmdline,
+            .pre_fuzz = generic_pre_fuzz,
+            .fuzz = generic_fuzz,
+            .crossover = generic_fuzz_crossover
+    });
 }
 
 fuzz_target_init(register_generic_fuzz_targets);
-- 
2.28.0


