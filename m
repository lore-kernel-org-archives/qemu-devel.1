Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F5AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 21:41:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 907EF2088E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 21:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="s12u75hy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 907EF2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jow6R-00080u-Pi
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 17:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jow5P-0006jU-QJ
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:40:39 -0400
Received: from mail-db8eur05on2124.outbound.protection.outlook.com
 ([40.107.20.124]:39136 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jow5O-0004FJ-5B
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:40:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvsd//ieVzB69oeAq602H7yxWa2bMqsK6KWAMxho7AnJW0yTlxAuxZ72l+tk1yeV+f4XF7Z+expmr4sVuc/uM6jFDTu0DAif7Mbn1Zwavt7LFvjibXjAJ8s/+nRXurnlEufY21Rf/7ipVYbPkxDu69cow4gpjtqIL5Wr4lX1q6Q1o+uktMyIVPSq3CBXbzbCfXqGVT6S0Vv9dRyysvFv3Y2+ROrXvoo/I90Frs96C+yOAPnJfDaApJ8E36lJ/PTf/YaWwM5LbM2xMmF+Euds/YMEBMbNVQqU8P1eWv28ywXaGQ0prb6Xjp0gOPoY4SlnWSkuDjjkVk7k1bupwhFmbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsZzd8qdifyi1SBubYzCR5kC4yvuuYIuX7CUtsNn2Tc=;
 b=AQYGAg66srFlBuXngd1I6su/EyEkNEvMALIAWZyzG37r0mm1MPLOnblVeK1LueWtkeTx9CPrBFPH41r8uC8bRlbvLIunz3YxuJSZbYECi2EBzl+SGVc5+Dj6Uv+KpRMJ2mE00PR0lpQm5VIvPBNm1Lg8WJ2V8+QuRbOMiWrcTOOtfT7dZGftq5KbxxzfXfOiW+HCIzskEOu6oDYh/6/JrsDaLpYEN5sOzZs6UqClDRLDd8CYfOf3X6UQ93GvjYdU60rF3LiiEoFVf4oqmc3tmvPq8dCLIDUnZmHbA6C8jgBX86gDR+sRk01VLYSAE8Y6fH6FPjCxZEjQkI3sxRwnFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsZzd8qdifyi1SBubYzCR5kC4yvuuYIuX7CUtsNn2Tc=;
 b=s12u75hyhUjhPJtz4GKc2ACIcn0aNA0PCSsrIfFBXUqAM4DnxD2cKl4U2vnNOGCtTEMyH5O0a+OqB73W12IYu0qAg8s1QCd+95GW4IEtAvDQFDylb5oB+kEjVULFc8kHHiROEoCWR3WmipyDpwAtWvoe+Vsl5/oRW0XR5vAiv7U=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB5234.eurprd03.prod.outlook.com (2603:10a6:20b:c3::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Fri, 26 Jun
 2020 21:39:59 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3131.021; Fri, 26 Jun 2020
 21:39:59 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] linux-user: Add strace support for printing arguments of
 syscalls used to lock and unlock memory
Date: Fri, 26 Jun 2020 23:39:36 +0200
Message-Id: <20200626213937.20333-3-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200626213937.20333-1-Filip.Bozuta@syrmia.com>
References: <20200626213937.20333-1-Filip.Bozuta@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0044.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::13) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.240) by
 ZR0P278CA0044.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.20 via Frontend Transport; Fri, 26 Jun 2020 21:39:58 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [147.91.217.240]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf9dca0d-cd9c-4320-de28-08d81a197992
X-MS-TrafficTypeDiagnostic: AM6PR03MB5234:
X-Microsoft-Antispam-PRVS: <AM6PR03MB52345C5A306EFF8ACE94AC92EB930@AM6PR03MB5234.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ppT8pMXd/U6iCnAD0OG/zr3LD8+Vkk9a8SX8V32KEVWXxQd9iaB0m0ph10H7rHtMnI11h/FNcSdwrk/atpkAoqMF3OQutUgBJG5u6VLuYASCzKc4C5RVecxNokuLfDvnKJ0zvl94LS1mRdfd2VYL5J+sB1Xcr3gGcREeIlbJb/PAXssVa225p8qLA+HWABxDTENZJ3unDzz5IP8UDc43DB3YMFxNYlRcpV6lD63wqVXWxu/Is4z1RKt1SgJquPnaXjrECzh0IbJnPyAVwq7fo4nMpN1abHvW2ZzU+wQKTQCmptjudS1dmE2Zv4t0AcfKi3Bz7fDzKbLCyULJhzT6LpsPtExgxJlDdDy84Vbtj4qs55GXu07VB/OGhwvWoEBPc/Ey71TN6dMHLZmMsmafgg14ntq34w/ffzCj8u0NetSa3L7yP8fQR1ZfTtBfW/K0F2FvQzeqlFkjtcupxLXYGKrAzi9D+Q5CEXbuLweNSIM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39830400003)(376002)(346002)(396003)(136003)(366004)(4326008)(6666004)(6506007)(1076003)(508600001)(83380400001)(966005)(86362001)(6512007)(16526019)(186003)(6486002)(52116002)(316002)(6916009)(36756003)(2906002)(66476007)(66946007)(69590400007)(66556008)(8936002)(26005)(5660300002)(8676002)(2616005)(956004)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: lHtdsj4C4Njl1kYrXFp30yUUkOMLbMXydwLqDpEW2Q9zk8UVAXfW0FRM5pPjGSee+TbcaDABgB8t2MvcyiuenYzKzDHD3kBApjAFFLmGGSNF5PU0Mnn9+nU3M9JdJlwk9M1l/cPpF5mvGc5HhuYDzS1wGNl3knrCJ0LMf8KHP+65g6GDOhOtX1EH+f0JVcakpzoSnTOnWwwdoHIQwiJjORRK8gSbrZh7frL3KwNOmxeN4+V5acWBrn2fHiWkTe2CLJthYjqZIb4OmUVDky/TkZnl9FTaiedPfrzDUWv4uJ5aVhprDREPvj3TiVuKF0cP45Kw/mSC5wrnBXwrPTC9tPF0Tpk9IgBE4R1EcJYI3uyx3vAUiLxGrQmEMUu9FeSqlc9UHrj7laI5jkHVZSeo3aEd6oF3KPHEuMqaFTsb++GzQOJYr9+uCpHnqj1VFGNIkjYUy68Hlc4sam7ZalSSHi78mAUp0t2XwsTCgWun0Ws=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9dca0d-cd9c-4320-de28-08d81a197992
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 21:39:59.1086 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sT1sSVMc3fQNmlgEiwdINMpY1krHgTsTpHDmmKU+4iPP3UAFpG6flJ26jfiTTZWSBGVXCq78w4oxGCoDXtEJfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB5234
Received-SPF: pass client-ip=40.107.20.124;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 17:40:33
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

This patch implements strace argument printing functionality for following syscalls:

    * mlock, munlock, mlockall, munlockall - lock and unlock memory

       int mlock(const void *addr, size_t len)
       int munlock(const void *addr, size_t len)
       int mlockall(int flags)
       int munlockall(void)
       man page: https://man7.org/linux/man-pages/man2/mlock.2.html

Implementation notes:

    Syscall mlockall() takes an argument that is composed of predefined values
    which represent flags that determine the type of locking operation that is
    to be performed. For that reason, a printing function "print_mlockall" was
    stated in file "strace.list". This printing function uses an already existing
    function "print_flags()" to print the "flags" argument.  These flags are stated
    inside an array "mlockall_flags" that contains values of type "struct flags".
    These values are instantiated using an existing macro "FLAG_GENERIC()".
    The other syscalls have only primitive argument types, so the
    rest of the implementation was handled by stating an appropriate
    printing format in file "strace.list". Syscall mlock2() is not implemented in
    "syscall.c" and thus it's argument printing is not implemented in this patch.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/strace.c    | 21 +++++++++++++++++++++
 linux-user/strace.list |  8 ++++----
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index dccfbc46e9..1fc4404310 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1161,6 +1161,15 @@ UNUSED static struct flags falloc_flags[] = {
 #endif
 };
 
+UNUSED static struct flags mlockall_flags[] = {
+    FLAG_GENERIC(MCL_CURRENT),
+    FLAG_GENERIC(MCL_FUTURE),
+#ifdef MCL_ONFAULT
+    FLAG_GENERIC(MCL_ONFAULT),
+#endif
+    FLAG_END,
+};
+
 /*
  * print_xxx utility functions.  These are used to print syscall
  * parameters in certain format.  All of these have parameter
@@ -1939,6 +1948,18 @@ print_truncate(const struct syscallname *name,
 #define print_truncate64     print_truncate
 #endif
 
+#ifdef TARGET_NR_mlockall
+static void
+print_mlockall(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_flags(mlockall_flags, arg0, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #if defined(TARGET_NR_socket)
 static void
 print_socket(const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 3b77b22daf..822b6be49c 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -567,13 +567,13 @@
 { TARGET_NR_mknodat, "mknodat" , NULL, print_mknodat, NULL },
 #endif
 #ifdef TARGET_NR_mlock
-{ TARGET_NR_mlock, "mlock" , NULL, NULL, NULL },
+{ TARGET_NR_mlock, "mlock" , "%s(%p," TARGET_FMT_lu ")", NULL, NULL },
 #endif
 #ifdef TARGET_NR_mlock2
 { TARGET_NR_mlock2, "mlock2" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_mlockall
-{ TARGET_NR_mlockall, "mlockall" , NULL, NULL, NULL },
+{ TARGET_NR_mlockall, "mlockall" , NULL, print_mlockall, NULL },
 #endif
 #ifdef TARGET_NR_mmap
 { TARGET_NR_mmap, "mmap" , NULL, print_mmap, print_syscall_ret_addr },
@@ -636,10 +636,10 @@
 { TARGET_NR_multiplexer, "multiplexer" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_munlock
-{ TARGET_NR_munlock, "munlock" , NULL, NULL, NULL },
+{ TARGET_NR_munlock, "munlock" , "%s(%p," TARGET_FMT_lu ")", NULL, NULL },
 #endif
 #ifdef TARGET_NR_munlockall
-{ TARGET_NR_munlockall, "munlockall" , NULL, NULL, NULL },
+{ TARGET_NR_munlockall, "munlockall" , "%s()", NULL, NULL },
 #endif
 #ifdef TARGET_NR_munmap
 { TARGET_NR_munmap, "munmap" , NULL, print_munmap, NULL },
-- 
2.17.1


