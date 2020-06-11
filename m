Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF035C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:12:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 995C6206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="D62MLptY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 995C6206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjPoO-0001nq-Rs
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 12:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jjPip-0000Zm-6G
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:06:31 -0400
Received: from mail-eopbgr80117.outbound.protection.outlook.com
 ([40.107.8.117]:27360 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jjPim-0001cI-2x
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:06:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iR0K9isxbbAlaJdlNqNfMGkZKzF+NN+FejiE+j4yV2IT3+oqD0B864PjigNfixeR9H/iBFscpzPQaJkAGSIwSPhpb92LpQlihtrZUTSOES9ZFf0NYn3sfUPiQp7Rev/mPgNCj4aboOIxV8pFWl9h6UHXkcP0HqKVCbZ9hVV2VxQw5OXgsbm1liNp4A/zn7QOhRXaO2wKYi8zaicTfQc92nIzcuUZR7KvZdCewZRsBHw6tvaKFfgldU3XPFW+Q0MgmG7cZ0Vrr30TsdM221iye6X+yckI8E/7T2bUSj0/VpRo/L+V5YeFA7s5FdDJrmj5KSz0lZd/ViIXkFOdjM6LUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBl2H6hbVcegyp+EsCQCI1C8r8tpdRRumyzlF36DHc0=;
 b=f/9oYpMOnnJEMKLImmGqgtLZx/zcJmbA+3PhowvlrDWPs19uBmXlEpYXLISGUffWqRrSFjeqMVb1zmwcN/nUGOIejmpdj148rOnOZ95AnhiWsyLSiGlFBnCTqNNy0QNs/cseCP3BXnmR2UX29KQ1R4XHgxcQPWLXSKDc7FWBEfH69hEUtO9BOTmQu0J48IpHFgfM5kEzIRxLWdcGjfHDs1O3qxgPd1NglA6YqiTFWdU4gSaUd+7jsCI4Vpjdw9UuQStdu7hFI/M18P5upQI5160fpKZdV64qN8tqlq+qg3h1AVFRy7JZ0ZQTlg9/pEXFhNDk3DteGRnOKmwWDh1HFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBl2H6hbVcegyp+EsCQCI1C8r8tpdRRumyzlF36DHc0=;
 b=D62MLptYQ1lmHWyeFbZ2+79lxS4npswsrehwDAH2RDtYDPaxfU2PZ/+1yv9RRjwnDVATC8quZ4/8VVbQoxl+Ozd4A4jOlq/EJ1zvICcmUwF3yXS061GrK2HyjZQft8v1akIAQLudqQ3WMkSrUt8sS3BNNbpJht/9yMp/tAxVeLE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB6008.eurprd03.prod.outlook.com (2603:10a6:20b:ed::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19; Thu, 11 Jun
 2020 15:51:23 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 15:51:23 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/6] linux-user: Add strace support for a group of syscalls
Date: Thu, 11 Jun 2020 17:51:05 +0200
Message-Id: <20200611155109.3648-3-filip.bozuta@syrmia.com>
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
 15.20.3088.21 via Frontend Transport; Thu, 11 Jun 2020 15:51:23 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8991b82-f2eb-4d4a-aa74-08d80e1f4ac0
X-MS-TrafficTypeDiagnostic: AM6PR03MB6008:
X-Microsoft-Antispam-PRVS: <AM6PR03MB60089A22D2A067F154CF9C82EB800@AM6PR03MB6008.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XTpb2lLRLElr/DA/QBconsQcRn7BAlXRBjtr10G+X9Bwesz02BaEIs3W2hoEFy2bZ33hrCMsD3nuPwNSgL20BzA/sYbKCqUP5r8zw7hxrHRX4zhO53C1NJ+pHRT3eScxqnqBh5Ld5qOJo4EgRbuT+erliXH0kyNYYnwCfJKQ5kPE+00v8wAs3/pmLxzg24KAkGmCZGH2BgLeHO+fahjUE4GZbn5Hy3DZs0qsUt0gfxA9uV7oBZqjEpnH46nLX3IftBXWqdtaC4IZYBw0OGV0Ekrw5dN6R03NaUS9rH41oJBApu/o87TMXS9Z7LHUtWOoIrVcNI24NffRbbRgGOHVhbVRhddeX47AMYhzSpzhi9MPmBy3Eq8Inisch2kwV/ZpkrD4tOtNGTQ6lbmnVsbCPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(376002)(346002)(136003)(39830400003)(396003)(508600001)(7696005)(966005)(52116002)(316002)(83380400001)(8936002)(8676002)(956004)(2906002)(6916009)(6486002)(2616005)(4326008)(36756003)(186003)(44832011)(6666004)(16526019)(5660300002)(1076003)(86362001)(66556008)(66476007)(66946007)(26005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: DWRHxTodW6JejHPropuIcfSrrGgR1auMOjPJNsrsaL00kYjzanOZcsm3fLWX2GKbYCl4kj9Y68sJpfbRYO2Rw8yUzeIQ+/EmvI1r2ubBC/OVboxyretZQ1ZesJXbAFmCs9fzck67ouDALsoypMJ5HYrQZbSz864lbbl1vXCN1wgPTp8iuibMeHDZ8/5qGBmqESosEUg1YtlrudOjhRL82es0e8smg/a6o2wH1r4YLb2bO13MetV9xS+fwWYO0O7dOuWauh+SwyktH7ocovf3cU+DEzECpNpeL5+du9Isn8h4w/3ZtkMNAzeBQ7c0niN6OqtFkJ1n7THLOKWWlWyV6S0DUa8BBNdKuP1I63s2ezAxlVDYjIJoMAvYhp0fKW4juiQa+fUpddAMT//bTgqezJV/wJP1sFrsab1WMNL4p58MU9Hb+aqMGeiwV0VQErZk6H0+wkY2LlyB+4M8/OYJljjq2I0Lj3T/NHqoXBEwep8=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8991b82-f2eb-4d4a-aa74-08d80e1f4ac0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 15:51:23.5249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5vbAycm1HrEW8B+D2Lao0On4EVcLKmDF9VKxg1w+V3DcH1sAmwjt7e0XahSnv/IDnQaqhc12DsQNKEYUaQPRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB6008
Received-SPF: pass client-ip=40.107.8.117;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 12:06:26
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
index 8678a2aeac..4f85606c19 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1365,6 +1365,18 @@ print_access(const struct syscallname *name,
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
@@ -1629,7 +1641,6 @@ print_fcntl(const struct syscallname *name,
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


