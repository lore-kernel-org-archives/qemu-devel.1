Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D966C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 13:58:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36577206B2
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 13:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="tJ9fFueF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36577206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5rH8-0001jC-FK
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 09:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k5rGP-0000wu-3M
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 09:57:57 -0400
Received: from mail-eopbgr80112.outbound.protection.outlook.com
 ([40.107.8.112]:43264 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k5rGM-0007KP-OA
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 09:57:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3gNQWtUzc1oYlB92H0yDq4KD7b/JBgGznZ4SEcP+iuTBjyhIV+h2zVrhrNLJoyUIwaswguY/gf44+71KvLE1OTTG0FrDczfuahp/xS31ltry97KMFboduhwv2BELssKgOv/YL3SrqofDg1VNRPc/Ft3vVhInOqUalWh5i9536fwSTtae5n9Hs8R1f/1sbtog2X/5MZqIeIMxJ/PDxRJxvIveIg/O63JctPojRoGpUDUxIiSh/eqXvP2Op1jAMMCw8lpBUHICAJYllU1oOMnUlQ8onOrgk1DEXXcOTFvFhTnSpQavimrW08DcBOJq7/IMyTUvhFFswwtW8ciieVgwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBt+LLF1Q7yg/tD4FIKHbIf3GeErDHR6nQfQxhRgU1Q=;
 b=oLNHP5T6YIMI8z0Iye+zcAMCDLiDujSdIeQHcN+9CEvFU+YBD3xnHMyGFHiYskT5L2rfLg/vaUuVkL6PmJOXiOL18qcrD4BYMplDib7FfEgBkDUwWZM8yJowl3qiha3x/isyseJQJ0vfucDz67Fs087Av/kJT9tVjD7ioBzYvXfobV4ciRlRluago7GjH/eDlII00O7UnTu2cj/StRFaDbrcN3ZSnDae2N6553trRF8rTSLd2wxbo6LdWRhIzOnJvbKd3Lg7qno5uEIXT19m3ZP3J0TGi87VVZtljHEMCrMDi5IlzrBKXEwYD6OrpEfwXoFA0g/M60ssjLOqDCIN4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBt+LLF1Q7yg/tD4FIKHbIf3GeErDHR6nQfQxhRgU1Q=;
 b=tJ9fFueF0JQCNwl8kFF1DMq6OAoOTCiDZVQmr79XqhAG0JqZA3n2gRwgdMpeHCoJNFNKNwav0TQyzNoY8GVPGKczbvyeSI5V8RAn4nqUbTkoKdoiBHQ6jcvhNpctl5qVzs7oNd/dQsb46sXOVhDsBz15yQiD8euhiFoR8cuDbZs=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR03MB4928.eurprd03.prod.outlook.com (2603:10a6:803:b6::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20; Wed, 12 Aug
 2020 13:57:18 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3261.024; Wed, 12 Aug 2020
 13:57:18 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] linux-user: Add support for 'ppoll_time64()' and
 'pselect6_time64()'
Date: Wed, 12 Aug 2020 15:57:02 +0200
Message-Id: <20200812135703.39404-2-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200812135703.39404-1-Filip.Bozuta@syrmia.com>
References: <20200812135703.39404-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVAP278CA0011.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::21) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.238) by
 GVAP278CA0011.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:20::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Wed, 12 Aug 2020 13:57:18 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.238]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02fea6d4-3ada-4ba0-2349-08d83ec7a089
X-MS-TrafficTypeDiagnostic: VI1PR03MB4928:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR03MB492850D0D9CCD3431C7197C4EB420@VI1PR03MB4928.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QDgxGWhj9hPUOlryD23PJAsyAx1uUAgzEu56J1aWJ/yVcDkqLkS7QcHrd9oCSbaLvyjBzzyFQMvw1SVR83FBzEE04cM43A3JIuwLmJxSNFNURph9pchYY0/peEOUDDdqt6rgqhiH9XKRo7ZVkzs23FDTlezH7E1uhpTf/ZaZ84HH5tztekK+gSa7jcIwNB4aDTEGkKAra5y6rZVV57Kq5XchCDEcWHXV3oTl4VCXSx+ASIDD01foPv+W75qWZtYvFTRK40kJq6BKY1CYwmBCeK2FRFIPGdAw8wsI6tXtc3ErL5ey4OgaL4kbzrRhsBG3x0yRLcbX6argkS8scPmZci2sG4jysGBPE3AysfpYVG9YkugZipwEJ3eAK0iF3KEYEA5PMmrmss1zg5bNIySK+PHaG/ejtSL0TDeXaNHCKeBq3OzRjX2pf3+ymLzhbOShMhSYLV7NUuDP6VWWeJX6+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(376002)(136003)(39830400003)(346002)(366004)(107886003)(36756003)(1076003)(6506007)(966005)(5660300002)(956004)(6486002)(6666004)(6512007)(6916009)(54906003)(86362001)(66476007)(26005)(52116002)(8676002)(66556008)(66946007)(2906002)(508600001)(316002)(8936002)(16526019)(186003)(69590400007)(4326008)(2616005)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: +KTLzsaSjjouhHvn3FXgcnO12qKLnR6nhxlnY2lCqz9slmid1kq7boEY5lzAipkqUO7COG+Een84Cyk6QNKutyo/FWhLjfdZxBrmnGdlyQZcP/EKsselQrloSYoBG2oSLJEbKZ91eYCyb3eIGDlMmkbH8SiMpzCtOtgyevqUvNfH4/LYMMQCPhTGy8YL3Rppd2TN3qH8pPlc8lYkqV1I0Z15jdZedBstTJLBRYJ3bBPd8/MOGCpk323U0DQfcUbYpxolem7Yuy8jOUcgTWwwXM8Xb+ACaowJYahuZyDdCL8iiG35gtHBspj6qLGdfinWYhSIPf3wfaDt0++EUX53IWa8v3xhfbQgKF7xrvFrZpNMcS9cm2gIzpXvH6x1omNu4x0Mx6qkowyXIsThHllN2AzqtficqVu0qJu1AIgPlN606XJmQl4kqUgb5aPxEt9h3O2kcRyKwGTajULLu/0y46PQnziTm5whdsCcoEhq7MQbdnWSKdZQFnYxiX3DxWmsdQLNRjzPgqe5b9V8uagxYtlRbcRD96Y7gGlqRh4mXGaJYKixSdhKO9o1cZprlLzUmrcF8BlL5Bg8RB/Z5Hy5zp+crTNfuQlQb/FmBgBAlhfv7CMhjxZVstXFnjibaAmcRSgwe7426DNrKC8XUfTRQw==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fea6d4-3ada-4ba0-2349-08d83ec7a089
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2020 13:57:18.7630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLzqxTOeAKh13T+F3Ybbunt/GezR0JgEkDrJvPDZdPlHsdeulFNY2XEbNPaa49tiSlS5k4ujuMt1Oe3E5h7VFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB4928
Received-SPF: pass client-ip=40.107.8.112;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 09:57:53
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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

*ppoll_time64

    This is a year 2038 safe variant of:

    int poll(struct pollfd *fds, nfds_t nfds, int timeout)
    -- wait for some event on a file descriptor --
    man page: https://man7.org/linux/man-pages/man2/ppoll.2.html

*pselect6_time64

    This is a year 2038 safe variant of:

    int pselect6(int nfds, fd_set *readfds, fd_set *writefds,
                 fd_set *exceptfds, const struct timespec *timeout,
                 const sigset_t *sigmask);
    -- synchronous I/O multiplexing --
    man page: https://man7.org/linux/man-pages/man2/pselect6.2.html

Implementation notes:

    Year 2038 safe syscalls in this patch were implemented
    with the same code as their regular variants (ppoll() and pselect()).
    A switch/case statement was used to call an apropriate converting
    function for 'struct timespec' between target and host.
    (target_to_host/host_to_target_timespec() for regular and
     target_to_host/host_to_target_timespec64() for time64 variants)

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/syscall.c | 101 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 86 insertions(+), 15 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1211e759c2..8f63a46f58 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -397,7 +397,7 @@ static int sys_getcwd1(char *buf, size_t size)
   return strlen(buf)+1;
 }
 
-#ifdef TARGET_NR_utimensat
+#if defined(TARGET_NR_utimensat)
 #if defined(__NR_utimensat)
 #define __NR_sys_utimensat __NR_utimensat
 _syscall4(int,sys_utimensat,int,dirfd,const char *,pathname,
@@ -763,11 +763,11 @@ safe_syscall5(int, waitid, idtype_t, idtype, id_t, id, siginfo_t *, infop, \
               int, options, struct rusage *, rusage)
 safe_syscall3(int, execve, const char *, filename, char **, argv, char **, envp)
 #if defined(TARGET_NR_select) || defined(TARGET_NR__newselect) || \
-    defined(TARGET_NR_pselect6)
+    defined(TARGET_NR_pselect6) || defined(TARGET_NR_pselect6_time64)
 safe_syscall6(int, pselect6, int, nfds, fd_set *, readfds, fd_set *, writefds, \
               fd_set *, exceptfds, struct timespec *, timeout, void *, sig)
 #endif
-#if defined(TARGET_NR_ppoll) || defined(TARGET_NR_poll)
+#if defined(TARGET_NR_ppoll) || defined(TARGET_NR_ppoll_time64)
 safe_syscall5(int, ppoll, struct pollfd *, ufds, unsigned int, nfds,
               struct timespec *, tsp, const sigset_t *, sigmask,
               size_t, sigsetsize)
@@ -984,7 +984,7 @@ abi_long do_brk(abi_ulong new_brk)
 }
 
 #if defined(TARGET_NR_select) || defined(TARGET_NR__newselect) || \
-    defined(TARGET_NR_pselect6)
+    defined(TARGET_NR_pselect6) || defined(TARGET_NR_pselect6_time64)
 static inline abi_long copy_from_user_fdset(fd_set *fds,
                                             abi_ulong target_fds_addr,
                                             int n)
@@ -1252,7 +1252,8 @@ static inline abi_long target_to_host_timespec(struct timespec *host_ts,
 }
 #endif
 
-#if defined(TARGET_NR_clock_settime64) || defined(TARGET_NR_futex_time64)
+#if defined(TARGET_NR_clock_settime64) || defined(TARGET_NR_futex_time64) || \
+    defined(TARGET_NR_pselect6_time64) || defined(TARGET_NR_ppoll_time64)
 static inline abi_long target_to_host_timespec64(struct timespec *host_ts,
                                                  abi_ulong target_addr)
 {
@@ -9043,8 +9044,13 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
         return ret;
 #endif
+#if defined(TARGET_NR_pselect6) || defined(TARGET_NR_pselect6_time64)
 #ifdef TARGET_NR_pselect6
     case TARGET_NR_pselect6:
+#endif
+#ifdef TARGET_NR_pselect6_time64
+    case TARGET_NR_pselect6_time64:
+#endif
         {
             abi_long rfd_addr, wfd_addr, efd_addr, n, ts_addr;
             fd_set rfds, wfds, efds;
@@ -9088,8 +9094,21 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
              * use the do_select() helper ...
              */
             if (ts_addr) {
-                if (target_to_host_timespec(&ts, ts_addr)) {
-                    return -TARGET_EFAULT;
+                switch (num) {
+#ifdef TARGET_NR_pselect6
+                case TARGET_NR_pselect6:
+                    if (target_to_host_timespec(&ts, ts_addr)) {
+                        return -TARGET_EFAULT;
+                    }
+                    break;
+#endif
+#ifdef TARGET_NR_pselect6_time64
+                case TARGET_NR_pselect6_time64:
+                    if (target_to_host_timespec64(&ts, ts_addr)) {
+                        return -TARGET_EFAULT;
+                    }
+                    break;
+#endif
                 }
                 ts_ptr = &ts;
             } else {
@@ -9140,8 +9159,22 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 if (efd_addr && copy_to_user_fdset(efd_addr, &efds, n))
                     return -TARGET_EFAULT;
 
-                if (ts_addr && host_to_target_timespec(ts_addr, &ts))
-                    return -TARGET_EFAULT;
+                switch (num) {
+#ifdef TARGET_NR_pselect6
+                case TARGET_NR_pselect6:
+                    if (ts_addr && host_to_target_timespec(ts_addr, &ts)) {
+                        return -TARGET_EFAULT;
+                    }
+                break;
+#endif
+#ifdef TARGET_NR_pselect6_time64
+                case TARGET_NR_pselect6_time64:
+                    if (ts_addr && host_to_target_timespec64(ts_addr, &ts)) {
+                        return -TARGET_EFAULT;
+                    }
+                break;
+#endif
+                }
             }
         }
         return ret;
@@ -10076,12 +10109,16 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR__newselect:
         return do_select(arg1, arg2, arg3, arg4, arg5);
 #endif
-#if defined(TARGET_NR_poll) || defined(TARGET_NR_ppoll)
+#if defined(TARGET_NR_poll) || defined(TARGET_NR_ppoll) || \
+    defined(TARGET_NR_ppoll_time64)
 # ifdef TARGET_NR_poll
     case TARGET_NR_poll:
 # endif
 # ifdef TARGET_NR_ppoll
     case TARGET_NR_ppoll:
+# endif
+# ifdef TARGET_NR_ppoll_time64
+    case TARGET_NR_ppoll_time64:
 # endif
         {
             struct target_pollfd *target_pfd;
@@ -10110,17 +10147,38 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
 
             switch (num) {
-# ifdef TARGET_NR_ppoll
+#if defined(TARGET_NR_ppoll) || defined(TARGET_NR_ppoll_time64)
+#ifdef TARGET_NR_ppoll
             case TARGET_NR_ppoll:
+#endif
+#ifdef TARGET_NR_ppoll_time64
+            case TARGET_NR_ppoll_time64:
+#endif
             {
                 struct timespec _timeout_ts, *timeout_ts = &_timeout_ts;
                 target_sigset_t *target_set;
                 sigset_t _set, *set = &_set;
 
                 if (arg3) {
-                    if (target_to_host_timespec(timeout_ts, arg3)) {
-                        unlock_user(target_pfd, arg1, 0);
-                        return -TARGET_EFAULT;
+                    switch (num) {
+#ifdef TARGET_NR_ppoll
+                    case TARGET_NR_ppoll:
+                        if (target_to_host_timespec(timeout_ts, arg3)) {
+                            unlock_user(target_pfd, arg1, 0);
+                            return -TARGET_EFAULT;
+                        }
+                    break;
+#endif
+#ifdef TARGET_NR_ppoll_time64
+                    case TARGET_NR_ppoll_time64:
+                        if (target_to_host_timespec64(timeout_ts, arg3)) {
+                            unlock_user(target_pfd, arg1, 0);
+                            return -TARGET_EFAULT;
+                        }
+                    break;
+#endif
+                    default:
+                        g_assert_not_reached();
                     }
                 } else {
                     timeout_ts = NULL;
@@ -10146,7 +10204,20 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                                            set, SIGSET_T_SIZE));
 
                 if (!is_error(ret) && arg3) {
-                    host_to_target_timespec(arg3, timeout_ts);
+                    switch (num) {
+#ifdef TARGET_NR_ppoll
+                    case TARGET_NR_ppoll:
+                        host_to_target_timespec(arg3, timeout_ts);
+                        break;
+#endif
+#ifdef TARGET_NR_ppoll_time64
+                    case TARGET_NR_ppoll_time64:
+                        host_to_target_timespec64(arg3, timeout_ts);
+                        break;
+#endif
+                    default:
+                        g_assert_not_reached();
+                    }
                 }
                 if (arg4) {
                     unlock_user(target_set, arg4, 0);
-- 
2.25.1


