Return-Path: <SRS0=rO5d=BF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915E8C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2020 23:54:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F2E5206E3
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2020 23:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="Nee2mRfw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2E5206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzqTF-0002bo-LS
	for qemu-devel@archiver.kernel.org; Sun, 26 Jul 2020 19:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jzqSA-0001jS-MM
 for qemu-devel@nongnu.org; Sun, 26 Jul 2020 19:53:14 -0400
Received: from mail-eopbgr140134.outbound.protection.outlook.com
 ([40.107.14.134]:43294 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jzqS8-0003jM-VI
 for qemu-devel@nongnu.org; Sun, 26 Jul 2020 19:53:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c//qng5XjFgym/3ZRVK+uCewVwarvKuCBJGKijyrAzjYa7BQLboJzGbRqBrf+5Cdi3hjuvlREuvYvI068uFKxLpRC+EBefmbOpHKiH8CLzVUG1pGcNAF6gbKvutaDp9l0FiHK9ERNpxDYlkOQNbYj76X0MC6ssTmjfQdejG1zSDGD/g/lETrwCO+744FpCN3Z4GJ8F7G1MOE1MF2uNtqaWUdf9zS/32p79yq6fP3TGs2QQwvm4/eiNkNIh4N2KGoBb51jD3MQ6tThRIzLdjypjMYU9mjQDI1jsTid98qzHbCTvtYraZKoazFYSNFsIo2YgZDnIwMAIuhZA7jAbGSsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjqw6F8vHlzLpBNAdct3LrfO+zrfZJKcAk9we61Wyj8=;
 b=S7gDNCPF4zedImyVmEohO6TohQp9H6bOJ3/i50qQ9L46gdWXsjP0Z8eD7Kxt+zCDJsKfu/iHLZ3H2bUALGITsWnHJPxkuHxCwZp1/HFH4qc54ZsXIqBD9PhEGkJnJpgHfJhMvu/4/63X8xXAoMgf/dcRQ9c7UwF0dF/Kw93KlzC48cZTOHLBgtVO353tbDpO4RtD12YqDjOg7WSKzvBm7kutF1CANy1WEJh01E/yw4vnSN+o6caq8B5uwFiDJ/rRuokwt5BNxGp0kVw34KcCAzoUFUGBhOqzRUSbAER5HhRGSE5KWQJZi25u6u+tMZ8MCUiEtyDhlOl3q7SUXtEfTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjqw6F8vHlzLpBNAdct3LrfO+zrfZJKcAk9we61Wyj8=;
 b=Nee2mRfwwP/DqWG4YSTX+CVACCLmvjTnrHt/HpcJTAymByDDmZCSecuBMZg5zqdA7MzOLpluhelSJ4J+bHI2esdGl3aEr8N0iBoWo0wkz4acz5hFGu+UlnAMDjLhDhj9XHJNoEhpn879Rg7iIknHmN/mm9Zd86Q7P+YiSvMLUf8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR03MB2925.eurprd03.prod.outlook.com (2603:10a6:802:2e::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Sun, 26 Jul
 2020 23:52:38 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3216.033; Sun, 26 Jul 2020
 23:52:38 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] linux-user: Add support for 'mq_timedsend_time64()'
 and 'mq_timedreceive_time64()'
Date: Mon, 27 Jul 2020 01:52:21 +0200
Message-Id: <20200726235221.337529-3-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200726235221.337529-1-Filip.Bozuta@syrmia.com>
References: <20200726235221.337529-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::25) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.239) by
 LO2P123CA0013.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:a6::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.22 via Frontend Transport; Sun, 26 Jul 2020 23:52:38 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.239]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e476762-de26-4779-a037-08d831befa4c
X-MS-TrafficTypeDiagnostic: VI1PR03MB2925:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR03MB2925CE3CEADC79A9E60CD9F3EB750@VI1PR03MB2925.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eHX0f4D6e0Z1wI8yXAQjV6+9P+YA4WJP1G6te3x+wa4sVQuqesc18TitgeYwznFcgprEHnwmLF3BUPHq13Cn+CUpNf1AovlsllBdofqv5str1PSZvG3kbQ7NJS0xcHr0gdf4O2qYAcwojG0HqNa/E12QymAceUdSfbIO2IwiRWqIAPPw7VOmS4LonhsU1Gp8RFTgWFTDFo+Hq1BhliOTmoezNoLdKTkFfajavIQSnhCREtcvDHbPJRLgVgQQnSrzsFcGJIMA3enyKvxGFXKLL0+Q/bbQ7Pn1u3MI1aaDCYiSIJLDrNmc7jPT69ruO7Ib0BzRHU6pEBrJOvM3s7KHH/iwNQIRTAKKRfNCgEUT80tghkKWcBtP4m7euSTzvMlv5IgWwAgK4T5HVcuZd5Y7+gnN+0pwx9AyCetX27TfIZ22a6MoHNJyvvWfIGhnukQWJq+BpSXQIp5RFffvk5OJMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39830400003)(376002)(366004)(136003)(396003)(346002)(1076003)(83380400001)(69590400007)(2616005)(956004)(316002)(2906002)(54906003)(6486002)(36756003)(16526019)(4326008)(6512007)(107886003)(66556008)(66476007)(186003)(966005)(6916009)(66946007)(26005)(508600001)(6506007)(86362001)(6666004)(8676002)(52116002)(5660300002)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 6uC4RgeM22sz3aia+Qi9uHuJH09KVd0VD434a5+fZZJHonTPwiKzgROcQOFQ/k6PxBZJkV3J/JG2faHn8/iy7xSGgTGXLgrWk6LGtXKBNILPiejmPy27G9Ml0VOBMhmvD4abfh8Z/URwbwnNUXkB9pMQXJI+4DsmjMVIdU39pqG0r2IG+jUGYqA9uZ5BTZpotTw5/QjKQ9NA/xZmlI9hwwQlqEuGjlYBB5acJsQepsOtQISgIvPck9G9Uappp2Lgdp80NkzkuuKyajQwGR+bOCfJnWSKdPYwtT9kMPhd/K91J8RWwcLuduI6zychbSpQbJ7NyK427h3a/crYTb/QxN3RRP1bGxI9I5aDSM9afRWEIlcdOAWgkkeW6Ug+EjYYEfkeFs0+nOprogrET8RqRdBzEcjfyCGzke80juL20EQoDxJeYShx1Y0wH4teAB9PvtFDhz77/t/Vu9HyGF1HFC7EMPP+FvjP+9r4ZDLBzcQ=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e476762-de26-4779-a037-08d831befa4c
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2020 23:52:38.7647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eafGnQx/NCrvohxFsURyDBoqweokMtQyae58Pg0T3u/0zUEnZh4xWRspWdsuBpxmCLoC+LeudFgkjkDL0LZU0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB2925
Received-SPF: pass client-ip=40.107.14.134;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/26 19:53:09
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

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/syscall.c | 58 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1f8d04934a..d8cb3c0fd1 100644
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
@@ -11831,6 +11835,27 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
+                if (target_to_host_timespec64(&ts, arg5)) {
+                    return -TARGET_EFAULT;
+                }
+                ret = get_errno(safe_mq_timedsend(arg1, p, arg3, arg4, &ts));
+                if (host_to_target_timespec64(arg5, &ts)) {
+                    return -TARGET_EFAULT;
+                }
+            } else {
+                ret = get_errno(safe_mq_timedsend(arg1, p, arg3, arg4, NULL));
+            }
+            unlock_user(p, arg2, arg3);
+        }
+        return ret;
+#endif
 
 #ifdef TARGET_NR_mq_timedreceive
     case TARGET_NR_mq_timedreceive:
@@ -11858,6 +11883,33 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
+                if (target_to_host_timespec64(&ts, arg5)) {
+                    return -TARGET_EFAULT;
+                }
+                ret = get_errno(safe_mq_timedreceive(arg1, p, arg3,
+                                                     &prio, &ts));
+                if (host_to_target_timespec64(arg5, &ts)) {
+                    return -TARGET_EFAULT;
+                }
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


