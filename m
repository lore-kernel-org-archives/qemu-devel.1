Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAAEC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 22:47:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E26ED2072D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 22:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="P137ZK8U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26ED2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kALF2-00045X-6i
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 18:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1kALEG-0003eK-Ea
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 18:46:16 -0400
Received: from mail-eopbgr80129.outbound.protection.outlook.com
 ([40.107.8.129]:39006 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1kALED-00059D-JT
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 18:46:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUjZVXlZpN7kKtX4QfGuf3KiPiBXpp5FcwsZQLA9gZkuobe3X1w2n6epxjZx3tXFImNweb/yCpm5d5dSzA7NVs0PbFdiE/6c/OfyPYdx/Tf42ZscYfG3nWSivazAYQCjr/t4O5SXIYeJ1R8j82JtIFRcrQxLbpbjlr3H0BamthncuEnMfbwb5AbaSFww3OfJOCpiSVdnUgIY88+5xJGvjw9PRfGDSsxss9AJThjNZbUjR/8mhCFSU1wrU2+1NDksgjE8msLSyPQPEUme39I1ZFlUslZqZ4g8J0MnDasJMtf2LLbCN6iD/CU9OTcuUiMRFHNkAt7IgO6aGgnrpCsNtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6KIZ9ZswSBlb7850B30zD/evIRLg7FGhAxFrLSo7EE=;
 b=aNwk80pOKMXC7vybH2kO3F53znKMFjwuPUxn1P82/9a2Yp9UFjwmOYeJ6j9TB16vQUAAdEceEc5xaVQVkwgZF1wTtY+smLXcE+E1nLO9+fGIGXhqWT0nnZBoBKJnhrVWqviB/vKEK63jHavtnAlCQ4Dwr3hpuEOXcwRgZtKPugZAfZfFlz138ZtDze4M1iOzjARINaCHqAQtqcDzeAPwHujXw8w5SpVrwLsQjz3g861kjAws5ydsJmE7V3bZOxTbMCrtIm7YCoBYT3CHfwRrRQ31DyAM5J8WaWaHiEa4DJEX6qlrlxIYfTmvP4uW+2d8yEGtoypNJR1qsR2JhtLBNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6KIZ9ZswSBlb7850B30zD/evIRLg7FGhAxFrLSo7EE=;
 b=P137ZK8UBN16tkH5hq4eilTh7C8lT9Zh48vE8xzKndrV7N768PV3HA6Rn/3w14IeaqXwF4NjVSP4UHZb0GVvabMxEuyANtUKpJkVBulr2T2sBi+i+qhst06fVJ4pfons5DDbdRBG3XCacb5WHjWKfP0zT0vj3Rypr1E6RV3SctM=
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
Subject: [PATCH v2 1/2] linux-user: Add support for ppoll_time64() and
 pselect6_time64()
Date: Tue, 25 Aug 2020 00:30:49 +0200
Message-Id: <20200824223050.92032-2-Filip.Bozuta@syrmia.com>
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
 15.20.3305.25 via Frontend Transport; Mon, 24 Aug 2020 22:31:05 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.235]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8aab561a-66e9-49e1-ded9-08d8487d63da
X-MS-TrafficTypeDiagnostic: VI1PR03MB4575:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR03MB4575BED66892D934505A482AEB560@VI1PR03MB4575.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m27K21jh7hE57PBO2/YaSStZbiG76O5S4dbNHq4GpRsK8bzHRhrJuEdIqFbaTYbUUhdev8ZdCp1ED74/d98VmkN/K+KLjCh0UA88O7NazRU4+QF7sgMUEp6ojuZIY9vZJh78Vw6Jy0ZGlmm8OCR2gZZwMHuFWf25M9CrEcxcgjd06T6WdVaYzyAJVu3X4wpAPJfB7883iV0zzNozgwuFuiVdIrDEnKQVm4Soww2rgbeiVbgL/NCDofXvDP6l223wLddieaDIrAO98UhQKErakoTFakwpasIaCNRYDz8gyu2vIxoqeBOZFTsu/a7YUI+ndA/J9aTrT5b8O/4CC8uCNrSdUaBJFu+itFeYjOmqyrHtycvAjFUetgO6PerYFeud7SftUP7O6NdK+KL9Jek1mmawm+e/j07lTGNrWbYBjlD4FZHleQi11nF+Zv55nC9BfCY/yhbZaVi2uQsQF7NWJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(136003)(346002)(366004)(396003)(39830400003)(6506007)(6486002)(6916009)(83380400001)(69590400007)(2906002)(956004)(8676002)(2616005)(8936002)(26005)(478600001)(36756003)(54906003)(316002)(966005)(66556008)(66946007)(186003)(16526019)(4326008)(66476007)(6666004)(30864003)(1076003)(52116002)(86362001)(107886003)(6512007)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ncCiCLWTX7hm7g/satjPnyep61k4jLlG9xVy+xX8b6+rdxC/AgtJspaa7uXSh3C8X5A6eJiGfV059hdVk2yLTPb9Ex0E5T/0tTXaxRd1HdXlRJKw3LMsAkKyp6AOf8U96aBDtsK4BAsZWz2WUocJ6UvKkkLX87PEBZJ1w/rKs+X08HBkNlr7G3vdQyfqmTDl3My0Ib7aq/ENsfnF7B9fs1dYFOhJ/9LQNot30tCP6cKx8mcaYDsPQ9jHbg+Bywvj4FwKukyykkLnj3sS0YmfYAV4Igkh2fo3xqFUOEgM/Uqm9vaKt5Y7xZ1pkC4X7zPNX1BY4w6HwBx7l/otDImXYSQJ20eOyR6KrZmZVXiIJoK/CXaE9IqCifdQekNb863QBzl9tFltN3E9pirKK0Ohm1X8Xmo0nGlScgOpqQiw3vPd+Y9WwfCGbYRQsC6nB2ZDrii4//zp4XH0Q0XdN7sBi5PfSzMZrEDw0yY0cUAPj4NfCd5xwOXPMnyJzL8yeZTbHPTOLSLzZlk8vSAL4zefswbFWzX8IyUdSHhSmWy4HXV/FzEFCsSUCanojfJbK0H8kREs9VJpRzeqWJ5nAa5eqfkAgQsn8L9AJAyzzS+0y4Cvt3U0adP+BanDBY3wWUQK/6WeC85+hiMtO5SzPzMp1A==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aab561a-66e9-49e1-ded9-08d8487d63da
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 22:31:05.8973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zMFsi/6IJRajUpPexEw+8nu0JvsJdHEuAgHAJepgfwEw02mYIOB1NxCmQDl8MFyuE1QKwFGTXqMFls8haDugeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB4575
Received-SPF: pass client-ip=40.107.8.129;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 18:46:10
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
    This code was moved to new functions ('do_ppoll()' and 'do_pselect6()')
    that take a 'bool time64' from which a right 'struct timespec' converting
    function is called.
    (target_to_host/host_to_target_timespec() for regular and
     target_to_host/host_to_target_timespec64() for time64 variants)

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/syscall.c | 462 +++++++++++++++++++++++--------------------
 1 file changed, 251 insertions(+), 211 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1211e759c2..fc6a6e32e4 100644
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
@@ -1458,6 +1459,237 @@ static abi_long do_old_select(abi_ulong arg1)
 #endif
 #endif
 
+#if defined(TARGET_NR_pselect6) || defined(TARGET_NR_pselect6_time64)
+static abi_long do_pselect6(abi_long arg1, abi_long arg2, abi_long arg3,
+                            abi_long arg4, abi_long arg5, abi_long arg6,
+                            bool time64)
+{
+    abi_long rfd_addr, wfd_addr, efd_addr, n, ts_addr;
+    fd_set rfds, wfds, efds;
+    fd_set *rfds_ptr, *wfds_ptr, *efds_ptr;
+    struct timespec ts, *ts_ptr;
+    abi_long ret;
+
+    /*
+     * The 6th arg is actually two args smashed together,
+     * so we cannot use the C library.
+     */
+    sigset_t set;
+    struct {
+        sigset_t *set;
+        size_t size;
+    } sig, *sig_ptr;
+
+    abi_ulong arg_sigset, arg_sigsize, *arg7;
+    target_sigset_t *target_sigset;
+
+    n = arg1;
+    rfd_addr = arg2;
+    wfd_addr = arg3;
+    efd_addr = arg4;
+    ts_addr = arg5;
+
+    ret = copy_from_user_fdset_ptr(&rfds, &rfds_ptr, rfd_addr, n);
+    if (ret) {
+        return ret;
+    }
+    ret = copy_from_user_fdset_ptr(&wfds, &wfds_ptr, wfd_addr, n);
+    if (ret) {
+        return ret;
+    }
+    ret = copy_from_user_fdset_ptr(&efds, &efds_ptr, efd_addr, n);
+    if (ret) {
+        return ret;
+    }
+
+    /*
+     * This takes a timespec, and not a timeval, so we cannot
+     * use the do_select() helper ...
+     */
+    if (ts_addr) {
+        if (time64) {
+            if (target_to_host_timespec64(&ts, ts_addr)) {
+                return -TARGET_EFAULT;
+            }
+        } else {
+            if (target_to_host_timespec(&ts, ts_addr)) {
+                return -TARGET_EFAULT;
+            }
+        }
+            ts_ptr = &ts;
+    } else {
+        ts_ptr = NULL;
+    }
+
+    /* Extract the two packed args for the sigset */
+    if (arg6) {
+        sig_ptr = &sig;
+        sig.size = SIGSET_T_SIZE;
+
+        arg7 = lock_user(VERIFY_READ, arg6, sizeof(*arg7) * 2, 1);
+        if (!arg7) {
+            return -TARGET_EFAULT;
+        }
+        arg_sigset = tswapal(arg7[0]);
+        arg_sigsize = tswapal(arg7[1]);
+        unlock_user(arg7, arg6, 0);
+
+        if (arg_sigset) {
+            sig.set = &set;
+            if (arg_sigsize != sizeof(*target_sigset)) {
+                /* Like the kernel, we enforce correct size sigsets */
+                return -TARGET_EINVAL;
+            }
+            target_sigset = lock_user(VERIFY_READ, arg_sigset,
+                                      sizeof(*target_sigset), 1);
+            if (!target_sigset) {
+                return -TARGET_EFAULT;
+            }
+            target_to_host_sigset(&set, target_sigset);
+            unlock_user(target_sigset, arg_sigset, 0);
+        } else {
+            sig.set = NULL;
+        }
+    } else {
+        sig_ptr = NULL;
+    }
+
+    ret = get_errno(safe_pselect6(n, rfds_ptr, wfds_ptr, efds_ptr,
+                                  ts_ptr, sig_ptr));
+
+    if (!is_error(ret)) {
+        if (rfd_addr && copy_to_user_fdset(rfd_addr, &rfds, n)) {
+            return -TARGET_EFAULT;
+        }
+        if (wfd_addr && copy_to_user_fdset(wfd_addr, &wfds, n)) {
+            return -TARGET_EFAULT;
+        }
+        if (efd_addr && copy_to_user_fdset(efd_addr, &efds, n)) {
+            return -TARGET_EFAULT;
+        }
+        if (time64) {
+            if (ts_addr && host_to_target_timespec(ts_addr, &ts)) {
+                return -TARGET_EFAULT;
+            }
+        } else {
+            if (ts_addr && host_to_target_timespec64(ts_addr, &ts)) {
+                return -TARGET_EFAULT;
+            }
+        }
+    }
+    return ret;
+}
+#endif
+
+#if defined(TARGET_NR_poll) || defined(TARGET_NR_ppoll) || \
+    defined(TARGET_NR_ppoll_time64)
+static abi_long do_ppoll(abi_long arg1, abi_long arg2, abi_long arg3,
+                         abi_long arg4, abi_long arg5, bool ppoll, bool time64)
+{
+    struct target_pollfd *target_pfd;
+    unsigned int nfds = arg2;
+    struct pollfd *pfd;
+    unsigned int i;
+    abi_long ret;
+
+    pfd = NULL;
+    target_pfd = NULL;
+    if (nfds) {
+        if (nfds > (INT_MAX / sizeof(struct target_pollfd))) {
+            return -TARGET_EINVAL;
+        }
+        target_pfd = lock_user(VERIFY_WRITE, arg1,
+                               sizeof(struct target_pollfd) * nfds, 1);
+        if (!target_pfd) {
+            return -TARGET_EFAULT;
+        }
+
+        pfd = alloca(sizeof(struct pollfd) * nfds);
+        for (i = 0; i < nfds; i++) {
+            pfd[i].fd = tswap32(target_pfd[i].fd);
+            pfd[i].events = tswap16(target_pfd[i].events);
+        }
+    }
+    if (ppoll) {
+        struct timespec _timeout_ts, *timeout_ts = &_timeout_ts;
+        target_sigset_t *target_set;
+        sigset_t _set, *set = &_set;
+
+        if (arg3) {
+            if (time64) {
+                if (target_to_host_timespec64(timeout_ts, arg3)) {
+                    unlock_user(target_pfd, arg1, 0);
+                    return -TARGET_EFAULT;
+                }
+            } else {
+                if (target_to_host_timespec(timeout_ts, arg3)) {
+                    unlock_user(target_pfd, arg1, 0);
+                    return -TARGET_EFAULT;
+                }
+            }
+        } else {
+            timeout_ts = NULL;
+        }
+
+        if (arg4) {
+            if (arg5 != sizeof(target_sigset_t)) {
+                unlock_user(target_pfd, arg1, 0);
+                return -TARGET_EINVAL;
+            }
+
+            target_set = lock_user(VERIFY_READ, arg4,
+                                   sizeof(target_sigset_t), 1);
+            if (!target_set) {
+                unlock_user(target_pfd, arg1, 0);
+                return -TARGET_EFAULT;
+            }
+            target_to_host_sigset(set, target_set);
+        } else {
+            set = NULL;
+        }
+
+        ret = get_errno(safe_ppoll(pfd, nfds, timeout_ts,
+                                   set, SIGSET_T_SIZE));
+
+        if (!is_error(ret) && arg3) {
+            if (time64) {
+                if (host_to_target_timespec64(arg3, timeout_ts)) {
+                    return -TARGET_EFAULT;
+                }
+            } else {
+                if (host_to_target_timespec(arg3, timeout_ts)) {
+                    return -TARGET_EFAULT;
+                }
+            }
+        }
+        if (arg4) {
+            unlock_user(target_set, arg4, 0);
+        }
+    } else {
+          struct timespec ts, *pts;
+
+          if (arg3 >= 0) {
+              /* Convert ms to secs, ns */
+              ts.tv_sec = arg3 / 1000;
+              ts.tv_nsec = (arg3 % 1000) * 1000000LL;
+              pts = &ts;
+          } else {
+              /* -ve poll() timeout means "infinite" */
+              pts = NULL;
+          }
+          ret = get_errno(safe_ppoll(pfd, nfds, pts, NULL, 0));
+    }
+
+    if (!is_error(ret)) {
+        for (i = 0; i < nfds; i++) {
+            target_pfd[i].revents = tswap16(pfd[i].revents);
+        }
+    }
+    unlock_user(target_pfd, arg1, sizeof(struct target_pollfd) * nfds);
+    return ret;
+}
+#endif
+
 static abi_long do_pipe2(int host_pipe[], int flags)
 {
 #ifdef CONFIG_PIPE2
@@ -9045,106 +9277,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_pselect6
     case TARGET_NR_pselect6:
-        {
-            abi_long rfd_addr, wfd_addr, efd_addr, n, ts_addr;
-            fd_set rfds, wfds, efds;
-            fd_set *rfds_ptr, *wfds_ptr, *efds_ptr;
-            struct timespec ts, *ts_ptr;
-
-            /*
-             * The 6th arg is actually two args smashed together,
-             * so we cannot use the C library.
-             */
-            sigset_t set;
-            struct {
-                sigset_t *set;
-                size_t size;
-            } sig, *sig_ptr;
-
-            abi_ulong arg_sigset, arg_sigsize, *arg7;
-            target_sigset_t *target_sigset;
-
-            n = arg1;
-            rfd_addr = arg2;
-            wfd_addr = arg3;
-            efd_addr = arg4;
-            ts_addr = arg5;
-
-            ret = copy_from_user_fdset_ptr(&rfds, &rfds_ptr, rfd_addr, n);
-            if (ret) {
-                return ret;
-            }
-            ret = copy_from_user_fdset_ptr(&wfds, &wfds_ptr, wfd_addr, n);
-            if (ret) {
-                return ret;
-            }
-            ret = copy_from_user_fdset_ptr(&efds, &efds_ptr, efd_addr, n);
-            if (ret) {
-                return ret;
-            }
-
-            /*
-             * This takes a timespec, and not a timeval, so we cannot
-             * use the do_select() helper ...
-             */
-            if (ts_addr) {
-                if (target_to_host_timespec(&ts, ts_addr)) {
-                    return -TARGET_EFAULT;
-                }
-                ts_ptr = &ts;
-            } else {
-                ts_ptr = NULL;
-            }
-
-            /* Extract the two packed args for the sigset */
-            if (arg6) {
-                sig_ptr = &sig;
-                sig.size = SIGSET_T_SIZE;
-
-                arg7 = lock_user(VERIFY_READ, arg6, sizeof(*arg7) * 2, 1);
-                if (!arg7) {
-                    return -TARGET_EFAULT;
-                }
-                arg_sigset = tswapal(arg7[0]);
-                arg_sigsize = tswapal(arg7[1]);
-                unlock_user(arg7, arg6, 0);
-
-                if (arg_sigset) {
-                    sig.set = &set;
-                    if (arg_sigsize != sizeof(*target_sigset)) {
-                        /* Like the kernel, we enforce correct size sigsets */
-                        return -TARGET_EINVAL;
-                    }
-                    target_sigset = lock_user(VERIFY_READ, arg_sigset,
-                                              sizeof(*target_sigset), 1);
-                    if (!target_sigset) {
-                        return -TARGET_EFAULT;
-                    }
-                    target_to_host_sigset(&set, target_sigset);
-                    unlock_user(target_sigset, arg_sigset, 0);
-                } else {
-                    sig.set = NULL;
-                }
-            } else {
-                sig_ptr = NULL;
-            }
-
-            ret = get_errno(safe_pselect6(n, rfds_ptr, wfds_ptr, efds_ptr,
-                                          ts_ptr, sig_ptr));
-
-            if (!is_error(ret)) {
-                if (rfd_addr && copy_to_user_fdset(rfd_addr, &rfds, n))
-                    return -TARGET_EFAULT;
-                if (wfd_addr && copy_to_user_fdset(wfd_addr, &wfds, n))
-                    return -TARGET_EFAULT;
-                if (efd_addr && copy_to_user_fdset(efd_addr, &efds, n))
-                    return -TARGET_EFAULT;
-
-                if (ts_addr && host_to_target_timespec(ts_addr, &ts))
-                    return -TARGET_EFAULT;
-            }
-        }
-        return ret;
+        return do_pselect6(arg1, arg2, arg3, arg4, arg5, arg6, false);
+#endif
+#ifdef TARGET_NR_pselect6_time64
+    case TARGET_NR_pselect6_time64:
+        return do_pselect6(arg1, arg2, arg3, arg4, arg5, arg6, true);
 #endif
 #ifdef TARGET_NR_symlink
     case TARGET_NR_symlink:
@@ -10076,114 +10213,17 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR__newselect:
         return do_select(arg1, arg2, arg3, arg4, arg5);
 #endif
-#if defined(TARGET_NR_poll) || defined(TARGET_NR_ppoll)
-# ifdef TARGET_NR_poll
+#ifdef TARGET_NR_poll
     case TARGET_NR_poll:
-# endif
-# ifdef TARGET_NR_ppoll
+        return do_ppoll(arg1, arg2, arg3, arg4, arg5, false, false);
+#endif
+#ifdef TARGET_NR_ppoll
     case TARGET_NR_ppoll:
-# endif
-        {
-            struct target_pollfd *target_pfd;
-            unsigned int nfds = arg2;
-            struct pollfd *pfd;
-            unsigned int i;
-
-            pfd = NULL;
-            target_pfd = NULL;
-            if (nfds) {
-                if (nfds > (INT_MAX / sizeof(struct target_pollfd))) {
-                    return -TARGET_EINVAL;
-                }
-
-                target_pfd = lock_user(VERIFY_WRITE, arg1,
-                                       sizeof(struct target_pollfd) * nfds, 1);
-                if (!target_pfd) {
-                    return -TARGET_EFAULT;
-                }
-
-                pfd = alloca(sizeof(struct pollfd) * nfds);
-                for (i = 0; i < nfds; i++) {
-                    pfd[i].fd = tswap32(target_pfd[i].fd);
-                    pfd[i].events = tswap16(target_pfd[i].events);
-                }
-            }
-
-            switch (num) {
-# ifdef TARGET_NR_ppoll
-            case TARGET_NR_ppoll:
-            {
-                struct timespec _timeout_ts, *timeout_ts = &_timeout_ts;
-                target_sigset_t *target_set;
-                sigset_t _set, *set = &_set;
-
-                if (arg3) {
-                    if (target_to_host_timespec(timeout_ts, arg3)) {
-                        unlock_user(target_pfd, arg1, 0);
-                        return -TARGET_EFAULT;
-                    }
-                } else {
-                    timeout_ts = NULL;
-                }
-
-                if (arg4) {
-                    if (arg5 != sizeof(target_sigset_t)) {
-                        unlock_user(target_pfd, arg1, 0);
-                        return -TARGET_EINVAL;
-                    }
-
-                    target_set = lock_user(VERIFY_READ, arg4, sizeof(target_sigset_t), 1);
-                    if (!target_set) {
-                        unlock_user(target_pfd, arg1, 0);
-                        return -TARGET_EFAULT;
-                    }
-                    target_to_host_sigset(set, target_set);
-                } else {
-                    set = NULL;
-                }
-
-                ret = get_errno(safe_ppoll(pfd, nfds, timeout_ts,
-                                           set, SIGSET_T_SIZE));
-
-                if (!is_error(ret) && arg3) {
-                    host_to_target_timespec(arg3, timeout_ts);
-                }
-                if (arg4) {
-                    unlock_user(target_set, arg4, 0);
-                }
-                break;
-            }
-# endif
-# ifdef TARGET_NR_poll
-            case TARGET_NR_poll:
-            {
-                struct timespec ts, *pts;
-
-                if (arg3 >= 0) {
-                    /* Convert ms to secs, ns */
-                    ts.tv_sec = arg3 / 1000;
-                    ts.tv_nsec = (arg3 % 1000) * 1000000LL;
-                    pts = &ts;
-                } else {
-                    /* -ve poll() timeout means "infinite" */
-                    pts = NULL;
-                }
-                ret = get_errno(safe_ppoll(pfd, nfds, pts, NULL, 0));
-                break;
-            }
-# endif
-            default:
-                g_assert_not_reached();
-            }
-
-            if (!is_error(ret)) {
-                for(i = 0; i < nfds; i++) {
-                    target_pfd[i].revents = tswap16(pfd[i].revents);
-                }
-            }
-            unlock_user(target_pfd, arg1, sizeof(struct target_pollfd) * nfds);
-        }
-        return ret;
+        return do_ppoll(arg1, arg2, arg3, arg4, arg5, true, false);
+#endif
+#ifdef TARGET_NR_ppoll_time64
+    case TARGET_NR_ppoll_time64:
+        return do_ppoll(arg1, arg2, arg3, arg4, arg5, true, true);
 #endif
     case TARGET_NR_flock:
         /* NOTE: the flock constant seems to be the same for every
-- 
2.25.1


