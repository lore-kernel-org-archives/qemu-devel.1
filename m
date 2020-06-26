Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F31C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 21:41:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 105EE2088E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 21:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="YCfEJs98"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 105EE2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jow6W-0007zt-7a
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 17:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jow5N-0006jO-Uy
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:40:38 -0400
Received: from mail-db8eur05on2124.outbound.protection.outlook.com
 ([40.107.20.124]:39136 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jow5L-0004FJ-Ta
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:40:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O48QQoM6pBYgCIB/pRKafHJrbMuF73PUbg7CgA8APoDnjkU0I3IUSSG0IXzNremfPZLxafRJet/xc39wnpH1MXtmvVmDRJXLpV0ZTW4PU/jmWqfqp/oTDQ23lAfBIv2s+smwn4Q1n37IOLhriim/ToYCRUXIP1YJCJFmQdi77udTdCfIf8UbMlQAiSNnQPRkcxc80atjYDjjAgOJrQto6h7otDgIufCEoZdz0zpCRolcJm/+kgDyn9kyJuGPgA3N/j+0wr07eEFkuTg17lCmE8ywoT5SULPl6Rfz/s6VYjrD/ZZ5ZVm5YXflpDRDT3qFdi8BSlXIUVQO1PlbSCgasQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54SWIRdOkKgujbox1T7bMQ48rABURJts6Zb88YDrn88=;
 b=KO/YwPJJVm4hP7HD/JCj29jElIXU84Wyiy55BwhD0mZmYhyWL7qGzqT38GFN5HD8UZKIhRwbRQK1684SUkU2b2/yjtXW/cM9Hb3KiKd5iYujqA+E13QCF4CVtYFyMtzk7ncHrXl89XfyDt4lSAx3ey0MlQ1BZ8sBGTfWAylg7uB8NAkN9z3mxaiv40GfwwFhojuLa2IhQBJ2BqJFsKnCco396oEr80AfkVkFlPiIQhdtc6FW1d2vWfWu270l9GQjsXV7sd8rbzbZewwKdkD1S1ZQ6RyIQPkcpyTx9pDn9UFLmeiyhMwKr5mbSaX9ybfrbutmjaORaLjhXLMjn1bQdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54SWIRdOkKgujbox1T7bMQ48rABURJts6Zb88YDrn88=;
 b=YCfEJs989vvRqYZkrvzhZDsIKRdpgkZ5KwCInj2ZLDPAJIlDevoUuTJN8OQj7dHW1m4sE1u++j6o78RZ9J2rD2dsbgRTui7JDLEZvIxP0IIgf0GlsNtfG91SkRVPmcWUp+dq2oWea6mApiRClaFh7rFchrTBlGqFD0k8WB0uuX4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB5234.eurprd03.prod.outlook.com (2603:10a6:20b:c3::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Fri, 26 Jun
 2020 21:39:58 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3131.021; Fri, 26 Jun 2020
 21:39:58 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] linux-user: Add strace support for printing arguments of
 truncate()/ftruncate() and getsid()
Date: Fri, 26 Jun 2020 23:39:35 +0200
Message-Id: <20200626213937.20333-2-Filip.Bozuta@syrmia.com>
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
 15.20.3131.20 via Frontend Transport; Fri, 26 Jun 2020 21:39:57 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [147.91.217.240]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37ab2a49-1e58-474a-374f-08d81a197925
X-MS-TrafficTypeDiagnostic: AM6PR03MB5234:
X-Microsoft-Antispam-PRVS: <AM6PR03MB5234FE44D5909062508C7551EB930@AM6PR03MB5234.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XZYQNJm4TC/3z8h97nfPNJd+IrDQCXsDe81CnGhioTwjBiQ7dpW7d0LSvcPtqwldLRhi1snh5vVjrNIxbKoFpqHTcXYvxbiUtYqMUwAvw9VhbzgQArTzB7wavvrIgLp75HiNuYIJQgIo+9NDuZpcyGpZD8AbpH7wG5djOvNdI0T5EDn4XYJHYhhbxOWZHKPtJMjkqTYnEF3bCk+KAn1Hbsm9ftCvqBT6FROmTsYa0MGkfQwtYzpKwdKyWgqO7x4GQwdVH4PeZF7aUZKh4Cv+MJ31hPr6f6gR8Ca8DP5pM1tGzGw8uFtWTs4jn3nbv6EHZ+GVwfedHI4J4+E/uXf19AshaE66zO9MYAvJXwjeKa/8FmjXByCsDqXEnRW6KNBt8shj5CHBgrUkanJugeraa0EXuASN6Ef2BYOhiTDqq2e5lTs/UJhK/OM0hAzGQAGQ4nMxwuBtMHlKsX1oSO7BWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39830400003)(376002)(346002)(396003)(136003)(366004)(4326008)(6666004)(6506007)(1076003)(508600001)(83380400001)(966005)(86362001)(6512007)(16526019)(186003)(6486002)(52116002)(316002)(6916009)(36756003)(2906002)(66476007)(66946007)(69590400007)(66556008)(8936002)(26005)(5660300002)(8676002)(2616005)(956004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: mFK/+SANpV8RVfGeHcuR4Y3gN9F9WGyQ3Lf/xj4kRJGCpkj/8vDnw/BXF0iRX/gs0yNx0jU9yct77d4/YfZi821tMcrOdcqsUkVzdOSPFj85tQHx4q0eab0eMavfW6qkvdXk1Ha2n8lKDvUhEUJ+1XUVzH0uDw7rwJMfj6S2FpJNB2BQ/SxDp2wxOhzOXAzpTdM7FDSVmXXAmVZzMXS4V4SRXfLmpoodtohpTkdPbXC6V55DfomB6LU/bgHfuKavGuX3O20hk1dPT7RmZZWlMlFpvuHrG1h12sxUCoQCMTQh/XZym/WvBW+7hRUkIWcbK7s6Pup30JjbQ7dwaLTSTRLdkODNH66Yy9aGt4LKAnzC/SvPDQcK345yBVMF93HhPXyrAiXJIGqYkiRkgjqg+L06iPRV7a1J6WZ0Xc1mEK4C6gcF8nhE7AkvSlgxyqWXeIw/f06CFKz6HKt4a876LJ0oqRbte1Mr1WPcpYgy3gc=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ab2a49-1e58-474a-374f-08d81a197925
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 21:39:58.3950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ocID57RBOpMXa8ttIWWisb7f74zxeFLpnAkJsBZQR0/r6tmhKkH9rPaPaFTPSd/xUKowqWRi+NNXM4q4Eec+0A==
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

    * truncate, ftruncate - truncate a file to a specified length

        int truncate(const char *path, off_t length)
        int ftruncate(int fd, off_t length)
        man page: https://man7.org/linux/man-pages/man2/truncate.2.html

    * getsid - get session ID

        pid_t getsid(pid_t pid)
        man page: https://man7.org/linux/man-pages/man2/getsid.2.html

Implementation notes:

    Syscalls truncate/truncate64 takes string as argument type and thus a
    separate print function "print_truncate/print_truncate64" is stated in
    file "strace.list". This function is defined and implemented in "strace.c"
    by using an existing function used to print string arguments: "print_string()".
    The other syscalls have only primitive argument types, so the rest of the
    implementation was handled by stating an appropriate printing format in file
    "strace.list".

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/strace.c    | 14 ++++++++++++++
 linux-user/strace.list | 10 +++++-----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 6044c66954..dccfbc46e9 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1925,6 +1925,20 @@ print_lseek(const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_truncate
+static void
+print_truncate(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_string(arg0, 0);
+    print_raw_param(TARGET_ABI_FMT_ld, arg1, 1);
+    print_syscall_epilogue(name);
+}
+#define print_truncate64     print_truncate
+#endif
+
 #if defined(TARGET_NR_socket)
 static void
 print_socket(const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 10e3e4a814..3b77b22daf 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -258,10 +258,10 @@
 { TARGET_NR_ftime, "ftime" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_ftruncate
-{ TARGET_NR_ftruncate, "ftruncate" , NULL, NULL, NULL },
+{ TARGET_NR_ftruncate, "ftruncate" , "%s(%d," TARGET_ABI_FMT_ld ")", NULL, NULL },
 #endif
 #ifdef TARGET_NR_ftruncate64
-{ TARGET_NR_ftruncate64, "ftruncate64" , NULL, NULL, NULL },
+{ TARGET_NR_ftruncate64, "ftruncate64" , "%s(%d," TARGET_ABI_FMT_ld ")", NULL, NULL },
 #endif
 #ifdef TARGET_NR_futex
 { TARGET_NR_futex, "futex" , NULL, print_futex, NULL },
@@ -372,7 +372,7 @@
 { TARGET_NR_getrusage, "getrusage" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_getsid
-{ TARGET_NR_getsid, "getsid" , NULL, NULL, NULL },
+{ TARGET_NR_getsid, "getsid" , "%s(%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_getsockname
 { TARGET_NR_getsockname, "getsockname" , NULL, NULL, NULL },
@@ -1534,10 +1534,10 @@
 { TARGET_NR_tkill, "tkill" , NULL, print_tkill, NULL },
 #endif
 #ifdef TARGET_NR_truncate
-{ TARGET_NR_truncate, "truncate" , NULL, NULL, NULL },
+{ TARGET_NR_truncate, "truncate" , NULL, print_truncate, NULL },
 #endif
 #ifdef TARGET_NR_truncate64
-{ TARGET_NR_truncate64, "truncate64" , NULL, NULL, NULL },
+{ TARGET_NR_truncate64, "truncate64" , NULL, print_truncate64, NULL },
 #endif
 #ifdef TARGET_NR_tuxcall
 { TARGET_NR_tuxcall, "tuxcall" , NULL, NULL, NULL },
-- 
2.17.1


