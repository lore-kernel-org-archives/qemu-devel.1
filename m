Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D682CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 17:08:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2BC32065F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 17:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="N15krGd6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2BC32065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnPvh-0008RG-W4
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 13:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jnPtj-0006Qw-1w
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 13:06:19 -0400
Received: from mail-eopbgr770118.outbound.protection.outlook.com
 ([40.107.77.118]:23989 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jnPtc-0003Ih-AQ
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 13:06:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q45HR43sH24emHIIma82o92YJ+Trbgjl6bbkdtXgq+aeHNdZF2gnLi0rIvLXJIf1/eobG1MHv6g9UsZYlbA0m3CzYd+8fljgv63mlLmz+kHJmZy94OnGCgY88UHXFQIckG3R5Ly6bcyo0BdG+JutpEWxh09sRwSEGD0bS06lLAcWXt8dPrVfv6Yuxj3+Lu+b19MTlXrnqTZFccGFm+76OWRyS2Knjkl2qq17YpR80QKlkqP7s4Cp9QEFOoIF+3hSFmzaGRagnmbTEFLnT04Y3bc8KjloPH07funO8E1VQ88jyKXRQ8CxqWUWIP9neZ9lW18T8uvqMYBqpzDnxd0ZTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mu/T7bHTtapOSeNaWLFNf84aQ8uEfzIC6t/4bR2taMc=;
 b=D/W1ttEMWSu1b0sV1tW2jaDaoUrfFp89TYZQo/GUNp9U4nbNabcbHwTmmL4N0ILUbCfhQpy2cdWL9qN+dk0/QwlEPPNurV+cPTg/mbDq3uSgWPJ0hUq5CxUR2wh100LOaUNQG+Q0DUw3jvrvxaKro79gfPKWNjCN2vZKM8Lk7h1CjPTm13sKm2cuo8HHkNx+daLXy4siVZMUCA0caXJ4RbsDgdyYTNfVcVg4BXwpsfrsPAz/lIitwIxgoJDDiKIu6Mf7jBtps8rGLBh8cKFSaWKGqgDu029UjFA7BptIJf01YEiWyuTchTbKTNbMqAYwJhygZqRoETa0iQi000Iwsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mu/T7bHTtapOSeNaWLFNf84aQ8uEfzIC6t/4bR2taMc=;
 b=N15krGd6RBOi+204xsr2EeMiyzR6vOff7FzNJtsM7Ts6xBNXRWL2dgV4HDasfDGkRoYvoVqGLaJFQ7eATopM/vOOjy6Ugbw66+qeJTQB+xY6750STWE4rqTb3K4qoKEQMjgfwQR5D5Bh3piA7DbTje5EqT2+54/fvohr1hq5BO0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN2PR03MB2144.namprd03.prod.outlook.com (2603:10b6:804:c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Mon, 22 Jun
 2020 16:51:04 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 16:51:04 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH] fuzz: do not use POSIX shm for coverage bitmap
Date: Mon, 22 Jun 2020 12:50:40 -0400
Message-Id: <20200622165040.15121-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0029.namprd18.prod.outlook.com
 (2603:10b6:208:23c::34) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR18CA0029.namprd18.prod.outlook.com (2603:10b6:208:23c::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend
 Transport; Mon, 22 Jun 2020 16:51:03 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4be7aae-5849-48b0-29cc-08d816cc7377
X-MS-TrafficTypeDiagnostic: SN2PR03MB2144:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR03MB214428FDC3ABE39FDEF31587BA970@SN2PR03MB2144.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Kc1TfCa6P+B+8UYsgPNVMkXlc5EcGSqsSTPgPJXTdIbXZ0ZHUq0NMjVtZW9O4Qhl3KTQY90Om2Qojqo0TOjwnPgYbAMOL/bkNEnhZK8WQNq2fKw8VgGQmJNliSxu4E/rojqikhoni0R8vXHJc5mf1rJc4KTvYu/AXp/yuhPgg+0BuH7S5FgFAaxUHdtlAqKTzuJzpW0BO3gJv4Bog5Z4Guptvsj8NExecqFgr0jlC9DCWQDT26bkvv7X+29qye5IOeBIvSs3Nl1y+CiLmTVGPQVbGgl2/4NfbTw5v/RFZiwNQ1Y+UXfJ9DBp59Ptb1DzQ0NhC9sua8W0FoYdQ+izdwZ0LvmPrsmcbMl8k4bz+CGfUeu7QaoYF3Us+xgQZg30dOUVSAaLp+yhvk04t+8OA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(83380400001)(54906003)(8676002)(26005)(7696005)(75432002)(966005)(6486002)(6666004)(316002)(2906002)(786003)(1076003)(52116002)(16526019)(186003)(478600001)(5660300002)(4326008)(66946007)(956004)(66556008)(36756003)(8936002)(86362001)(2616005)(6916009)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 8h2/bWKRini27vd2fzd37D5Fo1qu19ZTeKPYwNdTfJdH9BGVeFJi6VqXF+1XJmKMNsHGs2mNVv9vlqhsIaR+XCnM4wVwPigbjbtiZe98VY/mUdp0gl+qVkMbW5WRHrpkAmCal20CAChXv78E4zowf2gYyxoqsAG2OuUPJgkIFjB0gFv1VXS+qSTbPUQpUlMoUsKxWW5YTXQiCQ50Hscb59QtM+9E3AyrVtoT1990VbH7YwuRAwXfGLyQiBjgH7Eqv6LksEDCQvtcOc+tvKdNI/VJdecWOQlbusTScHaVcNbn3R9tB8LKLqjOFPBZX+r4S7kxmIIbF1IL7DfGt+jpb/xbj7ERPPW+yH6/eZsbD2vzGQww7Rz5qEfrF+X7yZYOloSiKd9UPQLiYyGlDofVapxM1CtSdB78kYwS8d57tel56rJj7q/58uNDAMMryWmhm5aMuLc8l/IkZRlZ8jDaRxxVAOBYLVQbL7M/ZuWUP7g=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: d4be7aae-5849-48b0-29cc-08d816cc7377
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 16:51:04.1702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xAo1C5s8Xbj0VjRDuVE4A1k1599KSGL+dUpiqTpDr9VMyTq1JdPw+Wptwdqulcv5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2144
Received-SPF: pass client-ip=40.107.77.118; envelope-from=alxndr@bu.edu;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 13:06:07
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 f4bug@amsat.org, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We used shm_open with mmap to share libfuzzer's coverage bitmap with
child (runner) processes. The same functionality can be achieved with
MAP_SHARED | MAP_ANONYMOUS, since we do not care about naming or
permissioning the shared memory object.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
This might fix:
qemu-fuzz-i386-target-virtio-net-socket: Unexpected-exit in
counter_shm_init 
https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=23636 (private link)

oss-fuzz does not provide access to /dev/, so it is likely that shm_open
breaks, when it tries to access /dev/shm. This seems likely, based on
the oss-fuzz minijail setup:
https://github.com/google/oss-fuzz/blob/3740c751fd9edea138c17783995d370d6b1b89bc/infra/base-images/base-runner/run_minijail

 tests/qtest/fuzz/fork_fuzz.c | 40 ++++++++++++------------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/tests/qtest/fuzz/fork_fuzz.c b/tests/qtest/fuzz/fork_fuzz.c
index 2bd0851903..6ffb2a7937 100644
--- a/tests/qtest/fuzz/fork_fuzz.c
+++ b/tests/qtest/fuzz/fork_fuzz.c
@@ -17,39 +17,25 @@
 
 void counter_shm_init(void)
 {
-    char *shm_path = g_strdup_printf("/qemu-fuzz-cntrs.%d", getpid());
-    int fd = shm_open(shm_path, O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
-    g_free(shm_path);
-
-    if (fd == -1) {
-        perror("Error: ");
-        exit(1);
-    }
-    if (ftruncate(fd, &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START) == -1) {
-        perror("Error: ");
-        exit(1);
-    }
-    /* Copy what's in the counter region to the shm.. */
-    void *rptr = mmap(NULL ,
-            &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START,
-            PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
-    memcpy(rptr,
+    /* Copy what's in the counter region to a temporary buffer.. */
+    void *copy = malloc(&__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START);
+    memcpy(copy,
            &__FUZZ_COUNTERS_START,
            &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START);
 
-    munmap(rptr, &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START);
-
-    /* And map the shm over the counter region */
-    rptr = mmap(&__FUZZ_COUNTERS_START,
-            &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START,
-            PROT_READ | PROT_WRITE, MAP_SHARED | MAP_FIXED, fd, 0);
-
-    close(fd);
-
-    if (!rptr) {
+    /* Map a shared region over the counter region */
+    if (mmap(&__FUZZ_COUNTERS_START,
+             &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START,
+             PROT_READ | PROT_WRITE, MAP_SHARED | MAP_FIXED | MAP_ANONYMOUS,
+             0, 0) == MAP_FAILED) {
         perror("Error: ");
         exit(1);
     }
+
+    /* Copy the original data back to the counter-region */
+    memcpy(&__FUZZ_COUNTERS_START, copy,
+           &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START);
+    free(copy);
 }
 
 
-- 
2.26.2


