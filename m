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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAB0C433ED
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 23:21:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BD0C20738
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 23:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="MzZhear0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD0C20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzTU7-00061a-QY
	for qemu-devel@archiver.kernel.org; Sat, 25 Jul 2020 19:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jzTTU-0005ce-1I
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 19:21:04 -0400
Received: from mail-eopbgr00097.outbound.protection.outlook.com
 ([40.107.0.97]:46392 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jzTTR-00032c-RQ
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 19:21:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjOS/EolSEDPZ4SKOhcmv6oHig1k+ZzvxKEwgJFuxSmj1EK/DSXVa9VG0l17TEUMlnnS8BAhvJb+nWxPQ6FqkrCPA7WwtMHRkFpL5+JsW1wlo/XBm9E1Ya6s5WrabZjMLuIqPaoDIgKvPhqTMgJD41rKcSjJv6z1qbJsjwqZud86kgARE0Fc7FQuQwAUbXjAgVgLBjjMS8uVT8GmUOrqLOcXO5o6eLlZ0uLGabn9wIPTAx8kJThes7guaJ8XFXvL9PPmxawYnF1WzNqLPFogBvQtP0y82BD1plMqJLbO4WHf3TM/jnt0K/DFNazRhMNPSKCGQLGw6Qp2R5CVHVeiuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jbp2JXbPbWZo3+UJ9S7EKDRSvOLUdWESrkiXILpTnao=;
 b=ZOwyONRusQKw1D+5Z8Ea8+chMDr6IxeYDdqN3wZ89iRBLzPhRkVf7e+l02Zv3b0E5uDqTIu1AXxHUsufh7yLTXDVbyvCszoJ2tGSPwddOBHFhbq1D3+zTD+xhXqRHX6APwURN9e+GTeDIuQIs2z7AoqzCj8W0JoJxL4Gj/S88H2INw2M1828Bb0HMbSZyHNknGZfVmoF3Rh+wKk5D8QK4REpK1JbWCaKSFvu/+LQ3mpKEfpkIVi0iUPvS9yUfCoT7ssTuz2L1MmRiJmyLueu2NpWDf5jk6gbXG6lPFhZ3jgIQ9CDxwoOqT96S9nVo9DparriR4SZWUJHzg5K29vpVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jbp2JXbPbWZo3+UJ9S7EKDRSvOLUdWESrkiXILpTnao=;
 b=MzZhear0OyvXNSJrz1dZzJdbUD3jqKz1yZmVyWJExi0YrYoMt4sJQicvnYrW9/nk6zNaeNEaxMcmmhvhUPlQTpI/Lwq4OmQ5xrURlgkNzaf6Qr7CFIsK+cf2URWOhsPrGcTJDZAFu+F9nm9fby+VjhzO3rJqaF7J4c1a3X3L3nw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB4661.eurprd03.prod.outlook.com (2603:10a6:20b:d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Sat, 25 Jul
 2020 23:20:58 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3216.028; Sat, 25 Jul 2020
 23:20:58 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user: Add support for 'mq_timedsend_time64()' and
 'mq_timedreceive_time64()'
Date: Sun, 26 Jul 2020 01:20:44 +0200
Message-Id: <20200725232044.318431-1-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0036.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::23) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.237) by
 ZR0P278CA0036.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.20 via Frontend Transport; Sat, 25 Jul 2020 23:20:57 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.237]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1ec6ec0-ff27-409b-a67b-08d830f16334
X-MS-TrafficTypeDiagnostic: AM6PR03MB4661:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR03MB46618AC63A97B27102F4F259EB740@AM6PR03MB4661.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LCydtv+dUObN5vo3sImZODXYFT7IaAxXcGtrcMPm16ADFfKwHf4+ZL1iyd4tQaqmDefEEsx2KE5K8aleJb7iYgxkQvoy0vC/MV9iRWP2J7Blemu/Ipiqscss+v3RtnVDgAsrGmUURwgl78wu+bybs94ReKqWpkC0hlJWQNm+obon7ZjemunFVbyzxZRilT32qEtJxX88nGlIquGxAt/1f6RXhdWk26jOmq2a9Sr3NmIPwJwhj1+6ps3CaUhCGFxWw68CtIQyCoHW4lmvepOfD3R8YfsRU759lZP+dH+dxSkfdwrgRBiFf7gMyDdzEqhwNhwUuKsyoDdS6x2U94hhwGWRfMGb9T1Pt+QSW+h3+5q1KVHpgIyPywBMkI8P1tm4DogLDq2Q43RX+vQDDbH6FezfYFM9v/9P7+CDQGrBX2u7Hr3hNHjL+ECYmyfPZJyQBSiC0Yct6i7zCG0yaKIvkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(366004)(376002)(39830400003)(346002)(136003)(86362001)(8676002)(107886003)(69590400007)(4326008)(6916009)(54906003)(316002)(6486002)(966005)(6512007)(6666004)(508600001)(36756003)(8936002)(5660300002)(1076003)(66946007)(66556008)(66476007)(6506007)(2906002)(26005)(83380400001)(52116002)(2616005)(956004)(16526019)(186003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: MVavrYtX55XKMLXb5qrWboZZFsu5pp190O/TQLK69mm4MrdtF9vgX5cGE5jJ1G6xHhG2a5TG4EBRTSCKrwtFvgIi52S0errvlnoOn5MKEgJK02+qLZYUZe2fKbTVyOEwjv15+S3AsUho2G/u4vaqwpiYS7iHqAymill+x2w0YGjTSglwojcGaC0KZXN5H1JqT2I/jiWPX+qHx1TITEINIYoAIxLEXPonpGeMhg8a2J0RDTLrnRRY5WqF0uIdNgGK3yKVCr4lRt7NpZHMBlVoQLacKrQftnNmreRvlSkTSf/Ehq+mmN86oGeLZIsB5psKaSIUZXG+0OlGag/R4JJ9EepKlrrz7OGLUHKjdBEXksiarUSbQi3ymgbu+/ZdpcbCAdJUArSWc7owu3B3ewbM+2MO9CkR/qFRBT0caUAsFoKJX9fRyzbTSelpzVFsG4RgEwupE9Dw9/9LhlsrWZTTrDdEOFtE5H32guYlaxMQRYY=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ec6ec0-ff27-409b-a67b-08d830f16334
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2020 23:20:58.5190 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iI8eBo8bQM74Avl1HLI8gMrU+hZe9PkoBz0uGv3IDtoUWfv9ZX3W3+RDhWK6YsKcqrzl7o1LjAnCMvXDB/LFjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4661
Received-SPF: pass client-ip=40.107.0.97; envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/25 19:21:00
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

This patch implements functionality for following time64 syscalls:

*mq_timedsend_time64()

    This is a year 2038 safe vairant of syscall:

    int mq_timedsend(mqd_t mqdes, const char *msg_ptr,
                     size_t msg_len, unsigned int msg_prio,
                     const struct timespec *abs_timeout)
    --send a message to a message queue--
    man page: https://www.man7.org/linux/man-pages/man2/mq_timedsend.2.html

*mq_timedreceive_time64()

    This is a year 2038 safe variant of syscall:

    ssize_t mq_timedreceive(mqd_t mqdes, char *msg_ptr,
                            size_t msg_len, unsigned int *msg_prio,
                            const struct timespec *abs_timeout)
    --receive a message from a message queue--
    man page: https://man7.org/linux/man-pages/man3/mq_receive.3.html

Implementation notes:

    These syscalls were implemented in similar ways like
    'mq_timedsend()' and 'mq_timedreceive' except that
    functions 'target_to_host_timespec64()' and
    'host_to_target_timespec64()' were used to convert
    values of 'struct timespec' between host and target.

Testing method:

    The implementation in this patch was tested using
    recently added LTP time64 test variants for
    "mq_timedsend()" and "mq_timedsendreceive()".

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/syscall.c | 50 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 05f03919ff..894e835065 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -829,11 +829,13 @@ safe_syscall5(int, msgrcv, int, msgid, void *, msgp, size_t, sz,
 safe_syscall4(int, semtimedop, int, semid, struct sembuf *, tsops,
               unsigned, nsops, const struct timespec *, timeout)
 #endif
-#ifdef TARGET_NR_mq_timedsend
+#if defined(TARGET_NR_mq_timedsend) || \
+    defined(TARGET_NR_mq_timedsend_time64)
 safe_syscall5(int, mq_timedsend, int, mqdes, const char *, msg_ptr,
               size_t, len, unsigned, prio, const struct timespec *, timeout)
 #endif
-#ifdef TARGET_NR_mq_timedreceive
+#if defined(TARGET_NR_mq_timedreceive) || \
+    defined(TARGET_NR_mq_timedreceive_time64)
 safe_syscall5(int, mq_timedreceive, int, mqdes, char *, msg_ptr,
               size_t, len, unsigned *, prio, const struct timespec *, timeout)
 #endif
@@ -1243,7 +1245,9 @@ static inline abi_long target_to_host_timespec(struct timespec *host_ts,
 }
 #endif
 
-#if defined(TARGET_NR_clock_settime64) || defined(TARGET_NR_futex_time64)
+#if defined(TARGET_NR_clock_settime64) || defined(TARGET_NR_futex_time64) || \
+    defined(TARGET_NR_mq_timedsend_time64) || \
+    defined(TARGET_NR_mq_timedreceive_time64)
 static inline abi_long target_to_host_timespec64(struct timespec *host_ts,
                                                  abi_ulong target_addr)
 {
@@ -11827,6 +11831,23 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         }
         return ret;
 #endif
+#ifdef TARGET_NR_mq_timedsend_time64
+    case TARGET_NR_mq_timedsend_time64:
+        {
+            struct timespec ts;
+
+            p = lock_user(VERIFY_READ, arg2, arg3, 1);
+            if (arg5 != 0) {
+                target_to_host_timespec64(&ts, arg5);
+                ret = get_errno(safe_mq_timedsend(arg1, p, arg3, arg4, &ts));
+                host_to_target_timespec64(arg5, &ts);
+            } else {
+                ret = get_errno(safe_mq_timedsend(arg1, p, arg3, arg4, NULL));
+            }
+            unlock_user(p, arg2, arg3);
+        }
+        return ret;
+#endif
 
 #ifdef TARGET_NR_mq_timedreceive
     case TARGET_NR_mq_timedreceive:
@@ -11850,6 +11871,29 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         }
         return ret;
 #endif
+#ifdef TARGET_NR_mq_timedreceive_time64
+    case TARGET_NR_mq_timedreceive_time64:
+        {
+            struct timespec ts;
+            unsigned int prio;
+
+            p = lock_user(VERIFY_READ, arg2, arg3, 1);
+            if (arg5 != 0) {
+                target_to_host_timespec64(&ts, arg5);
+                ret = get_errno(safe_mq_timedreceive(arg1, p, arg3,
+                                                     &prio, &ts));
+                host_to_target_timespec64(arg5, &ts);
+            } else {
+                ret = get_errno(safe_mq_timedreceive(arg1, p, arg3,
+                                                     &prio, NULL));
+            }
+            unlock_user(p, arg2, arg3);
+            if (arg4 != 0) {
+                put_user_u32(prio, arg4);
+            }
+        }
+        return ret;
+#endif
 
     /* Not implemented for now... */
 /*     case TARGET_NR_mq_notify: */
-- 
2.25.1


