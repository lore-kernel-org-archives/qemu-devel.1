Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8341CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 13:12:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 504AE20674
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 13:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="mCVIMDJ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504AE20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg6iB-0004Se-IG
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 09:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jg5UO-0000Tl-3f
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 07:53:52 -0400
Received: from mail-eopbgr140120.outbound.protection.outlook.com
 ([40.107.14.120]:62970 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jg5UN-0000gD-Aa
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 07:53:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtQ/9pNJb/iba7i01lFD9djz1WIj9lWy5w6V0lHQU1qQ0WaNof+via5PZFGUb0BV+9a7Q7ZNvcKhHIhgIxAgA58pa9fmtCP0b8C9D5teg9jBNCVKVP0G1F2dqrTnoetzj5CtrjJhVeK6qDkaDlS3GuejtKSoa+UjWPk5KkmeopuP20tE5io1t8KMuj+hksnBedO48yrlCn/Jx7QBNP5xaTjqnS4SFqBDvbloakSSYrPAv8FlIdKE1QhKCVsdUa3b6jCD5pg+ffJ4dqlEABdVBC0o7chuWeU88XOR5kD4UOU300ZRLkhJstOQLSIjeIRtE3DRAswbLBzSAKb6N+6ZKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAl752kyM1B1Z/Fmsw6lGIhRmCjuXq8U+QzWIJvLX3g=;
 b=Dc19adaO+3Jyb4V1Rt3IOyGif1J3iM7uOT6psYe16T92c4ifGWxLG49WFjIHcmnYym4KJozcxwLnmHkUIOW+YvPpHbpryZBCAWtSL3pxB8o14svGwdAFUAOo9nE53g5xWOWxyzQHuECE3+heWP4n1+rYzwRcjbSiLshXEyE5fHUGW0PqMZYG5znDijPXiZgARZhaMdwhmmynh/XlI42CGn2LdeltWPR/HPKaizBTcNp93gG3pWbXFCcxG+pS50zr8SZed8iPReyJ5rIgcGU0sv5vLyO9p013faeMDu8x3YTMmJEjM2/mGtt93wxJ4XA8WHSeg3HRu4WZfdYUk/cLmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAl752kyM1B1Z/Fmsw6lGIhRmCjuXq8U+QzWIJvLX3g=;
 b=mCVIMDJ6b4NuJBclp3miL0Y5EzhmqDp9Mb58biW9TGLBKseBGU8huGx9kZBIL8WYc8XrDMcvlJA3zVJYi5sTwcOoK5OinFDXaKjOt1ekdOyBthb3ALDeHCps/LdxF0FSfXj+h527C79bGWLQuEwtAp//Mz1uztaaNG2errIcwNQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB4022.eurprd03.prod.outlook.com (2603:10a6:20b:22::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.22; Tue, 2 Jun
 2020 11:53:46 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::7935:50dd:e879:bca8]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::7935:50dd:e879:bca8%7]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 11:53:46 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/5] linux-user: Add strace support for printing arguments of
 chown()/lchown()
Date: Tue,  2 Jun 2020 13:53:30 +0200
Message-Id: <20200602115331.1659-5-filip.bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200602115331.1659-1-filip.bozuta@syrmia.com>
References: <20200602115331.1659-1-filip.bozuta@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0116.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::32) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bozuta-ubuntu-18.syrmia.com (46.240.135.226) by
 LO2P265CA0116.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:c::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19 via Frontend Transport; Tue, 2 Jun 2020 11:53:45 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63a1652b-3abc-40d8-c32e-08d806eb9afc
X-MS-TrafficTypeDiagnostic: AM6PR03MB4022:
X-Microsoft-Antispam-PRVS: <AM6PR03MB4022360A9D8F8B386FCD9FDEEB8B0@AM6PR03MB4022.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IP3QHs9clb8uDxc8+w2pJf46Vl5aNIcr4ZFMI1H/JhLLKTsYVRY7QZyOYLrZbfL1aS6WcrYTLONa2n52owgn1FTrWDrV2GTLPegrIwOkVGnc8ekqbXcNyHhJRFEHX6up0nyCY5/qE3COIcflKSGJZqnUdNr6rMndBeLG5s7Svq/EbTxKvKPzo188tLF4veKHHw2Mw5M72Riuz2X8G9yu7ov/6ItLwU3o1FIs+qnWNKEtIvQ78ZMvG86z2KyZ9BMHlK2W6t53s63LNKWN799zaOq4dE3RbPJO2QZ9xp7j0EaMrsxr6mW0MgCgyOGH0FHKVx7eOsGNry+jdOykJaraGvr0eTpJnwf1iV2u0AjY0Ovu5qfdNwb2ZbMCjhXBIQ+zkxEZBKNJ/2BZh/JgLvdt+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(376002)(346002)(39830400003)(136003)(396003)(966005)(44832011)(956004)(2906002)(4326008)(36756003)(2616005)(86362001)(508600001)(66556008)(66476007)(7696005)(66946007)(26005)(8676002)(52116002)(6666004)(6916009)(8936002)(316002)(1076003)(5660300002)(16526019)(83380400001)(186003)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: CPqvehuHs+R0HK+3lmn2bB1jjxyYKvK8vQ/K8qRlRDauogjp9Q+nhbC7fbx11u6NAMK4Vngc1PCNdDIatK7IfcJ3hdXCsgFcQSBHOyH1MvC5IPQzy3SNcr+vuRe1PDtlFEN7otU6/kIqVK/t51JiZFjB19puCzZNkdfZ1R8zCQxuAEwfJDtZn0vlvLe4VC4UysTVMxoQWxq6TZx3zDAQCvRPo7802YtBW4lMY/DPVuzzKRlYZFT7tnKVXHyVCX291w3Qzji6xBQh3+uSxQleSGJZW1H6LcTIlT9xH2+xvacvUkNB5EPOsOcyroSvqsAssCEZlOjb5q4+/XaiX/fmoBtoejhKqy6oi+crskA/S3cHG6u+NIgVVxLUAewxjwYY2Lnoh/gRKVLskcUIaEO0iEt/RfA9QiykztQsbtM+VAuRL2A2ApoY8NehyXxCQ4n5EU6cEWWr9Txy0UKLgBnyOsKney8Y1OzaZypPdy0iPZ0=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a1652b-3abc-40d8-c32e-08d806eb9afc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 11:53:46.2251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PyBa/KrDdw9NrIdFd8ItRbIAY9E124HBVLeowhhZ/HBDZ24SjRJUWTQXSE0hOKIOh+zOgTzTl+lEKmnMHyxiFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4022
Received-SPF: pass client-ip=40.107.14.120;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 07:53:48
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 02 Jun 2020 09:04:50 -0400
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
---
 linux-user/strace.c    | 15 +++++++++++++++
 linux-user/strace.list |  4 ++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index b7f012f1b5..542bfdeb91 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1414,6 +1414,21 @@ print_chmod(const struct syscallname *name,
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
index 5a56212532..b72f757d3f 100644
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
@@ -474,7 +474,7 @@
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


