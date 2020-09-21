Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498EDC43465
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 02:33:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF0D22078E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 02:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="HyblB8zW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF0D22078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKBdW-0004ru-2a
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 22:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kKBWc-0003Iz-LS
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 22:25:55 -0400
Received: from mail-dm6nam12on2117.outbound.protection.outlook.com
 ([40.107.243.117]:28256 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kKBWb-0000b7-0H
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 22:25:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SshB1Gh3JnulgRRj6KYHLX5raYJYhJWnMZqf5XO0Ypt3uITaF6WrKFl8bGrJl6p/SHYbUvIXeUyWYvZajonBeEHrHnAQ3k6iEwhnD0pgPxiso7JSPrS9poHRfLUt9iNoibSR7D68wmrnGMAiv9UF02sROfnIlvfLPAIG9ldF04p/P5jMHwrA5wscrKbniYg40lDMYwoYx/OoSiOlfJOm51IkwQRZ7U5/rpCTyXQOs5o/lTemEY4hP6DGkt3jYWBK+aw1YJlDxW3kRZ4YzaqyH3NLUTTW9hFli0Csv+n0WdBhNOHKS7HBt2SZ9HfT1X217wNq3Ew+eF0UcV4Y1UFQMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6hz67y/zGvT+mQzDe+EH2DgKtQ5SUMdPMnvak35Rkc=;
 b=df2J1JZI6dznFYfzicEa+N8vrE0+MSNHafmCJWtKUcw7SX51Pl/95ALguScwEXHI6tc2d/Opo3arK0E5Hrrg8uijG1f9D169+rI4DEpRyliiNms4D6cfZInKE/NZ3WWAgJ+FliT+VotKoy39L4VYlGC9vvCFOZ9M6APBl5PJNgKJJb+VTeEU0PAFHty9+7Jj7YyZMvJBDLYEprJwiHXrbNgdaqaCe6GaQShadhuWg7/ZJc4snzz5f/wYpYGOgGagHfcCcNXAvziY6ZDru5xuY30X2bqzWBfK5mG6B0PCBXmhei+Usg/4lIBkq2zqPzRVDx3WFrjR1B78W947UjtrXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6hz67y/zGvT+mQzDe+EH2DgKtQ5SUMdPMnvak35Rkc=;
 b=HyblB8zW4IOl4IDTiYZrcaqeOHx8Dh+p807Wnjei2msKMu0xY0H0jhsUwmrJNo3vm59XVF687zzDjQALceMZTI1n7aT3ZoP+f0anKoYQraFRdRea5J+bjVchkZgYkd2wHpCgrjzPYFOYkSLSxiYQ2mKNVVOGIU38i3cS3MNelTo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN2PR03MB2237.namprd03.prod.outlook.com (2603:10b6:804:e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Mon, 21 Sep
 2020 02:25:39 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3391.024; Mon, 21 Sep 2020
 02:25:38 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/16] scripts/oss-fuzz: Add wrapper program for generic
 fuzzer
Date: Sun, 20 Sep 2020 22:25:00 -0400
Message-Id: <20200921022506.873303-11-alxndr@bu.edu>
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
 Transport; Mon, 21 Sep 2020 02:25:37 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ebfb7d2-62d1-40fa-5d6d-08d85dd5a0bf
X-MS-TrafficTypeDiagnostic: SN2PR03MB2237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR03MB22376FAD81269D2C74965B65BA3A0@SN2PR03MB2237.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jx6qKRkBTies0M1OXUnnfkvAj/iiApTzE2KqBW2nzi2WDeYVmW2ISYEDg5zoww1IYVpUL58R5syfhbINVSnD7CvmqjBGC2/spz7OyosjiJ1gXtmVZ8Tykdl+QA97872ecxAUTBnYGpi7hXgIVZnbIKxNhLHEWiB3BH3tGqX63gzvtT/D4Vd3k3DraK/FGQwNuALZh6V3rTBUnK0l3RQARnb+iS/3SUeR4/ZL6s91gNqwnNV6/If12yWsKiVUETuOH/r+lCcYSJokulH1NSHkwsgxkN++LM888Eh6Ilnc6iR5jFXIVt/LvHru7J0HCmnpQ6Z87nnXCby1pn8anFLTJuS5SVnUr4Uwwzbd9WvP2BmjuThdLxAvl7lWovNoYX5gctFqHoj3x68l1vBqrxs1RyScZvgNofYJ8kepMXBHg7k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(2616005)(956004)(4326008)(54906003)(83380400001)(26005)(478600001)(16526019)(6666004)(8936002)(316002)(6486002)(66476007)(1076003)(6512007)(186003)(6916009)(86362001)(66946007)(5660300002)(36756003)(75432002)(2906002)(6506007)(8676002)(66556008)(52116002)(786003)(41533002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: OYpnsNke/4MwtzZn9HeRXlN8rxyCD7Q50WavKu69jbjONDPTCENEFDBL9kFcMGsLmRJb+paUaKc26B9cXHJvqPzwMB7mwdmHsyafrIy9GiZMjpgGf6MjTaIFna/4VslerzgErkgm7MkcnaS+ni9B4J9F9PIvoVPSfywHcbzWK/z8KK1Jv/MPPogcJ9/973ojY6NVNtfVjRqghIZKnIf3XkaBSFJYH3+7MBFv87/0Y4WBFtsROApTMFoZNJK4NYjvAGn9Kb8syccwnHkwiiFDhOuP99kRv2xcw+S08ci4bN6mKaiLJwJ2shkDrTSddzkR14QlzCRb1WQe79XUBBVHwB4Pq2Zzrve/5KXoH/wMuWI537Tfl9/eJRxtE0WuwpigCccACbElTs0FML7BED4yRGFNNRzFqoy4unKTmA/DN8Ja9YnH29vDPZ5ANaz4fnl9KRmuXLmE5yT5a+puKQ9SrZRqFuCfSwFNEr5ZDg0XiZrTrGhHOIPICHCci4/WZ1rjNYsUQ2YJcKCoH9Lbtnz7h4g8ql5t8kVZZFNnsjGQ5qJsmOQMNHaco6X+AOOrNjzngqcZMqjT8OpMYOSl+1jAZKBjNkRCvEDBT1WdZV4P1naCSINEOj6rKOvCSqZxMOehexflM2Mr/rMwn2W5S6lg6g==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ebfb7d2-62d1-40fa-5d6d-08d85dd5a0bf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 02:25:38.3805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qbMFSNibQ6Je20c0UYhdUoxlHdLkiU8UZM3Mnuty5jFuNHgz7K4CKE5yn5Ua1w5w
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
Cc: Thomas Huth <thuth@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On oss-fuzz we need some sort of wrapper to specify command-line
arguments or environment variables. When we had a similar problem with
other targets that I fixed with
05509c8e6d ("fuzz: select fuzz target using executable name")
by selecting the fuzz target based on the executable's name. In the
future should probably commit to one approach (wrapper binary or
argv0-based target selection).

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
---
 scripts/oss-fuzz/target_template.c | 40 ++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 scripts/oss-fuzz/target_template.c

diff --git a/scripts/oss-fuzz/target_template.c b/scripts/oss-fuzz/target_template.c
new file mode 100644
index 0000000000..4a7257412a
--- /dev/null
+++ b/scripts/oss-fuzz/target_template.c
@@ -0,0 +1,40 @@
+/*
+ * Copyright Red Hat Inc., 2020
+ *
+ * Authors:
+ *  Alexander Bulekov   <alxndr@bu.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <limits.h>
+#include <libgen.h>
+#include <string.h>
+#include <unistd.h>
+
+
+/* Required for oss-fuzz to consider the binary a target. */
+static const char *magic __attribute__((used)) = "LLVMFuzzerTestOneInput";
+static const char args[] = {QEMU_FUZZ_ARGS, 0x00};
+static const char objects[] = {QEMU_FUZZ_OBJECTS, 0x00};
+
+int main(int argc, char *argv[])
+{
+    char path[PATH_MAX] = {0};
+    char *dir = dirname(argv[0]);
+    strncpy(path, dir, PATH_MAX);
+    strcat(path, "/deps/qemu-fuzz-i386-target-general-fuzz");
+
+    setenv("QEMU_FUZZ_ARGS", args, 0);
+    setenv("QEMU_FUZZ_OBJECTS", objects, 0);
+
+    argv[0] = path;
+    int ret = execvp(path, argv);
+    if (ret) {
+        perror("execv");
+    }
+    return ret;
+}
-- 
2.28.0


