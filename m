Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6DFC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 07:49:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A69320738
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 07:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xYH6p7zP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A69320738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXJjU-0003Wa-EC
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 03:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kXHvz-0007RY-8B
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:54:16 -0400
Received: from mail-bn7nam10on2050.outbound.protection.outlook.com
 ([40.107.92.50]:55041 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kXHvw-000447-CH
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:54:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdSi5kJvCh/v6ZJ5qKgkEvSScu08+TNmfGnssB/eVb67H/XZoebW6td07ZqtuC/a3UNYeLAB0hvvz72p7g0Ubw7QbktXav4Z9yo0c+AnPaxG/D1cBSMMgu9jy2+GHOEBcpuS2cWsbQyTbp/wew1TBdJgz+stLQ0Qig8nvWmfBcAaJSmpothAKozull10KpTlH80DYbzEW0VQNuYsYfN/Q2vfAs5q2cuff+SrXJvEJ53MrlZtJA3bj2qPkmxehKYu0dY9TpEgxGzEk3BczLRdlC9STgDmrH3CutVyZ9wGV0spfsTvfRRJ0FYrw7NIvhb/4gHKFuwLm7KbOpuriA02Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxNQWgIru2r1B471fgC0ReHA9FdKC5m11LQJgXkIMtI=;
 b=h7su5AFn6hDwJuBnSptLefvfQ8URHvcqcRy/wi6WXDZCXxvRZyLESkEr/Tg/kdYAl3ZSrlabLt5YxpLxWtvYB+i12YT5IdryiyPP/ichVyKZXgNKvsJnldEGrqeVgGpctQgB4LhAi4P5pmrctyiKkqa2YRaSClFqD+R6KX+cvNmma6dWkr5tWyJYzijeljRCFAOiFbPwgLJkK7g5N7cUvhvhoKIs7Y0pFhrkyha9DTP8++JZf1/lHmKncXZSQrTfOILbvLB4IUmt4c7//sBB3igAfXNKhHlyiq7dGwvRSUNFfdDOM5yUWZfaaosDVWNi+ZNsT+owb4cXHtwZkQ2cuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxNQWgIru2r1B471fgC0ReHA9FdKC5m11LQJgXkIMtI=;
 b=xYH6p7zPOtqB0Zu9t/eXF/4konFwOMetgAFeUytLs+U4iGOKTVrSZ9vHW7v2ElK/Hp5mxuY+isZOsmqDxbOGs76Ilsg+ibgC1rt/25W3/NhcEEhBxfEAISMMzZTivnSWeHC82mJWEP/5matJVz1cSDAj3xrCY4XuGrAH4fl+6jo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB5004.namprd12.prod.outlook.com (2603:10b6:610:62::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 05:53:53 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.018; Tue, 27 Oct 2020
 05:53:53 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/12] glib-compat: add g_unix_get_passwd_entry_qemu()
Date: Tue, 27 Oct 2020 00:53:13 -0500
Message-Id: <20201027055317.351868-9-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027055317.351868-1-michael.roth@amd.com>
References: <20201027055317.351868-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [76.251.165.188]
X-ClientProxiedBy: DM3PR08CA0017.namprd08.prod.outlook.com
 (2603:10b6:0:52::27) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (76.251.165.188) by
 DM3PR08CA0017.namprd08.prod.outlook.com (2603:10b6:0:52::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.23 via Frontend Transport; Tue, 27 Oct 2020 05:53:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6b230f32-f2b0-4280-cea5-08d87a3caf6c
X-MS-TrafficTypeDiagnostic: CH2PR12MB5004:
X-Microsoft-Antispam-PRVS: <CH2PR12MB5004233EE6758B77E91E093A95160@CH2PR12MB5004.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o5f8VciL3WBAnqCV4pGSrlaHOM1akcHWFW8cTiWowTQA/rd6MtlDh7PjVNeizcQoBpVDXc+Xw1cn+yU2bn1NmxB2yRGzxNRri0w0FdMfRB9dztHOAMaywN3dFITqBfTNk2NLvGAuvV7jf0ZhNHUrlfFlILezRD0rqn8JuQGWEqFcXzcxNWimnz1Lq9EI3Mz3J6CFDenxbWvfo/jxGBzY5cPa2RjkgaNfF6xm5c7Ft1rkGskAha+W/itLKRV6hHKJ8ckUm9173kMfkhIowpER7SRTXPbM1tYwJU7zGMXwBzS4YJUp616N67elegDLIpd4CnyIsuN0hWX9RETjndqH8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(54906003)(316002)(956004)(2616005)(1076003)(8936002)(6496006)(5660300002)(86362001)(52116002)(66556008)(2906002)(6666004)(6916009)(478600001)(66476007)(26005)(66946007)(16526019)(8676002)(186003)(6486002)(4326008)(44832011)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: EA/stS32tPrW7J2UYr4tJQpdkQ2dYaCPu0SPNKn40vzo4cGAqy7iBigQ3/8YojeS60YpDxkfGwyahVUv3DgShpWUUUC3KGNke0h+l8UiNT193O1B3i0gPRW5LVM2r3vIfWQejHfMYH0//q85hMBdshMB6D05s5tmn0rURNhInI3p1jLpi+9hdYmMzmXD/w8eEv2ELPdQI70kqMToYgYfbZy9yYUQ0FS8j0ZJ7te4Sxpz9Pc465FOvK0nV2v4eSDQniN/iFpUus3Qi2qk4sP6Cx7mqql68gff1Y6KoirQjNI3CJpyWYDA4xNM7qfXpSeAJ33SSnOWIYz5DFjkFvzsQl/THGKqNUX8KZXGY/2D5mfl7lyPwwK152uC3il5/ztYIHSxiN1GbqPR2Zup5ulIABWQ8vD6VeqsvchDUcMXU3YV7kR/Pe3ZR26rNxWVV3nMQ5Ksi3viGV8jwDnrJ6nCWOGWRR22fDeI9mQKYb/RlvexEmcAeGpcFH37Amcqvp67Klzwf7qudCQl6DpwqQyXZD9WQ6GUA1OHbbjxXUx/xbV/RpkqersufQFTKlyawHa7bBRgCh+Gwjy81RfdFHVUzTNYkjfBrsx2OwKhjkXjNPTIs4brPP0rRR3W3/5FdhLjGV5dnQfCyf/y9i7Th3KENQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b230f32-f2b0-4280-cea5-08d87a3caf6c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 05:53:53.4477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YRdAUDWX5IImR0HqYGBn8KbDOQl9abEmKYOTfRFfv4Lp56O8qYauozQdOWWnM8qUKU4mD/jVLybgU0qBlHOgDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5004
Received-SPF: none client-ip=40.107.92.50; envelope-from=Michael.Roth@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:53:47
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 27 Oct 2020 03:46:54 -0400
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
Cc: Michal Privoznik <mprivozn@redhat.com>, peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The glib function was introduced in 2.64. It's a safer version of
getpwnam, and also simpler to use than getpwnam_r.

Currently, it's only use by the next patch in qemu-ga, which doesn't
(well well...) need the thread safety guarantees. Since the fallback
version is still unsafe, I would rather keep the _qemu postfix, to make
sure it's not being misused by mistake. When/if necessary, we can
implement a safer fallback and drop the _qemu suffix.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michal Privoznik <mprivozn@redhat.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 include/glib-compat.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/glib-compat.h b/include/glib-compat.h
index 0b0ec76299..64e68aa730 100644
--- a/include/glib-compat.h
+++ b/include/glib-compat.h
@@ -30,6 +30,11 @@
 #pragma GCC diagnostic ignored "-Wdeprecated-declarations"
 
 #include <glib.h>
+#if defined(G_OS_UNIX)
+#include <glib-unix.h>
+#include <sys/types.h>
+#include <pwd.h>
+#endif
 
 /*
  * Note that because of the GLIB_VERSION_MAX_ALLOWED constant above, allowing
@@ -72,6 +77,27 @@
 gint g_poll_fixed(GPollFD *fds, guint nfds, gint timeout);
 #endif
 
+#if defined(G_OS_UNIX)
+/* Note: The fallback implementation is not MT-safe, and it returns a copy of
+ * the libc passwd (must be g_free() after use) but not the content. Because of
+ * these important differences the caller must be aware of, it's not #define for
+ * GLib API substitution. */
+static inline struct passwd *
+g_unix_get_passwd_entry_qemu(const gchar *user_name, GError **error)
+{
+#if GLIB_CHECK_VERSION(2, 64, 0)
+    return g_unix_get_passwd_entry(user_name, error);
+#else
+    struct passwd *p = getpwnam(user_name);
+    if (!p) {
+        g_set_error_literal(error, G_UNIX_ERROR, 0, g_strerror(errno));
+        return NULL;
+    }
+    return (struct passwd *)g_memdup(p, sizeof(*p));
+#endif
+}
+#endif /* G_OS_UNIX */
+
 #pragma GCC diagnostic pop
 
 #endif
-- 
2.25.1


