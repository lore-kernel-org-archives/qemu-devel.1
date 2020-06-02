Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6386C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 13:11:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9215220674
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 13:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="H/mf+Z43"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9215220674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg6h4-0003Uy-SU
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 09:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jg5UN-0000Sf-1a
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 07:53:51 -0400
Received: from mail-eopbgr140120.outbound.protection.outlook.com
 ([40.107.14.120]:62970 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jg5UM-0000gD-0m
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 07:53:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTJD/ZDsBnhLzzbmo9tUZVRliP7N4EdepoKY7gXvnlCz0xDF9pOnKHvkUkDIQoccqDMt5lSckxpBN2k5kSAARA8mPa2KuN1yAhZXsiPGTriXC6LqYBLu2yEKe/wB8M1hWRqab0uYuTeeh/2LBEmml/SdDQvwScV26XWbHYLoIbtQRXY6Q3g7Lhzfc/w+m5wPASgkqyhU+EY4HcAkdf3Jb3O70HYf9h0zhsrFt1cadEoGEFL/dD9R0IYTEhjFWsIvcTGknEFVEItQCu+oGf5DNRrBVJFBDqUtLKQsiI5nLU245I1VepgreE0AQO5Je9l4y4zYg2S/ScT7t+8ODecAtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HoGfHx833cseo7lcT98rumaR6KLzRSpmoMgOe0Z+IY=;
 b=VqZeUlZcwalsWP89+n9uzus3zAMt11hibRu2l+3ZodZltOVxGsscjbKyQDwFfS/575QUAhSwdXA7G3VAntxcoy7UraLlebdGRPfs2Wf5FB+ZZ6oGrnp6IcTjtqvlLHWf8bjqoV1fX7H+kWE/GuDphtrdfGaCGc0AHwesQu2Il1VdqrxzNno16K3aqUHr+hZU3yaeaPiLsdwTVGMSOuIzoQMlg1W1Fw/mgvWdpz6vhHR0wL8SqXIoqTJ45AYOAcaVR1IS4+gggVWAS+8bp5fEopHUJGJlawC59lfhgfa0+QHeJ/dZO10M9VkzgyCbomqF0Vd6Lvl5+gO8ZibqNyjoKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HoGfHx833cseo7lcT98rumaR6KLzRSpmoMgOe0Z+IY=;
 b=H/mf+Z43l6B5CyWQ7g5z5z1AtWdzYv6MEVNomLrVbgJ4pshhSN4aAykauoqr75O18GFj5khYYhaco/e0G23c0+AQ2AQ8PuvZMBLBDJyBEBa0xLbigQThMVIqb2jkyLBC/PakgYImwmfLnj/hRM2RBO9+w/dPJ1ThoxxHK3KweV0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB4022.eurprd03.prod.outlook.com (2603:10a6:20b:22::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.22; Tue, 2 Jun
 2020 11:53:44 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::7935:50dd:e879:bca8]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::7935:50dd:e879:bca8%7]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 11:53:44 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] linux-user: Add strace support for a group of syscalls
Date: Tue,  2 Jun 2020 13:53:27 +0200
Message-Id: <20200602115331.1659-2-filip.bozuta@syrmia.com>
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
 15.20.3045.19 via Frontend Transport; Tue, 2 Jun 2020 11:53:44 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4225fe53-9582-4831-79a2-08d806eb99eb
X-MS-TrafficTypeDiagnostic: AM6PR03MB4022:
X-Microsoft-Antispam-PRVS: <AM6PR03MB40228C348B13600A663B9B52EB8B0@AM6PR03MB4022.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6FYMLr8oTGDucE61zPep75PdZnUQQenu9h8NufMTNU7/+Ol0Q1Aa1++lhaPkLeX8eoCqn/N81GKnWhBKYwezhwDlTYtPkxeBU3IJvKcn8siKufD13N4GP2tdFBPV3qEGaQ2ejb2tZOQ7GbIAzWYtVfIMUEagFckpS9h6ALPWednoE9zN1t6Uqn7F3aMKR8mTMIYpjiCWbsluO0BrfFU1ZW7wDWbmpInHiDN9UIT6cNpN93OXrsBBo++qJFt4lEXUP5Y69wX81+iSwD3tKq8aVzDnYgSh7OGce2u9DPQAMCHeL9LantCJOpZ/+wby5bPLoIhKVzoVTYEkQhSMNNmXNvfo8CNLGUnkhvtG1CT/Y/tyYZcofyRbc3AmBCqi8xxTjsqWhGLWoBmDRsqMPydApQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(376002)(346002)(39830400003)(136003)(396003)(966005)(44832011)(956004)(2906002)(4326008)(36756003)(2616005)(86362001)(508600001)(66556008)(66476007)(7696005)(66946007)(26005)(8676002)(52116002)(6666004)(6916009)(8936002)(316002)(1076003)(5660300002)(16526019)(83380400001)(186003)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: pmFXPGhwT93EHWnOWIAfIHZYmhEV9IduWcixVzGhgJ196q7VstmNzZYhIa2+B3yMPn0OYM15b5WyoDIR/41ayM9r9/9LcBmbKvqDuVqE7bUMglLFIv7wjUapGwd73yHjetzpuSsRbOZEg/aehUMxgNPSxlDwHtFM92wzQrtVHXmMtqsy1fLODZZdAQBi71xEEUoMu5jW6NQuk7VYW8pZ+GODLTEynIR43Affc+STGqXIx2EvT0OkdjjyultF+afI8SchielyghfAaMaEJbhd8eOyArIcc5qbmRd9O89IjPTChdKi9MIKehESm8dqeEk14VEUQ/skX1ZWvzreVEU3wob248NH8NFvFihV7E7B0xS4DG4b7y4mWOH6B92gadp40ebDm/ndY/Yoq8J6CJ1NPzW06MXCltqhZtMp216mdyfXDXklYgRBuMRC4JzMzX6PGNwwbZyRGqmJyPXY6xHuRYpRbICHiTebn1Kd2IRBb9M=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4225fe53-9582-4831-79a2-08d806eb99eb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 11:53:44.4211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +VhlRV/l3ATcwINTYCWlAOUGTQSH/ULPnnqenWg6wIzRg0fWheW0XApVGDwVdjYJ7I+UW48O2mufM05uvupg6Q==
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

This patch implements strace argument printing functionality for following syscalls:

    *acct - switch process accounting on or off

        int acct(const char *filename)
        man page: https://www.man7.org/linux/man-pages/man2/acct.2.html

    *fsync, fdatasync - synchronize a file's in-core state with storage device

        int fsync(int fd)
        int fdatasync(int fd)
        man page: https://www.man7.org/linux/man-pages/man2/fsync.2.html

    *listen - listen for connections on a socket

        int listen(int sockfd, int backlog)
        man page: https://www.man7.org/linux/man-pages/man2/listen.2.html

Implementation notes:

    Syscall acct() takes string as its only argument and thus a separate
    print function "print_acct" is stated in file "strace.list". This
    function is defined and implemented in "strace.c" by using an
    existing function used to print string arguments: "print_string()".
    All the other syscalls have only primitive argument types, so the
    rest of the implementation was handled by stating an appropriate
    printing format in file "strace.list".

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/strace.c    | 13 ++++++++++++-
 linux-user/strace.list |  8 ++++----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 0d9095c674..c578876d22 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1353,6 +1353,18 @@ print_access(const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_acct
+static void
+print_acct(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_string(arg0, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #ifdef TARGET_NR_brk
 static void
 print_brk(const struct syscallname *name,
@@ -1617,7 +1629,6 @@ print_fcntl(const struct syscallname *name,
 #define print_fcntl64   print_fcntl
 #endif
 
-
 #ifdef TARGET_NR_futimesat
 static void
 print_futimesat(const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index d49a1e92a8..fb9799e7e6 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -13,7 +13,7 @@
 { TARGET_NR_access, "access" , NULL, print_access, NULL },
 #endif
 #ifdef TARGET_NR_acct
-{ TARGET_NR_acct, "acct" , NULL, NULL, NULL },
+{ TARGET_NR_acct, "acct" , NULL, print_acct, NULL },
 #endif
 #ifdef TARGET_NR_add_key
 { TARGET_NR_add_key, "add_key" , NULL, NULL, NULL },
@@ -215,7 +215,7 @@
 { TARGET_NR_fcntl64, "fcntl64" , NULL, print_fcntl64, NULL },
 #endif
 #ifdef TARGET_NR_fdatasync
-{ TARGET_NR_fdatasync, "fdatasync" , NULL, NULL, NULL },
+{ TARGET_NR_fdatasync, "fdatasync" , "%s(%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_fgetxattr
 { TARGET_NR_fgetxattr, "fgetxattr" , NULL, NULL, NULL },
@@ -251,7 +251,7 @@
 { TARGET_NR_fstatfs64, "fstatfs64" , "%s(%d,%p)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_fsync
-{ TARGET_NR_fsync, "fsync" , NULL, NULL, NULL },
+{ TARGET_NR_fsync, "fsync" , "%s(%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_ftime
 { TARGET_NR_ftime, "ftime" , NULL, NULL, NULL },
@@ -492,7 +492,7 @@
 { TARGET_NR_Linux, "Linux" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_listen
-{ TARGET_NR_listen, "listen" , NULL, NULL, NULL },
+{ TARGET_NR_listen, "listen" , "%s(%d,%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_listxattr
 { TARGET_NR_listxattr, "listxattr" , NULL, NULL, NULL },
-- 
2.17.1


