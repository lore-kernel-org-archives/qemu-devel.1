Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D15C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 19:22:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 274CA20578
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 19:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="GAgXKGFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 274CA20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAI3N-00078i-AU
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 15:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1kAI2O-0005su-Ar
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 15:21:48 -0400
Received: from mail-eopbgr70128.outbound.protection.outlook.com
 ([40.107.7.128]:6919 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1kAI2M-0006qi-IN
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 15:21:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSbjeO/huMAzJpyGyHOf66xFtHBc6UHih3gfFGgAIS54dY+v1F6JbefF0BoHqAoV1ZTGFAwx++azMKhbYDY3onLheFB2tzdNu+Cl6/+VAxs1ffg/cHWsHeWiUby+zHxk98AgIIo9upo5gqXoRHQHqC/8MP/Dne6+SODXjuw+6kLWZvtlXgSwW5AUG50p1LdiROMzb1KSorsCTaVdR30rSpR1AviT5OTxGPXiVghXih7GzPNi3j1pz5CXfrYT/iKbQsOTZgUUyUuFfb+Oie0MYj2mr609ZBKZFhgdJZoqEluNozS6S6IRNBcfUbUoTdy16XkE2q74lfgn/eVrNwtdmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggqDEXsd5E6qQLIjbuwhSkczyc9cXyy9GfvRMFHH/b4=;
 b=VpaA2F85KK1EpIm0vR4NUxyx0z9dlZZupr7e7VRyWQNwokVf3ItOPO7q5UD8Fbf5cakocHji1lXJDUutGQp9YrcVmFp/2/wtBhlDVnLubAnnDsiuGt6ehdbX3PI/xeZbyTv9F39yvrj79WJe+b95mLuPIlZGg+8/O6c6g1L4GX1AI8/sSo36un2ttCM1zyYZjRD2sKneAnf+8vvkzit52JeB+Ly5Wbam75Kv8Qd7POW9mMMypo449sG0SxfaPcxkjbHe+9KTSjwIATNkkVb4HSxs+I6PL1Fv4HWB4wzx5EPz3YJrZ+asQb7LDnYgWg6+TEew1OO8x1/F6jwGu3gluQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggqDEXsd5E6qQLIjbuwhSkczyc9cXyy9GfvRMFHH/b4=;
 b=GAgXKGFr8aXW0MY5jSuuE+sCwt4MdP7oF7atOgvZD9Pqd/FZadIlPPJCIoCueXKU5KuFrUpX9f+zbZBC0oPoxu8NsDFDKmf1sNqv1yUqokZ89Iae8bwo2DyCYqJiRSMVhew+T7e85BljVzME9ndh1cIAfxjL435HD/hDbeICQDU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR0301MB2254.eurprd03.prod.outlook.com (2603:10a6:800:29::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Mon, 24 Aug
 2020 19:21:32 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3261.026; Mon, 24 Aug 2020
 19:21:32 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/2] linux-user: Add support for 'rt_sigtimedwait_time64()'
 and 'sched_rr_get_interval_time64()'
Date: Mon, 24 Aug 2020 21:21:16 +0200
Message-Id: <20200824192116.65562-3-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824192116.65562-1-Filip.Bozuta@syrmia.com>
References: <20200824192116.65562-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0017.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::27) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.238) by
 ZR0P278CA0017.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Mon, 24 Aug 2020 19:21:31 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.238]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69226eb6-51ec-4581-c6ad-08d84862e867
X-MS-TrafficTypeDiagnostic: VI1PR0301MB2254:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0301MB22542082B5513D0AEF1BD758EB560@VI1PR0301MB2254.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t3epBBC2926yJWX8mKqbDr9SATCSs+5Pe+McysobhzDIKCf4gUfN8BY1JL0IpHhSmtPVNrRuBZACG6Up3ykDZq/lUlfLgW+DJx1g9e+kMcnM4KungWGGxuV5Oub5o9braM0M/5UDn9uRDlztIPIbHjHlMf1/Gmr5jR4hqQ9/5stm9ei3dz24m053+kDr5+Heo+k4EeuTd3BKIB7q7V8wn7G6oB9iCESLcIpZphrNFsUifvnCc4qGtEASafJFsDKt6e+XjQh0h9Qn5ZnapMYThwvOQtrH1BZMVCY+iVKcZtmzxmVF9aZYxNN24AHrcfaUHlmrDb2gY/W2wAEYpsdEANWiDOjWJg89Bb5EZcGiNN36JCAxnXMUJugZHREEmG6bn65ZxFs/+jKM0rlqEasB2CELULg2VkUZUKWKp1DhZIx6bZBw/hWxkqBJH1xdXQExvAYn4CKsT1IRa/QYRWwogA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(376002)(39830400003)(136003)(396003)(366004)(6666004)(956004)(2616005)(5660300002)(66556008)(66476007)(66946007)(2906002)(1076003)(478600001)(4326008)(107886003)(83380400001)(6916009)(6512007)(8936002)(6486002)(966005)(186003)(6506007)(69590400007)(16526019)(86362001)(316002)(52116002)(8676002)(36756003)(54906003)(26005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: cMqE0IJJ+E7v52BVuNLNPRUDmSMVZrs6tpQVcrD+xzZnhmt1qv5tuIZ7RzQknEDLpJuNbgGIY5+W9JE4V92/3gDewVCR6MM/aw3B6WDEt6kPtIJXd/jeUu4Qo8y/HclitzepnGPW1MTtKDjxfwrX1jFDul21zjfaVsanJZ4kG+bdZy5olNOfatNxzTiWOW342eqwiO0i1Xgp0Q4jsK4xHdZ9y/k5rOx+9Y5zTKW/m+rOpP4SD8fiOOqrhu3DEB+P5l1TcKnOcI3VsffAFCRERdvk+Hfp6T8IRcLwostiaCNpgLMo4v7F0Bc3Bv31F8Z+4Onp7NjEQLPpqUhbUn/L/4gnAJh9FUfadz7dAHDPuOY9ufwaUq2plU0u6Ly2rjoqkzKIaZ3v3fpmF4C1+N/AvCNq3MRl2QIBRUVvEtoJxkOiVpkGiKab0wDDiKFBD7djUpR5Mb94B4D6tehLV1UVowpZXNSTraTQOTreFKJnRrEBES9CShbKl7iynqRdsZNAKHqGANi3nKsLFcg6L1oGDTHv/raJM4JkIYTieqNGDEhr/zbiuxgGSx4b1latnz681l0PeQQz9erPP8YSGJRV2F5loN9JvHls/oM7NhTip8e25XyHBRESDVlzEghp4HGmDij8Ao/CV/OpJJF6X1vo/w==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69226eb6-51ec-4581-c6ad-08d84862e867
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 19:21:31.8453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vXKLYZDLUjBIfDW/tvNM8yb4keuUmOEkj79tdqkBNKxU1JHshuBuEvt9swr1kipciRcNRER3HHFEWV+6rDTBRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0301MB2254
Received-SPF: pass client-ip=40.107.7.128;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 15:21:42
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_PASS=-0.001,
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
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 53 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index a359bd8620..0533a5a5bb 100644
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
@@ -10351,6 +10393,17 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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


