Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DD2C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 15:36:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3E76206F5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 15:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="z5tLTx/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3E76206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyGn5-0003TW-4o
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 11:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jyGlZ-00027p-Jz
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 11:34:45 -0400
Received: from mail-eopbgr140099.outbound.protection.outlook.com
 ([40.107.14.99]:54099 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jyGlY-0004dy-1q
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 11:34:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsEuodJQTIGTnnv21ywxtfQW3nayhELemlvuL2Ub20Sy8npajj2k5VBYwBvpM3Q6M0J5AQJ73Tl6LGGyiWgKDGz1ahat7ThUEeMGy27ZhOhwKSwr9gG71mCJI+2q0bN4rU4o5oC2rl97cs+1ycv6YxNVuauNFqKxIJK7OCFX1p+Mn61HlBuenZYRwgO5h1FpVfwLc35xff6X/gQqxdr7kmDrGOKcdQL49NceunhoFmUwTDVBSCJs/JoeOy/Vcb9mTGuPi5u0iHfL/jfuPb4k9YRmRG82/GVFb0uxz2oDqtC1Fij0vqiludCiDfZq6s89y5MFXxehBBmPjy/qSwhS6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmMZ+gmSSMnYfibJvwfYQ9AcWZeGPIhKy1fY6CaWyco=;
 b=DA+HmjK/jOACfgIeoR+baFqWU54joqC176uY2/l9i21GZ7f30udekc8JjEEpAlLI0oLZlzIK3LbbLYfsxsPfMviLaQwpOkATPUZz9raM5Q3pMlEDsEwII3n/t+EhS6O99tdpGTAe5TEAToBQzsPX2g7tsZyjX/cBNUBLQoJOdRDZqxBiLJ8O244AEMgxCQaN00lHkHcZhuALRlR+v6b/qHsRwxXHUYgCtEbejI69iH4w1xIxQaIHh+uWMyk/EmFopj/jkYMfrmXiix+55t3pvt5RDgYP/x3QnPzrJ/SLIMPVtZXPtKRYY85rHAo0CdhxBiRJ2zYfc3qtTZtf0QgSdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmMZ+gmSSMnYfibJvwfYQ9AcWZeGPIhKy1fY6CaWyco=;
 b=z5tLTx/SAV9xTtTDMoIcaqZZv61ODmVWRbsJs2LpvC//NuMKulX21uzR3XTGtSlxQW0ksKNDlWyMGqHIRUaxxNIMw/rtRi66UXVtl+VLaQDdU0RllYwQ9Z8CmG/mWcwrabNupUJP7epXK+HHQNLJPUvpD/c4Y2YLxZtxtXPnurE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB4744.eurprd03.prod.outlook.com (2603:10a6:20b:b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Wed, 22 Jul
 2020 15:34:38 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3216.022; Wed, 22 Jul 2020
 15:34:38 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] linux-user: Modify
 'target_to_host/host_to_target_itimerspec()'
Date: Wed, 22 Jul 2020 17:34:20 +0200
Message-Id: <20200722153421.295411-2-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200722153421.295411-1-Filip.Bozuta@syrmia.com>
References: <20200722153421.295411-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0008.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::18) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.235) by
 ZR0P278CA0008.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21 via Frontend Transport; Wed, 22 Jul 2020 15:34:37 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.235]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29b339ce-62e4-494f-0e81-08d82e54be47
X-MS-TrafficTypeDiagnostic: AM6PR03MB4744:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR03MB474422C856BF842224EF5969EB790@AM6PR03MB4744.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wz5YiqKAHYQuaIHwyxhO7J8FkR5Le+K9sdHvsHWVp2/+KfrKwwZ/qbStKpv3aoUaCdHyVsALFSC/5IhP4KEtfDBa9KydcyQCiQlPsW1cPXDiVEAH3iA96JvBE2+1YavsPbj9dbwZTOOUa9WH6iBuYfNpCJUq2XMq55CkJge4LvkimQ05eIXl+2A31noYP4au8r3NufJ2umoDFQgavmJJY3c7pJ3SJgSX7yB1NHgW8i7ARLlaI7fD7oFrXhXVawQH+6UB5sFB5u4V4wBfwko/9rhbHibeHznWC/9OjTLpR4EjNVdNJHrwJxMIj+q2o0piKCwMWmLuwd835Ebhj+G4JpUVlTrAFPi+P/rmu07DGDNTI+0Dt9w6OIkpNIsnV3R7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(346002)(376002)(39830400003)(396003)(136003)(5660300002)(52116002)(8676002)(508600001)(69590400007)(8936002)(1076003)(186003)(36756003)(26005)(54906003)(6506007)(956004)(2616005)(107886003)(316002)(86362001)(6916009)(4326008)(2906002)(66556008)(66476007)(66946007)(6486002)(6512007)(83380400001)(6666004)(16526019);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: rVnmz1Err+4RnLxNUQSlEMhYaNztgMS8tYNQE4GZT3FLU2BqCG5XuKwyxhoqP4OmWtcCGRD4SGK0n1FdBpYlrxLzOgNuifUr84byN2fvTi9ieEO39cpLQOo7ABoyT43IHuHD2GKoQAMBqgUl214HoxePCv6XEIVA1lnZB3KeaGS8qRklHqiv1NVbX0wqYYJmmZRTOBW1iUHzweYNIcCYkv4HwFMAhhIjf69HEUxEL36cLsNIRrUFmtZypp8Anz7Q4JMbAbraHVvgF8L17yTndl5V+LY/Iic7dapVfnTJMFtrfqF2kjo8skg2n/jAOFG3a0+1Iyc4bIrTLEDvUcOHhmsFlhpJWIrO0y6sxhLPBIiB3328U2n7cU60QKKVy9LsLqiD2Pjzrj8u1gfWGNZu9MRAHM8SqwZ4PvrKszmZ+RCEybEuGL4udq69zrKYN9Uyx3y6HGjOD0IJQwUCJHVJf5qa4hBcinjSQ672bAy/T18=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b339ce-62e4-494f-0e81-08d82e54be47
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 15:34:37.8992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pR8SFtB4BMTUFXW3WaPqCMQ+C39CpY+/WCpgqKW6hOCik5ZhHMuskFr2STVF6hEAmOj1kKONDTwc/+3R6hisNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4744
Received-SPF: pass client-ip=40.107.14.99;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 11:34:40
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Laurent Vivier <laurent@vivier.eu>, Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Functions 'target_to_host_itimerspec()' and 'host_to_target_itimerspec()'
are used to convert values of type 'struct itimerspec' between target and
host. This type has 'struct timespec' as its fields. That is the reason
why this patch introduces a little modification to the converting functions
to be implemented using already existing functions that convert 'struct timespec':
'target_to_host_timespec()' and 'host_to_target_timespec()'. This makes the
code of 'target_to_host_itimerspec()' and 'host_to_target_itimerspec()' more
clean and readable.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/syscall.c | 46 ++++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1211e759c2..b1baed346c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1236,7 +1236,9 @@ static inline abi_long copy_to_user_timeval64(abi_ulong target_tv_addr,
     defined(TARGET_NR_nanosleep) || defined(TARGET_NR_clock_settime) || \
     defined(TARGET_NR_utimensat) || defined(TARGET_NR_mq_timedsend) || \
     defined(TARGET_NR_mq_timedreceive) || defined(TARGET_NR_ipc) || \
-    defined(TARGET_NR_semop) || defined(TARGET_NR_semtimedop)
+    defined(TARGET_NR_semop) || defined(TARGET_NR_semtimedop) || \
+    defined(TARGET_NR_timer_settime) || \
+    (defined(TARGET_NR_timerfd_settime) && defined(CONFIG_TIMERFD))
 static inline abi_long target_to_host_timespec(struct timespec *host_ts,
                                                abi_ulong target_addr)
 {
@@ -6790,46 +6792,36 @@ static inline abi_long target_ftruncate64(void *cpu_env, abi_long arg1,
 
 #if defined(TARGET_NR_timer_settime) || \
     (defined(TARGET_NR_timerfd_settime) && defined(CONFIG_TIMERFD))
-static inline abi_long target_to_host_itimerspec(struct itimerspec *host_itspec,
+static inline abi_long target_to_host_itimerspec(struct itimerspec *host_its,
                                                  abi_ulong target_addr)
 {
-    struct target_itimerspec *target_itspec;
-
-    if (!lock_user_struct(VERIFY_READ, target_itspec, target_addr, 1)) {
+    if (target_to_host_timespec(&host_its->it_interval, target_addr +
+                                offsetof(struct target_itimerspec,
+                                         it_interval)) ||
+        target_to_host_timespec(&host_its->it_value, target_addr +
+                                offsetof(struct target_itimerspec,
+                                         it_value))) {
         return -TARGET_EFAULT;
     }
 
-    host_itspec->it_interval.tv_sec =
-                            tswapal(target_itspec->it_interval.tv_sec);
-    host_itspec->it_interval.tv_nsec =
-                            tswapal(target_itspec->it_interval.tv_nsec);
-    host_itspec->it_value.tv_sec = tswapal(target_itspec->it_value.tv_sec);
-    host_itspec->it_value.tv_nsec = tswapal(target_itspec->it_value.tv_nsec);
-
-    unlock_user_struct(target_itspec, target_addr, 1);
     return 0;
 }
 #endif
 
 #if ((defined(TARGET_NR_timerfd_gettime) || \
       defined(TARGET_NR_timerfd_settime)) && defined(CONFIG_TIMERFD)) || \
-    defined(TARGET_NR_timer_gettime) || defined(TARGET_NR_timer_settime)
+      defined(TARGET_NR_timer_gettime) || defined(TARGET_NR_timer_settime)
 static inline abi_long host_to_target_itimerspec(abi_ulong target_addr,
-                                               struct itimerspec *host_its)
-{
-    struct target_itimerspec *target_itspec;
-
-    if (!lock_user_struct(VERIFY_WRITE, target_itspec, target_addr, 0)) {
+                                                 struct itimerspec *host_its)
+{
+    if (host_to_target_timespec(target_addr + offsetof(struct target_itimerspec,
+                                                       it_interval),
+                                &host_its->it_interval) ||
+        host_to_target_timespec(target_addr + offsetof(struct target_itimerspec,
+                                                       it_value),
+                                &host_its->it_value)) {
         return -TARGET_EFAULT;
     }
-
-    target_itspec->it_interval.tv_sec = tswapal(host_its->it_interval.tv_sec);
-    target_itspec->it_interval.tv_nsec = tswapal(host_its->it_interval.tv_nsec);
-
-    target_itspec->it_value.tv_sec = tswapal(host_its->it_value.tv_sec);
-    target_itspec->it_value.tv_nsec = tswapal(host_its->it_value.tv_nsec);
-
-    unlock_user_struct(target_itspec, target_addr, 0);
     return 0;
 }
 #endif
-- 
2.25.1


