Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF29C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:38:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3C43207E8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="H2f2GK9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C43207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmGHR-0004u7-UY
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 08:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jmGDl-0007Ho-VR
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:34:13 -0400
Received: from mail-eopbgr00110.outbound.protection.outlook.com
 ([40.107.0.110]:51142 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jmGDj-0003z4-8t
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:34:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OupyIOaYyS5fpdWQKrZ2gzkISNPJND/YKUZgBTTsabzJyKCHOBf0yVvuk1ebT1oRpXqI0/wgJcFAWcnv2sowgBuz94iQ9kyeqW60N1w8JOgrOX7xrVa8vJaeMA9SDAEJom6jY67ejyLN2ifje5GeV6Upq6IVtEf3ER8iwHdDS6ChDHABlTy1hACHYUeo87BI8IWDPFXsDkWPunsi9DiIpEPJZv4wHess8/DiJmoj/4AOKwj/hg9+cwU7KsCqlzuuzRSo/FH+/B4Ll6+T4hYpM68qEmfwRttQOeCrHbpujHOAoT83DyZUHLdO43eULYyne6w/BxyNOCp/aORKk70Gkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgzN8txt3mzdm1ocEJXUVSaKAKJ8PghbeluPcypdvps=;
 b=jAQYTGAJglOOLxHV8aK+4zMkyjwIuo/DF6DP7RRvoAzuACm4+VwKFx/wYvfag5RA4KORI6yUv4TyRwFL6QL3kUkAbm1vS1AKbhKkj1PG1XaegbCMqEoD1yb+BFHrYkCeCj0ReJZSVci4Q/4aGIUeURxb4YC2kwDhlnFNUpGNKhXKO6sa7U5FWaamgtk5k4LFUJscSQ0Kf06fQXycsOLgLgxeldxGpxUGiZVOLeOTJ2u5+gdeJW5ZuI99W1zp7j9HmWZchA0OdaQqom380nywuv1VAF8Cn05SrVZtO5/ukB1HGXnSSAVBuXynIU6SXTPulgNg8+3Zl68LiKp/8JG7Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgzN8txt3mzdm1ocEJXUVSaKAKJ8PghbeluPcypdvps=;
 b=H2f2GK9iKd4JkqTnnbMyqWch/pVH9D8rdB/9cKA+T7jvEKKU6/deJbhtkFiYrhzHZkD6SQ39MBiAEw1F687gPPLiOkr68JHsAOETFLPZrSU1zdx6AUuiOnsstHyA5BYHsArTMSSJZV8yYC8FwEsDASo2fUtHYjUxR3GRnEy9Xkg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB5315.eurprd03.prod.outlook.com (2603:10a6:20b:d1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 12:33:47 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3109.023; Fri, 19 Jun 2020
 12:33:47 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 5/6] linux-user: Add strace support for printing arguments
 of chown()/lchown()
Date: Fri, 19 Jun 2020 14:33:30 +0200
Message-Id: <20200619123331.17387-6-filip.bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200619123331.17387-1-filip.bozuta@syrmia.com>
References: <20200619123331.17387-1-filip.bozuta@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0023.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::10) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bozuta-ubuntu-18.syrmia.com (46.240.135.226) by
 ZR0P278CA0023.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.21 via Frontend Transport; Fri, 19 Jun 2020 12:33:46 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f58ac836-bbc1-45f4-1a5e-08d8144d0332
X-MS-TrafficTypeDiagnostic: AM6PR03MB5315:
X-Microsoft-Antispam-PRVS: <AM6PR03MB5315A15DCB31786E342F3D66EB980@AM6PR03MB5315.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EwaeNRBK5aCek2hmZyuhm4e1GRWGZAI7jf54aVSorjKdmi9O5lA2ltcxcmBqe/QOhJss9bKqcIKDMPJth3mAtPbCOcLMeM24niiE5M3be9fzDp/Mi2llFV8xz6zzzzZyg+QCEeuoDYbTZjuPc9aPN29jZy4P+TdphxWxfF4NOa+a+B6Zrq0lJE3bdjw8zLLVpjjKcxPZfeKi187MH+wCgSfmCpyXJYGKnlJTclbopvYKskDsW2CTadxs/8NXT/YL9MDjzInnSh46A89Ov+VD0iyvM967hYjj9VaXY30Gpy5BpJOyl2eTOp5X63KATrr5Hp98kDm/47R3b1cmdW7UE8qtwguopkgGO6jxeAMliTZkFuW15tRA4qNjLuUSTtpndcV54qC7SpQyRlK8b+IBYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(366004)(376002)(136003)(39830400003)(396003)(7696005)(52116002)(4326008)(186003)(36756003)(6916009)(2616005)(26005)(16526019)(66946007)(66476007)(316002)(956004)(66556008)(1076003)(83380400001)(2906002)(508600001)(6486002)(966005)(5660300002)(6666004)(8936002)(86362001)(44832011)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: s1hdfIOx+4A5L3hv+MjJhjzfcYiluX+Xy9PksAXfkfTeDi1GEiqQwmw7tNCFsusspMnxqIyuT+eFqspEKyzRlIqlUcQUNQw69BSGJwZP2nQJpZh/JQFA5XTfvY7pQNc2IPNm/f6tp548ACoz/DODNELvYcIf47ZZNN5YQs/cBj8KqWvm+QW+XIO67b/jNktTIil0suMhRz0kXZYaLIwJAJOrluOi2uSSvCSw5OuYr5k1sHrrqAJr2TJaQ6VYiDL7Ua0RtIW5y7MR5wGqNj4wwx4W+KrRox6MKCEDTznEUdwdfVXvA/9wfBbvUitTYg87tnCFvCNMurXrK7lB6Ue8QHi9vsYGraO5M5FzavProCadv3J1RM8ZrVvgS46myFzvhWfFVC12C61/vqFdjiuRlH9NclZL6CipdlDLVWqwtnMBMpDk63tpvd7oCL15K328XoWtCwd/X6dm19yQCd0jL3Sq07HxbYSyU6N/Ft5ryJk=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f58ac836-bbc1-45f4-1a5e-08d8144d0332
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 12:33:47.3226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CWrzP7eKQL0F2Dk0e585VuM4f+n6WDiaEMahBkDqtJ6/HTWSi7TDCaJ2PPInWGA8L8ghcxDpmZ8JqJSJ3ysKVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB5315
Received-SPF: pass client-ip=40.107.0.110;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 08:33:52
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
Cc: riku.voipio@iki.fi, laurent@vivier.eu
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
index a26736516b..957f08f1ad 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1452,6 +1452,21 @@ print_chmod(const struct syscallname *name,
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
index 905a9c395c..633f43f490 100644
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


