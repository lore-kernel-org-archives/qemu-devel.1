Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5BFC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:34:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0CB3206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="LoSCpzwv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0CB3206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgaa-0005WL-Qa
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1kAgMo-0005ku-V8
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:20:30 -0400
Received: from mail-eopbgr60111.outbound.protection.outlook.com
 ([40.107.6.111]:2560 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1kAgMm-0004EC-N7
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:20:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apriyXGWLAjVtem2eK31qwNo6ifrjR7ea9BPRayAsxIRRO4tla/2KLZyUok/Y/9Owr5xk5sd3/brjktsSYoFNVsg3Fbx0GDgwJrSCG14Yn6DqqyvSQkElDai0A77C4JdqIXuuVV/W/Fc9mxBYRe0UZY71y5A9fi+j6xkypRFOfymz1I0yZkZqwn+7RZmG21OUBOFyItn9FJTUvyPSkxzaO/64k0j+XMUerMyxhChZHq7K29yOzVkNBnRB1GeBgUVPlwC2ozSz9ntGglp2OiUlUTu9EhRhg4JgetMMLEzn55W916grh8zbn7zns1shTBph4FHPxuEKfnzqweGsFKMow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1dV1RWzSFMO1GVgumA+XdGxwE57lNFLjPnlvb0DEGY=;
 b=RY/SxPx5yUE51MQ+n3+UsJqinAqcWSxMvnd6fz6jHonNHoNxhlE2UafKneYjX04SYA+VWkDdk8UhhbVhYK9kNtb1GQU/nd/poia1E0bksrA6ApQ/PAvuU1oD8XU306G9a6edhdhhfoGBHJIIxGv7VpQw9jbxtLApnCtsmoGI8w/B0NYvhpVNZcQ4URgriYwdkkf+gYlhaPMHahaVwssTGu0Fyi0kO/gDL27ThAAuLvulAnH6d4Z3MU1uHRzPn3A24H/Gg1Ew6HxjCVrkQDRuyoNFjkC5PQ5JhoczWmsFNIJPxevIYDBnN+gDNmPc0I33sKslpBi5nGd1kn+MPGa+mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1dV1RWzSFMO1GVgumA+XdGxwE57lNFLjPnlvb0DEGY=;
 b=LoSCpzwvGOPC1KgEJrkwUuoWt0ynVzU32KE0Ir1ZHnEqJjmfKI+3YebdiQk76UjMK4Bb2NzBbVW5pohH83Cz7LYk/1Ui/zEQPYs8BFg3EhmO0UqBM2xY2BoEEzfPEei67uJpDSbaq9a+Y9AOM3xnVkppxtlEoxLrViZHSea+1MM=
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
Subject: [PATCH v2 2/2] linux-user: Add support for 'recvmmsg_time64()'
Date: Tue, 25 Aug 2020 23:20:05 +0200
Message-Id: <20200825212005.35982-3-Filip.Bozuta@syrmia.com>
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
 15.20.3326.19 via Frontend Transport; Tue, 25 Aug 2020 21:20:20 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.240]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb6754b0-4dd0-411a-389f-08d8493cac0d
X-MS-TrafficTypeDiagnostic: VI1PR0301MB2253:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0301MB2253AD931BFC7157A659B93BEB570@VI1PR0301MB2253.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AQsSqSTSCcbJVgwFeEJkwZX1NVS916uv3B4V6Q1Fy8vtTc6ORJAoyNd7okOJWpgjF2t/EcaqbVHCXA6gfPIs3wvAAl/vJhNaMN3ciIU7HBqrIM6L8RyiTy+YKlLChgnLALRZ8eTvlE8HlCQV9r6JHEmePzk8OSzQkz2bzehzW2EgLeGXKhHqYUe8B/4rKeu5XBALr//FP6H6MMgVXR2lWWXn1XGSQMz6h7rte+LtGJiZ3BoPqKUnBzp0KPlWo5jOJDch7cmKvkOPfGO/sqEnUBXnkDlFuftNW35Ou9o9sYSp+SDdgwgMbLXftEEU2LNHqnwkowXvuA8fV1aM49HmBFWA+EKKTFKu5n/j6/avQDa/WtalcAlepXqZ0FDvg2Bl/7YOR40kp7zxcVHLerAuECJqwvoelsQS38/Y6v/Pp/VUPBs9wCVOqbop4jvRwC5LAveC2xWXKChokS4p0bAqcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(366004)(39830400003)(136003)(376002)(396003)(66476007)(86362001)(16526019)(66556008)(107886003)(1076003)(8936002)(186003)(2616005)(956004)(6512007)(26005)(6916009)(5660300002)(83380400001)(4326008)(966005)(316002)(66946007)(52116002)(478600001)(6486002)(2906002)(54906003)(36756003)(6666004)(8676002)(6506007)(69590400007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 4GuMjlE5kvfRzKJ7iMYZjTi1uBtJBhMQuBjC4AXQvNfDiy2HPDOQzi/1t9tBHK/T2xL7p+xUf70Ri+clCUVDGjhjs03TZKX5YqJTythuL6U1yrIN/ry8ZCz6LPKLrtob2w9BsSiuDxnQEnJOg4iFkTeKRPGKUtAZ15tye2Zxs95darTNwG0NEUYSxYu4SCAnVTZItzYWGUJELIKZ0kJ3trA+NvZ7HfJtt0GlSq7bn4HnEYSrPddve/iVM7eDuu/yqUlnvJLZZhuz2l/ljboLzb0KI2QViLGXJL9Bs47gM9RGJXoDodxGWfXVkETThSFSlL1Y1IB09R7IkOdXW62GwuLZLTFpEoSrT/xOFu62KXwUbBCr/JMJQC4W5gW1+ZkEm8deLyoXv+7t4fOYBB9gNvLqWrSWbQWAX+TM/72qgsmv8WZ3b8oQWQd4RP1HWB3YuWimx5wTREbF1yYTZcvn8yGDuY8mdDi+dKmZ/N9/91wTxZtjcLHzknBinlBna77dP2xWaJJpEs7dj6gY/r8Db1eEozMX5JKSacXPHI6Bjhco5ntfJsgDnkv+VCYnlbj1znOKwcFkrq/lAZzUiDbFmmsvDy+2uMIn79V5DKHyqxqBNCsRyMNKg4xxXjT4HS4pRA6OKXFDWfhlKXpD+lZG0Q==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6754b0-4dd0-411a-389f-08d8493cac0d
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 21:20:20.7877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MokUvIORbi26zL4BEgVp4S8WpNYbyvUs6oCC3nZTEmzPDQUFFSwOdY4Pg4GG2DgkseGHkutLtAWzI03TMiNPzg==
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

   This patch introduces functionality for syscall:

*recvmmsg_time64

    This syscall is a 2038 safe variant for syscall:

    int recvmmsg(int sockfd, struct mmsghdr *msgvec, unsigned int vlen,
                 int flags, struct timespec *timeout)
    --receive multiple messages on a socket--
    man page: https://man7.org/linux/man-pages/man2/recvmmsg.2.html

Implementation notes:

    Function 'do_sendrecvmmsg()' in 'syscall.c' was changed with the
    addition of a new argument 'time64' which represents a flag by
    which the function knows what kind of 'struct timespec' converting
    function to call ('target_to_host_timespec() or
    'target_to_host_timespec64()'). It is false in case of
    'TARGET_NR_recvmmsg' and true in case of 'TARGET_NR_recvmmsg_time64'.

    In 'do_socketcall()', the 'TARGET_ABI_BITS' was checked to know
    what value for 'time64' argument to pass.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/syscall.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index dc89bfacca..762eea0e5b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3197,7 +3197,7 @@ static abi_long do_sendrecvmsg(int fd, abi_ulong target_msg,
 
 static abi_long do_sendrecvmmsg(int fd, abi_ulong target_msgvec,
                                 unsigned int vlen, unsigned int flags,
-                                abi_ulong timeout, int send)
+                                abi_ulong timeout, bool time64, int send)
 {
     struct target_mmsghdr *mmsgp;
     struct timespec ts, end_time, curr_time;
@@ -3212,8 +3212,14 @@ static abi_long do_sendrecvmmsg(int fd, abi_ulong target_msgvec,
         return -TARGET_EFAULT;
     }
     if (timeout) {
-        if (target_to_host_timespec(&ts, timeout)) {
-            return -TARGET_EFAULT;
+        if (time64) {
+            if (target_to_host_timespec64(&ts, timeout)) {
+                return -TARGET_EFAULT;
+            }
+        } else {
+            if (target_to_host_timespec(&ts, timeout)) {
+                return -TARGET_EFAULT;
+            }
         }
         if (ts.tv_sec < 0 || ts.tv_nsec < 0 || ts.tv_nsec > 1000000000) {
             return -TARGET_EINVAL;
@@ -3506,7 +3512,7 @@ static abi_long do_socketcall(int num, abi_ulong vptr)
         [TARGET_SYS_SENDMSG] = 3,     /* fd, msg, flags */
         [TARGET_SYS_RECVMSG] = 3,     /* fd, msg, flags */
         [TARGET_SYS_ACCEPT4] = 4,     /* fd, addr, addrlen, flags */
-        [TARGET_SYS_RECVMMSG] = 5,    /* fd, msgvec, vlen, flags, timeout */
+        [TARGET_SYS_RECVMMSG] = 6,    /* fd, msgvec, vlen, flags, timeout */
         [TARGET_SYS_SENDMMSG] = 4,    /* fd, msgvec, vlen, flags */
     };
     abi_long a[6]; /* max 6 args */
@@ -3566,9 +3572,10 @@ static abi_long do_socketcall(int num, abi_ulong vptr)
     case TARGET_SYS_ACCEPT4: /* sockfd, addr, addrlen, flags */
         return do_accept4(a[0], a[1], a[2], a[3]);
     case TARGET_SYS_RECVMMSG: /* sockfd, msgvec, vlen, flags, timeout */
-        return do_sendrecvmmsg(a[0], a[1], a[2], a[3], a[4], 0);
+        return do_sendrecvmmsg(a[0], a[1], a[2], a[3], a[4],
+                               TARGET_ABI_BITS == 64, 0);
     case TARGET_SYS_SENDMMSG: /* sockfd, msgvec, vlen, flags */
-        return do_sendrecvmmsg(a[0], a[1], a[2], a[3], 0, 1);
+        return do_sendrecvmmsg(a[0], a[1], a[2], a[3], 0, false, 1);
     default:
         qemu_log_mask(LOG_UNIMP, "Unsupported socketcall: %d\n", num);
         return -TARGET_EINVAL;
@@ -9372,11 +9379,15 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_sendmmsg
     case TARGET_NR_sendmmsg:
-        return do_sendrecvmmsg(arg1, arg2, arg3, arg4, 0, 1);
+        return do_sendrecvmmsg(arg1, arg2, arg3, arg4, 0, false, 1);
 #endif
 #ifdef TARGET_NR_recvmmsg
     case TARGET_NR_recvmmsg:
-        return do_sendrecvmmsg(arg1, arg2, arg3, arg4, arg5, 0);
+        return do_sendrecvmmsg(arg1, arg2, arg3, arg4, arg5, false, 0);
+#endif
+#ifdef TARGET_NR_recvmmsg_time64
+    case TARGET_NR_recvmmsg_time64:
+        return do_sendrecvmmsg(arg1, arg2, arg3, arg4, arg5, true, 0);
 #endif
 #ifdef TARGET_NR_sendto
     case TARGET_NR_sendto:
-- 
2.25.1


