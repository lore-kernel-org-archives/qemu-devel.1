Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88823C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:34:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55F1C206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="ehdWG6eJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F1C206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgao-00068b-Kg
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1kAgMm-0005ja-Gg
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:20:29 -0400
Received: from mail-eopbgr60111.outbound.protection.outlook.com
 ([40.107.6.111]:2560 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1kAgMk-0004EC-A6
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:20:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0LWHoec1axFoThhFgRRosR9FxSjKh+ipIwdOhC1dDhu13LeLKxZ1qDtS7CX9ubya6mbxYKlDuRanCOMwPm1MWcrDpdhBtuTIeDyeP2GFXBhLnTpTT13Z94wqPdwXMYY0Dw101jwXfbTssc14UZ1uq4IjSnCWxitvZDk4EXdR/KAK9XQgLDTsIVYnqWd9vGS3v24Aua7OpF5VsZTviiBUx7BD+/Pazo7UtZQpT2maaeVy5btmYYPOe8gapOht+K0YJd6tarT4jkpTIDscHWtIDR6/bdQ0pagB0tpffxfI/L/7ULIW/qETKLyP6g5TGC5HGnRbrs/UNaaHVJHt0OHuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rxDHV8VzSrstEgbdUUXtJ1blVeoXD32EQXBcZLp9Ls=;
 b=Ej/kTAwyuP6F3xOVVKBauQJg6cWUt/+ICcga4UO8J/ghnachI5fYvkLVbHx+ozvXtYTOl36mN0/OUY1YUWUtByf5A1uKI1nZb+BUo81ZF8rU4BLSawZd+0CPtYnbZkhqfti1bYDk48g3FxRTmGkEwPbRgHeSDEKXV1trhVd6eEE/zJubHe0b3QJQD5e+k9q5TsFW6RmB/kBpZ6AtAjKFzdCi5pPuUfUEszMezvmBtQFokKzOu9u/rQxPXPH+5uuZ29v3jzaqjpqzpYnCduzkUKZqylF42l16O9dvOMpHBqGZUkZ9PDvjXG4y98ALGvBCkCeRavLzNc9WvGA5gtrv7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rxDHV8VzSrstEgbdUUXtJ1blVeoXD32EQXBcZLp9Ls=;
 b=ehdWG6eJE5a0M3HjFZVoC9NKKNIeEckMMzu7Qa4p65KOvnTwnwg3f+vlxWN1X4/WeBb6P5b5Umg6lzHv3PuY3FK4kxXtvIXIeTAZXJ8UNHzUlkV/yWaUTLagZzE805nmATwMnD2GJdm+0glld1Y2IFO47P6kGfgCrnXzjizTTI8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR0301MB2253.eurprd03.prod.outlook.com (2603:10a6:800:27::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Tue, 25 Aug
 2020 21:20:20 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3261.026; Tue, 25 Aug 2020
 21:20:20 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] linux-user: Modify 'recvmmsg()' implementation
Date: Tue, 25 Aug 2020 23:20:04 +0200
Message-Id: <20200825212005.35982-2-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825212005.35982-1-Filip.Bozuta@syrmia.com>
References: <20200825212005.35982-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0045.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::14) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.240) by
 ZR0P278CA0045.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Tue, 25 Aug 2020 21:20:19 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.240]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d857388d-7c28-4e8d-a4a0-08d8493cab97
X-MS-TrafficTypeDiagnostic: VI1PR0301MB2253:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0301MB225364F00AC9FB61C929180CEB570@VI1PR0301MB2253.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ehds/tTxiGlnuXXt3KkvS0gQqaPWF/Ir/1eUJSUGsTMeHgdeAw4NMvxxbD6rIdMS2NBzugzJmAaqxuYTCXypxuSnrKfMM0tFepxfrz+m3G5PNyJa209RMYr+VXEe1KVfXbZfCgyznDEmRDEzcOqIdWaGlZeXzzqSvrdz3YhMx4X+ihPyDAMFggU6vSZL/7d0GanVuPIebp5Ft4tyeQu4KyfWR8tOZkX0YK4i25nzkBxu+1HX9KwEI4eELjy1Oy8WyX4NDG/U38yGNhJjyGEtxg/Hc0cy2nnPBZEoAioHJdp6KIlT8Kh99AYqwrD2bw1WHy5wuALR+oisulEScjrRELlr+f/ByP1rm0ELW+Wl1mp4dKFgolpf95FL9jUHgbI+vfhiXBUwCZmYhYrKseuPItnOb3I3ZL2OMc+AHbi4gA5MpLgZ/h5dDHEPAAXUPrtVoPx/NFX7U9PCtnZr5dOdYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(366004)(39830400003)(136003)(376002)(396003)(66476007)(86362001)(16526019)(66556008)(107886003)(1076003)(8936002)(186003)(2616005)(956004)(6512007)(26005)(6916009)(5660300002)(83380400001)(4326008)(966005)(316002)(66946007)(52116002)(478600001)(6486002)(2906002)(54906003)(36756003)(6666004)(8676002)(6506007)(69590400007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: tmW7yrqfTcrwHk8epaq8Izpwdf3mnCx016mlU9UCfBJI2i8n7+h02uODd/Zxj8X0wMoIICQRfQtWwA6kVNXLUO/7CRsmKwME3Vs3k8yxXS1Sm9AHhVBYoU63FqAMttzYRiZUjYgiPuaeQl7v2yFwKmUZImcGtBLneh3eAQvFatc8X4D2BoXwjbAy/QvtrJ9BQ1am/j7GTUi3pmiXHY2r5cGxXj35Y1KLBRbDy/W9xIrpHziE0lGZzz+5lBO/2yrTysNBE6tseVy3aOsb48EJrHa0LtYGsVgSr4EbV2tFzD4FoO8v4FVFGMU+PwOYJ2SbGY/HHfG/A+qgQQk/DpvEtOZBvbbr5Cs2tS+iFVNdsVVfhwbzMg0t6MXIs++Pvtngdaq/sGcHq0kepDLdl0n1mjIXjqS4L2ZAkwyp7zeVD3m+Dy2HmB/5tVRjuv08JfD0lNOA4ZZh/JVRg6X3N+TIGR+bUO39UZmUZ/j4Qrnw0AnNQ7goVUFr//J/MpZbXl795s8hst3hjG3LRNTDNnSvrTO0ktLhZe34axXCyQ0OZGU7wcwVJ/t/X/2OlCF7Jvd3kZMjqJ6EuBdpOpMt/um8ujpN/7Xk/ZKMBkEQ0j3AWVSOktxPnQZWWpOdFngiIUl8naYt5CKO3lmvGT9y0UuCOQ==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d857388d-7c28-4e8d-a4a0-08d8493cab97
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 21:20:20.0241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dTvEwBI7XgTGs+EYMRu8LzyKGKPNiPuvoYuxcd4GmOU+GKC3r2qYzwbRU7vzJ1rVmPTwWQP6h20cDA31e07NSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0301MB2253
Received-SPF: pass client-ip=40.107.6.111;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 17:20:21
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Implementation of syscall 'recvmmsg()' in file 'syscall.c' uses
a loop over 'recvmsg()' to receive each individual message from
a socket. However, the implementation ignores the timeout argument.
This patch changes that by introducing a timeout check after
each received message.

Implementation notes:

   Function 'clock_gettime()' is used to check the time before
   messages start getting received. After each message is received,
   'clock_gettime()' is called and used to check whether the timeout
   is expired.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/syscall.c | 45 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 05f03919ff..dc89bfacca 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3197,21 +3197,36 @@ static abi_long do_sendrecvmsg(int fd, abi_ulong target_msg,
 
 static abi_long do_sendrecvmmsg(int fd, abi_ulong target_msgvec,
                                 unsigned int vlen, unsigned int flags,
-                                int send)
+                                abi_ulong timeout, int send)
 {
     struct target_mmsghdr *mmsgp;
+    struct timespec ts, end_time, curr_time;
     abi_long ret = 0;
     int i;
 
     if (vlen > UIO_MAXIOV) {
         vlen = UIO_MAXIOV;
     }
-
     mmsgp = lock_user(VERIFY_WRITE, target_msgvec, sizeof(*mmsgp) * vlen, 1);
     if (!mmsgp) {
         return -TARGET_EFAULT;
     }
+    if (timeout) {
+        if (target_to_host_timespec(&ts, timeout)) {
+            return -TARGET_EFAULT;
+        }
+        if (ts.tv_sec < 0 || ts.tv_nsec < 0 || ts.tv_nsec > 1000000000) {
+            return -TARGET_EINVAL;
+        }
 
+        clock_gettime(CLOCK_REALTIME, &curr_time);
+        end_time.tv_sec = curr_time.tv_sec + ts.tv_sec;
+        end_time.tv_nsec = curr_time.tv_nsec + ts.tv_nsec;
+        if (end_time.tv_nsec > 1000000000) {
+            end_time.tv_nsec -= 1000000000;
+            end_time.tv_sec++;
+        }
+    }
     for (i = 0; i < vlen; i++) {
         ret = do_sendrecvmsg_locked(fd, &mmsgp[i].msg_hdr, flags, send);
         if (is_error(ret)) {
@@ -3222,6 +3237,20 @@ static abi_long do_sendrecvmmsg(int fd, abi_ulong target_msgvec,
         if (flags & MSG_WAITFORONE) {
             flags |= MSG_DONTWAIT;
         }
+        /*
+         * For recvmmsg() the timeout is checked only after a datagram is
+         * received.This is an existing bug in the kernel for this syscall:
+         * https://man7.org/linux/man-pages/man2/recvmmsg.2.html#BUGS
+         */
+        if (timeout) {
+            clock_gettime(CLOCK_REALTIME, &curr_time);
+            if (curr_time.tv_sec > end_time.tv_sec ||
+                (curr_time.tv_sec == end_time.tv_sec &&
+                curr_time.tv_nsec >= end_time.tv_nsec)) {
+                i++;
+                break;
+            }
+        }
     }
 
     unlock_user(mmsgp, target_msgvec, sizeof(*mmsgp) * i);
@@ -3477,7 +3506,7 @@ static abi_long do_socketcall(int num, abi_ulong vptr)
         [TARGET_SYS_SENDMSG] = 3,     /* fd, msg, flags */
         [TARGET_SYS_RECVMSG] = 3,     /* fd, msg, flags */
         [TARGET_SYS_ACCEPT4] = 4,     /* fd, addr, addrlen, flags */
-        [TARGET_SYS_RECVMMSG] = 4,    /* fd, msgvec, vlen, flags */
+        [TARGET_SYS_RECVMMSG] = 5,    /* fd, msgvec, vlen, flags, timeout */
         [TARGET_SYS_SENDMMSG] = 4,    /* fd, msgvec, vlen, flags */
     };
     abi_long a[6]; /* max 6 args */
@@ -3536,10 +3565,10 @@ static abi_long do_socketcall(int num, abi_ulong vptr)
         return do_sendrecvmsg(a[0], a[1], a[2], 0);
     case TARGET_SYS_ACCEPT4: /* sockfd, addr, addrlen, flags */
         return do_accept4(a[0], a[1], a[2], a[3]);
-    case TARGET_SYS_RECVMMSG: /* sockfd, msgvec, vlen, flags */
-        return do_sendrecvmmsg(a[0], a[1], a[2], a[3], 0);
+    case TARGET_SYS_RECVMMSG: /* sockfd, msgvec, vlen, flags, timeout */
+        return do_sendrecvmmsg(a[0], a[1], a[2], a[3], a[4], 0);
     case TARGET_SYS_SENDMMSG: /* sockfd, msgvec, vlen, flags */
-        return do_sendrecvmmsg(a[0], a[1], a[2], a[3], 1);
+        return do_sendrecvmmsg(a[0], a[1], a[2], a[3], 0, 1);
     default:
         qemu_log_mask(LOG_UNIMP, "Unsupported socketcall: %d\n", num);
         return -TARGET_EINVAL;
@@ -9343,11 +9372,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_sendmmsg
     case TARGET_NR_sendmmsg:
-        return do_sendrecvmmsg(arg1, arg2, arg3, arg4, 1);
+        return do_sendrecvmmsg(arg1, arg2, arg3, arg4, 0, 1);
 #endif
 #ifdef TARGET_NR_recvmmsg
     case TARGET_NR_recvmmsg:
-        return do_sendrecvmmsg(arg1, arg2, arg3, arg4, 0);
+        return do_sendrecvmmsg(arg1, arg2, arg3, arg4, arg5, 0);
 #endif
 #ifdef TARGET_NR_sendto
     case TARGET_NR_sendto:
-- 
2.25.1


