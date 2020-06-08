Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D9AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:53:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F9472053B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="GfaPelR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9472053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiL1B-0006XJ-Ch
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jiKsv-0003QW-B6
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:44:29 -0400
Received: from mail-eopbgr80091.outbound.protection.outlook.com
 ([40.107.8.91]:62103 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jiKsu-0007Fd-Cz
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:44:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fI3Xh6hyoZ3ISiJvJ9FbMJu+6PdswVzgcGkvodZ7kH6UGYq7utW2E8lk7cVzr4keOr+eZ3he4q7esGY4h5dOaQF5UU75caVzpKxf7ckIdlNQp4O1UIYL9tDG1ksys6xxszLeCvZr/L2O+H4G2nQ5dNw0T64S0Q9qsgaKUvH8ob+VQc0uk2R4GxEu8OYL0EFgEB5jV/yn0jRX6NrMTUOCMc/UKhXddpHeNMan+XMHL9AYt9bpI/bKnna1cXoMcMYTNL1FDOEPLQ6sHjlBjDVuEejADSskovrS2YvQf9IiJYVGUnYC26VIM8j3j+/E3JDJVbdLINdkYecLeaacqL57lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLcPByuBr8OPi19Y7QYCB1y3yAJbPcWQt4AU+ZljE2U=;
 b=F/MUDOpXq5gV8Xfk8vEX0boIYrSbMr5ZT4+fy/Ez7c7zSbS0+d3QpWliq6OSTFxCqdKrTzFxerh6vMMh+8nhNS1EqXxbUYn+GKxutQV9A8vupDgdR5uK662RkUq6/0A4sCFqz36yaCpUyVN+boJHtbo3deJIHgIVLveo2HnJyYkfLzpOnZSbDzKJIPKaRB77BySfTLUMe5SIMWLwUXLg1jGx7oFsgLp/C/hgLcEymeNzz2PDMKTE+vSEySEzWBlnFK8kz8b63MZhGV/g/iA1+oHHM3czELKoqxvnu72zG8qS7iwHKDPkt+mettpoqg8DMlNOHlsNZqdWBvAMcLW3Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLcPByuBr8OPi19Y7QYCB1y3yAJbPcWQt4AU+ZljE2U=;
 b=GfaPelR8TRMo+B+4lwsAxuSqou40oMBhkfASxbwvPVpWvs4BPERe3ANXxrOBUsTkneVcxs9YLADBxamKaLk9Tm4LNTLK+qeFfHd9JDtmTGtZf+iBAWpW0GgUrUASGKBwCq5/SC3uo2NTXMiUVocqasrgzwtVU0SAric3C9A4ih8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB3798.eurprd03.prod.outlook.com (2603:10a6:20b:1f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Mon, 8 Jun
 2020 16:44:12 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 16:44:12 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/6] linux-user: Add strace support for printing arguments
 of lseek()
Date: Mon,  8 Jun 2020 18:43:55 +0200
Message-Id: <20200608164357.25065-5-filip.bozuta@syrmia.com>
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
 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 16:44:12 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce3a0c92-2bf1-4769-54cd-08d80bcb2c5b
X-MS-TrafficTypeDiagnostic: AM6PR03MB3798:
X-Microsoft-Antispam-PRVS: <AM6PR03MB37980BFD6133A1C0B63CFA9FEB850@AM6PR03MB3798.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p4SZxPf4Gw3Mvax1NbzpIlQGFIdDV8mUPsdD5Xke7WvelpqIKHr1vECdThU9ggJaID2Ol42bf1hjgFOUvXV4lVhXkmvZ64dQY+vrADLu/Atf/xv2kHKAQkUrHyL8QPeeaOTu7lO/QRcrm49uVhAMzZGj2BZbh98f/k/xPkCM+1ceqhvTeZyOUVqYK4nmVt5VGF9731jLKcqKlrBJELkxWBxgVIlHacsRpt9cBy1FUF7hw/hnlszurrzXvuzsVEC38l/WwusL4HZsesDjyDGjMcd1AFeeuFTrogUoNAqFC0Iyb9AVKJXuuZNNY55ViahEvqh3nidrC4iU2bmaZaQ8JZqRgxxQNLVhB6isXKoYh2KKASBGSxByTDy12XuzYcAuaVjGjRmMM8K8wu36xGyvhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39830400003)(376002)(396003)(346002)(136003)(366004)(508600001)(4326008)(8676002)(8936002)(966005)(1076003)(66556008)(6916009)(66476007)(5660300002)(66946007)(86362001)(316002)(36756003)(16526019)(26005)(2906002)(52116002)(83380400001)(2616005)(956004)(44832011)(6486002)(7696005)(186003)(6666004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: NDHw0P9Df667kd+KZUrwXHQL/e5sF8eVEBXz616Ae8LBJUKUz/jdiWZrTW+bm34LqI+behbFBLs70fPEWhxx0pPIkPXYW1kEmoWDAOlcWbOpDJZ1FKf3iLt0VZ8FuCJ8n7UT2yh5lR6jj48tSFOJJxSPfmpza8hmWTg50aKsWHjAwAf8mpT3LUd9q4fQVT+irxq7q6al4M4b1xCo1JZq91NQCU19xEgsqhbisciF9BN0/sVMaokx6KFOo+keol7cz2Q2OvKSiG91HQFWVLmEVgyN1WMlUBePN4ep+95N4PnvrxsGWe6W34ugGo5iGarQ0O7tHh6wxGjVh3M5NUZY92bkQt+5yYx0K9Jfi9RR+Ry03On9yLaHQu1sKAhIgnCru1Z1YxVX2N/oTBz2pW+OlvsuR7g9dfr2SuLyJ2ow+XdDYMQT+Vv4KkdoAVCSekhsiWsTxJFA+Z8L5n5xK+47IzJDT1cMmjUIn2bL7xlJoOQ=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce3a0c92-2bf1-4769-54cd-08d80bcb2c5b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 16:44:12.5103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7GQmalTyunWEt/vJ/cYs9SkWYKetSINT/9LDTIkbnp0L0wWMBT0/UpcIcJ9/8lIurLJghObYu5q7vwZ0uA5t1w==
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

This patch implements strace argument printing functionality for syscall:

    *lseek - reposition read/write file offset

         off_t lseek(int fd, off_t offset, int whence)
         man page: https://www.man7.org/linux/man-pages/man2/lseek.2.html

Implementation notes:

    The syscall's third argument "whence" has predefined values:
    "SEEK_SET","SEEK_CUR","SEEK_END","SEEK_DATA","SEEK_HOLE"
    and thus a separate printing function "print_lseek" was stated
    in file "strace.list". This function is defined in "strace.c"
    by using an existing function "print_raw_param()" to print
    the first and second argument and a switch(case) statement
    for the predefined values of the third argument.
    Values "SEEK_DATA" and "SEEK_HOLE" are defined in kernel version 3.1.
    That is the reason why case statements for these values are
    enwrapped in #ifdef directive.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/strace.c    | 31 +++++++++++++++++++++++++++++++
 linux-user/strace.list |  2 +-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 59fdb0a05f..adf9a47465 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1842,6 +1842,37 @@ print__llseek(const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_lseek
+static void
+print_lseek(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_raw_param("%d", arg0, 0);
+    print_raw_param(TARGET_ABI_FMT_ld, arg1, 0);
+    switch (arg2) {
+    case SEEK_SET:
+        qemu_log("SEEK_SET"); break;
+    case SEEK_CUR:
+        qemu_log("SEEK_CUR"); break;
+    case SEEK_END:
+        qemu_log("SEEK_END"); break;
+#ifdef SEEK_DATA
+    case SEEK_DATA:
+        qemu_log("SEEK_DATA"); break;
+#endif
+#ifdef SEEK_HOLE
+    case SEEK_HOLE:
+        qemu_log("SEEK_HOLE"); break;
+#endif
+    default:
+        print_raw_param("%#x", arg2, 1);
+    }
+    print_syscall_epilogue(name);
+}
+#endif
+
 #if defined(TARGET_NR_socket)
 static void
 print_socket(const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 05a72370c1..bd04596c50 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -516,7 +516,7 @@
 { TARGET_NR_lremovexattr, "lremovexattr" , NULL, print_lremovexattr, NULL },
 #endif
 #ifdef TARGET_NR_lseek
-{ TARGET_NR_lseek, "lseek" , NULL, NULL, NULL },
+{ TARGET_NR_lseek, "lseek" , NULL, print_lseek, NULL },
 #endif
 #ifdef TARGET_NR_lsetxattr
 { TARGET_NR_lsetxattr, "lsetxattr" , NULL, NULL, NULL },
-- 
2.17.1


