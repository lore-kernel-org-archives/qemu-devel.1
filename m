Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2321DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 13:58:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6921206B2
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 13:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="PGpjPCM/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6921206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5rHA-0001lG-1p
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 09:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k5rGR-0000xW-9n
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 09:57:59 -0400
Received: from mail-eopbgr80112.outbound.protection.outlook.com
 ([40.107.8.112]:43264 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k5rGP-0007KP-Is
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 09:57:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONGPKyfLEM3rnyTGHCUB2L4TjUhmUnY0fpspRzuLUX8sfYKUBymtOZQ3jrjNjgYYv3dOExRKoqJeezWTP4q9KT10vCjfo0Riw61lXMD/psl7eQugTOe+Mw3EKC28bNT0E3W6RVCejU8cHpJPdMAbB0QlkiyxJnhIDW9P2K1HOQEAxsqqzkOCa4J8Phqh1Bbt4t+H0AgIg6Hlc8RT+ADFMpSl7WlSwZlUDPtK1WkV+aQRtigMyrvQdY7V3XvEmj5ZsaRJKwr+2zkk22fGxad+ozJbz/9fCSBJp08b1dbofqOZKdDf2d5wBSFZTwzD5MABkRdqmj8TMcZbcu1dnLRZuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoSs1F1XuJ97JwuSV0UpM8yNCLM+4UxxRCCkK98LvrM=;
 b=Iae7627lXnAksXhIH6f6SKWWeP2V2A4EBTE3Z3I0T37V3W3UKDnQIah4QYEAXb3KMVBzdhp2ZX8SQL8I9nVXQziWxyXZ4B+aPCBScsB2EyYeh0YKg11rtFZAW22mX3b2pVt/YRw+RVS/yalfUuWNp6DNnjExC855Q1RpVavOt4D8HhYBHW8IuS5fgCGm9aGFwCu7uP+v2hULYMN/A71uAmYRDE1FfF4+5/qh2GRhcN6i1s1jDwKR0JFGRUI1FS59kvO+i6y563j9JH1muhyI+AD17Fc4JTts21ePU4nmWcoBVzeSPL56OFD4qIJAunsSGJwY68x1/1nkUnoKGgH9Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoSs1F1XuJ97JwuSV0UpM8yNCLM+4UxxRCCkK98LvrM=;
 b=PGpjPCM/VdNv4H8R2/mTWhgfkHnQXrVPk43VQ4vqgXvLvxnZybkKRPiExHBvh+veZ/Gakh3kIK2cgl21PZ+aCTaf0BrBwZo2zUFn0E7hJP3ZSbmA3Zvl45r4LlxrfgC1YFKx8qVSzCdJp8woHsZuu6XIYBT6sOGSLWDRUbQNlJQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR03MB4928.eurprd03.prod.outlook.com (2603:10a6:803:b6::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20; Wed, 12 Aug
 2020 13:57:19 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3261.024; Wed, 12 Aug 2020
 13:57:19 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] linux-user: Add support for 'utimensat_time64()' and
 'semtimedop_time64()'
Date: Wed, 12 Aug 2020 15:57:03 +0200
Message-Id: <20200812135703.39404-3-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200812135703.39404-1-Filip.Bozuta@syrmia.com>
References: <20200812135703.39404-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVAP278CA0011.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::21) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.238) by
 GVAP278CA0011.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:20::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Wed, 12 Aug 2020 13:57:18 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.238]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81a69fe3-8e2b-472e-9445-08d83ec7a0fc
X-MS-TrafficTypeDiagnostic: VI1PR03MB4928:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR03MB4928D253E4BA7D2EE8E2DA01EB420@VI1PR03MB4928.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RUIzv4trut09maOPWNBdbUylat8O2xFx3nuSUbNLMsxdjlHJL7tvhXQEbrmIs4d0wigHKWLfWdSCrW6BTvbODM8CZ8xTzlYRBBRX99VrtK2/K8Ymyj2HpkfW56auuKvfEn5FeawR5cs/lmWJzegCpQ+ZZEYCD07OrT+zrl96QEjrZI4sTr4YmtH7hNyRsAlaesys6nFi9BHPHDYJ+hsoEdTHS6jOkTDMZabFErazkRUN3kNJ3RyJsSEhlP7Bx4Z78AukgPYPTcE7gLBqKLoFxTzIW7ULuPQW8UVoC68elZ7Y/lGR3BVbkKi2dSj0TP3/Ke/jdtkkswvzB2JW8aWohts+SguN4EGwHD2n7TFjym8oreOCK8IUfiLSV6KXMrZbS4CF3VLspBYRqsOudNriDnmLsCvZhnIZTHcs8eUrX8m98Wtym+TFBjq8/i2ViVTRgxrrEaM6BQjwF8C5HVXkJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(376002)(136003)(39830400003)(346002)(366004)(107886003)(36756003)(1076003)(6506007)(966005)(5660300002)(956004)(6486002)(6666004)(6512007)(6916009)(54906003)(86362001)(66476007)(26005)(52116002)(8676002)(66556008)(66946007)(2906002)(508600001)(316002)(8936002)(16526019)(186003)(69590400007)(4326008)(2616005)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: DhBNAbiduKVzJIlwLyxvifmtbWSQwxsDvfe2lmISY86MLIGqKyjiSSBUULfeiqMxQmw9KbzXxIKyi6gi8/dVu9La3CxwOV2ObSVQeJ3WElM9+6MfmZb2NCTBykWo0HzeVKFLeRydTYGJsaJnjnZXoJaRe+LQhBXIqdtaClNQcrssI5eNqvBdx6Wcdhjc6CulzIM6lT4jx1HdWLi23ELsxn+qLRka9fq0oPyWpB6UXTQxTU1A6AKDlevqbfYlficQmS+lTXJZ8bE4FojtWJFSVtvUVabisTP665rZBKkQjj51Fb+c6BpD0sCJDtSx0iiLPR56GimlTAyjxxJ4flaMdqF5H1O+QJD6lFonCQD4zATfcbFdmJZA3v3+L9FnsXVirg5ykeWG1SxM7Exw68cjXHm4TBCejHhbE+6SDyCt14EGHF4pn0kr2k7SnQgzugLFfyWqfXRJmvj1xUyZ2NTRoKRSLELSL8mQKnUof6XnmynfX9F6lxweo2yvyj9xrxjvN1mVHdcazxVv3NYwFHkc3MiNs5fyMXbeDdLeFbV1jVkA7AAsOMg56InRAhwGzHSNkhUGB5cfXplGtk/bXIBQbfP66J9Abi0mCFEHsika+fPflSjG+CRsbPp7FpgX5C6cXUk7Ix8K3Tt6uoZgvykA1g==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a69fe3-8e2b-472e-9445-08d83ec7a0fc
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2020 13:57:19.4705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qnle+ouFYwSrgS5m1xuzv1rZXVWoZUadtLToYv7JJSNSFT2emE+CQvAVVyJrhTD0kVjQO9EvSj8zR6XfA4vgxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB4928
Received-SPF: pass client-ip=40.107.8.112;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 09:57:53
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

This patch introduces functionality for following time64 syscalls:

*utimensat_time64()

    int utimensat(int dirfd, const char *pathname,
                  const struct timespec times[2], int flags);
    -- change file timestamps with nanosecond precision --
    man page: https://man7.org/linux/man-pages/man2/utimensat.2.html

*semtimedop_time64()

    int semtimedop(int semid, struct sembuf *sops, size_t nsops,
                   const struct timespec *timeout);
    -- System V semaphore operations --
    man page: https://www.man7.org/linux/man-pages/man2/semtimedop.2.html

Implementation notes:

   Syscall 'utimensat_time64()' is implemented in similar way as its
   regular variants only difference being that time64 converting function
   is used to convert values of 'struct timespec' between host and target
   ('target_to_host_timespec64()').

   For syscall 'semtimedop_time64()' and additional argument is added
   in function 'do_semtimedop()' through which the aproppriate 'struct timespec'
   converting function is called (0 for regular target_to_host_timespec()
   and anything else for target_to_host_timespec64()). For 'do_ipc()' an
   check was added as that additional argument: 'TARGET_ABI_BITS == 64'.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/syscall.c | 55 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 9 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8f63a46f58..44a13c5ec2 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1253,7 +1253,8 @@ static inline abi_long target_to_host_timespec(struct timespec *host_ts,
 #endif
 
 #if defined(TARGET_NR_clock_settime64) || defined(TARGET_NR_futex_time64) || \
-    defined(TARGET_NR_pselect6_time64) || defined(TARGET_NR_ppoll_time64)
+    defined(TARGET_NR_pselect6_time64) || defined(TARGET_NR_ppoll_time64) || \
+    defined(TARGET_NR_utimensat_time64) || defined(TARGET_NR_semtimedop_time64)
 static inline abi_long target_to_host_timespec64(struct timespec *host_ts,
                                                  abi_ulong target_addr)
 {
@@ -3886,7 +3887,7 @@ static inline abi_long target_to_host_sembuf(struct sembuf *host_sembuf,
 }
 
 #if defined(TARGET_NR_ipc) || defined(TARGET_NR_semop) || \
-    defined(TARGET_NR_semtimedop)
+    defined(TARGET_NR_semtimedop) || defined(TARGET_NR_semtimedop_time64)
 
 /*
  * This macro is required to handle the s390 variants, which passes the
@@ -3903,7 +3904,7 @@ static inline abi_long target_to_host_sembuf(struct sembuf *host_sembuf,
 static inline abi_long do_semtimedop(int semid,
                                      abi_long ptr,
                                      unsigned nsops,
-                                     abi_long timeout)
+                                     abi_long timeout, int time64)
 {
     struct sembuf sops[nsops];
     struct timespec ts, *pts = NULL;
@@ -3911,7 +3912,10 @@ static inline abi_long do_semtimedop(int semid,
 
     if (timeout) {
         pts = &ts;
-        if (target_to_host_timespec(pts, timeout)) {
+        if (!time64 && target_to_host_timespec(pts, timeout)) {
+            return -TARGET_EFAULT;
+        }
+        if (time64 && target_to_host_timespec64(pts, timeout)) {
             return -TARGET_EFAULT;
         }
     }
@@ -4426,7 +4430,7 @@ static abi_long do_ipc(CPUArchState *cpu_env,
 
     switch (call) {
     case IPCOP_semop:
-        ret = do_semtimedop(first, ptr, second, 0);
+        ret = do_semtimedop(first, ptr, second, 0, 0);
         break;
     case IPCOP_semtimedop:
     /*
@@ -4436,9 +4440,9 @@ static abi_long do_ipc(CPUArchState *cpu_env,
      * to a struct timespec where the generic variant uses fifth parameter.
      */
 #if defined(TARGET_S390X)
-        ret = do_semtimedop(first, ptr, second, third);
+        ret = do_semtimedop(first, ptr, second, third, TARGET_ABI_BITS == 64);
 #else
-        ret = do_semtimedop(first, ptr, second, fifth);
+        ret = do_semtimedop(first, ptr, second, fifth, TARGET_ABI_BITS == 64);
 #endif
         break;
 
@@ -9783,11 +9787,15 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_semop
     case TARGET_NR_semop:
-        return do_semtimedop(arg1, arg2, arg3, 0);
+        return do_semtimedop(arg1, arg2, arg3, 0, 0);
 #endif
 #ifdef TARGET_NR_semtimedop
     case TARGET_NR_semtimedop:
-        return do_semtimedop(arg1, arg2, arg3, arg4);
+        return do_semtimedop(arg1, arg2, arg3, arg4, 0);
+#endif
+#ifdef TARGET_NR_semtimedop_time64
+    case TARGET_NR_semtimedop_time64:
+        return do_semtimedop(arg1, arg2, arg3, arg4, 1);
 #endif
 #ifdef TARGET_NR_semctl
     case TARGET_NR_semctl:
@@ -11969,6 +11977,35 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         }
         return ret;
 #endif
+#ifdef TARGET_NR_utimensat_time64
+    case TARGET_NR_utimensat_time64:
+        {
+            struct timespec *tsp, ts[2];
+            if (!arg3) {
+                tsp = NULL;
+            } else {
+                if (target_to_host_timespec64(ts, arg3)) {
+                    return -TARGET_EFAULT;
+                }
+                if (target_to_host_timespec64(ts + 1, arg3 +
+                                     sizeof(struct target__kernel_timespec))) {
+                    return -TARGET_EFAULT;
+                }
+                tsp = ts;
+            }
+            if (!arg2)
+                ret = get_errno(sys_utimensat(arg1, NULL, tsp, arg4));
+            else {
+                p = lock_user_string(arg2);
+                if (!p) {
+                    return -TARGET_EFAULT;
+                }
+                ret = get_errno(sys_utimensat(arg1, path(p), tsp, arg4));
+                unlock_user(p, arg2, 0);
+            }
+        }
+        return ret;
+#endif
 #ifdef TARGET_NR_futex
     case TARGET_NR_futex:
         return do_futex(arg1, arg2, arg3, arg4, arg5, arg6);
-- 
2.25.1


