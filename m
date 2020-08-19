Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A88C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 06:15:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58E6A20738
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 06:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="ayPxOVJ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E6A20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8HO4-0003V9-KU
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 02:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k8HKG-0004BF-BS
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 02:11:56 -0400
Received: from mail-bn8nam11on2094.outbound.protection.outlook.com
 ([40.107.236.94]:24608 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k8HKE-0001Y3-G4
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 02:11:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqxVs/Xe8fC76nuK2olidT+UqwyukPUiIadPEjAruIZnoPFZNOMrDTmsvnEmF4GRoQ4LWD2j60XuoQ08w75c+fyXSnGZEajTk4w+cHs+7zpCrx5klSsuRCfWqyQr3xZQScsElYo4QyqkizEJzI5H4KvFTvogpB8DkjhMUzhKHtmBsbGUrC2v5T2cpQhwCZhfJhpfWtwdhQQItyHsShxGi02uXEHhWTxC+7TVjgxlqp9yGQ0sHLyKvMLaUeW2sszEpwtdQDNJ8Nt8Pu2wGjfRaBHL24kz1P64kXY49tf4mSKnyzjowwCoRLVG0ZzgiPGbsjQ/RLxvlwjJ5aUiW0S8rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIe/dnR63JYB8Up+MAS928e1OIoQgKr9JYoMOnC4QsQ=;
 b=lgDfCj/cONlcBWdmqvl6XvF0sUWScqaW7dmOTrMGIB0n5mx0X61l7FsBOh+6GaGtL5MeQb3eomsZeud7dP1oravjasgQMCVBwwrf7L9UdU26X39YAMhETOSmOlB2fQ6QWIA1CyvK97KY7rp6/UMfF7SvFSYJOsRYGem+p+GLWVjxrMO1d54pBZnRORv6h0hFrOcjkjmsVU7F++XDONOYtacBJu0JHNgUUV/Z7Tro9FzOnxUG0eQDDSa/NtJfYOwvhXNcs7bVikF0F7Qt/1Ouu0OI+kNJJHbLbzdzPysV5ldlXiabHuB1CvRWah2bOiYg2ZDdMcKrCQtCZJE2VcOS9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIe/dnR63JYB8Up+MAS928e1OIoQgKr9JYoMOnC4QsQ=;
 b=ayPxOVJ3fMgf1IsKgAQWfValVB6jhwziw+v2zrGw40/7aQ7Cdjupkd/rR8vhXublUGV8X6loHi3adWfe8QHfrRtklrSaRD5N2Fc/XYG0cKb6MbJHpeq/QW3ARyS/pE17J5sd0nXQqzQahPVQD78moCw0MoKUn8Jag0OGIZ/7Am0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3934.namprd03.prod.outlook.com (2603:10b6:805:70::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 19 Aug
 2020 06:11:41 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 06:11:41 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/15] fuzz: Add support for custom crossover functions
Date: Wed, 19 Aug 2020 02:11:02 -0400
Message-Id: <20200819061110.1320568-8-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819061110.1320568-1-alxndr@bu.edu>
References: <20200819061110.1320568-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR1501CA0012.namprd15.prod.outlook.com
 (2603:10b6:207:17::25) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL0PR1501CA0012.namprd15.prod.outlook.com (2603:10b6:207:17::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Wed, 19 Aug 2020 06:11:40 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25481880-6dc7-4cae-1e39-08d84406bd4e
X-MS-TrafficTypeDiagnostic: SN6PR03MB3934:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB39340F926CA52B3EC057A450BA5D0@SN6PR03MB3934.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CGQrUSzht4n2UlEwkpcBcbkzh23HNB51cSY+IVJKPW2c8ys67OVT490OG7mc3yYNktyLas12dgY/dUbBELI/D9aPLEwgYTybuVKdfRtbL9GNd5ZtDatc/JRRjhj11l05Vdss/Z5JhSsy+70hhGBh3+y1CEAEthrDzCbkj2KMN/j2839cW5l8OetBQfhQrLVUh9LpI7KE2YrO15kpPZ7Dfb/1em03bJgyyoEVP4uyob7UVp4slhPof/kPGY6gU1H4l39jkvFDwgDYgDqO4md9JrQcmR8zyGHGSguRdOuoaBiWwoT4RO9VmTwDhUXx38C8FQRmUejRuBx8MIGDDG/HEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(1076003)(8676002)(6666004)(2906002)(6512007)(8936002)(6916009)(6486002)(54906003)(956004)(6506007)(2616005)(36756003)(26005)(52116002)(86362001)(478600001)(786003)(66556008)(316002)(4326008)(75432002)(66946007)(5660300002)(66476007)(186003)(16526019);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: P1S5rnLSXLtfwAB/A57giw0NKHWBzNfOFqMOzRTTar1SdtAWv1vVANtyp1UaGR+3T1UfCO3pOxibXNGljUtw2LYV4mP85PZVAjfRz+hgSRzBHLUAtCCwLpMgGkgFw07iTi3fasaC+17y88/PPy7Q4gB+y9pWJf0NaNVTiamd8p2s77l/zkZqfRtWJVMIWmgXisDd8uKRjA+cHAnsupBf0igN0vgl7sa1PuTbQp+HCrQ8LfZp7M2BNtieLb3KaVHX+fEKgDbsdaYgrzejTqNqrihKITsOHufnnORBOgsPzN7MoqjCilcWHxkpiBCdfIUZ6cXb9YWq7uYb1dQXHOmILy3dYIvMpbb5Siy3jLQZgbncB2uBKWtiDmy85F6qTSa7obJB20syDB2VEUCktBh20CGCRIOVasmc7xTyjmlASq8kvGdv9/qEG5kETbaaVTWvhnTKV9y6WGoMUifaWZ0q8f8T+Yaj7Bgp77SmiYyZct8knm/T5Fta3y1KGBtLk5tZXJ0poK1vKQN/4DDuHOzoEysC3pB86B5XzbzszuKB8TpUVTjsWb4k+ivig4NLptAnGuuAvphH5HHstJXgP3FSm5Pv3tMzE/jc9rlYjtbL73GCQFaEeeHY2RoJrJ1N4Nltun/+eYKVuwvmunZ3JVWauw==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 25481880-6dc7-4cae-1e39-08d84406bd4e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 06:11:41.2059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gA59hEwW3bITOD8XvK2yTwV+1UJG21SOAB2UgV5z72h/R6gGeCB5sejDP/BMl3ep
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3934
Received-SPF: pass client-ip=40.107.236.94; envelope-from=alxndr@bu.edu;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 02:11:39
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, f4bug@amsat.org, darren.kenny@oracle.com,
 bsd@redhat.com, stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

libfuzzer supports a "custom crossover function". Libfuzzer often tries
to blend two inputs to create a new interesting input. Sometimes, we
have a better idea about how to blend inputs together. This change
allows fuzzers to specify a custom function for blending two inputs
together.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/fuzz.c | 13 +++++++++++++
 tests/qtest/fuzz/fuzz.h | 26 ++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index 8234b68754..248fab5f37 100644
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
+    if(fuzz_target->crossover) {
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
index 9ca3d107c5..d36642b5ec 100644
--- a/tests/qtest/fuzz/fuzz.h
+++ b/tests/qtest/fuzz/fuzz.h
@@ -77,6 +77,28 @@ typedef struct FuzzTarget {
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
+     * seed: the seed that should be used to make mutations deterministic, when needed
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
@@ -91,6 +113,10 @@ void fuzz_qtest_set_serialize(bool option);
  */
 void fuzz_add_target(const FuzzTarget *target);
 
+size_t LLVMFuzzerCustomCrossOver(const uint8_t *data1, size_t size1,
+                                 const uint8_t *data2, size_t size2,
+                                 uint8_t *out, size_t max_out_size,
+                                 unsigned int seed);
 int LLVMFuzzerTestOneInput(const unsigned char *Data, size_t Size);
 int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp);
 
-- 
2.27.0


