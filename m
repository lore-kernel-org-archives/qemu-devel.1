Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAE5C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:53:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1C702222B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="J9ylmOmJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1C702222B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT3gr-0003sK-ML
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 09:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kT3WZ-0007hq-2a
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:42:31 -0400
Received: from mail-eopbgr750112.outbound.protection.outlook.com
 ([40.107.75.112]:30180 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kT3WW-0000kr-TZ
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:42:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDm0nanmSmdCWJYzDIwk8Hn0uA+tRXqIsj4820vjWcALfs5SXJ0Mx3qMYVbKk2Kix+d+eW1C4TZ6OEH3bb2XjakZRl2D62Xz6/bNpwRpIrJ5g6CsYbHODa7POixrxd9jNTlEp0jLmgoa2MoDEI/6xXCbNgstPZaJ0rGk7w58YnTJCF1xvsHA1J4ggmTPsyWPgfuOy95/xV0+82hFDhv1owM5y08W2du4CbPyf1GNYq/+AE+qCSqB7u8jc49qVqwVu2flDpT2Lo2g2Fhqmyu1OM3ySFh388QG9SGATFTy59Sj9L21bTPiVN7Ya+A7lGynwtliuVM64ta1IXUYOltmlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ofhel/Y+zk6nPpUJhwyqcyc0WQlzkNTfewTkfViO8DY=;
 b=d6PeMqs70BfKY6wOYDk9zt0J42pefP52ti4utBkhdisnjOlHAkEorGpFtPvfMRqVMjCz50pYAa0JLUWGiIXjEA9d5LW/XmypsNTdkOciBvZ8sx6OJjq+7Y6wg6hf5x4kR1w/6TofV9lYEl9PHON2IAyMtcin7p7S3zUxIDCzVjnsFWwa6EkxJEdXhR4qeuuH1YhPDYlL6h+RIPtXlupJGl1riSypdpViUBmn5Gs/XZYjIlmHVuhL0cgF7kWtR/ICmnvxAv+A2AA8GoTaeR1Ao2zVWWggpIr73V0z09X3woG3Kc4T5Y8EeHusCwPoqZQEObXayd5KsXfxU9JX/wauBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ofhel/Y+zk6nPpUJhwyqcyc0WQlzkNTfewTkfViO8DY=;
 b=J9ylmOmJw8CMAxF27UNc43Oih/u8slZXINsOzdquokahJKlBiofMRebWQoKVlpy0Mb8LQe9C+KIaQBByDIttdLKcLZSwwHj6GR8h8HXnX2K8R8vIdJJi1USlgNwOYVdStrbAZ9mHqjibsn4C9XkFQg8kfa0ho3XagUW4OGWkeLw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SA0PR03MB5465.namprd03.prod.outlook.com (2603:10b6:806:b5::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Thu, 15 Oct
 2020 13:42:13 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3455.031; Thu, 15 Oct 2020
 13:42:13 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 13/16] fuzz: add an "opaque" to the FuzzTarget struct
Date: Thu, 15 Oct 2020 09:41:33 -0400
Message-Id: <20201015134137.205958-14-alxndr@bu.edu>
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
 Transport; Thu, 15 Oct 2020 13:42:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 580574b0-c5ff-4bcc-af68-08d871101f12
X-MS-TrafficTypeDiagnostic: SA0PR03MB5465:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR03MB54650A846E323629B5759615BA020@SA0PR03MB5465.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eQSnS1+sa4fqd2aM3sMRvEnp/1Vwrly+I+ZR/7qZk5tL3l0L83oNZ0qM660WVkh++yBy7OCV4ErmSi4IbIxYyL5ASkCGaIDuGUzgC7/eFJw0pAW/OHAFdj6L6CYhiPtqLTZcMJJR+iI4ATOoRdHhLwUGtZKHwScqAWWgOeUpQhvKMnqhDZk2yP7ld0cXPVX0QT8CZhCAFPRKRgb59nhlNIrtQ5g/fUkpkls03yc+5aTSPsDO5zIUwbs07dcSLEI9BB/vqIYQYM2uQ796uWxiG8/7FezAhRDbuH6hEjO/+AsX+7djqC+7iMf2V6asP24OVgm49feOwPrsq4YOZ5w2yFau3Xv6PY6Yl98NRMqqYcxrY3/ItqecG0u+JiyNMUjW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(5660300002)(54906003)(4744005)(2616005)(8936002)(34490700002)(1076003)(66476007)(66946007)(6666004)(956004)(4326008)(6512007)(6486002)(8676002)(75432002)(6506007)(26005)(6916009)(52116002)(2906002)(86362001)(186003)(16526019)(786003)(316002)(66556008)(478600001)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: NDQHs0jvtymtzDSLA31sc7UlAwrb3lwc9ERRlpZYY3VuSeNGHcyvI6Re6Hc/ZkXBD+xKac9iVu22ELmzjnx4/4jDRM6G8TqOngM6P7cm2ExlDrz1jaeKWja7bxw21G3wvqbmt17wPLTp8YchMhk62gRYJNPTvYqZhdmXaVbKVKfvlXuYvtba9TYCL4v9+wKmIwP62rsMQLmOv9ochaqaLSJ2mkRg/5a1N7Z/AbRYfh9l+uSqYzsMyfHpJ/7j50vL3wAJHnGuEUSB7t8Mfd3Hry10n+VZKkaw4oZ5TN0ipylBPbQGvSF+Ydw3ElwC2skxSS8Q0r9OLv2UucjnGqbt+BsXR0BZteocjP5XWh1/cTFZu050ODfpBxc08DikW6JTiHZxvOzz6BgX+y3oOa0tHewedOT4QomkOEeDELihuj3jlCw4IlSfBBxadzksc+viFwip0P9jpmEfMVrw0QE+mWgqE8WGN/KHEAzZF1Cclw5t126spW4XTYdKGE0v7hQAVH9EaSBzXhdSwhUK5vqM6TZZYJqehHAXYE07b9Z9kFxHLmsotzEZjfmN8Xr4QAtSQrAVLoCJ4+frqMUv8vRaonDc//WUOmyxYKdLH2wbIgsVCNGJWQoD9eNQqwPUB5ZSO0xQ60LP5paJrVleYL77Rg==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 580574b0-c5ff-4bcc-af68-08d871101f12
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 13:42:13.2795 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ceHqAsY2AxjF5JdovWVLMrEMt5PMmsDugQJkF4bHgalAH5vaLVvByUgAFwdGyaN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5465
Received-SPF: pass client-ip=40.107.75.112; envelope-from=alxndr@bu.edu;
 helo=NAM02-BL2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 09:42:04
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, f4bug@amsat.org, darren.kenny@oracle.com,
 bsd@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It can be useful to register FuzzTargets that have nearly-identical
initialization handlers (e.g. for using the same fuzzing code, with
different configuration options). Add an opaque pointer to the
FuzzTarget struct, so that FuzzTargets can hold some data, useful for
storing target-specific configuration options, that can be read by the
get_init_cmdline function.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/fuzz.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/fuzz/fuzz.h b/tests/qtest/fuzz/fuzz.h
index ed9ce17154..08e9560a79 100644
--- a/tests/qtest/fuzz/fuzz.h
+++ b/tests/qtest/fuzz/fuzz.h
@@ -100,6 +100,7 @@ typedef struct FuzzTarget {
                        uint8_t *out, size_t max_out_size,
                        unsigned int seed);
 
+    void *opaque;
 } FuzzTarget;
 
 void flush_events(QTestState *);
-- 
2.28.0


