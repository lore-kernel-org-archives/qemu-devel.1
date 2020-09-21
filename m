Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DB9C43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 02:34:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24E3E2078E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 02:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="fQNz25ae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E3E2078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKBep-0006gI-7n
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 22:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kKBWY-0003Dv-4N
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 22:25:52 -0400
Received: from mail-dm6nam12on2117.outbound.protection.outlook.com
 ([40.107.243.117]:28256 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kKBWW-0000b7-FF
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 22:25:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZaXw3FHAMIiLBVsHd9XcPfBilkuzAFngDHsSJ7tbeRDhMth4oWaNDZ3I7X5XjLqNrl2Bcqk2t9Y7GDPlaR1GaXCfxcaqPN/WCXEW0utUA+33RizOQZJFIJjjGhOaoM3SmfvCOsZPpw9hog7hy9P5XyT4vwUABlu7M4cgCNdtkd16WDcVoWHP8ghmp4+Q2uTUS9Cvtx/OrbDpJdqToQsagdykFATfn/z2SYhi/U8Ai9AbspY9Cy73pMx3zOAVqn9R4dDFj+oZM6HeqlxkobObPEpo4mCR0tHEafVRgPul0lQWD1dYXr9h4Gd9BhGEdKxHFuNXoq9zAALAvIVQwqy33w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdbSPAuFvXRPyMkLVUBpMuOypvkPeOU9Oeq5sCNBAbk=;
 b=deQhs1knGwJbGBd/5sb/+WX9ncMU0/TFBr0fnRTMeLufmhdivivOLxQsxt9zYPqlyrvWYblfuSMp6b0SIPz5gb/Wppxelovbm7owK2V/2xeJPYpZG6wae0ImirNnRZj3E/kjm5prncVCUVo8ffkBwbC1lIc6DG3PoDopY1iu5ZW6FZ1XhXOMICLqfjP3COWSQ++qX16mYVZpwccnCQMxjjJKfjpXKSxCkf9QcJezLw7LhI85zgU/e6UVHK4Pb+y2sM9+ItgDcUN6MmTH/7Cs9u0dhtPUgZJF2koC956QF56u/Se4NE5aamLOvByBthernjvLCnbBRFewqxuXEFlZmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdbSPAuFvXRPyMkLVUBpMuOypvkPeOU9Oeq5sCNBAbk=;
 b=fQNz25ae0P54GHpZyYVnICm0iXj2ZOe4n+CuXGkJnVMRxcfDLof/MZ9hOGPVA06TNWhX/h3Rjv+3pVLSn80mZAtWkFrfylgQYgZWB8yynygtIyANR23ok2y/qoPwetkq8IPv3xxGiCtC9fAESFgDVWkPEnxAaKTZx7CJBGP3hYs=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN2PR03MB2237.namprd03.prod.outlook.com (2603:10b6:804:e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Mon, 21 Sep
 2020 02:25:33 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3391.024; Mon, 21 Sep 2020
 02:25:33 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 07/16] fuzz: Add support for custom crossover functions
Date: Sun, 20 Sep 2020 22:24:57 -0400
Message-Id: <20200921022506.873303-8-alxndr@bu.edu>
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
 Transport; Mon, 21 Sep 2020 02:25:32 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb05b5b6-6720-4f55-b1bd-08d85dd59dab
X-MS-TrafficTypeDiagnostic: SN2PR03MB2237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR03MB2237C019514FADC3F0F8564DBA3A0@SN2PR03MB2237.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u8udvrnZXdrVnIbBcDrU9PLE8ouxdnXqKjrx4puMmCcuYB3Tefg4ti/RYxi6egtEGDPDo/zB1Ush2YbxaxBum9x49UrU8Ebrnr20Txik4jmIGrrvE1NWr2xY+1j8hSZN1V4gc+WrXTuoTwmevo/IC/NL9IH9xzxS0KOmrY/Zfuzo5fK6QqoT/rp9/52ePsgj8Tw/MOwGvnRb6P/98sRW0k5xWCaXxHgLsLWkFIxzzFSjpIg52/K/PSelzGcPTE+4BltFz9HRqGabJMD3EfU823H8bP2YVfOU3eY/AGMPqxgklpUCkW1nKljpXzilWEEAZI68QR9vaj8O2tTlYJE0X/DjbFjWw0rAF666yJaF/8OEclFSOTMqwiZyG3MTlHEC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(2616005)(956004)(4326008)(54906003)(26005)(478600001)(16526019)(6666004)(8936002)(316002)(6486002)(66476007)(1076003)(6512007)(186003)(6916009)(86362001)(66946007)(5660300002)(36756003)(75432002)(2906002)(6506007)(8676002)(66556008)(52116002)(786003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 67FAfmIlhjHiuCz9DqpabfoONeNpIPd0dydqmQ/oD/Ww3zLlKxBqLnKTUIkyV7GpGG1KlkeAyqxpcrMxOD7WdieGV0qTytgmEub8E3w+1aLSHaLGg5VtoRyo/OLVZPiQDW5n+FsPSJs9e8GOfkVjK5vjT9ClkzuXq+6rWS66tMV99jDucZ8xLbhupQ2aJu0Ag2f1HQrYAN8rDnKF26qa0L1ecEqDlcphnb5xF/e9qPquqmjQ9KqMSqVTssDVL/KWSVXpb9UEif1J0qRET/C5pBabwgQ9zKGa3gASox4Op7qI4fb5S6jXBXoo+bicPiHyGZeVDkxHl7324iPda3WEXFtADW1qIgMLrGeU2l4EMRn7hWF5GcbLCU6e+ZUzAzLvESSx8sgi+VH2LawAvOYlCKjMI1lZ52orJX6dlrYqzVjGypI68j+osKriI2bM+i2+2LIlNNqqgt95GKIRsCiPBl3ImJYIyhWqIK4IjxrbsLZzfYyV3CwGuTYEOfA4SgIp5aBg/Qs65aILWlWPpU2nwmQx8ISyAXrcBT0c7xtOyRtswudy9HygUH1CwgI49rkNNmL53rojQ9zsNUUY1pdJe6hTTvS03+/oTMy0f12z2HSKQSWERXbQOY76ZQAv8A8/I8NEMD3Lz47IUYG0Wp+Juw==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: fb05b5b6-6720-4f55-b1bd-08d85dd59dab
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 02:25:32.9926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6HdJbDxcRqTY94zPQalDmGtIVQ2qMf01nfbm0eW981pATPGGFDP5B+MHanuLau/I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2237
Received-SPF: pass client-ip=40.107.243.117; envelope-from=alxndr@bu.edu;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 22:25:42
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, darren.kenny@oracle.com, bsd@redhat.com,
 stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
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
index 7f266ffc63..87a1b88f9b 100644
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


