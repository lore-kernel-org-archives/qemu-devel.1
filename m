Return-Path: <SRS0=thXK=BE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC0BC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 22:06:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9346220663
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 22:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="v50VVsRi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9346220663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzSJE-0003vC-PL
	for qemu-devel@archiver.kernel.org; Sat, 25 Jul 2020 18:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jzSIU-00035j-Bi
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 18:05:38 -0400
Received: from mail-eopbgr150103.outbound.protection.outlook.com
 ([40.107.15.103]:43750 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jzSIR-00041r-Fa
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 18:05:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IatM57W2HJ9GrQ9aqDJXS74DhFrfJTumGMF3aLg0V1oV5azoWGKulGLxVzMgR25Ipf32rflZn7mZFmxeR1j6uixz6LZrjtQ7RkuQZAt6vIKsbEkIhrKegV2dsX/vgHbR2GDDXDRmTT217qwE/MiImCVChGoHnSuppqv6IiruL8rISgF7JphBNHz/ZqhGT9OtDfTwcNpRuS66LHy3U9FnOHYVF6YweEZcHig/XSWhYbcFDrDAoP1od3q7bqgVb3vAbxh9NNtsNyKiYCRu02a7DUOyH8McnjP5wOMkJi+/V9phZhlBFbq6YgZo0By4pRZ1/gpO804z/EUVyTAv72py5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZfJREWqSN6jIxYrvaSsExQUAg87LZPqLlDA2XdEpF0=;
 b=RrCGryv1NYhMFbithzLuYl64oAAwY12OtUiYpCu7WMiTDpPXbpfjyl8Zrl3PYSZLyen8v838XEv2WbBESbF2WXcXHEQZufnSKRUmMNtVJSb/Dqk+z8CBCI3u8RfPZuT2mMEfgIyqK08vRK9JMEl7+clPdRb1cIF7xXVlqFjkx9iz+RUr8LJdm8QqhcixbMYjzM0DwVQVEBpvEJHZjdWqoKOgtwVMFx++P7Cv+T8sGPvMnbMk1Dg4a9SFdwzjEOiDMSzyNTWWEX6h9qvq2niPquCV8Vr+iOHCy63WfGtxK7jMjji9eAmeG97y14ddeXkXi1rRfdT56mOyugOk5CEz+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZfJREWqSN6jIxYrvaSsExQUAg87LZPqLlDA2XdEpF0=;
 b=v50VVsRipfJcOoZeJSUU1vgUbKGVRXOfjafG68K6IigqBmyzy4BXlc4EaBr3bgMk0S+MRZuqa2AgeqXUh6sY1tGflM+TD+hM9qQTBoZz9w3MT6rsb3xMftzU6O36KytGFnhJPwHH1hrDb6ErwT7Xy0Fpq8i7My7nFOsUHGyolZg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB4519.eurprd03.prod.outlook.com (2603:10a6:20b:11::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Sat, 25 Jul
 2020 22:05:00 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3216.028; Sat, 25 Jul 2020
 22:05:00 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] linux-user: Add support for 'clock_nanosleep_time64()'
 and 'clock_adjtime64()'
Date: Sun, 26 Jul 2020 00:04:41 +0200
Message-Id: <20200725220442.301408-2-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200725220442.301408-1-Filip.Bozuta@syrmia.com>
References: <20200725220442.301408-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVAP278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::20) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.235) by
 GVAP278CA0010.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:20::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23 via Frontend Transport; Sat, 25 Jul 2020 22:04:59 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.235]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40da62bf-7471-4129-3c78-08d830e6c667
X-MS-TrafficTypeDiagnostic: AM6PR03MB4519:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR03MB4519243101FA25500D3A78F0EB740@AM6PR03MB4519.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l2IqcYEnXu2NPPVUuwhcsdeSjaui3XU+rubbehnlOUWCIh2Xf5WmHaitPJfW25ISzngl9OJgqVK8o/b0VQZGWg10bLFbuSfSVky3ugqmsj2J/kjlENFjRhfOz6XeqzqXchJGA3/qxb7uAShu7EKtO+MULFrFp84CBBPsiSZrzGxTZ+inw58QmH6SSn/sfDUZErCjoXZcSbvuYjFg45RxlX/5xJ3skdmN1cJ+5Vy101SG741KJ0Ys+HanXK3YGlC8tD1JeznFhrb7hY/5QiH5X8Bya7Nbkl3AR+21LXN9agyEqCrT/LO5NwOVtPGDuVuQOgYidkGKEE13m68JZhz+UhB03LB/2XL+StgyplBrBTAFEdVdqstiiKPL74YqpkaY3lALIHAdAVcThWs7j8jiga4xqEDYi+QNiyM0rGJ3oApRB5FCfvfb2i1h6IQcUJDZXgz0p0N5H0RTJD3rlKC+KA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(376002)(366004)(346002)(396003)(39830400003)(136003)(107886003)(54906003)(186003)(316002)(16526019)(26005)(6506007)(52116002)(956004)(2616005)(86362001)(6916009)(508600001)(4326008)(66476007)(6512007)(1076003)(966005)(6486002)(36756003)(66946007)(6666004)(2906002)(83380400001)(8676002)(5660300002)(8936002)(66556008)(69590400007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: pKdO7Q3dj1M6x3PnjGOvTgkDFmaUEqMuXOmxWkx4n4N0aC8gmQO575n2QPD16iSjQcqejXZ64ZD5wonhne/PxTdNg2arDtfavvHs3tA+97uVuOo5KM3GrVLDIWY397+mITPEZ/5Voi9qj/QI6eLFN1tpsTlyjUMpH3hMKRU0Lo02gWLRxg/qIFdB34Kf3WCV2oVnMYLhSIY/mC6ddmFzUhaHB16Vv0V46k0V7wofdCUHK3uLlhIYS4x0pinlv+9Qy11idsLkF26q8Z4vP8HCIuvkiV9YOQ4tUO7RUStmd7RHxUkYNfX0FsVY+4RgluyEB43Udyeb/3i1X+ZJJ8Y7Pgq8C/G7n46NOqY2pl3ophQB2uU0QOPUrGOizBMmZcC8UwbsbPLZJZtuqUEIjnWnHBos1eJnQGqBDEzOU6YZyZ4XNtn5wXYIG5thVeNHT9FwsrFvjYh/vu3LvLk3ejsuiKD+MwLI9LAbRiw9brqEQk8=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40da62bf-7471-4129-3c78-08d830e6c667
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2020 22:05:00.5868 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c8+MLRxSKyN2NhjVfPqsW0oR8WuoHueN9xmyyYQO7weqMkYdYJeQDv7R9H0cy6FvrNCsNHjY5uYQTuqgHJW39w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4519
Received-SPF: pass client-ip=40.107.15.103;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/25 18:05:33
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 linux-user/syscall.c      | 144 +++++++++++++++++++++++++++++++++++++-
 linux-user/syscall_defs.h |  31 ++++++++
 2 files changed, 173 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 05f03919ff..0de11e4245 100644
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
@@ -11684,6 +11800,30 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
     }
 #endif
+#ifdef TARGET_NR_clock_nanosleep_time64
+    case TARGET_NR_clock_nanosleep_time64:
+    {
+        struct timespec ts;
+        target_to_host_timespec64(&ts, arg3);
+
+        ret = get_errno(safe_clock_nanosleep(arg1, arg2,
+                                             &ts, arg4 ? &ts : NULL));
+
+        if (ret == -TARGET_EINTR && arg4 && arg2 != TIMER_ABSTIME) {
+            host_to_target_timespec64(arg4, &ts);
+        }
+#if defined(TARGET_PPC)
+        /*
+         * clock_nanosleep is odd in that it returns positive errno values.
+         * On PPC, CR0 bit 3 should be set in such a situation.
+         */
+        if (ret && ret != -TARGET_ERESTARTSYS) {
+            ((CPUPPCState *)cpu_env)->crf[0] |= 1;
+        }
+#endif
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


