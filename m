Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4102BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 15:52:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08561206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 15:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="jvp6Vn2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08561206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjPVg-00065O-8E
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 11:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jjPUU-0004bY-9I
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 11:51:42 -0400
Received: from mail-eopbgr60103.outbound.protection.outlook.com
 ([40.107.6.103]:37760 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jjPUR-0005xt-E8
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 11:51:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxWGMj5F2vzS2+XWIdw/DsKpOkRfHlpjTLP34vpAJ5eSpyRmG0ExpPrhUBJK05oy1TWmm5pam5bjMMRMv9Ppkbj/RQKBByMleOjBorHtme458DV7MfPgl2yG4YDCLdF98fFAaPPERXhsurF9wy1mZpUwRalNp1taDuXeep2DbxUcZTXaBQtxbtId3foF5lza5YMomB4uFxi0C9bNdtMYjXJjxI1u7bYSOUiOtgsbLs5KT9Eg89Eos+7ZjZANhg7LZvKoGH8w2FEFtanzgGl1U7U96LrnR0DQ7G/P7bYOrDVF37+VkiYL3y3quxZEfO0w6U3IdvvIx9B/trGleLxvbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSalO0zv4ImkEtPpcBO9NclPkkKQj3lzl9Avq4Xmv0I=;
 b=Z22ODg4Fa8gnGLiNQ/PN5ZET/61VQVoppvw80DPtapSXZjd1g8nnkvEmt0McHCjT7wiRrpQbULVQbZkaw6RvhI7VfqvXS8jG4pWd/NcjOiW/QotS37igu8KZ4aVVc3B+5XHA5Vtj8sl2VVYlccsB5lCfWKKI+UIBuwGNkaGMwOvf142Lroo+7NGQpNfamg/R5lU1NgIiRBt5nXykuezC1Ve70oAzctMPmImQtwbfww2CQ8W45rWIQfkFX04VDqUkEsjC++P/AB+RwUHsQZYg75OljG5cRLnMyzcz8RyeWj9HCJqB+B3tgeswgWX88n2HBJiPgloE1CBuSbIlYMCP9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSalO0zv4ImkEtPpcBO9NclPkkKQj3lzl9Avq4Xmv0I=;
 b=jvp6Vn2oZeogAhDzL9YLEo9xQ23nK2MyYZZ1Scy3Os4u0stPGf9yXRG1OkQqEBhJrhCkNAUtNo/QgAxAbghUtbytW5Z7qB4EOgHbvDKbUn7/prhRnLEhvv7HwFq9ZpvcqMavpnyXK1FVPS+mZJOs5axkb+U/T55qkKVzWqxsy9E=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB6008.eurprd03.prod.outlook.com (2603:10a6:20b:ed::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19; Thu, 11 Jun
 2020 15:51:24 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 15:51:24 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 5/6] linux-user: Add strace support for printing arguments
 of chown()/lchown()
Date: Thu, 11 Jun 2020 17:51:08 +0200
Message-Id: <20200611155109.3648-6-filip.bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200611155109.3648-1-filip.bozuta@syrmia.com>
References: <20200611155109.3648-1-filip.bozuta@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0031.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::18) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bozuta-ubuntu-18.syrmia.com (46.240.135.226) by
 ZR0P278CA0031.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.21 via Frontend Transport; Thu, 11 Jun 2020 15:51:24 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba8cc42b-6fdb-420e-a142-08d80e1f4b96
X-MS-TrafficTypeDiagnostic: AM6PR03MB6008:
X-Microsoft-Antispam-PRVS: <AM6PR03MB60084074130A853C77756382EB800@AM6PR03MB6008.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xnh++RzaxMlKOBOupd6hrathyKZlrfEHZdsU3k4qiB6ONSqJhM9SA/iz6kbs5Gau6Nyn262wJn9cZo3H4BUFz9GJFv9eBQrsnZyxAAf3brGC581zR107DBJFFHEdsWdugSEe16Aqm/9vi22Ow1DAjW6s69p9IqPc73Er4U8aUCUPepQiTa8cgTPWtV9k56ipRlSq+Yku8Tq7yckLmUGsy2Exua5VE6Pdjs5zLJqXLC+4T4s21rLyISmxTlDrILXo/v4fMK2YbB+tJTu24tZmZ9TNAO4KmJo+veCJfqLrC10eT3Fl56fk5IraFJ3hFBcoAkSWO0iw/Wt/8JBzjuR6n+QwS9qZYKDG+XktlNt8SFupU4jCHpw70NjVb8xDegqBbrZrwmaXTQP5x+4BRKzOmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(376002)(346002)(136003)(39830400003)(396003)(508600001)(7696005)(966005)(52116002)(316002)(83380400001)(8936002)(8676002)(956004)(2906002)(6916009)(6486002)(2616005)(4326008)(36756003)(186003)(44832011)(6666004)(16526019)(5660300002)(1076003)(86362001)(66556008)(66476007)(66946007)(26005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: T6TwyUQNceNzklL2dIoahxS8uDUQ5FdV9eaFQBZWsT1NY1YNAqIZq/8ylJDzPQNcJH1JSzTFKfHnY0cCWaymve1WzuCxb+jCHUxLYentT7nPPsoupfXEwWRGWhIxf9QWt/SUj70vnr1shfEEH8sRfHBkYC99f0Ti7bvIG5pu1IfOp3s/qpI8ZYXWPUyYnDGilKG0sAAhNNLE4VLdYfh4AtDrQ7GUKWtgGdVqYFarYlEo0nomfih6DOpzGyH55azTpm7lOnklpGUGalR8+ATWITTMNmq1Ig82BdMCpg4ln0sRfO0dtXpq9dSqd07pIi8rqOYzbX0jUa+RxckIL2QsELWZBswx6LSGNsvFEXjhJ2VcN++CZ4i46CSZmOePcNm0CXtyXWH1Fzn6RY4pJaTMOOVhYUhAlNwf9Y2/0W/zugIlHqd6Kg90o93T43nvK3tdT/5UP5AfVwr7AfcLbiAeDC21KdMAaQtCTkXGtDrqYu4=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8cc42b-6fdb-420e-a142-08d80e1f4b96
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 15:51:24.9232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xymapXb5+rEjMxz19jTDCMqo7s5ViAlcHOzxZ9SVYYsFS5TwjgF9hZd8nPFP3WngYSp3SKB5Vb7qcTof39b5bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB6008
Received-SPF: pass client-ip=40.107.6.103;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 11:51:27
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

This patch implements strace argument printing functionality for syscalls:

    *chown, lchown - change ownership of a file

        int chown(const char *pathname, uid_t owner, gid_t group)
        int lchown(const char *pathname, uid_t owner, gid_t group)
        man page: https://www.man7.org/linux/man-pages/man2/lchown.2.html

Implementation notes:

    Both syscalls use strings as arguments and thus a separate
    printing function was stated in "strace.list" for them.
    Both syscalls share the same number and types of arguments
    and thus share a same definition in file "syscall.c".
    This defintion uses existing functions "print_string()" to
    print the string argument and "print_raw_param()" to print
    other two arguments that are of basic types.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.c    | 15 +++++++++++++++
 linux-user/strace.list |  4 ++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index ee73ff575c..40c17f7abe 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1461,6 +1461,21 @@ print_chmod(const struct syscallname *name,
 }
 #endif
 
+#if defined(TARGET_NR_chown) || defined(TARGET_NR_lchown)
+static void
+print_chown(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_string(arg0, 0);
+    print_raw_param("%d", arg1, 0);
+    print_raw_param("%d", arg2, 1);
+    print_syscall_epilogue(name);
+}
+#define print_lchown     print_chown
+#endif
+
 #ifdef TARGET_NR_clock_adjtime
 static void
 print_clock_adjtime(const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 63e150736e..552184098c 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -71,7 +71,7 @@
 { TARGET_NR_chmod, "chmod" , NULL, print_chmod, NULL },
 #endif
 #ifdef TARGET_NR_chown
-{ TARGET_NR_chown, "chown" , NULL, NULL, NULL },
+{ TARGET_NR_chown, "chown" , NULL, print_chown, NULL },
 #endif
 #ifdef TARGET_NR_chown32
 { TARGET_NR_chown32, "chown32" , NULL, NULL, NULL },
@@ -475,7 +475,7 @@
 { TARGET_NR_kill, "kill", NULL, print_kill, NULL },
 #endif
 #ifdef TARGET_NR_lchown
-{ TARGET_NR_lchown, "lchown" , NULL, NULL, NULL },
+{ TARGET_NR_lchown, "lchown" , NULL, print_lchown, NULL },
 #endif
 #ifdef TARGET_NR_lchown32
 { TARGET_NR_lchown32, "lchown32" , NULL, NULL, NULL },
-- 
2.17.1


