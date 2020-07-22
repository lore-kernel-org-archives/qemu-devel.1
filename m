Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EFAC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:12:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 417F220771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="S/jTkyMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 417F220771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyCfP-0003OA-Iq
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 07:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jyCed-0002x5-Cf
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 07:11:19 -0400
Received: from mail-eopbgr10110.outbound.protection.outlook.com
 ([40.107.1.110]:34565 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jyCeb-00066M-KX
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 07:11:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdVwkqc/MU2sqPeK9ta2UnLN759/5DM/GjWKBOZ+Drjb9t0yuJSlunh3zf5mm3rAmZJNkXkpUQROH1BBokjWUZPJijznNMFMvnzrC+ylhvGXPax18JrB/ZHkvh7gFs2nzLvWALhbecIfZeFxho+Zw3sjkJkIc0jihNGqAzueMdI/VIPuf7QqExVzdEdEShfZqy7RALXB5MF0bvq3btwyNqtKxkAnR8FZBIuKSirdVTVdKDfbDqFh0rtCb5CsQPaz8qAeu27llGG8lbCUFyeuxBpzMm92awgdWWyDOGbdpbp4vkEj2rpj+qELqkLBL8SxvEW6SB31HBe3gj8uKhweDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bWrn2Idg8zs4s0fhtLJy/K27dM5p7w1iIoMpi2aFvM=;
 b=fstf0dqn2YOBhYCPq0SJ/BY2FcVtDvWzvGBMTekjnQdhUTEaOkY5RlyefgMYF2LpdIQrEjBOwk80puLwQz1QR3+mM/Stav/hXXVwzMe3jL8s8fObhVR66qm5m+Cnhm/eHZmrL5c24K1qDeVx4Eojn5PVnWBcbPz8i6dh0xSLvPZErVQi5lft6rK89PuWAuVoD+Lag0zCdo5CTzucM4X5LFx82Aqf/IDkj7UkQK4yk0ubOlfV20vB4tWpoDM9SAM7sox6BjPpGPZrOhr7bSKSQoGUtruZ4yWM1XxX0gpI/RyRdyJiSKztzfMXmyojN7HkW4jEIeGTXrAv+pOEznHL+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bWrn2Idg8zs4s0fhtLJy/K27dM5p7w1iIoMpi2aFvM=;
 b=S/jTkyMJGsXH4nO7SUpNfSDT62A/IqbcQZdI84+91dMecRk+gSi47vqknGf+JSGjsb3tcJo+kjEhTnZkRjYyiECR5JA/hPdAQb3Ln45QL1HriEo9yBMGs+fgLUxk7L1sjCmQNSoVq9ww4MZH2qJ6kOkJ+1p29QO92VjL0Iz+jEk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB4838.eurprd03.prod.outlook.com (2603:10a6:20b:81::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Wed, 22 Jul
 2020 11:10:40 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3216.022; Wed, 22 Jul 2020
 11:10:40 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] linux-user: Modify
 'target_to_host/host_to_target_itimerspec()'
Date: Wed, 22 Jul 2020 13:10:23 +0200
Message-Id: <20200722111024.272553-2-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200722111024.272553-1-Filip.Bozuta@syrmia.com>
References: <20200722111024.272553-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0036.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::23) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.239) by
 GV0P278CA0036.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:28::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21 via Frontend Transport; Wed, 22 Jul 2020 11:10:39 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.239]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc9bd885-e6fc-497f-25e6-08d82e2fde5a
X-MS-TrafficTypeDiagnostic: AM6PR03MB4838:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR03MB4838AA1775239A48EF2511A2EB790@AM6PR03MB4838.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xS/HtxigCyCehyqvhsR45Cn0+QbpNRbhavX8b9ArFMH1ZCe0a1JvMIPUPv6zV4JEVEzzJXmzLJtsBd6HIV4cp6HSqj+iM4PLE6wIMU5csGK1pYMl3Q5eMtO3rSQUsZFvcLEMminn+tFvnLQGCwG3FBmb/Vntz00FLXHVFjKhulaQNjYWZ6aW1031P65o+S/bSRXXNI4Lnk4bVugUCwQRqsAVoeL1LjA12k47po2Rt7Xfe5j7lCT0hbT0xOPRzHMQeYHNXb3kQB/Z2zktRsI5brcgavxA2MsFEnXyfkQGTnsLZlpRsYJLvC6sBLZIoI1g/kEDtCGHyP0NtEXhWf6oirh+3tHsAbxbEkrE34BRC0xViVL+hu0a+rxAIqBosld8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39830400003)(376002)(136003)(346002)(396003)(366004)(107886003)(956004)(2616005)(6512007)(66476007)(66556008)(66946007)(1076003)(186003)(26005)(69590400007)(16526019)(52116002)(5660300002)(6666004)(54906003)(86362001)(508600001)(6506007)(83380400001)(316002)(6916009)(36756003)(6486002)(8676002)(4326008)(8936002)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: FwUr1HkEER3HexagxXZn1iUGNocND4LkNtKlIC8hoBJS4Ai5SZIU96HsBySvEz8fXnla+r98GFwuL3Gs2dRX+2MOM4wK6VMfWus88ZLLhXJfw+FoVTjQoFVYjQvcF/dWqs67uLNdCUcrRpSI2g4gkIQmiRzpkKwpIVsNMUHL/D1XcI5Vl3jmcXbTY4nJKkfuq2h03TPkodtOkyBn2sVVF7IQqbFHd4+A82XEeFYx2Ft60+qZZ30v5jpBuXhPnC55RKFH0Tvk8rrNUmj3snGbt5ar/V22BIABJNuxKwGrfIieJ2gzngtyZMaoljIlLuzILj0RGsSOGqFA8mn2+DhTSDdDoxlvJVrpOIy4an/D1gzsj8s4PY8AsaQLIazPRvoGvFUIACHRzjojAPSLXTADp4NbxMhlSnsw9winuejpXdkAlLZxhlS8W1EG7X+EpPUpmg5MEvbd8YB8JoJT9H9SIy0p4uMWIY6hfIo+CaQ8q7c=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9bd885-e6fc-497f-25e6-08d82e2fde5a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 11:10:40.4414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H1rGALjqwLMGeP3Ozad5JX7oVebGW7KKme9VenHo+lJS9YZFktaOslbNLnEPEPff/rrwZ9LUoObrFv3wI8w2Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4838
Received-SPF: pass client-ip=40.107.1.110;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 07:11:15
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
 linux-user/syscall.c | 38 ++++++++++++--------------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1211e759c2..17e09c3cd3 100644
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
@@ -6790,46 +6792,30 @@ static inline abi_long target_ftruncate64(void *cpu_env, abi_long arg1,
 
 #if defined(TARGET_NR_timer_settime) || \
     (defined(TARGET_NR_timerfd_settime) && defined(CONFIG_TIMERFD))
-static inline abi_long target_to_host_itimerspec(struct itimerspec *host_itspec,
+static inline abi_long target_to_host_itimerspec(struct itimerspec *host_its,
                                                  abi_ulong target_addr)
 {
-    struct target_itimerspec *target_itspec;
-
-    if (!lock_user_struct(VERIFY_READ, target_itspec, target_addr, 1)) {
+    if (target_to_host_timespec(&host_its->it_interval, target_addr) ||
+        target_to_host_timespec(&host_its->it_value, target_addr +
+                                sizeof(struct target_timespec))) {
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
+                                                 struct itimerspec *host_its)
 {
-    struct target_itimerspec *target_itspec;
-
-    if (!lock_user_struct(VERIFY_WRITE, target_itspec, target_addr, 0)) {
+    if (host_to_target_timespec(target_addr, &host_its->it_interval) ||
+        host_to_target_timespec(target_addr + sizeof(struct target_timespec),
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


