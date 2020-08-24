Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A992DC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 19:40:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58042206BE
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 19:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="uba0B8yt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58042206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAIKU-0006bf-IZ
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 15:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1kAIIP-0004Sm-BY
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 15:38:21 -0400
Received: from mail-eopbgr10113.outbound.protection.outlook.com
 ([40.107.1.113]:60643 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1kAIIN-0000YT-6b
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 15:38:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/uPEYftRaO46Zi/pyxkTXeyqxLYj9y0l8KfD2ap2yOkFp7QJN4xSz9TH4dI9TyxbchZRgQ1D7MckUYt8bvu3BMZ4xQrHd9SOtyf7Yj7P+SU02gtYzeJMHEUDCFnW/l7qwxTM5PZxT5aJB7yg1O5C1BPrzFrOQweAZTQ8cy4NVAheNo8jSILp8K5D9DgD8DzXW8nSFjsysE+RTJPt7F+LlWNQDqoY9GzCV56gJ8wxF3Bry0vfxeqNBQH21fNFtfw15IuR6GP16HHciFEQYGf6pBzne86wr0vl50wxXLEn1dfBa5M+p9mAJpF7KBDjuhpZHi/+26MB6DSQyZvMKnMmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D58k38h9xk9Nq28XHZi+jEvQTLchwClfkZEJ2V5IM1Q=;
 b=QAcqPpXIEXCEbb4R6K8HM+VWO8wx1FbxKX7cL8L8Gd4zHMUn3AkLYmc67ynhnJr3+n1vf3sPj4pPfVOboBwKhJz3l4/ueimvGa43AmiS3aZGRh39XmyQMFiq7+mBWnHoYYIeCFle2VoB0m1Nd8tIeGIhmaUxA+7YFhAXB/JS8PVAbQG0KAyM+SaG8ZAxKzy5kxs/DMYIrSWhZC1FrbO2unjKsSgme4gCdo4RIgmkLYSeQlYVR8alikvMmB1gINrdyD4IQzF6xzgksQsBNiuQa0Mc5tO7nGJsqu9bp6GbgY8wMOn0QAqKAnDsKUKfaI0eu6NB2VwJFevnW+O9cL7ezw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D58k38h9xk9Nq28XHZi+jEvQTLchwClfkZEJ2V5IM1Q=;
 b=uba0B8yt8uSTanl5NHnwH7DtcgxARTBiqkMZesgd6geOr1NBRIIAkAn+eVmtKZxwZUhMPWUEXCj4nHGNeVWCACT5cQslpk81ToKfqXAmm8PyE1wx6UkTkA3i/foBD2vFddQ+vgEdFZPtmWJHxTUlB5vNjUKCZz7THX/SY4KCDVs=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VE1PR03MB6047.eurprd03.prod.outlook.com (2603:10a6:803:114::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Mon, 24 Aug
 2020 19:38:07 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3261.026; Mon, 24 Aug 2020
 19:38:07 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/2] linux-user: Add support for 'mq_timedsend_time64()'
 and 'mq_timedreceive_time64()'
Date: Mon, 24 Aug 2020 21:37:52 +0200
Message-Id: <20200824193752.67950-3-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824193752.67950-1-Filip.Bozuta@syrmia.com>
References: <20200824193752.67950-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0251.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::23) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.242) by
 LO2P265CA0251.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:8a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25 via Frontend Transport; Mon, 24 Aug 2020 19:38:06 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cab737b7-fc58-4d53-418a-08d8486539eb
X-MS-TrafficTypeDiagnostic: VE1PR03MB6047:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR03MB60470445CEDB832FB317F4E9EB560@VE1PR03MB6047.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OUfroD0gBccWm2hQCWDTjeELfbtXk+FoTH+6Z97zGrUH8kAhYDOs50pkDJfURTigokvYOCHQ12xRr8I0crGeo+yBrVCDmPZGMKBmg18vYa4K8/QS2Ijp63OSZpZR+wFVz/g3nlmNuxUsaQ9roDOgtr3YkncsoEavEzoVsL0NR4/aZns+n9ntaivBUwhqe2aQ0mOb5XW2UGMaVCvQpSHa6H9cw0tiqEYf4XfMmXkD1o660UIjXRbxWPR45vewxF466q/Uq6Hqhvs3H2/J7dIQIhVD9nDlnawBqORYZVyEq/V+RwSMLc29kLGEs6MQyVTErLILLdoHxIx07l0qgBZbJdRYCYlVbL1eOc9LVfu4h/vIcWEvpQpRXd6BLpX4yx0VuSgrAE0055Cl471HxtM7yw+Ssp8OxCrlu19RQDBJ6RkaOh7lpsToknKDFlvjQCmAL0bLwY1jk3ji7/QXAX5S/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(136003)(366004)(39830400003)(376002)(396003)(16526019)(8936002)(66556008)(83380400001)(26005)(107886003)(2616005)(956004)(6916009)(86362001)(66476007)(5660300002)(1076003)(6512007)(186003)(6666004)(316002)(966005)(6506007)(66946007)(6486002)(8676002)(36756003)(69590400007)(4326008)(52116002)(2906002)(478600001)(54906003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: A6BYmVdxr0qdnpIMAneX4lQZOJHNNbpHgn+QkcRyyDQid8psZrc7G9LWG+fGjrJzeBTM3vKa2NV0mUFOUa2upO6Lo9mE5Al15ZyrjClwjI/3eLaMfDns5IYh/BUilyR+FT4pr3rWWCHq9TwyG9XooQ8aCr1/j5ySe6gEueQjh7+26d6nzTEcdJ9aalwxqYov9+C/7FzKoS0K6VEEEJd/TOerj6j3F/iSfAjz5i9Oo8ox8d00MO2sJtHUY9MWfSkQoESwL6nt4ZAlTZPD/+cqDbAWAnlcZTb6SDG5kTBNT5rETbcsevLhqSbbkFztwmE48J/4oWAWw0J2giJAnqvB+MUPT6zAhSLEMQUv3MYJOt2FazkTFk7FE8+nu+vjpv67xAcmjWWUDMOWUGqWBoylM/b/hU9AzH+Ieirn0VQlcjUppw/cbFwpjDJYMreO5FQN02M9VTCJHueUsZZlz+FgQ+ugmRYNeDSEBBeMAkL2P66gCvM+KTREnT+2RGXkWW0YqrkvTLMq+IgaJUgjhuXfdWzLbL2lrYsUvXHPLY9dra+jzaq8/Fp9HP5464Ps63O3RY4irS4b1N/LDxRXyC6N2OS0MGgJWAcRo+rLWJmZXW4ppRHyJWfebnvfON6U1x8BSCVKWNsYN+utM/IkpIXg3g==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cab737b7-fc58-4d53-418a-08d8486539eb
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 19:38:07.4990 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ozgM4d3R7v//wB5iX3XHtAB0XtwJx7zljzygsqH1rwWuDa9cWoHh3bbYj5FoKiZEPTshwqrWb39GRo5aeZgLkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR03MB6047
Received-SPF: pass client-ip=40.107.1.113;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 15:38:08
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
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 58 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 4ee1de6e65..3331ec9fea 100644
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
+                if (!is_error(ret) && host_to_target_timespec64(arg5, &ts)) {
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
+                if (!is_error(ret) && host_to_target_timespec64(arg5, &ts)) {
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


