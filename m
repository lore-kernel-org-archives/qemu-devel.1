Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,RCVD_DOTEDU_SUSP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EAFC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 16:34:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EE2722245
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 16:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="zsmrASXZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE2722245
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZcnJ-0003ot-33
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 11:34:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kZcmI-0002lo-9A
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 11:33:54 -0500
Received: from mail-mw2nam10on2094.outbound.protection.outlook.com
 ([40.107.94.94]:38144 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kZcmG-000114-5F
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 11:33:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzUx+nE/2XF4Gr51C5iYl2w7uOzuiHS/HvOJf5v4c+C3prTzJcC3n3Ssv6Ux+QN9R+XSbTiPwTvjkletJoPV2bJdxhVTyDnFiWVIu9KqHzQSQhbpmcSMyWcquqo3Ta3avK5CGj16Y7TaQNAwnCohywczvVdIg6ldkFCaqFaghvUPwWHx7hzlFnKLdpsDbKvvzPcGheUMlCmsOH0mt6ThZg21OeMJWxAD25HrPfKUwmNAOnAm6rbpcr5fB8iH1WB+/3+MA+3sqNKo5DcuLAUWPEVHzTFpiTWwQL0cmPPzWA3oNTHsESi+8nkmO9U/n815p/MVtgt7sOp5l6dC2t8OdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fjVqGZbd/b8mz4//HikOCl7aeWSV70Nq4JKsJNtVlw=;
 b=nAtho2uqPKnaKE6WQVJgT4qOuEZ3rn/HU3O2YzFfMik+tTCqczS6JHwAKkFzfTfC01EWr+S8n1F3fUCoeFLZHj7yPpvPffwNs2qdw4yQdJoaoEeqCPfCjKKLCrJT+8YBLaRm4ocD3HMVCWpgR8LGRbL084ufrYgVrDrX/R2rJqOmxx9oh0M6ldb+Z+iIIWlV44HUaxJYtWbsRn3/q5IVnaPEBb+T3khwqpHyXnczDwJWeFNpULYqhs03kFPFEpU3fES7HtBgDj5XDJlebEHFp5nwbaUqWXjKufEqKpeV7ltW/lxQ7xYEmqgp9gbWgsDfMc0/mja8MRrsMW42+B/fHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fjVqGZbd/b8mz4//HikOCl7aeWSV70Nq4JKsJNtVlw=;
 b=zsmrASXZS19xAUsJ467yeLHv2m2ykSNOfF0gmmMFh4j9fPljp6Wo7yi1F15NgfNJyBjbngCyx/K48st4uyfTTWsNB4b6zXW8fxzZbT3PBucLCvbbQWQlXaZEAH00ZcGA7x0IhM/rSkf+jDu3gwrsOgsa6acia2MgAnaTGGxDT0A=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SA0PR03MB5483.namprd03.prod.outlook.com (2603:10b6:806:c0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.28; Mon, 2 Nov
 2020 16:33:48 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 16:33:48 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH] qtest: add a reproducer for LP#1878642
Date: Mon,  2 Nov 2020 11:33:36 -0500
Message-Id: <20201102163336.115444-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [72.93.72.163]
X-ClientProxiedBy: BL0PR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:207:3c::14) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL0PR02CA0001.namprd02.prod.outlook.com (2603:10b6:207:3c::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Mon, 2 Nov 2020 16:33:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c08f6c9-5f52-4722-d270-08d87f4d12eb
X-MS-TrafficTypeDiagnostic: SA0PR03MB5483:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR03MB5483820AADAC06A9C190C135BA100@SA0PR03MB5483.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:61;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gygfBUzGEkQx52vJH/Sqj9XehIKFgrX1jdCSUIYwPClA6cbzusTBTz4xv++RT2q3xr90TxHHV9OrSI5N+jQza41W2NagD9zw2HZ6ZqHQ7zlPXUN+OUSCpdkIieznqYhw4TtHmXu1/7+6h1+iFbP91YyKMNWLFgwoAn5hXwg9wsqiVAFCVQ/6aZFG+xt1L0oVeRATNTqaX8GAI0Z4RYG5iM3KGha5Nqyqd5kARA+roSWoheTO0QMhiWKQFrjfUg6osjAoMaee+zm+4bgOR3jcD+U6HqZLyUFAHHGyx6f5coWxbsDcc2nPr/ub8rs6/eJ8KqYyhTthGInGwucjTgWXAHGtkGWRpIXisdUZG7+kuH2j6+anHqce+tADytB1v0yMLLInwf0qx5PI/BbYazda+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(1076003)(2616005)(2906002)(66556008)(966005)(66476007)(6512007)(316002)(786003)(52116002)(478600001)(54906003)(956004)(66946007)(36756003)(26005)(6486002)(16526019)(8936002)(8676002)(5660300002)(6506007)(186003)(4326008)(6666004)(86362001)(6916009)(75432002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: nD/wQ+UMPrXfvFMPXbFBlxKBvwJ9cJOyIkt+sIUfWOTEW4rAsvfBO+PdzHbeXs7h4DJVtk5zXlTcw2ZB0KDyTPIi5lXVvk4xeV0jU5q2gUEpNPS/51C+rOdJUqZlsRvjebzlBHSJhxM2PQDe5w5nudc9liC0lM3zqMdAIJP8YDJ3PZJSoqmJaKZuxI2wPf1zPID5beqxAAK+VApr30WrN8eJKQw92rA0Y5eljKsXgMJ74GwsYMQsMLt80DEUleu2+XmZ3fMCvcMtSwwPxF4UWUT341Beasf1k0oGGo+gAngA9JHqbIsg/fT+GwjOQVCSHIRJ9nwnVlqltIoCA5hZfyvzsZH+8NiEbZRGBwrRJm+jK9riOtsyD8POHiR8z79ys46YieorrQuvgzObrFOu0aGWOnI/sA8Mpva1fQXz9b+NM/cxsB5cBbfowKQnQUjGz+Cs5caAWuL4ouz8sTnFykIYgx7zU4+EE2RPh/nQxqdn8IyJwLt/XmuWShetsux2ZZOY0N2PkaI5jlUUsfpFD3VH2NSpZoSgXCNPeE2wx1fXKF8Wq8pGkuUUA3DH8oPKhrSn6upImngfiHp0DA/6TT54cYoQ08ARfqPxapKpEDaFU+lK5eBxhE6g3zR5gTJOY2nmyY9qARFZ6MB4UAkXpA==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c08f6c9-5f52-4722-d270-08d87f4d12eb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2020 16:33:48.1508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EbwqC1/CmmuohJVSg/tPeiLfKJSjlwXNCtabxZlr/H3HwRdnV5wosiF8PCDAaCYi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5483
Received-SPF: pass client-ip=40.107.94.94; envelope-from=alxndr@bu.edu;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 11:33:50
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.374,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Thomas Huth <thuth@redhat.com>, f4bug@amsat.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

https://bugs.launchpad.net/qemu/+bug/1878642

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---

Based-on: <20200717151705.18611-1-f4bug@amsat.org>

The added testcase will fail, unless this ^^^ patch is applied.

 tests/qtest/fuzz-test.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tests/qtest/fuzz-test.c b/tests/qtest/fuzz-test.c
index 2f38bb1ec2..9cb4c42bde 100644
--- a/tests/qtest/fuzz-test.c
+++ b/tests/qtest/fuzz-test.c
@@ -34,6 +34,19 @@ static void test_lp1878263_megasas_zero_iov_cnt(void)
     qtest_quit(s);
 }
 
+static void test_lp1878642_pci_bus_get_irq_level_assert(void)
+{
+    QTestState *s;
+
+    s = qtest_init("-M pc-q35-5.0 "
+                   "-nographic -monitor none -serial none "
+                   "-d guest_errors -trace pci*");
+
+    qtest_outl(s, 0xcf8, 0x8400f841);
+    qtest_outl(s, 0xcfc, 0xebed205d);
+    qtest_outl(s, 0x5d02, 0xebed205d);
+}
+
 int main(int argc, char **argv)
 {
     const char *arch = qtest_get_arch();
@@ -43,6 +56,8 @@ int main(int argc, char **argv)
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         qtest_add_func("fuzz/test_lp1878263_megasas_zero_iov_cnt",
                        test_lp1878263_megasas_zero_iov_cnt);
+        qtest_add_func("fuzz/test_lp1878642_pci_bus_get_irq_level_assert",
+                       test_lp1878642_pci_bus_get_irq_level_assert);
     }
 
     return g_test_run();
-- 
2.28.0


