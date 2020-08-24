Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF06EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 22:32:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86F8A20656
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 22:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="NeZ6XY3H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F8A20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAL17-0006UV-SB
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 18:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1kAL0E-0005Go-LK
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 18:31:46 -0400
Received: from mail-eopbgr10128.outbound.protection.outlook.com
 ([40.107.1.128]:39578 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1kAL0B-0003by-G0
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 18:31:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJUC1yWNUbkCHX+Zwd5q7gljrCFEUqwzPxOjQVAquUWxPmHjPjkzh6BH9tRuqVKZ83TapAtLDDhvTHXQLrLIMnysOS6RtmdvpbSCnwQfib0iw7xG8jVIbl5fX5cxd8Q/ucRJ4zNoVcOVrERbFiMy+9WqTi2xiLVA/+NRorVEkhkH6KVlZKMm8GGHKrALo9SqUKs3quluP0zxniDmJzY1ceUSzt2kBR8xBf05R0AJNRLOXuFXCdEconP7u5XThLbqbJbNDbLYzY7OqmkCQMcdrIZTNSUCsJqnoPX1x4xs55huNd1w6PUVJmxMAtq0af39tL0eQaEC4n4mYKPERR6mKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpWUKwMHjkh1T/V+Ct2KD30TGl2imXue0l6/0vKi+pE=;
 b=U8Dd5nEVvXlw/KiFQ9Fq7ncTtxbP0lwe67QBx6u06xg+UxP47+ie48g9OFsJleD9MLQZ1jGPqDaUcXwFn5fmCxi4Hk+xUqqd3peCjH03dPrity8G9II4vwNr22u1kA8p6XmGp/LN23ivJUfMqS9ARZJsQCGiC7/wafSR95siUugy13frcxj0wnBCGMF6rZqFF8LGQIE6WdAstWb1F+nD8WD7siLg7vNqIyaEpaldB4zatC7ztVuQuKnZycENXyV6IhRb24opBeUAXK6xxQadtRxKAmPwPUtrT8ACctvzr9Ewfyv191BK5FDCOhcX3f9JFcJJrFt9GBwI3k4k/BsMZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpWUKwMHjkh1T/V+Ct2KD30TGl2imXue0l6/0vKi+pE=;
 b=NeZ6XY3H8tevdCcAcr08u+CpgvDF+F3YpAphDFDas6g6xuAK2/xbx5BBgjozT5t2J5blFp0xFJbv3XBSkxAfzgJKnhLAFAOisf6Tbn/W9ZYf3FKAl+Y1hMw0wMFaZPOT8bwbVywcUMNpy4Wy2Ccu/YR+NVDPOLz7Z/FeXzSIFDE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR03MB4575.eurprd03.prod.outlook.com (2603:10a6:803:59::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Mon, 24 Aug
 2020 22:31:07 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3261.026; Mon, 24 Aug 2020
 22:31:07 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] linux-user: Add support for utimensat_time64() and
 semtimedop_time64()
Date: Tue, 25 Aug 2020 00:30:50 +0200
Message-Id: <20200824223050.92032-3-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824223050.92032-1-Filip.Bozuta@syrmia.com>
References: <20200824223050.92032-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0070.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::34) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.235) by
 LO2P265CA0070.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:60::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25 via Frontend Transport; Mon, 24 Aug 2020 22:31:06 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.235]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d8ce107-ebd7-4380-f3cc-08d8487d645c
X-MS-TrafficTypeDiagnostic: VI1PR03MB4575:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR03MB4575B260735DEA08F54F4506EB560@VI1PR03MB4575.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +QT+H2LJxb20UUNOhgNula1/yfWzyQfjS21AgOanm5/CW6fISwraSwEWEiQFohA1FqI8ENjwk4Z7ws9YVlLOfe6RhJhkofDHQmjJJ9skJmlfJgEUY9qeL/WX1ySjX4SHqjBnmHkp6lPE4xqeEMZnF1Jam7Pjtn7YR9XWKTaE/w3rw8bqE1S7SW48aVxBgcxG92FuToQgBqiUnEYIe/OlvpChU7JMpgYQCtiiwubT4ekrWdWGRmWuWWHP3M9gxaRzS6R4FG81jqr/JLZjcUTJB0BvM/z8XQ2TpbY3e52jKuHE+3gE/p5nrdfpj8rQNRqYDvT7faobj55kW0AAQnSjsPON5NNZa2C/Jg9dI3x+3wYYLOj0NV46jC7mChGED5k1H/KXiiTvwUZXBeMWjQBVru8r70FZsnf4Vav5joPEUSSuzjwCSsPSfI1Ayh1HkUlrW8MnULM64dCyZjZKJP9Hng==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(136003)(346002)(366004)(396003)(39830400003)(6506007)(6486002)(6916009)(83380400001)(69590400007)(2906002)(956004)(8676002)(2616005)(8936002)(26005)(478600001)(36756003)(54906003)(316002)(966005)(66556008)(66946007)(186003)(16526019)(4326008)(66476007)(6666004)(1076003)(52116002)(86362001)(107886003)(6512007)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: qr7zUaRrpigeCv7aJQicGtssxw+sU60LfjLwGS4UCUdh2PjHKi1bS9GvGX/nwXQb7+DnwQYinszlH4s+9nUPBp9EuXk55cveJOLX1dO6VFQxBL1VFXCBWVxHp2iHLQI4l880dh+ZDk4TVvy0RRx3nvFnpKMRcH6XSOPBr9SpSQ9/27U07DfejLIEj0e3vIAHbIFJL1sW2KgZI05dq08HZty7WZvkki7lEGSHJ1cxDR6UWv/srEdg+IRF1tQ/7k8HF1DG7vkZReAd7Jkqy9q9QR1d1tZHKpreWIYPY5EXUAcPZELethlmEU0WUD8Z8rf+e2F7Hg3nfz0XoPurrk4Z/wJSENHgZ+cejx/tEhBZfVb1BAFxiPQGpOFIrTeMTVAZdI0O6VzLBiOSfQOVTJVr5uEA+IwOy3ez3y+o1fay59YWCYcQ7mShBgpHzc3MAy5p+9Nvzbo6ZP58Dz2rARduuhbSw1FOTDzlN4FUE84REo0+7wz01CkExBBgV/3/lGQJ6RnbeJGMpHoTX+RfG1qejZX8SzBGR0W/0foJMB0RN17OpRHYa9Haz+UgCY5cVNV33rNd0o4/fjuaO1pLjDyxy/fHohcLC9XmLkgx+zi8gHwrNJwXzVz6UCErpe8pCVEftic86UdfvZhWD0lDUaQ77A==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8ce107-ebd7-4380-f3cc-08d8487d645c
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 22:31:06.6479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltIOt99Xf2kfOBK9jif/xsQdS0b3eS2NNpOrvNiU5ldzKEkLOpyqS7ML1m8mHwElqEXpsgtjCZDphAc5WELGKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB4575
Received-SPF: pass client-ip=40.107.1.128;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 18:31:41
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Laurent Vivier <laurent@vivier.eu>, Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch introduces functionality for following time64 syscalls:

*utimensat_time64()

    int utimensat(int dirfd, const char *pathname,
                  const struct timespec times[2], int flags);
    -- change file timestamps with nanosecond precision --
    man page: https://man7.org/linux/man-pages/man2/utimensat.2.html

*semtimedop_time64()

    int semtimedop(int semid, struct sembuf *sops, size_t nsops,
                   const struct timespec *timeout);
    -- System V semaphore operations --
    man page: https://www.man7.org/linux/man-pages/man2/semtimedop.2.html

Implementation notes:

   Syscall 'utimensat_time64()' is implemented in similar way as its
   regular variants only difference being that time64 converting function
   is used to convert values of 'struct timespec' between host and target
   ('target_to_host_timespec64()').

   For syscall 'semtimedop_time64()' and additional argument is added
   in function 'do_semtimedop()' through which the aproppriate 'struct timespec'
   converting function is called (false for regular target_to_host_timespec()
   and true for target_to_host_timespec64()). For 'do_ipc()' a
   check was added as that additional argument: 'TARGET_ABI_BITS == 64'.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 60 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 10 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index fc6a6e32e4..4d460af744 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1253,7 +1253,8 @@ static inline abi_long target_to_host_timespec(struct timespec *host_ts,
 #endif
 
 #if defined(TARGET_NR_clock_settime64) || defined(TARGET_NR_futex_time64) || \
-    defined(TARGET_NR_pselect6_time64) || defined(TARGET_NR_ppoll_time64)
+    defined(TARGET_NR_pselect6_time64) || defined(TARGET_NR_ppoll_time64) || \
+    defined(TARGET_NR_utimensat_time64) || defined(TARGET_NR_semtimedop_time64)
 static inline abi_long target_to_host_timespec64(struct timespec *host_ts,
                                                  abi_ulong target_addr)
 {
@@ -4117,7 +4118,7 @@ static inline abi_long target_to_host_sembuf(struct sembuf *host_sembuf,
 }
 
 #if defined(TARGET_NR_ipc) || defined(TARGET_NR_semop) || \
-    defined(TARGET_NR_semtimedop)
+    defined(TARGET_NR_semtimedop) || defined(TARGET_NR_semtimedop_time64)
 
 /*
  * This macro is required to handle the s390 variants, which passes the
@@ -4134,7 +4135,7 @@ static inline abi_long target_to_host_sembuf(struct sembuf *host_sembuf,
 static inline abi_long do_semtimedop(int semid,
                                      abi_long ptr,
                                      unsigned nsops,
-                                     abi_long timeout)
+                                     abi_long timeout, bool time64)
 {
     struct sembuf sops[nsops];
     struct timespec ts, *pts = NULL;
@@ -4142,8 +4143,14 @@ static inline abi_long do_semtimedop(int semid,
 
     if (timeout) {
         pts = &ts;
-        if (target_to_host_timespec(pts, timeout)) {
-            return -TARGET_EFAULT;
+        if (time64) {
+            if (target_to_host_timespec64(pts, timeout)) {
+                return -TARGET_EFAULT;
+            }
+        } else {
+            if (target_to_host_timespec(pts, timeout)) {
+                return -TARGET_EFAULT;
+            }
         }
     }
 
@@ -4657,7 +4664,7 @@ static abi_long do_ipc(CPUArchState *cpu_env,
 
     switch (call) {
     case IPCOP_semop:
-        ret = do_semtimedop(first, ptr, second, 0);
+        ret = do_semtimedop(first, ptr, second, 0, false);
         break;
     case IPCOP_semtimedop:
     /*
@@ -4667,9 +4674,9 @@ static abi_long do_ipc(CPUArchState *cpu_env,
      * to a struct timespec where the generic variant uses fifth parameter.
      */
 #if defined(TARGET_S390X)
-        ret = do_semtimedop(first, ptr, second, third);
+        ret = do_semtimedop(first, ptr, second, third, TARGET_ABI_BITS == 64);
 #else
-        ret = do_semtimedop(first, ptr, second, fifth);
+        ret = do_semtimedop(first, ptr, second, fifth, TARGET_ABI_BITS == 64);
 #endif
         break;
 
@@ -9887,11 +9894,15 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_semop
     case TARGET_NR_semop:
-        return do_semtimedop(arg1, arg2, arg3, 0);
+        return do_semtimedop(arg1, arg2, arg3, 0, false);
 #endif
 #ifdef TARGET_NR_semtimedop
     case TARGET_NR_semtimedop:
-        return do_semtimedop(arg1, arg2, arg3, arg4);
+        return do_semtimedop(arg1, arg2, arg3, arg4, false);
+#endif
+#ifdef TARGET_NR_semtimedop_time64
+    case TARGET_NR_semtimedop_time64:
+        return do_semtimedop(arg1, arg2, arg3, arg4, true);
 #endif
 #ifdef TARGET_NR_semctl
     case TARGET_NR_semctl:
@@ -11938,6 +11949,35 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         }
         return ret;
 #endif
+#ifdef TARGET_NR_utimensat_time64
+    case TARGET_NR_utimensat_time64:
+        {
+            struct timespec *tsp, ts[2];
+            if (!arg3) {
+                tsp = NULL;
+            } else {
+                if (target_to_host_timespec64(ts, arg3)) {
+                    return -TARGET_EFAULT;
+                }
+                if (target_to_host_timespec64(ts + 1, arg3 +
+                                     sizeof(struct target__kernel_timespec))) {
+                    return -TARGET_EFAULT;
+                }
+                tsp = ts;
+            }
+            if (!arg2)
+                ret = get_errno(sys_utimensat(arg1, NULL, tsp, arg4));
+            else {
+                p = lock_user_string(arg2);
+                if (!p) {
+                    return -TARGET_EFAULT;
+                }
+                ret = get_errno(sys_utimensat(arg1, path(p), tsp, arg4));
+                unlock_user(p, arg2, 0);
+            }
+        }
+        return ret;
+#endif
 #ifdef TARGET_NR_futex
     case TARGET_NR_futex:
         return do_futex(arg1, arg2, arg3, arg4, arg5, arg6);
-- 
2.25.1


