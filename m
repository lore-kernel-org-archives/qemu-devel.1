Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B03C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 01:13:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC8F120797
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 01:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="P/NZEk+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC8F120797
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV2h7-0005zK-QT
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 21:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kV2cB-00011X-DW
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 21:08:31 -0400
Received: from mail-co1nam11on2130.outbound.protection.outlook.com
 ([40.107.220.130]:28640 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kV2c9-0004s9-Rh
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 21:08:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fG8l9WDS9XrYpRApzdB0Mu62ydKPM3gi3Y2TwQDMehZRqGiDpkcwDJGCQWQzUPJ67MhaKd5mvbZc4gTLmN6qVUvMN+A64Es5BMjYvnB7jZk/l8mLcMOZqjocpQLaCkhLuACSxmXltOsRpgXJGJgsc7eArbx+9XjqWRrroUGg3MIm7GIMQdn0sq0jfEEA+H146zsZSyyE6AsGQXJKVGmoWhuqZzOxklQ1/ZcFvZdkjWic/HBFiYvu8XY2KjgtYclM9QAMiTFdCYudPdNJ/Spp5ylbEv3RkZYYkP+RzpdH00iBaX5SDjk4YKr0c02YLvrDMEABozU2xKfBlkxTFsrXig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JConF3xBRqpbuFwEhD621vHq4kTf2LaXQ5y+kvYOsM=;
 b=bbSiXl9Jlte6/4+rOH8o1ZDEnk856GzYazcXi6lLRaljqvuuevwwVsELoL3coKIYRCN4MPlOu+hRGS7KtLbrDaY601JaaGM1ccq1DFlPowH/diwiXUPTfkO7MM0y7zoqpUMHWMgMj391ejbazK0YWga4fHQVbutvy4qNvhyHlJ+4v4nbaZnjXduqujsq9KPpZlsXsU4mC+743WGRQ/dcZWJTPgiQwyFPlGPQLx0Yuq6sDFU20vJRKNjSrRMSb7rDWgWIib/WLyUlK4CHmvEvFZaxQbzMQwmLx+7kr60TwMxgKkipYm7onFsdlMQ6RwkESwZ5uVfxVdHGXB5Bype3ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JConF3xBRqpbuFwEhD621vHq4kTf2LaXQ5y+kvYOsM=;
 b=P/NZEk+orsgKer0q3Fn0X4lkF1LC8O5lrR9X38cdULIt0UYxyr1k3blGcLMOqCMdGSOvn0KhOdUavQfjoQGiLfiL7HTRzDxMzUUQu5zx0ZY1uy1uC2+4s7O2IC8xpba/VsLddwQkLTui68JIhjOSNUcX5SPbvjGKjhJmsDNU69E=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN2PR03MB2333.namprd03.prod.outlook.com (2603:10b6:804:c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Wed, 21 Oct
 2020 01:08:14 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 01:08:14 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 07/16] fuzz: Add support for custom crossover functions
Date: Tue, 20 Oct 2020 21:07:43 -0400
Message-Id: <20201021010752.973230-8-alxndr@bu.edu>
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
 Transport; Wed, 21 Oct 2020 01:08:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e367fa6a-003f-4922-383e-08d8755dc8f2
X-MS-TrafficTypeDiagnostic: SN2PR03MB2333:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR03MB2333984DA253D38FC31910B2BA1C0@SN2PR03MB2333.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QnSSVjUOCEwiLEA2uFYF22NVlteBbhXt0xyuFkPgaJAIpL3n6a4jiszc/nmZ973F1s7GlblySNT76YO0rFngLyTBXi4x0T7wlAjg+MtyjsSAM5zPNzhJjTBJO3vsCEdITphjkO+3N63S1+TYgGF3CDSTHPjS6Jsgn7myek+wh2MxasMM2MeBbMIm4ZpkaSU5tbGyqRDRyaQ3aw/smzhT38GRBJkHAqcF5MdlvaVXP6ffeajzr4GPB0wIND+4USEveAQzktjAdfVxe/yVM1q4a9KknHK+GTr1R7OJwmvNzkYl+UJsdTN7pRUUz0Eu6s4Kb/rqm9Laq8kpcsS0cHGw9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(52116002)(2616005)(8676002)(6512007)(6916009)(6506007)(36756003)(786003)(316002)(956004)(478600001)(1076003)(4326008)(6486002)(75432002)(8936002)(54906003)(86362001)(5660300002)(26005)(16526019)(186003)(6666004)(66946007)(2906002)(66476007)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: JqwzMQfgEzUGO3NGBvS6YBU8o1wBIbSQ6YqKrhl1WRvHhjjWf1NEnZZalEyZC6iRufxZEh6ui2BLC2TGVQa/dlyLDo/0z/RwLjwXXyl6COwbgAQwbX5/BVBW9mDcIlzg8xLmwjjltbIMKCUHj9NuumB4y+jng+VPVI5HQkXVJXpcsRHt6AlZZ2xO9YNfYL38fL4TZ4nUhWGgKtkhPmYULyDUYnWiPfcg0a+2rpX5Lb4vcBkGU1S9Cgz6EJuj0QGzm6K0ZSnwTCbt0wzdfreS6x66kLGnGTL6B7VjdPCeBV8EHQYjC7kaMSYMT90engu0xyI2oBXPpBBr4ZnjHgb8L70gcPhMyLmbtimGX42TQPVwb7CsRCen5g55FckDkb4wDUGLPBUFNo2Bcj6VG2+BQdHR7RXPJoU2XcCAyj23PDQf+MlI2RM0yY+KvvMcjk2pOE/BSZzyvz0ew1M24U9/XemCpeKjYrDThJVEAhbGTwVa5Az/w5GtC5zrjN1EGFCsd5jemuIx8tLRkqBHCRL877lXPgxxBFbyDoQ3qFFk5K/lyHlk8/k85GOIGJp5UenTpSDrGT35ZrDRAu13ao0sGk2ebN6CXu3lJ4njysfi5TIcLAxLJxmf41QlJGMlOzUfaG0GlUCkOtlA+r2UbqmaaA==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: e367fa6a-003f-4922-383e-08d8755dc8f2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 01:08:14.2417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LrrctriesXVDB6gLB0Oi1cG9rOdGIhI3MhW9ZNXLPRoCkAVfMEN51YzOT1Q1rTpn
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

libfuzzer supports a "custom crossover function". Libfuzzer often tries
to blend two inputs to create a new interesting input. Sometimes, we
have a better idea about how to blend inputs together. This change
allows fuzzers to specify a custom function for blending two inputs
together.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
---
 tests/qtest/fuzz/fuzz.c | 13 +++++++++++++
 tests/qtest/fuzz/fuzz.h | 27 +++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index eb0070437f..7be7226bc0 100644
--- a/tests/qtest/fuzz/fuzz.c
+++ b/tests/qtest/fuzz/fuzz.c
@@ -118,6 +118,19 @@ static FuzzTarget *fuzz_get_target(char* name)
 }
 
 
+/* Sometimes called by libfuzzer to mutate two inputs into one */
+size_t LLVMFuzzerCustomCrossOver(const uint8_t *data1, size_t size1,
+                                 const uint8_t *data2, size_t size2,
+                                 uint8_t *out, size_t max_out_size,
+                                 unsigned int seed)
+{
+    if (fuzz_target->crossover) {
+        return fuzz_target->crossover(data1, size1, data2, size2, out,
+                                      max_out_size, seed);
+    }
+    return 0;
+}
+
 /* Executed for each fuzzing-input */
 int LLVMFuzzerTestOneInput(const unsigned char *Data, size_t Size)
 {
diff --git a/tests/qtest/fuzz/fuzz.h b/tests/qtest/fuzz/fuzz.h
index 8eb765edc8..ed9ce17154 100644
--- a/tests/qtest/fuzz/fuzz.h
+++ b/tests/qtest/fuzz/fuzz.h
@@ -77,6 +77,29 @@ typedef struct FuzzTarget {
      */
     void(*fuzz)(QTestState *, const unsigned char *, size_t);
 
+    /*
+     * The fuzzer can specify a "Custom Crossover" function for combining two
+     * inputs from the corpus. This function is sometimes called by libfuzzer
+     * when mutating inputs.
+     *
+     * data1: location of first input
+     * size1: length of first input
+     * data1: location of second input
+     * size1: length of second input
+     * out: where to place the resulting, mutated input
+     * max_out_size: the maximum length of the input that can be placed in out
+     * seed: the seed that should be used to make mutations deterministic, when
+     *       needed
+     *
+     * See libfuzzer's LLVMFuzzerCustomCrossOver API for more info.
+     *
+     * Can be NULL
+     */
+    size_t(*crossover)(const uint8_t *data1, size_t size1,
+                       const uint8_t *data2, size_t size2,
+                       uint8_t *out, size_t max_out_size,
+                       unsigned int seed);
+
 } FuzzTarget;
 
 void flush_events(QTestState *);
@@ -91,6 +114,10 @@ void fuzz_qtest_set_serialize(bool option);
  */
 void fuzz_add_target(const FuzzTarget *target);
 
+size_t LLVMFuzzerCustomCrossOver(const uint8_t *data1, size_t size1,
+                                 const uint8_t *data2, size_t size2,
+                                 uint8_t *out, size_t max_out_size,
+                                 unsigned int seed);
 int LLVMFuzzerTestOneInput(const unsigned char *Data, size_t Size);
 int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp);
 
-- 
2.28.0


