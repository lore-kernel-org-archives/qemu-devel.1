Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C40FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:51:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5438E2053B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="LvVAaFox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5438E2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKzD-0002gP-Bp
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jiKss-0003JU-F2
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:44:26 -0400
Received: from mail-eopbgr80091.outbound.protection.outlook.com
 ([40.107.8.91]:62103 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jiKsn-0007Fd-57
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:44:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/NgMz2nayRRtm3EwdDjtu7TADdIO8rmRaMRp9FIYeQQgsY2hgJkPrlGBw+gLn3Fubcb66Y9xledkMDAUewGRQ16/H9iRh49j8BUMyPcULIB6mUbES5WxrT57A8jwsOrsPkBuE7Vh6WZTycgXrP6r5sM1EPvWRuuhhupkCdnhw0+Bm0dgh4IWqvmnGgIxCBC2MDP6tyHBEZ2U5E/J2LDKP+Obqa9Ff+V3VOHq5EUOf/M/TqhO0S1L3ara/PEMa5Xtu8HccckYRJR/0yAOT8j+LSbhdhTg/K0lkLy0GrbaIh9DTFnnV5E81FxCGpgO6D5je22E4B+vSMrHHhjyD1X+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcVTZUvvqIqsP7TudJ8lNe6q8zY42kdYNe2MTpViLIA=;
 b=hBtR4qgr/RpL0R43UdUxe3pot9+M1HPhzsVmQ86Y0YY88kUT+wdYpbsFlG40ng+hk3qf6kytNp5Yc1V0qRsgRFHLfZTZ4PVhJsUB6jIPv4yggWWqFU35ID5WeeBz/yTIS6thOKnVDQqJZZlZva5omYDDjYs8bwRhQ0qKAFsv8tsBdoq6XdU4CI5th/LMEgeuC/N+jeiV3bZXZogpIGBQSTQJCHjrh9mlAK2MvBHchPkabGyW4dRJjEKh/+7jVrd4yGoj/5Ih2aQA5mDEElOPTYQ+qOlEvyjG2qR31uXU+IS2sLwU4fz8yzxQ0QIOwfGfuuVRpjRJKGAWU2aSjiSlkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcVTZUvvqIqsP7TudJ8lNe6q8zY42kdYNe2MTpViLIA=;
 b=LvVAaFoxZCBDgs0Rt00c0N6nlvKuilnn8eBZkX3rzjDGYF7HeljVqAbvIsgN1Fb6y60eHR7pVupiqhBud76T5Cn+fmLucEwf2FQKcBQz2Q5IVu08XHQEMsBgSpAMDwheyFk/c3uXvW88HKJGILSZOWW+xpjhk5nva/lgPQaoJjA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB3798.eurprd03.prod.outlook.com (2603:10a6:20b:1f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Mon, 8 Jun
 2020 16:44:11 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 16:44:11 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/6] linux-user: Add strace support for a group of syscalls
Date: Mon,  8 Jun 2020 18:43:53 +0200
Message-Id: <20200608164357.25065-3-filip.bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608164357.25065-1-filip.bozuta@syrmia.com>
References: <20200608164357.25065-1-filip.bozuta@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0016.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::26) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bozuta-ubuntu-18.syrmia.com (46.240.135.226) by
 ZR0P278CA0016.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 16:44:11 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87949a6e-3221-4ea5-baf6-08d80bcb2bb3
X-MS-TrafficTypeDiagnostic: AM6PR03MB3798:
X-Microsoft-Antispam-PRVS: <AM6PR03MB37989D35711DF46E8E77DFD0EB850@AM6PR03MB3798.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JkOcfvzhY1uX8CEvjpx93f13FK7pEv5g1RxeLCwP7XiXK1onlomEXpGvZHz3JU1T8pWQ7fHvIIx7G0AHiTV3F57zwfqD5PZzabV3CrBCS7+VL1t4SVnPRx5cImwxDyt2Q0DkvSbSZFTdHh+fE2PRu0/lRQdY8qXDxgSiq5bR5NSosoD+TftST49hMFDdEEOfWZsMLUXt2C1Sr8K+SehCK8istc43qGVnd2uKJsHUl3mJPnLx+TUDHIgrqnI2mwohIYE6WsVM6hSqfNucXtlFS2fE404NyUEa++bTe2XIiWJAkznNZlbJze2TP0ofP6xIpNfkIafj8DyWfp9sHG/8suKXOZhSOqRB/RV1IydOoDHy7FSdXj3v12aYZJi4RjTWZoaaSv0kU+Ckoow1hajz0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39830400003)(376002)(396003)(346002)(136003)(366004)(508600001)(4326008)(8676002)(8936002)(966005)(1076003)(66556008)(6916009)(66476007)(5660300002)(66946007)(86362001)(316002)(36756003)(16526019)(26005)(2906002)(52116002)(83380400001)(2616005)(956004)(44832011)(6486002)(7696005)(186003)(6666004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: +hTi77XScI3vimDB+i/cK4RoUa9W22Cm48kXfWX3ZEQmLb/tZAPDmHf0p7ETVHFVjocthEbEFsCD5r4AOh3OuDLoaBpbaJQxfIN+mSXzjqoG8t75I4SCVWxSNIiPsA6MncuEujzwCCnJZzV7KS3ROLx2KBq9CuWBEuD5YjH9TvtrY4h115teXomxXBYADbnpH4n85RhPVmS9Rl8JomOLnWNdETXGGyVk4H7zeQehZQuex2/CHMo9TUURzdHemE503KSzRQtok3aP2bH41K/0osUXLquV+Nx30eAd83vKSZTY7MJfSkOeFAtWN8FfKgFuQn8MCLxoJ4Vsats6eFO0fH0yaOgwrxabQpTpIPgxkyaqDThKScjgmt5xZWeMGmfxID66i9e9KvLY4aNBZXSflN45/atP+w68mzmTr1pcxftU/F2UQ/zOdAHuq8EtsVEZCDIY/9UJkEvqroVvadyfqR7KDs5Yn1oYPkVlNlFygO0=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87949a6e-3221-4ea5-baf6-08d80bcb2bb3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 16:44:11.4609 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPzcWRp/uX0QObm1QpwFHvthACdm67wzcXLPhGTyup9Tvz6MEMlFlmLqn0WEtsJg99ZNwiSOokexFX4bEiYj2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB3798
Received-SPF: pass client-ip=40.107.8.91; envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 12:44:17
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
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.c    | 13 ++++++++++++-
 linux-user/strace.list |  8 ++++----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 23f7c386b5..f980451e3f 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1361,6 +1361,18 @@ print_access(const struct syscallname *name,
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
@@ -1625,7 +1637,6 @@ print_fcntl(const struct syscallname *name,
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


