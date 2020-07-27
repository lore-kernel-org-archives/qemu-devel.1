Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29361C433EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 11:24:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D78C6206E7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 11:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="YAu2DaQ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78C6206E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k01F2-0005g3-3v
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 07:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k01E7-0004dE-SR
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 07:23:27 -0400
Received: from mail-db8eur05on2106.outbound.protection.outlook.com
 ([40.107.20.106]:9642 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k01E6-0007B7-0b
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 07:23:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CArXI7ATajEBLc9LYEmQBo5pTxw6A3ZqYyHYa4JrftzcAxzkneSsTXVNMBZXFMIQotOck4BYesoqCTJ+yG06nGeH+XJ4U5N3Y9Pj+kYx9lAPmFLTGyHDCVnw/TdmP7hNZfOyWGsp0J7kvHdfl5Sgkdkdwrf+uJs1tqhAKabmkNmxHCxeSJZtIBmtYgePgrv8t1JBWIChgcK+2Tvber1ZUHG7BWMK4wgf0WqiD6aoSOeTZExK3qoQwgB2ldKcwGnnDpolWwgC0FH54+PO8Mq6SFfG1mDTW/a2EWWD/oUFy8NWRRpR0kKnnDZtwsACRbsZZM8szyjMCMLyR+O16kCQeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6x0g+81w2F6rdGWsurgXe0WoM6L12c4IR+vMV6zrnUM=;
 b=HHioe4IpJ6RRFt0ILwLVf/Z4alPv6BGgSDmteq1j1jLN02NZaWOZFN7Ie/OrS1KdiM6/idJHp0kOA4FhHHmMgOOYh76cuzjjQxqCbz9ierOHIa45rteHJUUbH7dyXtOd+CSicGDrgI8qojzoJ8ut93J5wXk08xhoYqLeLuj1ZGB+kZonYvgryFJLnhZGE2Z4aXYlvGfLl3A+qZCFNSobubIgAKD0RffwFU0xMj/MGAfilO1iUTqb1gq7mWvgRBjsnET69koRmgI9HAbd9M3Kt35Pp7gnbMPNaaYSSvPVu/ZKW7z3ht++3BrMQDr69kq6To1k9w0V7pX27XZthCDwZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6x0g+81w2F6rdGWsurgXe0WoM6L12c4IR+vMV6zrnUM=;
 b=YAu2DaQ9rFEzULo2ZcQrgzKoI/j5a4CKC8gMICk/Dz1WZg4GQq/npeNE3gVcxWrKytOwNKy8XqBXGZTvz/Y1XdjNMGC2V7ZThPKrMAiWTdeMaQ2R2OBkd/BGidic4ihpC+K95GMpabXKSGbzqEybS6a/8YCSWLFgHbRsy4yhCbg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB3509.eurprd03.prod.outlook.com (2603:10a6:209:2f::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Mon, 27 Jul
 2020 11:23:21 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 11:23:21 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] linux-user: Add support for two
 'clock_nanosleep_time64()' and 'clock_adjtime64()'
Date: Mon, 27 Jul 2020 13:23:06 +0200
Message-Id: <20200727112307.343608-2-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200727112307.343608-1-Filip.Bozuta@syrmia.com>
References: <20200727112307.343608-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0039.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::8) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.240) by
 ZR0P278CA0039.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.20 via Frontend Transport; Mon, 27 Jul 2020 11:23:21 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.240]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b142b171-8010-440c-ce01-08d8321f7845
X-MS-TrafficTypeDiagnostic: AM6PR03MB3509:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR03MB350981D56325451F2661E84BEB720@AM6PR03MB3509.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WDepHQudYyMIFla7EQ466KBkMjLb/QLOqM/xBgp1teqdu0HkkB3WdJJaU5lVEgcS/IBdtB1irtdT/VvM2hG/ApHHtJla0qzaDZZiicM3J9he7IxD7mXO22SIkt7NskgZIAwQE3FJofsBPkskobgGb2I+lCVoyPPWu/ew3RDm2jQoWG6bZf7KsrDENRE1Z/hryEzZ4xIYfMpn6LcH1PbILHmLXUUtb//jS+FTcMbYUbiTiW5u9loUKXJlS9VIADq0ZK0Cng/MDj0adWZby0LbLG05R5GvzdyZbREuacMguMqHyJ0tp+m4fTwYseCZFAKH0g/dYsGrj9VuE2F4IYWeKlGrhpyIokpbI3cmHSk4l3bwFQiZDJ+AozZrLB94nkPKYVVbGolKG+zKxplcc7nMNr8cE2pCTzMGVPnD5EAAjCJHE2gw+MUgq+VojRHg1+xgHAJbBlshIEzKpcQgWwaOqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(376002)(396003)(366004)(39830400003)(346002)(6506007)(83380400001)(107886003)(8936002)(86362001)(69590400007)(66476007)(966005)(8676002)(52116002)(66556008)(36756003)(6486002)(5660300002)(1076003)(956004)(2616005)(508600001)(6916009)(26005)(316002)(4326008)(186003)(2906002)(6512007)(16526019)(66946007)(6666004)(54906003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 7BCo2epg4d+XcKL35aPG3X9KSmOGNJBOlwKHsGhnmYZRuRTMfVvgzonxEzS9yAoiEibLRN4RT73aMNEu5I0GqsgrsrO9j809GNorL5Boh1EUexqt2l8EOcK/VZx8bR3pRMkn3QrVJprrTv0DZWXqteaG8uvIySXqjiQBtQWUsoBP+icKgQsD5LcZm7AAKzAMBD2yC0koOqfmxzo/ZwCOtg9Qe1iTpMrEpohSO45nP5dHrtzah0RjqDin8D78iGE550bCJqY59VtgjFf8V3r56uC0u3b6SNR0cTbS9N8tO36i/oNkdvSls6/HHkt1gliMMe6e5xo0rYpeQ1Z4+WIq5Mm/6qegYBU3J9njxeMYmHHQVWcSer0m/H0zWs5uFY+1ftgXRBKc9Uyhdn8muxFeyy/9/R0lcl8h7boRS05UNt42FpmWOX2/m/BbpQ6mZ7dAcVVDWfoP34JeY205Uw2yLwnhNvoC1rAIZLJNIcxEEr4=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b142b171-8010-440c-ce01-08d8321f7845
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 11:23:21.8679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k8hII7Bp5TzkDhuumtRIbGdRBP/YutcovJOoVwTWyvoADoWKYuO3b57MC17IvQhreWbPgi8xypFWnfb3OHqV3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB3509
Received-SPF: pass client-ip=40.107.20.106;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 07:23:22
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch implements functionality for following time64 syscall:

*clock_nanosleep_time64()

    This is a year 2038 safe vairant of syscall:
    int clock_nanosleep(clockid_t clockid, int flags,
                        const struct timespec *request,
                        struct timespec *remain)
    --high-resolution sleep with specifiable clock--
    man page: https://man7.org/linux/man-pages/man2/clock_nanosleep.2.html

*clock_adjtime64()

    This is a year 2038 safe variant of syscall:
    int clock_adjtime(clockid_t clk_id, struct timex *buf)
    --tune kernel clock--
    man page: https://man7.org/linux/man-pages/man2/clock_adjtime.2.html

Implementation notes:

    Syscall 'clock_nanosleep_time64()' was implemented similarly
    to syscall 'clock_nanosleep()' except that 'host_to_target_timespec64()'
    and 'target_to_host_timespec64()' were used instead of the regular
    'host_to_target_timespec()' and 'target_to_host_timespec()'.

    For 'clock_adjtime64()' a 64-bit target kernel version of 'struct timex'
    was defined in 'syscall_defs.h': 'struct target__kernel_timex'.
    This type was used to convert the values of 64-bit timex type between
    host and target. For this purpose a 64-bit timex converting functions
    'target_to_host_timex64()' and 'host_to_target_timex64()'. An existing
    function 'copy_to_user_timeval64()' was used to convert the field
    'time' which if of type 'struct timeval' from host to target.
    Function 'copy_from_user_timveal64()' was added in this patch and
    used to convert the 'time' field from target to host.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/syscall.c      | 139 +++++++++++++++++++++++++++++++++++++-
 linux-user/syscall_defs.h |  31 +++++++++
 2 files changed, 168 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 05f03919ff..c1b36ea698 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -809,7 +809,8 @@ safe_syscall4(int, accept4, int, fd, struct sockaddr *, addr, socklen_t *, len,
 safe_syscall2(int, nanosleep, const struct timespec *, req,
               struct timespec *, rem)
 #endif
-#ifdef TARGET_NR_clock_nanosleep
+#if defined(TARGET_NR_clock_nanosleep) || \
+    defined(TARGET_NR_clock_nanosleep_time64)
 safe_syscall4(int, clock_nanosleep, const clockid_t, clock, int, flags,
               const struct timespec *, req, struct timespec *, rem)
 #endif
@@ -1205,8 +1206,25 @@ static inline abi_long copy_to_user_timeval(abi_ulong target_tv_addr,
     return 0;
 }
 
+static inline abi_long copy_from_user_timeval64(struct timeval *tv,
+                                                abi_ulong target_tv_addr)
+{
+    struct target__kernel_sock_timeval *target_tv;
+
+    if (!lock_user_struct(VERIFY_READ, target_tv, target_tv_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+
+    __get_user(tv->tv_sec, &target_tv->tv_sec);
+    __get_user(tv->tv_usec, &target_tv->tv_usec);
+
+    unlock_user_struct(target_tv, target_tv_addr, 0);
+
+    return 0;
+}
+
 static inline abi_long copy_to_user_timeval64(abi_ulong target_tv_addr,
-                                             const struct timeval *tv)
+                                              const struct timeval *tv)
 {
     struct target__kernel_sock_timeval *target_tv;
 
@@ -6771,6 +6789,87 @@ static inline abi_long host_to_target_timex(abi_long target_addr,
 }
 #endif
 
+
+#if defined(TARGET_NR_clock_adjtime64) && defined(CONFIG_CLOCK_ADJTIME)
+static inline abi_long target_to_host_timex64(struct timex *host_tx,
+                                              abi_long target_addr)
+{
+    struct target__kernel_timex *target_tx;
+
+    if (copy_from_user_timeval64(&host_tx->time, target_addr +
+                                 offsetof(struct target__kernel_timex,
+                                          time))) {
+        return -TARGET_EFAULT;
+    }
+
+    if (!lock_user_struct(VERIFY_READ, target_tx, target_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+
+    __get_user(host_tx->modes, &target_tx->modes);
+    __get_user(host_tx->offset, &target_tx->offset);
+    __get_user(host_tx->freq, &target_tx->freq);
+    __get_user(host_tx->maxerror, &target_tx->maxerror);
+    __get_user(host_tx->esterror, &target_tx->esterror);
+    __get_user(host_tx->status, &target_tx->status);
+    __get_user(host_tx->constant, &target_tx->constant);
+    __get_user(host_tx->precision, &target_tx->precision);
+    __get_user(host_tx->tolerance, &target_tx->tolerance);
+    __get_user(host_tx->tick, &target_tx->tick);
+    __get_user(host_tx->ppsfreq, &target_tx->ppsfreq);
+    __get_user(host_tx->jitter, &target_tx->jitter);
+    __get_user(host_tx->shift, &target_tx->shift);
+    __get_user(host_tx->stabil, &target_tx->stabil);
+    __get_user(host_tx->jitcnt, &target_tx->jitcnt);
+    __get_user(host_tx->calcnt, &target_tx->calcnt);
+    __get_user(host_tx->errcnt, &target_tx->errcnt);
+    __get_user(host_tx->stbcnt, &target_tx->stbcnt);
+    __get_user(host_tx->tai, &target_tx->tai);
+
+    unlock_user_struct(target_tx, target_addr, 0);
+    return 0;
+}
+
+static inline abi_long host_to_target_timex64(abi_long target_addr,
+                                              struct timex *host_tx)
+{
+    struct target__kernel_timex *target_tx;
+
+   if (copy_to_user_timeval64(target_addr +
+                              offsetof(struct target__kernel_timex, time),
+                              &host_tx->time)) {
+        return -TARGET_EFAULT;
+    }
+
+    if (!lock_user_struct(VERIFY_WRITE, target_tx, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+
+    __put_user(host_tx->modes, &target_tx->modes);
+    __put_user(host_tx->offset, &target_tx->offset);
+    __put_user(host_tx->freq, &target_tx->freq);
+    __put_user(host_tx->maxerror, &target_tx->maxerror);
+    __put_user(host_tx->esterror, &target_tx->esterror);
+    __put_user(host_tx->status, &target_tx->status);
+    __put_user(host_tx->constant, &target_tx->constant);
+    __put_user(host_tx->precision, &target_tx->precision);
+    __put_user(host_tx->tolerance, &target_tx->tolerance);
+    __put_user(host_tx->tick, &target_tx->tick);
+    __put_user(host_tx->ppsfreq, &target_tx->ppsfreq);
+    __put_user(host_tx->jitter, &target_tx->jitter);
+    __put_user(host_tx->shift, &target_tx->shift);
+    __put_user(host_tx->stabil, &target_tx->stabil);
+    __put_user(host_tx->jitcnt, &target_tx->jitcnt);
+    __put_user(host_tx->calcnt, &target_tx->calcnt);
+    __put_user(host_tx->errcnt, &target_tx->errcnt);
+    __put_user(host_tx->stbcnt, &target_tx->stbcnt);
+    __put_user(host_tx->tai, &target_tx->tai);
+
+    unlock_user_struct(target_tx, target_addr, 1);
+    return 0;
+}
+#endif
+
 static inline abi_long target_to_host_sigevent(struct sigevent *host_sevp,
                                                abi_ulong target_addr)
 {
@@ -9726,6 +9825,23 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
+#endif
+#if defined(TARGET_NR_clock_adjtime64) && defined(CONFIG_CLOCK_ADJTIME)
+    case TARGET_NR_clock_adjtime64:
+        {
+            struct timex htx, *phtx = &htx;
+
+            if (target_to_host_timex64(phtx, arg2) != 0) {
+                return -TARGET_EFAULT;
+            }
+            ret = get_errno(clock_adjtime(arg1, phtx));
+            if (!is_error(ret) && phtx) {
+                if (host_to_target_timex64(arg2, phtx) != 0) {
+                    return -TARGET_EFAULT;
+                }
+            }
+        }
+        return ret;
 #endif
     case TARGET_NR_getpgid:
         return get_errno(getpgid(arg1));
@@ -11684,6 +11800,25 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
     }
 #endif
+#ifdef TARGET_NR_clock_nanosleep_time64
+    case TARGET_NR_clock_nanosleep_time64:
+    {
+        struct timespec ts;
+
+        if (target_to_host_timespec64(&ts, arg3)) {
+            return -TARGET_EFAULT;
+        }
+
+        ret = get_errno(safe_clock_nanosleep(arg1, arg2,
+                                             &ts, arg4 ? &ts : NULL));
+
+        if (ret == -TARGET_EINTR && arg4 && arg2 != TIMER_ABSTIME &&
+            host_to_target_timespec64(arg4, &ts)) {
+            return -TARGET_EFAULT;
+        }
+        return ret;
+    }
+#endif
 
 #if defined(TARGET_NR_set_tid_address) && defined(__NR_set_tid_address)
     case TARGET_NR_set_tid_address:
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 152ec637cb..3783c5a07e 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -287,6 +287,37 @@ struct target_timex {
     abi_int:32; abi_int:32; abi_int:32;
 };
 
+struct target__kernel_timex {
+    abi_uint modes;               /* Mode selector */
+    abi_int: 32;                  /* pad */
+    abi_llong offset;             /* Time offset */
+    abi_llong freq;               /* Frequency offset */
+    abi_llong maxerror;           /* Maximum error (microseconds) */
+    abi_llong esterror;           /* Estimated error (microseconds) */
+    abi_int status;               /* Clock command/status */
+    abi_int: 32;                  /* pad */
+    abi_llong constant;           /* PLL (phase-locked loop) time constant */
+    abi_llong precision;          /* Clock precision (microseconds, ro) */
+    abi_llong tolerance;          /* Clock freq. tolerance (ppm, ro) */
+    struct target__kernel_sock_timeval time;  /* Current time */
+    abi_llong tick;               /* Microseconds between clock ticks */
+    abi_llong ppsfreq;            /* PPS (pulse per second) frequency */
+    abi_llong jitter;             /* PPS jitter (ro); nanoseconds */
+    abi_int shift;                /* PPS interval duration (seconds) */
+    abi_int: 32;                  /* pad */
+    abi_llong stabil;             /* PPS stability */
+    abi_llong jitcnt;             /* PPS jitter limit exceeded (ro) */
+    abi_llong calcnt;             /* PPS calibration intervals */
+    abi_llong errcnt;             /* PPS calibration errors */
+    abi_llong stbcnt;             /* PPS stability limit exceeded */
+    abi_int tai;                  /* TAI offset */
+
+    /* Further padding bytes to allow for future expansion */
+    abi_int:32; abi_int:32; abi_int:32; abi_int:32;
+    abi_int:32; abi_int:32; abi_int:32; abi_int:32;
+    abi_int:32; abi_int:32; abi_int:32;
+};
+
 typedef abi_long target_clock_t;
 
 #define TARGET_HZ 100
-- 
2.25.1


