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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880A7C433E3
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 22:06:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 545AD20663
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 22:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="sk/WFPFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 545AD20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzSJF-0003xB-H4
	for qemu-devel@archiver.kernel.org; Sat, 25 Jul 2020 18:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jzSIW-00036c-Gi
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 18:05:40 -0400
Received: from mail-eopbgr150103.outbound.protection.outlook.com
 ([40.107.15.103]:43750 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jzSIU-00041r-Eg
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 18:05:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MN2cWMFUNuQeIfQA8iJ6cXlEivPytLKVXc6wusMoSlmsle+ZWz75+FplMXeCbB2hS3uhErXyex1EMxnqknGfPHbBKiAg6Lb03tEHNelCUR7OdGWpCRdFkXsbCGZyHNUbfDi+DrdgKxmxVRS7n7t5Y8qmolSpMNMVLbJdc1X4aKyMmy2TLqhn+av0PJ+ub0PIV3dPRVz+TxgC6MU/fk4r+W65UEzkn0ZlMOBUksb7NEysK79xhmPz74cpTVVzHwwIo1qwpyF84jiiVCBJifdfO0TyLtZvOgOFTHnpYmhYGukJ5nAAuepRPNJSJYK7xmqIXC5Q7iG/G2lxyPB/vGjC8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sA+UWdAyRDdeUVNdWNwpNw82Qf6gaAsbdLoXpbuCDag=;
 b=S1PVfXrUJra+RJan8JrU8ZYe+uf2Ibk0a8os//LBaC41XR/C9sAnObNawl0PI2Dm0X4EMvoYcHcWoGS9DEkXdQOlwEnhHtMGqHduI2RPajA1YAxRGvenBlqizK168TDkbG6S/WHQgrbVY1n4gIlBGi2Ip85sSmtupuONzevxJfeGN2eYEOwCDgQyXEghtlThmse6/2ENOv0F0HNbzLxazez4wJR4MD4WSWZv+eNrDxPYIUBjNjnGGoapi3osx0Y5yda/NSWg7VqkjmE+4qgf0Uw8alI0n8pL5U4MirNQUc9vpvAD7LodgstQ0/akUsFuutedqf4WVNWMOiK7NqojIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sA+UWdAyRDdeUVNdWNwpNw82Qf6gaAsbdLoXpbuCDag=;
 b=sk/WFPFGBRQAb3aD2tGGWiBLLy4ElUIn+2F7Gq9WJ0JgegH8gE2Xr/ClgYZE/7yDk7o3SEwFd3o3vN1Ln/RODXzfDYaVgtYdwclDfaQdGd5lcsJe8g7LWzK++JoC1pnC+AUCMGrY52SLi+oXxGNmASkfhZe1C2t41lFPkMAGofs=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB4519.eurprd03.prod.outlook.com (2603:10a6:20b:11::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Sat, 25 Jul
 2020 22:05:01 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3216.028; Sat, 25 Jul 2020
 22:05:01 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] linux-user: Add support for 'rt_sigtimedwait_time64()'
 and 'sched_rr_get_interval_time64()'
Date: Sun, 26 Jul 2020 00:04:42 +0200
Message-Id: <20200725220442.301408-3-Filip.Bozuta@syrmia.com>
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
 15.20.3216.23 via Frontend Transport; Sat, 25 Jul 2020 22:05:00 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.235]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6381d79-642f-406b-8ede-08d830e6c70a
X-MS-TrafficTypeDiagnostic: AM6PR03MB4519:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR03MB45198E86FB55E6632882060BEB740@AM6PR03MB4519.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NhSGTo9yQEvgORRoPVNGbdddGZY39jHYOYP49BMzhelOkaG2g2nq1EtBtmFzBLSDj3n9kmdAdNey4JTzOyD9phQkTUaCOR/nZwjhEHnoyL6cVVH27TGqiJ9PpKC9CUUmLentRFHSYXRYUI4sbb82AUTQDpeOtTcfBzF4pae0ljhjc2CME1bW9MUQ8ihNwgj8IMiumz9ZSsJsevJAx64SqTGIZuZhug87Teu0v+XvbkShunZVHtak1x9W8vQoaNl3DZX055e9WkC1NcYgbuioF2JNUH4UgnZmj/Pux6TLg7NeYNmN1kTJxczpHxYvWQgPPiw2gHRqHKGeNczzdv1CUN7CxAo9tuzlClEJBZWmHnbVNYnp3/Jm3IdNZtJvrp8RZjUMcZp8hexXy/DSHip6HPz7zev9aNLPevvxZXSFzClpUkJuMQDSgQrmQm66mkqt+MWfGbSv5TBwfEK04HRo5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(376002)(366004)(346002)(396003)(39830400003)(136003)(107886003)(54906003)(186003)(316002)(16526019)(26005)(6506007)(52116002)(956004)(2616005)(86362001)(6916009)(508600001)(4326008)(66476007)(6512007)(1076003)(966005)(6486002)(36756003)(66946007)(6666004)(2906002)(83380400001)(8676002)(5660300002)(8936002)(66556008)(69590400007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: VHnF5LXb8cOoHUFIug+8qd6VR9Bw8zYJqVjd0MG9Cil6QcsM0ShXUJHO3qFG/xsKw3hppVl8IbN+RqzlNtVO906VLWCsEZDlmzRtT1DDc49qDikHDGg4HWCxjfEQOearZ9bGG/Qve0Qf+RtnqPI4FNcc8i0TlgYRatYtZp7SzqJrdE5V7IA1851Nx7IPbY6p5v5aD5mf+mCUwiTIJK0aH7wQ1JOTR0G+shMaJRjWP55MObjHe67GDyDn5E/jIf1BoSKn86v/TjNYt/Iqj/nfAI5ldhH07vUVHV+AIqCPM8DaYxw2mIrzWKY04ROjkF/ZL29FeTL9R09Q46DhHjCZe0q/PMcEQjRSxBvLGWM8gwEuW5HTHNw4R/mAPLf3Luo/ne3Cb/x0UeM/5G20P3TdxHxP0YT2cpP+4SXFuvgKEGDFfYokcIvrc6643OjDqDkBCdXT73T383gFq3c9VMv3zPVXfJpll1jvAqJ7wJRy2LI=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6381d79-642f-406b-8ede-08d830e6c70a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2020 22:05:01.4923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YiF9HPZnpJnLl+9tzU56mGccmCyTn2VTrGZFVtKNfNPAoJzgLGPLXH25Pvy6L1vqxhAGJTVkkJWUL/heMP2LUA==
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

This patch implements functionality for following time64 syscalls:

*rt_sigtimedwait_time64()

    This is a year 2038 safe variant of syscall:

    int rt_sigtimedwait(const sigset_t *set, siginfo_t *info,
                        const struct timespec *timeout, size_t sigsetsize)
    --synchronously wait for queued signals--
    man page: https://man7.org/linux/man-pages/man2/rt_sigtimedwait.2.html

*sched_rr_get_interval_time64()

    This is a year 2038 safe variant of syscall:

    int sched_rr_get_interval(pid_t pid, struct timespec *tp)
    --get  the  SCHED_RR  interval  for the named process--
    man page: https://man7.org/linux/man-pages/man2/sched_rr_get_interval.2.html

Implementation notes:

    These syscalls were implemented in similar ways like
    'rt_sigtimedwait()' and 'sched_rr_get_interval()' except
    that functions 'target_to_host_timespec64()' and
    'host_to_target_timespec64()' were used to convert values
    of 'struct timespec' between host and target.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/syscall.c | 53 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 0de11e4245..efd6157350 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8831,6 +8831,48 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
+#endif
+#ifdef TARGET_NR_rt_sigtimedwait_time64
+    case TARGET_NR_rt_sigtimedwait_time64:
+        {
+            sigset_t set;
+            struct timespec uts, *puts;
+            siginfo_t uinfo;
+
+            if (arg4 != sizeof(target_sigset_t)) {
+                return -TARGET_EINVAL;
+            }
+
+            p = lock_user(VERIFY_READ, arg1, sizeof(target_sigset_t), 1);
+            if (!p) {
+                return -TARGET_EFAULT;
+            }
+            target_to_host_sigset(&set, p);
+            unlock_user(p, arg1, 0);
+            if (arg3) {
+                puts = &uts;
+                if (target_to_host_timespec64(puts, arg3)) {
+                    return -TARGET_EFAULT;
+                }
+            } else {
+                puts = NULL;
+            }
+            ret = get_errno(safe_rt_sigtimedwait(&set, &uinfo, puts,
+                                                 SIGSET_T_SIZE));
+            if (!is_error(ret)) {
+                if (arg2) {
+                    p = lock_user(VERIFY_WRITE, arg2,
+                                  sizeof(target_siginfo_t), 0);
+                    if (!p) {
+                        return -TARGET_EFAULT;
+                    }
+                    host_to_target_siginfo(p, &uinfo);
+                    unlock_user(p, arg2, sizeof(target_siginfo_t));
+                }
+                ret = host_to_target_signal(ret);
+            }
+        }
+        return ret;
 #endif
     case TARGET_NR_rt_sigqueueinfo:
         {
@@ -10353,6 +10395,17 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         }
         return ret;
 #endif
+#ifdef TARGET_NR_sched_rr_get_interval_time64
+    case TARGET_NR_sched_rr_get_interval_time64:
+        {
+            struct timespec ts;
+            ret = get_errno(sched_rr_get_interval(arg1, &ts));
+            if (!is_error(ret)) {
+                ret = host_to_target_timespec64(arg2, &ts);
+            }
+        }
+        return ret;
+#endif
 #if defined(TARGET_NR_nanosleep)
     case TARGET_NR_nanosleep:
         {
-- 
2.25.1


