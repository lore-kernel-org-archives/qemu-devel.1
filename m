Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7313EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 13:05:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EBFB20674
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 13:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="kFRunn+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EBFB20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg6c4-000608-As
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 09:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jg5UM-0000Rb-23
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 07:53:50 -0400
Received: from mail-db8eur05on2098.outbound.protection.outlook.com
 ([40.107.20.98]:20705 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jg5UL-0000f1-3b
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 07:53:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJMNwCgB4tDewg5LHrL9hPdwZAF0Cs0mLcco3tv7I9y17HPtZpxcv45O2UjpY2ryHsDRpS5KHthNRgZlII3ni0RDdOKazFCfS5p45zMKnvWsifPKJ4eepeLr4fdBZVE6DACTIQTJe+9UuCRNReaxWOea6SwOcaW/GsDbc4g14TAoUOxSRuIG9VoPhqfIcZ21I4cwIBoy3xlkWUl+cGO8wj6trEg2eVI5KEzfoZVLypcZeRQbYSQ3zcbzkz6IqcaVGZOrUYmkkutcz2IwDo8YzSfMT9RCpYz75QoDr7LQcAuLj4U99GnR/sOoBj7/WSGdMOPDOpcazJZpEXKtTX6cJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSh4AVNR/OyJekO23RnLVMczpf/C7kIgC6iEaQcUuTk=;
 b=alBCfNAGdye7YGdcG/6q1XNg1w/tbmLi4An4e8nkyrp1mbiZq6GMZhTxUZ+kDgo9KfULscAS32grvEgynTittJ5f2uCcvQbLyPrOP4kvAwGMhh0NB0YLVifHZDAtnI3CQ5GKnntM5ka5x3shZobV5SzU3ByuttJ0i1965FsOcXMUq1vjF3K7XweMKYwSmFcLW30D4NBbEBKwhCHmhhJEAZ4RlnbXP/Z010/pItP6mvgSx4LQgeL5FTsOil19QWUz6cgPPYAwcLNrubTTCEqbH5ATSaleGTNmO4oWJZaYmY505X39xjz32eLf7e8LTsfr3RlLcY0pES3MPc4vG/r6MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSh4AVNR/OyJekO23RnLVMczpf/C7kIgC6iEaQcUuTk=;
 b=kFRunn+RaPNJilwesrIeQMH9RiKnogIRiAgOe76z8Den2VaY6e+vqsnfTN6+ba16ikhnt/7+DRGz4RPgXQ4CgakwFECQ5t/q0NtgIwd3Z80evpW8UePGggUDNaOeQFulbz5jI8wBAE0EWY5xeItzw1vrNVMwI8UBL5B1nPyZbCU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB4022.eurprd03.prod.outlook.com (2603:10a6:20b:22::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.22; Tue, 2 Jun
 2020 11:53:45 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::7935:50dd:e879:bca8]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::7935:50dd:e879:bca8%7]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 11:53:45 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/5] linux-user: Add strace support for printing argument of
 syscalls used for extend attributes
Date: Tue,  2 Jun 2020 13:53:28 +0200
Message-Id: <20200602115331.1659-3-filip.bozuta@syrmia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 10dcf27c-2980-4c7d-c1f2-08d806eb9a45
X-MS-TrafficTypeDiagnostic: AM6PR03MB4022:
X-Microsoft-Antispam-PRVS: <AM6PR03MB40229A31B54801587364B6ECEB8B0@AM6PR03MB4022.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:530;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qBg+p6mIUKT4J12ypRbOx8uQOVbWwj9hRI0T2JKZA9ZqmE5oWPb+2LIujdITMRY1wdXqOb/4UTyuXr4Gfd0WJWo3ReLQwHIQGVQ//JW84Z+UT01GZlidh7X0w9IkzwuXMtJ4Av7ggyGL0fSu05kyTUjshH7/JU+jQZNiheceMxuSjn7B0l/hY/43E4l+AUlO1XP/OI7j8lJWKGZ2QDrShsuJJDJcSwhT1pEvzBgxkfU1XdPfELulPeBTs2H1zmavEC7w6zWRKDMKaGhLmhYeSCzgAnRxO49OyviEWXi+6/QHj+LjIJmJAKYxxPcI9VFbjUhzjYwR0nY6f6PZraDVyU83mll/unCDa3TyPY8tfnXUc8+NXfiVOZSIKsj7XZ+jbt3JlSD+2lkyFzxgLerTMO72WASmsSlGMTMWgSzqviNbauALLb26HCX6EfKKK77thJmtzimKbxVQX2eKXx4Eow==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(376002)(346002)(39830400003)(136003)(396003)(966005)(44832011)(956004)(2906002)(4326008)(36756003)(2616005)(86362001)(508600001)(66556008)(66476007)(7696005)(66946007)(26005)(8676002)(52116002)(6666004)(6916009)(8936002)(316002)(1076003)(5660300002)(16526019)(83380400001)(186003)(6486002)(334744003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: An7pwbQwe8BrnVwzDg7NJ+FdhDvZ/l4w4/kd2iFMyvl4KMXMqj39wl+F07Cm5ROLdEkN4rE2NFEHNUko9XG8Yg3CFVdCD6NY1pI74HahUC40FR8eytedvySaZZt9q1dUPn15vtgjz1ASGb16faTxE2IAAPsggyObuYRj/6XIZYFlEOBoiUvpHPAlgQzbwi6bGDJAfLDC3ieQTrxkv9/c0USdKQd3u4fI2F/SV0k2KUTFVrKGL1DvFxldAFUf1ctrDK8hTZ1o9TyBg9aP4N+HHlxIfVx0ZjaMbMPpHgzwHKF0s/v0j/4pMtxsxfOcoCfwSMaqkSIkN9L3orST7p9eLT/y6JctlQQjQqyRAYxuUmm6lSIOMiQ2vuHeiDR6CbvhePJW5cx6aw/EDpTdr+9kllukuTjRC2v0lCqlYzzSYRzPw+TVtLLRku5oj9+jdK5NVivKYXHlwqFKtrmLzDkdlc11AY39uaK4Aaq6KUloE8Y=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10dcf27c-2980-4c7d-c1f2-08d806eb9a45
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 11:53:45.0058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dxvnMbHh6YZqmip+K5Y5KdQumrVKKznNcFdGjyXgotgvRk55M1Z8/JQ1zOJMFCHe3bARdQ0u4Y7YcNlJTSCJYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4022
Received-SPF: pass client-ip=40.107.20.98;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 07:53:45
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

    *getxattr, lgetxattr, fgetxattr - retrieve an extended attribute value

        ssize_t getxattr(const char *path, const char *name, void *value, size_t size)
        ssize_t lgetxattr(const char *path, const char *name, void *value, size_t size)
        ssize_t fgetxattr(int fd, const char *name, void *value, size_t size)
        man page: https://www.man7.org/linux/man-pages/man2/getxattr.2.html

    *listxattr, llistxattr, flistxattr - list extended attribute names

        ssize_t listxattr(const char *path, char *list, size_t size)
        ssize_t llistxattr(const char *path, char *list, size_t size)
        ssize_t flistxattr(int fd, char *list, size_t size)
        man page: https://www.man7.org/linux/man-pages/man2/listxattr.2.html

Implementation notes:

    All of the syscalls have strings as argument types and thus a separate
    printing function was stated in file "strace.list" for every one of them.
    All of these printing functions were defined in "strace.c" using existing
    printing functions for appropriate argument types:
       "print_strig()" - for (const char*) type
       "print_pointer()" - for (char*) and (void *) type
       "print_raw_param()" for (int) and (size_t) type
    Syscalls "getxattr()" and "lgetxattr()" have the same number and type of
    arguments and thus their print functions ("print_getxattr", "print_lgetxattr")
    share a same definition. The same statement applies to syscalls "listxattr()"
    and "llistxattr()".

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/strace.c    | 60 ++++++++++++++++++++++++++++++++++++++++++
 linux-user/strace.list | 12 ++++-----
 2 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index c578876d22..5cf419989c 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1629,6 +1629,66 @@ print_fcntl(const struct syscallname *name,
 #define print_fcntl64   print_fcntl
 #endif
 
+#ifdef TARGET_NR_fgetxattr
+static void
+print_fgetxattr(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_raw_param("%d", arg0, 0);
+    print_string(arg1, 0);
+    print_pointer(arg2, 0);
+    print_raw_param("%u", arg3, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
+#ifdef TARGET_NR_flistxattr
+static void
+print_flistxattr(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_raw_param("%d", arg0, 0);
+    print_pointer(arg1, 0);
+    print_raw_param("%u", arg2, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
+#if defined(TARGET_NR_getxattr) || defined(TARGET_NR_lgetxattr)
+static void
+print_getxattr(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_string(arg0, 0);
+    print_string(arg1, 0);
+    print_pointer(arg2, 0);
+    print_raw_param("%u", arg3, 1);
+    print_syscall_epilogue(name);
+}
+#define print_lgetxattr     print_getxattr
+#endif
+
+#if defined(TARGET_NR_listxattr) || defined(TARGET_NR_llistxattr)
+static void
+print_listxattr(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_string(arg0, 0);
+    print_pointer(arg1, 0);
+    print_raw_param("%u", arg2, 1);
+    print_syscall_epilogue(name);
+}
+#define print_llistxattr     print_listxattr
+#endif
+
 #ifdef TARGET_NR_futimesat
 static void
 print_futimesat(const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index fb9799e7e6..8d51c54bca 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -218,13 +218,13 @@
 { TARGET_NR_fdatasync, "fdatasync" , "%s(%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_fgetxattr
-{ TARGET_NR_fgetxattr, "fgetxattr" , NULL, NULL, NULL },
+{ TARGET_NR_fgetxattr, "fgetxattr" , NULL, print_fgetxattr, NULL },
 #endif
 #ifdef TARGET_NR_finit_module
 { TARGET_NR_finit_module, "finit_module" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_flistxattr
-{ TARGET_NR_flistxattr, "flistxattr" , NULL, NULL, NULL },
+{ TARGET_NR_flistxattr, "flistxattr" , NULL, print_flistxattr, NULL },
 #endif
 #ifdef TARGET_NR_flock
 { TARGET_NR_flock, "flock" , NULL, NULL, NULL },
@@ -396,7 +396,7 @@
 { TARGET_NR_getuid32, "getuid32" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_getxattr
-{ TARGET_NR_getxattr, "getxattr" , NULL, NULL, NULL },
+{ TARGET_NR_getxattr, "getxattr" , NULL, print_getxattr, NULL },
 #endif
 #ifdef TARGET_NR_getxgid
 { TARGET_NR_getxgid, "getxgid" , NULL, NULL, NULL },
@@ -480,7 +480,7 @@
 { TARGET_NR_lchown32, "lchown32" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_lgetxattr
-{ TARGET_NR_lgetxattr, "lgetxattr" , NULL, NULL, NULL },
+{ TARGET_NR_lgetxattr, "lgetxattr" , NULL, print_lgetxattr, NULL },
 #endif
 #ifdef TARGET_NR_link
 { TARGET_NR_link, "link" , NULL, print_link, NULL },
@@ -495,10 +495,10 @@
 { TARGET_NR_listen, "listen" , "%s(%d,%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_listxattr
-{ TARGET_NR_listxattr, "listxattr" , NULL, NULL, NULL },
+{ TARGET_NR_listxattr, "listxattr" , NULL, print_listxattr, NULL },
 #endif
 #ifdef TARGET_NR_llistxattr
-{ TARGET_NR_llistxattr, "llistxattr" , NULL, NULL, NULL },
+{ TARGET_NR_llistxattr, "llistxattr" , NULL, print_llistxattr, NULL },
 #endif
 #ifdef TARGET_NR__llseek
 { TARGET_NR__llseek, "_llseek" , NULL, print__llseek, NULL },
-- 
2.17.1


