Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90712C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:24:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7C642145D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="64Gf8KW/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C642145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVLbJ-0008KT-OT
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 17:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVLMr-0003dX-LC
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:09:57 -0400
Received: from mail-eopbgr690122.outbound.protection.outlook.com
 ([40.107.69.122]:45277 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVLMp-00083h-W3
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:09:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=he1sJHOS5weafBlZO600EFdtkaMXJUlHeQXLNFrWzKsYF0xQK7lkAMZpEZULzLD/VTbIwzx7JVwrSc8UVhJW+VLpeoj6iLHen3HFNOpCZ2j2rumN8EOOrIJbdd7Yll8kwl+tWJ4gpsPdUjNOUI27IxDWFzI6xKasehwLHg2hGTLBGeHXLxRwUqIvDfw0RHDyUKwBsT2qG6OFVelcubxClVPrZzSTBEMsPy9IYrSau1VSD6jZ8oIyNG7mzf64Hk1Q++FVtAF+VqjtS+apqpLA0i1nI2ythcXF7TefVtsdGBy5LHrE0EgrT5wMlPtws83TgfFL1euyAFtRDXzVPPO38g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JConF3xBRqpbuFwEhD621vHq4kTf2LaXQ5y+kvYOsM=;
 b=ONf+q0vq8W5rf2FX/Hqx3SrG//MowtFITOzrIY+9iBFdorie285rGaPV1ncZ5MUV6e9IUWMGY+6u7h4dX3UnEhd8GkF3Ou2XlJ3z6y98RnDCgpVkQeteHlXs3gHfZq3TIG1dxryJGPhHp3uQOC7CBYQR+9MffAfG6myFaU/u7Mw5VSA1QJc+/KDIEDuFV1RUIaiikw54bceVQYtOvnB4Rb9+fjfbaL0854nFrlZ7zB8g8MT4Z5UTyOL6KWHvk9bLDwVSwpnQNIso/XWCNF2p6Qks+ZuFlUsaOCaEQQYux1ShnF8aq+WqLWq2fwd7waN3rdygWrRWxYg1l1NgCDzUYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JConF3xBRqpbuFwEhD621vHq4kTf2LaXQ5y+kvYOsM=;
 b=64Gf8KW/H5zpb3fD2wvq1Nihaps+nLDkoC0ZX6F/EeE6S65pv60ZMnALydbEY+M9nmBBED+7Yhm35lTsq9ZAt8EjEwIxBxYUBne/saiPsIavZXFaSlKyAvshE7Opgv5yHtyLnEQ/z9tmCgESeB1Us6yZAfgkz9ZGtd+RI3Iiz28=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4045.namprd03.prod.outlook.com (2603:10b6:805:b8::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Wed, 21 Oct
 2020 21:09:45 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 21:09:45 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 07/16] fuzz: Add support for custom crossover functions
Date: Wed, 21 Oct 2020 17:09:13 -0400
Message-Id: <20201021210922.572955-8-alxndr@bu.edu>
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
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 21:09:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8901c859-1f86-4dcb-1799-08d87605a2c0
X-MS-TrafficTypeDiagnostic: SN6PR03MB4045:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB4045A26AD584D9CEA742324FBA1C0@SN6PR03MB4045.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ty3bI9J0wBv3Ey5g4AKQ8VsBoJAsws9OcMix4bayM1HY+y437s/qMU8r0uTcVXftmHVaOLvO0a1ETxSblNDn99nNJ2ZC+ck5cJHRsdeQVe1xArWI17Z9Wsl24u4ztJnovJPl1MG4fwQgOOfEqfsx8yuBmfPkGS/FdtMUj5R1hwsProD0qixmuDsW4LsZMUD9hwNjeeR2dfJM4lkKNrBLAMyrglb/jEaivxJOHIAYsqEJNOFD1Wcypx69DuF9hbBuRauAQqk2hgf/UKRlM92ef8NB6Ylzj7ePBQm3p43gNs8A9RI3GFFT13izjMTcZ3oK49mQ2qodZ+KVTLrj7KDZFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(86362001)(6506007)(956004)(6666004)(2616005)(52116002)(5660300002)(316002)(75432002)(54906003)(786003)(8936002)(6916009)(6512007)(16526019)(36756003)(26005)(186003)(478600001)(66946007)(6486002)(2906002)(4326008)(66476007)(1076003)(8676002)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: WNShwcge8O0/YQobMQ0cQqDB8hJPr1wNDX3ONmUgPbiprl3pEoxkZB/ieVhGxzVtDn+v1qpnf96b7OB4c+PFPGN2clF9jGZn9jE8GVglxX2QLZsrT+0SeqZ8hBSj6CCf6/UizFZdDdr3YepgWSjcxs9OWK77gAB7FtfOVYoXWCq4q8wZ6T4cgCFONJH5qoYO+3ONbydnOhRzL/0Fqis8EQToYYnkBKwtT/6TKxI0IboEAE+5nwFXzmbeQfK2VinxIJ//qNlxCM2F/fMJ3H59Sn/HIl96R80sW5bMAzAfj8JpL2N7zjaJjCE3CedA+Dwj56ONStrIktqD4Sr5mVXnUkuYNB/22a8X4cMBRyTAsz3kRxoJ7lkNQItaug2Jy8ccGMLRmr6RlQPEqNtuz4kHYgmSJlboXkY4otWCzSL0YW/rtep5ZX2HNIcTf767UO4Qahas44hr60Xy8Ly2sGSfDKi6tpRs3aryXJPL6l4T6twemzGPrukAkKu41Fyg8PWISUfSvF3KBT1hStsN6pajaNi0ry5C5TEzA7lmi72gWBkcGJ+r2+BXLfkp7sNoqwQqBl4RRDxpyeCSjq3L+TjD6fLsO9Oguc2mpKb3/Cs/LD2JzX6hUu0F4sygP5Wh+RgnI3b2K1lUlZvOYE4mqNowug==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8901c859-1f86-4dcb-1799-08d87605a2c0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 21:09:45.5004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pGKF3HAFaWA8gOl+vd2MdKbUUQpuuGwMoqcxf9K02maQs2Xi5QMOCxOnIxqdQHo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4045
Received-SPF: pass client-ip=40.107.69.122; envelope-from=alxndr@bu.edu;
 helo=NAM04-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 17:09:36
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


