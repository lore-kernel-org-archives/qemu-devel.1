Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11F0C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 11:25:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 766BF20663
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 11:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="VbUDiMeT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 766BF20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k01GC-0007Im-PD
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 07:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k01E9-0004fu-Ms
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 07:23:29 -0400
Received: from mail-db8eur05on2106.outbound.protection.outlook.com
 ([40.107.20.106]:9642 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k01E8-0007B7-2b
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 07:23:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UujF1mRR671Cv+rq5MGbnv6RLPCwRmK6Ld2MI8aIPiI6IOE9nQSdEhutpf2PSViN54HMm/fPlPachko5FdKA+TKaN3K85dd8ycyhyTuYI+g6Yuvr6Xk9LDF+PvWVRqYgP6tieFwrXYyvYVnCePgJxKOs6syiZ4FY4A5br11QS+geXcLqaa9bs8UkaS9GORwPshP+/W2opU5RCfPfWPs+xvua9xX6sFOAmZMej7FcR0i92c6C6gMJl486aZaXYMfMX4qCIaILqhWLbEUEMBm7yl1r4An5V6TY3LSDWcZw/pp4klY1maQ5y6/usmWHsv3GzRx8MRGv3hfA77cbsKj5jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XM0oU0jj09TQ+hjFC4BrUTXRd0AMuHaaQ9g9hRjd7zE=;
 b=axz2czFZk65zEefifraGQQJaMkgPYwjeoVfGRD5BOJvfpWZUH4i3sTs4cjLCjVqkVLfWNGnrfFRxB9HH95H+l+XDNN3BguXMTeVz+5IjB86Eig4DsZmKLjtXEFC0bsOXsNipSpOHfChj3V+XHFFPY3V/Sy5gfgHnqZT1P3BaHzdyx5hqbqGGMklnNvab/b9CevJ1nDRGDKRgDPY2fA6HNEmE3Irov4nCTjpgJQK4kHyZUYZ+8+9NvyAynByy85Y3plv3F4zVz+GonutDoLY/Z72+GMkfGGbudRGlTxBsiAs7O5WhkWU2Ko1RmhbdZ/xEf1WH9cVDQO874k0DoPBqtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XM0oU0jj09TQ+hjFC4BrUTXRd0AMuHaaQ9g9hRjd7zE=;
 b=VbUDiMeTztyfeb3hVOMoOEZsvV+Ggl7quUA2fsyL7f/zdGev/m2z3Xa/dJE4+WI+NwA4Q3zjRiJWQUGLDB/Wpz4GJQIVOUjNUEojSOepreqBdSjJjUZnwsMgQzdrCyjrlAGl36gPCBa9pjSjhSAxGmoIMMZJewyFPkRvMKcQ1eI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB3509.eurprd03.prod.outlook.com (2603:10a6:209:2f::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Mon, 27 Jul
 2020 11:23:22 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 11:23:22 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] linux-user: Add support for 'rt_sigtimedwait_time64()'
 and 'sched_rr_get_interval_time64()'
Date: Mon, 27 Jul 2020 13:23:07 +0200
Message-Id: <20200727112307.343608-3-Filip.Bozuta@syrmia.com>
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
 15.20.3216.20 via Frontend Transport; Mon, 27 Jul 2020 11:23:22 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.240]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89846542-cf94-475e-e859-08d8321f78ce
X-MS-TrafficTypeDiagnostic: AM6PR03MB3509:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR03MB3509E3CEA322D8BB4675F327EB720@AM6PR03MB3509.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tvrajY5VS8Np491eOKvxO/IWay1odxaTveuqeV0dT5T2ITLs/F4yZjN4y8ImvRyL8o4wGygYs1RaY/BLa/erreUV+6w+7OXgsA0ynqsjpCLiksswVgpIBS6nTrWNxKm+r525mpBrW9zaxiSPZIu33EDd0CD3EYc1U97DDvE2JVJrmK3Q2TeclizmewBK8jyC4EgFK65InXGDNLOho5AXE4fXqbGhyJfp9oHJXAlVVyQOZumj4MjBBCAaOYoATAJkV49R1bis+ItcfsO0xjickVYZGgK31tRrtXVly6Y8Pl861xbgXrMUCg4Ye4kYYdVck5jEByjfLTxibf17iOnOX6aLLo565tVnr3QiSaiLClwRTo5ak0mEC24Q+pH+3gqs1KEKIAVLQ5pc9uihr7//oaPGf76C1eOM3ImtzQq3ysa+FdQim4L2TkGpcIp/3l5QBsiHaR28IXdyPfqR5fkBLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(376002)(396003)(366004)(39830400003)(346002)(6506007)(83380400001)(107886003)(8936002)(86362001)(69590400007)(66476007)(966005)(8676002)(52116002)(66556008)(36756003)(6486002)(5660300002)(1076003)(956004)(2616005)(508600001)(6916009)(26005)(316002)(4326008)(186003)(2906002)(6512007)(16526019)(66946007)(6666004)(54906003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ig12Z9x5SYCofF3L9sfQ/+m2DDpnluVcpvsZx9/wRNVvlCGmjQB2u8t9qt7KxfEtE1wczmfDo4ZbOju12Rz7i6NRSqe0wbcbX6xbdvZN+ntGtaGml7yRuvrM5K5eVg1rtOyBNPdldauTSPGYlXriUJGFiFLNGzosd9RH6MHCIhC8ZBKuUZvj89Ku6WjLgD7yyXep3FUfTzqsgqAAGtJG5QXpUKK4oXrA/6laRIZk4iANB4H3JDaFkGvV2xSwxLUC1TRrepnPlsZbAwbDYctfk7HaJLbvI2v1h+zm0P4MDnmlQpkiK1p6wp0utQXyhENX8GfFCeHPMhSXaWM0YSuGGf0XEkibV3xISVG1AOQCsd32zmfzQbE3Xk11D/X3TSnnMfTu8BN0/G1OBHNiCPfYQjGsl3QmOJq7jbFxdBeY0rC+476HK16NSnr7hice0NTYs3GqKvqWnrknzuxoR1/QkUSchV33reR3pFN8na/0urg=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89846542-cf94-475e-e859-08d8321f78ce
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 11:23:22.7254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vWPR18XN7jn3kw/CORas6YmWz5ws4qa1Xd/R7rhqYH6LpFSVsIodXi5OLaN+utyn9R1jGPryaXT2AkZjDUnkeA==
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
index c1b36ea698..35f6dded81 100644
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


