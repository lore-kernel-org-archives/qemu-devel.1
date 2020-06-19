Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BB3C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:35:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14A8820732
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="uouBsvdO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A8820732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmGEd-0000PT-73
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 08:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jmGDa-0006xY-Il
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:34:02 -0400
Received: from mail-eopbgr00110.outbound.protection.outlook.com
 ([40.107.0.110]:51142 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jmGDY-0003z4-Jw
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:34:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBiH/fvHYuTFRO9ZZf5qd5oKXYPWicd1DS3CnYgeeuo/yccBArk/dpYIsYTrThQ+c4jtAJwPHkDxWgIyOqW+gpFzFnuPWJBz4ArgTgPvARBVzS08tsUheedWPgrJT7+ngO8oGCuo2/BGZmS7Sz9SxVU5mO2uQ+ZfeTiNi0MbvXB/FszzViYaqZ0mPbLSEl0sKunCif9A59VgLIAvco6kY8F4SlWusWYh3+ZepcvbaU/NqAisD2dagdEe06aTafoKBji8kHYGSOh3ZKZfQqq7CohvcwJ+8lukdT2liFIVzRELZBX9Z+SbRCfRSdxlgwOeADwDT2++3UQkRuEIUDjquw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAdoEJJjbXGc2+2K7DrF2I6dK/xOpEkM6Nkt8Ib0nzQ=;
 b=Z7Glj+oxeIkgzimVqq5UWwbTrCbc0c/yQkMsqM+4HRBppuQgWNEaAZCW2Fu9W/o6QMbtgFI281fbYV2t25SxEUExazGlznYf5g2jc7TfaNiZ8XSVY3zmJyPlEdB2lIVNOaNjxqi0g6ekUZWjQ401/nf8MTE90wbVqlOB+Vk8BdhR400yWPvLzJujJy+Fq8rQZACMKIYk6WjXj+NlSXf7XPwr/1pzrwG4Uh9AuDIwFcm7Xqgu8r8sBb+ZVmcgvY5PeHxzF7122UFf0SjCqWdOCWqP5kSHaFXOlTOXT6i15OPeWUb/avp4xqkS1NNCD963MxYOVGA4zSRjtcyZdT/Uwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAdoEJJjbXGc2+2K7DrF2I6dK/xOpEkM6Nkt8Ib0nzQ=;
 b=uouBsvdOub7dC7Vweo4ntFS40Tnkiwe1pGlwW0iyXcgb2R+/ZGD91dsicefSOj5gMiNuJ447CcuUzmm4kAmcQQF41NSvS6sRLQ0pdnpnELLcIqLDoMT/i6uiRzXBlOpzz4BHuc0rC9fIjcAAW8crpZOnH1UcL99qIRa5JOjQO9s=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB5315.eurprd03.prod.outlook.com (2603:10a6:20b:d1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 12:33:45 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3109.023; Fri, 19 Jun 2020
 12:33:45 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 2/6] linux-user: Add strace support for a group of syscalls
Date: Fri, 19 Jun 2020 14:33:27 +0200
Message-Id: <20200619123331.17387-3-filip.bozuta@syrmia.com>
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
 15.20.3109.21 via Frontend Transport; Fri, 19 Jun 2020 12:33:45 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc036064-5dcd-4810-8f8e-08d8144d022c
X-MS-TrafficTypeDiagnostic: AM6PR03MB5315:
X-Microsoft-Antispam-PRVS: <AM6PR03MB5315A751496D8CF02F1C7749EB980@AM6PR03MB5315.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h6B8wfTogrBgYn2sbCvnTokQQpmJQSEvCrshRBq7iVs7mtKGQFJudMC0LYQrr38+rH81Wt5VPpjzSHZaeQibXmgV8y5kjtZYM2nxZwmoStbtSDlDr3T2aikLE1HQOxsnKgiOQTkg/l4I5zO4BQd1t+/psaV/onElnpsPX91QqH99pgwfLFpWv6jkAgyAYRzKwjn7wvkged3rSiTqDfnnroEYZ4wX36BYHcx1JZRBOHXFDVmSvNWRA5G1JVQS4qkqbh7s6bCyKRzbe9X5BS/b/R2IdwKV7eO6IwXv805Vmfw9BkeYWs8wqAeGQ45NXiqwOuPyWrpyEDdNlLNdF+bIfE+RBDRP3QOCIm5+6BZG3d1S8L4e7sZjDeL/3027CL9b4cP4CS5L7Xg+RQ41dOYBZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(366004)(376002)(136003)(39830400003)(396003)(7696005)(52116002)(4326008)(186003)(36756003)(6916009)(2616005)(26005)(16526019)(66946007)(66476007)(316002)(956004)(66556008)(1076003)(83380400001)(2906002)(508600001)(6486002)(966005)(5660300002)(6666004)(8936002)(86362001)(44832011)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: D79+kDJqBbYU4VHT79qW+v3PjXxlv9JyBFW/qLLZ40QOX2hcemQm6NDwqj6f2FYS1zezYCStt9gz3PaFeWD9yibBefDybhLU28pB8Ji2THKMIMxig1Q9N659dghOEQIMwoIPh0+JbaBmriI27EZlPSRa7uCzPDdmi1NppjDqCgSmKP//kIu/L67shAzXADpJMGOn4Mk3Xx2UC2A5YozdJNnepJgZEU2ci+pu72RUXiKzfZqpNsAhuu6m5dkwywUQxSG7KLiACPmfkLu9lu9/oRPjcSrXFpEiQf822Jfsr9iZJGG/9gT8/SBYouX/q9QGxd1d/ki+RPbW+y4Zxtl6jyk9ERu13XaBdvcX/r/i4uHHbZFwCMENOIg2/VWZkjpJRZlBoLhcED9lr3vmSR0TVUTJcISf65riONQ0UykGvbsKi6mqlR/w7tlylOlpgrr4aRcpw7qi/rOBRW6lfSxZnuOPoOYJIJSWj2MtGEj1K9E=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc036064-5dcd-4810-8f8e-08d8144d022c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 12:33:45.6086 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLwEjB+QiYI/ODFU+DfxEdalvFAg7APpUfM8qsyYB/tleWldWPz9/AEPshNuSLOBaP5P94Oyy43jCQx3Aw28eg==
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
index 62117e8555..123e022c35 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1357,6 +1357,18 @@ print_access(const struct syscallname *name,
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
@@ -1621,7 +1633,6 @@ print_fcntl(const struct syscallname *name,
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


