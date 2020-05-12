Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A4AC47255
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 03:18:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93A0620661
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 03:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="ldoS+8ug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A0620661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYLRO-0001V1-Lt
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 23:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jYLPa-0006Qm-1G
 for qemu-devel@nongnu.org; Mon, 11 May 2020 23:16:54 -0400
Received: from mail-eopbgr750109.outbound.protection.outlook.com
 ([40.107.75.109]:56482 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jYLPY-0004Kx-DD
 for qemu-devel@nongnu.org; Mon, 11 May 2020 23:16:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1FZtlpMvklf/yaUwYfBVF0yVLBvt4fApQvg9B8+8DUWuM7RbpSz0DDCZFIa961u+YhjQY1BwPCbCQMs6ZjAk7I7Owj+i+bjCCBm0vjgiwsqLnvu78pBR/WC5uHj7Kk/dE85Z3bqQW2hczsER+ewSxNT8y6E9bo7RqqDvYB30V6a5kGDtq/gf645E+oY+gQf2Zf1u8QfzaiOpzJjqG8h4lcDLoFL6Ee7tCqwuJtWxUIeykVpxE1ETmEHdcbCeYh1ijVPQvgY7zTe/beD+AlrV7XkelqGYz13cllD4yxmxQjtuvJetA7wKfclgQR/nVzbTMZy35qy+27mbIlasgZNqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkAf2SqTvUp39W77N2uaZR3cGXl6YvhvrW9BvtwkEOs=;
 b=a64JSqk/JMtAbDM/w1yEmnu2R9UZHoPZR9CytO10hEW7rW9rEVLfypTmOpIwKxcQJ51o092GmiS9UiPnLYxveaspXcAnsQ32R3IXoilElcJR1ossUIQXgbU0t7LCpF+pSq5+l4JbQKJWE3T38UsKsviHUr6PTDdk5veS4eBrz9hSz0Scq+copsb5Xb8uiFxggXVc/TqmcpnIZkqmqc8buHDpe1b60q2O/7JiiosggALFJXO22dpywWCw5EllaLhIeqzYSIpSaP7j8/ITXgf8zrFL499bzt8rCp0jRnUUJvI41XvR1zRgx0HZl8ydu/huQgyMNq4YlJPsNwdNyi8zKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkAf2SqTvUp39W77N2uaZR3cGXl6YvhvrW9BvtwkEOs=;
 b=ldoS+8ug/E48AbK/s42qFFB+wAjHDjDPJOWRlt+d35zEfJb9lU9ez04bM+2U+qE+3/eKWEXw2qEWm2aLELEvbDJk4N8AVHrfqzdlzgdYjH9+fSB9c3ubnklzhDxLfTVUXDcnKmwXPH2fI6NJJDw34KzCv+Ya5mGK7Z/JVc37LmQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3520.namprd03.prod.outlook.com (2603:10b6:805:4d::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Tue, 12 May
 2020 03:01:47 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db%3]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 03:01:47 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] fuzz: add datadir for oss-fuzz compatability
Date: Mon, 11 May 2020 23:01:30 -0400
Message-Id: <20200512030133.29896-2-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512030133.29896-1-alxndr@bu.edu>
References: <20200512030133.29896-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0025.namprd12.prod.outlook.com
 (2603:10b6:208:a8::38) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR12CA0025.namprd12.prod.outlook.com (2603:10b6:208:a8::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.26 via Frontend Transport; Tue, 12 May 2020 03:01:46 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c46cdd6-f476-4025-7e36-08d7f620cecb
X-MS-TrafficTypeDiagnostic: SN6PR03MB3520:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB352032A5CA19878445EF763FBABE0@SN6PR03MB3520.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eBtpi54Rusd5TuYYt4FWtdwleCjcHt9HYw5zcmLz7MZURhH9bOP/vZU3qyeKFAxlagoYgK+lCvSvjcjwc8QVVh8183Zw1pabB1+t2eYQGKUq9rfiAc6s9ivHvKsERb0bfTvGPGLVyKfLbqXAd52OmQdRwW3qmGXZkaCH5q12eNXMxrTdNh3rffUvsPuYLSy0NQc0o4HhjDUshvP23UHNFAa4woxL0PXkFqeIqSrztY5+R54mae5PHHalQrVqLVAn9iYux22ri3dzCd2p9IVH0UTuUmB+A4w/iFYh4laPSvm8SluleAE/vGiXeycBNIIVvfo8wU5UimiFboFadIMYh1kWTM6Xp8RtoRpQxW87lXMo05Z0mZE3EM8cb53K/IofwnLXNhmR8YkqNALT74vra1zlGAgdORxiTOcbK5/fXhqzY4YtzXt27V/zpKEs+lfuAsjWW8cqqfuphPl/8U4U6G1GGGBonZ/NuLaF4fNp3p57thRFt+1kBpjnbdgaLmM83vkPALRMC3h4ecOoPCglWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(33430700001)(956004)(4326008)(6666004)(2616005)(8936002)(5660300002)(7696005)(316002)(786003)(66476007)(66946007)(52116002)(54906003)(66556008)(6916009)(26005)(75432002)(186003)(86362001)(16526019)(6486002)(2906002)(33440700001)(478600001)(1076003)(36756003)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: BpFaEkNOSUgx362KDeJnpOT3+rm+c5jgMmjlGXOXe3d4pAYBJ0pBn1vs7+eFY5lPpcivuU3MmRPyIVHvoCzfA3dXP+1802KAO7ttdbigcUFUbzjwd9aRaUtbQ5msbet9bOEhaiuAX/3L/mN5qyXvXSoNzNcgQgvEhqXh6vimY5o3I1qZQjwLzVZXJfvrXVg9YXpwf/TJen/QwI8PWDb3UQ2vITozg8aqr7dM625+ANO3AJ8jHiaUgpbmJWaVs6vj2F9h0jdh74mS3Y2joecR8tOfeCPLwKsg9K+4kPEWWYAoPKXocRS1P59o4rdCH2UOrOFs48012qDXNoE3NSscyXbuUF+YfgJoNowETnDt+++Gt7hkVypkV472TgHRvmCGAgO7x4GcrMahFrR3KYE7oZeL6nQzeMp4qmKMWhuYgnBlX1Un55M9/2ZCLeEe1tHcmzrEJjMozc6gWXk36CojVcIYWfdfQCkr/k0/sob3WyU=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c46cdd6-f476-4025-7e36-08d7f620cecb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 03:01:46.7572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tfMTp1H/ubzZCycsLxobhs5ExitDYYpzMLM5yoz5ScSaWdS9AL2t2anTZ1U2Pl1A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3520
Received-SPF: pass client-ip=40.107.75.109; envelope-from=alxndr@bu.edu;
 helo=NAM02-BL2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 23:16:50
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
 Alexander Bulekov <alxndr@bu.edu>, darren.kenny@oracle.com, bsd@redhat.com,
 stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This allows us to keep pc-bios in executable_dir/pc-bios, rather than
executable_dir/../pc-bios, which is incompatible with oss-fuzz' file
structure.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 include/sysemu/sysemu.h |  2 ++
 softmmu/vl.c            |  2 +-
 tests/qtest/fuzz/fuzz.c | 15 +++++++++++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index ef81302e1a..cc96b66fc9 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -15,6 +15,8 @@ extern const char *qemu_name;
 extern QemuUUID qemu_uuid;
 extern bool qemu_uuid_set;
 
+void qemu_add_data_dir(const char *path);
+
 void qemu_add_exit_notifier(Notifier *notify);
 void qemu_remove_exit_notifier(Notifier *notify);
 
diff --git a/softmmu/vl.c b/softmmu/vl.c
index afd2615fb3..c71485a965 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -1993,7 +1993,7 @@ char *qemu_find_file(int type, const char *name)
     return NULL;
 }
 
-static void qemu_add_data_dir(const char *path)
+void qemu_add_data_dir(const char *path)
 {
     int i;
 
diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index f5c923852e..33365c3782 100644
--- a/tests/qtest/fuzz/fuzz.c
+++ b/tests/qtest/fuzz/fuzz.c
@@ -137,6 +137,7 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
 {
 
     char *target_name;
+    char *dir;
 
     /* Initialize qgraph and modules */
     qos_graph_init();
@@ -147,6 +148,20 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
     target_name = strstr(**argv, "-target-");
     if (target_name) {        /* The binary name specifies the target */
         target_name += strlen("-target-");
+        /*
+         * With oss-fuzz, the executable is kept in the root of a directory (we
+         * cannot assume the path). All data (including bios binaries) must be
+         * in the same dir, or a subdir. Thus, we cannot place the pc-bios so
+         * that it would be in exec_dir/../pc-bios.
+         * As a workaround, oss-fuzz allows us to use argv[0] to get the
+         * location of the executable. Using this we add exec_dir/pc-bios to
+         * the datadirs.
+         */
+        dir = g_build_filename(g_path_get_dirname(**argv), "pc-bios", NULL);
+        if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {
+            qemu_add_data_dir(dir);
+        }
+        g_free(dir);
     } else if (*argc > 1) {  /* The target is specified as an argument */
         target_name = (*argv)[1];
         if (!strstr(target_name, "--fuzz-target=")) {
-- 
2.26.2


