Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6C1C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:49:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34D9B207E8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="dIw2g0n6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D9B207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmGSR-0000FM-DA
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 08:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jmGQu-0007A1-50
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:47:48 -0400
Received: from mail-eopbgr130117.outbound.protection.outlook.com
 ([40.107.13.117]:41591 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jmGQs-0006QN-9k
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:47:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgCGO5LlOyd8RWvi06Dohe+3tUM3WF64MQYDepQZPbdHJrGsKaiUNEhgPNKZVBbxuQP12ZtRvyBS6pfKfAxhdpsZUYpwizkNOxAfhZlw7dTD0kCaMJVdRlEizHQ4mk18PU8eRxq0grOukmFSzGcztbuVseNlrLEbW3MQSsPUD0P1ixN1csYO+mr0wen6+Ygli+vQRydwb3SgyVXoHaQkWdWogGYT45D6J3h1l2+bdpbQO2HpBKe2KimHdjX175GmCb5IFVRQ7XHP0/LPZQ3mQNBZHJMUnTfLVXJZyScGjlMySrDqrcHsSPa/q171X1Zd4Y3ezoziRtqYbjPZEsg5Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcYdOMbhAVIq4VN6SOXjgOGgI9gyNwmg6z+yTTxu9ZU=;
 b=TTJIS1TizbvO6vQBz+JHLPatvzC8dGK/Xgu47Tp87E7tRFvzkyTwerP/8mLKUsFImx0cGhXPf5aPrPj0VtOPpctYwlwH53oTgO0f6AacYhBMkmkpexl7+5D4VFSZkh1FSFdwV98a/W3OMNIV2aN20WsG5Eo7o6TrM+BurtC0vYzQ5eVfcpjsdJjcn2b2sS7niQSr1qP3FoOt3/K/x9OPdCiJg2OkFu8SSbRCskj/nCbsJ29v0OWtXcae0eDYU7qr7I4bMLZ3GSy8U84lsMj0YZCko7XhzUxMbPFFMr8W9mtcu97Jr3hXkc7eywo8JAi2jrtRPkoxTZSkXgju3WBCog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcYdOMbhAVIq4VN6SOXjgOGgI9gyNwmg6z+yTTxu9ZU=;
 b=dIw2g0n60cUyRC9J9B4TaTQ9rv9nKApz9ZIhTjzZ42rmmNPZb/itfc/RzrHyf0uWfaxo1iltpBe4evBvVVD+b+pXimg4qj021fI8FBPonfNzaekJN83IfdEEjqvrnED5V1jnD4OpRUY3jaCVfWU2YQ9Gllhp2EHApp9S3ZasV5o=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB5094.eurprd03.prod.outlook.com (2603:10a6:20b:80::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 12:47:41 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3109.023; Fri, 19 Jun 2020
 12:47:41 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/2] linux-user: Add thunk argument types for SIOCGSTAMP
 and SIOCGSTAMPNS
Date: Fri, 19 Jun 2020 14:47:26 +0200
Message-Id: <20200619124727.18080-2-filip.bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200619124727.18080-1-filip.bozuta@syrmia.com>
References: <20200619124727.18080-1-filip.bozuta@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: ZRAP278CA0018.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::28) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bozuta-ubuntu-18.syrmia.com (46.240.135.226) by
 ZRAP278CA0018.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 12:47:40 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad0d41d0-3486-44b2-6fdc-08d8144ef452
X-MS-TrafficTypeDiagnostic: AM6PR03MB5094:
X-Microsoft-Antispam-PRVS: <AM6PR03MB50949DB46B77A41B5F803C57EB980@AM6PR03MB5094.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Dt4TB9B2NyYP9U+15KWdQykYw7tioPO3YO2iKGDpkcwX8B8CcgrltYg2sNh/0I3N1thltz0wjDAlac1gJM4spAE3z/6dhOb8OgJT1s26xTwugh8GG/VVOFZJIab1ar5yBEXvBmkkIV6gMoJB2aj6OaWr2s3ADmsEoMG2/HAEKT7etlYX3gZl8orBUbo6cYyuZA6KQGC/kAbeNHz++VLEBHtY7Svc7OAkRXA2zlrg54g1CP3VaMKWk3tFoWzAZqQXkGPIpSDj2IAd9IfB2PPeRfEd5M4O+YZVZ3aAKx6g81kYbYzk3Ub+DHqNf/m6PplwK04xc+QI9/wYJJGLpFhrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(376002)(346002)(136003)(366004)(396003)(39830400003)(8676002)(36756003)(8936002)(5660300002)(83380400001)(186003)(16526019)(1076003)(86362001)(66556008)(6916009)(44832011)(2906002)(4326008)(6666004)(316002)(956004)(508600001)(6486002)(52116002)(66946007)(7696005)(26005)(2616005)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: yZticbx3FZQE3AugiLlMLeLS3JJzq2h0Vvyb1RJ3JpNL3eB7AAEUqIp2VG9FN9lMVoy7QiH5oaaSXccOtIMplNAGCogQWJQwCjoiFeiq3TkegwpH0y0Mp0+kpSka7M0vPo+R0CGVPxTTWOmvT21UAOkfgi3SsKoa1jaKjx+jCORebyfbW+VvgMJhfYp3c4YLCc1LjKSKCw3LqyuIWz/sUqaZtjFA/UUnkRYAm9/lWNkY2wnxpLNhs/ieh2ikXjNBMBuTiMi/pTvUTgrSH+DPntKR5iAAzvUvm7nITEe/exEuGxHhxkhcgb4PFi8jcwdu0/7mq2sx+5fJYQ/MCtwrycxtYkZ2xOiwgS6542VXIs80LfCNZgUxCmbF4oYOcmgBGnSsiDt2WqkI1A0GZM24mQ9HmU3vCnuGMtsWQo4St+NtgM/Vv+DIUkz//6XO6kwu9KGVP5pyEBKdXPD7H9lnLbNUMHatfKpLHtDHMOZxFLw=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0d41d0-3486-44b2-6fdc-08d8144ef452
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 12:47:41.3472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJfYTSOIeol0BjSsMk7/vFpdQ2CKU1jlUTx4jAlZM728Uo84+wUHlOjNtnXGv+ox1M1JwVQF6E/tuf0Bm4RdOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB5094
Received-SPF: pass client-ip=40.107.13.117;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 08:47:41
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: riku.voipio@iki.fi, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

Socket ioctls SIOCGSTAMP and SIOCGSTAMPNS, used for timestamping the socket
connection, are defined in file "ioctls.h" differently from other ioctls.
The reason for this difference is explained in the comments above their definition.
These ioctls didn't have defined thunk argument types before changes from this
patch. They have special handling functions ("do_ioctl_SIOCGSTAMP" and
"do_ioctl_SIOCGSTAMPNS") that take care of setting values for approppriate argument
types (struct timeval and struct timespec) and thus no thunk argument types were
needed for their implementation. But this patch adds those argument type definitions
in file "syscall_types.h" and "ioctls.h" as it is needed for printing arguments
of these ioctls with strace.

Implementation notes:

    There are two variants of these ioctls: SIOCGSTAMP_OLD/SIOCGSTAM_NEW and
    SIOCGSTAMPNS_OLD/SIOCGSTAMPNS_NEW. One is the old existing definition and the
    other is the 2038 safe variant used for 32-bit architectures. Corresponding
    structure definitions STRUCT_timespec/STRUCT__kernel_timespec and
    STRUCT_timeval/STRUCT__kernel_sock_timeval were added for these variants.
    STRUCT_timeval definition was already inside the file as it is used by
    another implemented ioctl. Two cases were added for definitions
    STRUCT_timeval/STRUCT__kernel_sock_timeval to manage the case when the
    "u_sec" field of the timeval structure is of type int.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h        | 12 ++++++++----
 linux-user/syscall_types.h | 22 ++++++++++++++++++++++
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 0defa1d8c1..edb7172207 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -279,13 +279,17 @@
    * FIXME: create a macro to define this kind of entry
    */
   { TARGET_SIOCGSTAMP_OLD, TARGET_SIOCGSTAMP_OLD,
-    "SIOCGSTAMP_OLD", IOC_R, do_ioctl_SIOCGSTAMP },
+    "SIOCGSTAMP_OLD", IOC_R, do_ioctl_SIOCGSTAMP,
+    { MK_PTR(MK_STRUCT(STRUCT_timeval)) } },
   { TARGET_SIOCGSTAMPNS_OLD, TARGET_SIOCGSTAMPNS_OLD,
-    "SIOCGSTAMPNS_OLD", IOC_R, do_ioctl_SIOCGSTAMPNS },
+    "SIOCGSTAMPNS_OLD", IOC_R, do_ioctl_SIOCGSTAMPNS,
+    { MK_PTR(MK_STRUCT(STRUCT_timespec)) } },
   { TARGET_SIOCGSTAMP_NEW, TARGET_SIOCGSTAMP_NEW,
-    "SIOCGSTAMP_NEW", IOC_R, do_ioctl_SIOCGSTAMP },
+    "SIOCGSTAMP_NEW", IOC_R, do_ioctl_SIOCGSTAMP,
+    { MK_PTR(MK_STRUCT(STRUCT__kernel_sock_timeval)) } },
   { TARGET_SIOCGSTAMPNS_NEW, TARGET_SIOCGSTAMPNS_NEW,
-    "SIOCGSTAMPNS_NEW", IOC_R, do_ioctl_SIOCGSTAMPNS },
+    "SIOCGSTAMPNS_NEW", IOC_R, do_ioctl_SIOCGSTAMPNS,
+    { MK_PTR(MK_STRUCT(STRUCT__kernel_timespec)) } },
 
   IOCTL(RNDGETENTCNT, IOC_R, MK_PTR(TYPE_INT))
   IOCTL(RNDADDTOENTCNT, IOC_W, MK_PTR(TYPE_INT))
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index 4e12c1661e..d636561bf4 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -137,10 +137,32 @@ STRUCT(snd_timer_params,
        TYPE_INT, /* filter */
        MK_ARRAY(TYPE_CHAR, 60)) /* reserved */
 
+#if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
+STRUCT(timeval,
+       TYPE_LONG, /* tv_sec */
+       TYPE_INT) /* tv_usec */
+
+STRUCT(_kernel_sock_timeval,
+       TYPE_LONG, /* tv_sec */
+       TYPE_INT) /* tv_usec */
+#else
+STRUCT(timeval,
+       TYPE_LONG, /* tv_sec */
+       TYPE_LONG) /* tv_usec */
+
+STRUCT(_kernel_sock_timeval,
+       TYPE_LONGLONG, /* tv_sec */
+       TYPE_LONGLONG) /* tv_usec */
+#endif
+
 STRUCT(timespec,
        TYPE_LONG, /* tv_sec */
        TYPE_LONG) /* tv_nsec */
 
+STRUCT(_kernel_timespec,
+       TYPE_LONGLONG, /* tv_sec */
+       TYPE_LONGLONG) /* tv_nsec */
+
 STRUCT(snd_timer_status,
        MK_STRUCT(STRUCT_timespec), /* tstamp */
        TYPE_INT, /* resolution */
-- 
2.17.1


