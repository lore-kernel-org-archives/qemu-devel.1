Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BD5C00A89
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 01:22:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B37612225E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 01:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ftkoy3NF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B37612225E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZl1z-0003tw-Iy
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 20:22:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZksr-0006rt-BS
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 20:13:13 -0500
Received: from mail-mw2nam10on2055.outbound.protection.outlook.com
 ([40.107.94.55]:25952 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZksp-0005Yp-Qv
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 20:13:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAWIxKuhimvr8k9U9MALQVcjAM+mpSYakH1lVK02EEmhC4QuKhTPOuQtkUqA4vsNV72M3M3MjsPuaQdG1TsMw0sVqcc56IdPZhjy0sbEx/ibVUWoQlV+tAqgNW/Ew6ZEzvIzMC7nkJiqBMH1Wx4F1kdpMqYMy5um6Uc2/hxsgY6hqw/MKMb+q4qO9L0K62LrVxtycdH5s/OCvSS4LC56T3kajwDE+jHkwODya0Mj80HXpzzn2UayoVm1uwcS6+hqYnDaxX+Syc82Flm2m3CQWvjnKrY6U5mTe8LCUsL9GjBMHJnXFF0m6DXPFzpcpL7CkxVYvtGGprx6tOMBzjD+uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxNQWgIru2r1B471fgC0ReHA9FdKC5m11LQJgXkIMtI=;
 b=X3vFsSbShmAXD3YXJxZVvZMb7wVwABNyPGtJDgIG7enJ9awIuuwP85VolXzS2xChYuU/rlxjTQfXVxm7Kb9OhHd2SJN4+uJMhFuyDYMZDIxecWnA57CjiX1WonFOrs4YCp2UokMU/cKrpVMgjwsI/4cI87wl0/XOthHX/PwSyEZjGJCJ1C/Kdfmf8ygVKaUi9tuaJexq4AjPBTHgp+y1i+7A9qDkqVzr/6D1tiI7QOzv7uSQu2wxzpNR3GrUgka2Ais/p9lN2EMIncW7AjcX1FbbADlhqSEFUwMj3Ss7+HzvoXbztQctuTWgX3zYIdVrIAH40MWQp6B8A000X9/EwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxNQWgIru2r1B471fgC0ReHA9FdKC5m11LQJgXkIMtI=;
 b=ftkoy3NF/mXiRDiBj1Ymt4SROB7YlV5FJml1UVjxYl9sNrsrseXcMT24A82XIZurzDQgfVgRfiNbK7g9LN/d8QPcXt/qJljzOM+Vl35Hri430/stPSSByZhT1nJ38HCfHSCaCl+Z2UxdYzpGRICi2lrt/TEXil7GH/u8gEJOGTA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB5001.namprd12.prod.outlook.com (2603:10b6:610:61::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 3 Nov
 2020 01:12:41 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 01:12:41 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 08/12] glib-compat: add g_unix_get_passwd_entry_qemu()
Date: Mon,  2 Nov 2020 19:11:30 -0600
Message-Id: <20201103011134.887744-9-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103011134.887744-1-michael.roth@amd.com>
References: <20201103011134.887744-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SN4PR0801CA0004.namprd08.prod.outlook.com
 (2603:10b6:803:29::14) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by
 SN4PR0801CA0004.namprd08.prod.outlook.com (2603:10b6:803:29::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend
 Transport; Tue, 3 Nov 2020 01:12:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1d0c6307-92ee-4e85-af3b-08d87f958fb7
X-MS-TrafficTypeDiagnostic: CH2PR12MB5001:
X-Microsoft-Antispam-PRVS: <CH2PR12MB500110E268CEF906BC989EED95110@CH2PR12MB5001.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u/kuLEiHPZF4TKLF4L7sGI7EJiYO5ZMgH2yyW6mu8CvRZnWYizIhl3Tv6XQAwNmuHaR1pAuqiPcC0V2KcbvAc2huxTR1+NejNmlFhwYLQYh0Co6ALLbqbE3wAHlTtf+ufpYsf3g9nUSW7SjjGnaVft8ewrKHEbbIh0lhBWHnYqEPazh1AmbQrx/4l2EwCdHW6Q5ibBEdbKiqGqrQ+wFrMq+rb65giAGuwUkmMJlKvUJOfUNZhFt9ll6cJyKXzd3G+T/UUOo1cbOIyyk45jIQtoTWZpvAZ2JWTiF8XQWhuGSNC64y8s/D9Avisxo7QBkWyqwxsg6X3E1BdACmEXEJDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(26005)(44832011)(66556008)(66476007)(66946007)(8936002)(86362001)(6486002)(6666004)(4326008)(36756003)(54906003)(2906002)(8676002)(5660300002)(52116002)(478600001)(186003)(316002)(6916009)(1076003)(16526019)(2616005)(956004)(6496006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: MsieuqxQFjLaEIBtOwro3vEE2iyLP+i/Np9oIS79f1Stt9OgeyCQgGgPT2NMsfppKNFZWmm4KGc5zr1xuQt/4L9kSG6XGem72A7vUtABlfhyeg/BpiOb0K1+h0RQMf6LtfTMsnYKpgBU/hlWjdh4JbZLxNuitbgTA1AHVmnz7HKiJZJ4lRRz6a8sfpzj0+Vo2XSUce946nNHOW8Ohjt6kZWWBB5sgvU0Q8I4gA+3TY/RHtAJFRgzv6B+p0yeZPkgjaZCcSJnrB1dRBzA3ODQmC1wAfn3jCKiKaZ+XDXcd4gQqNYMSAoN6Rxy9mArZ818yC3i3QZgvSy/v/IpN0TJeGrDgAqBp/HBbT4YqjZ127TE2uNAFdrJEC6p5l6nhfJ+iGHOn8vMYbzJVoccFtx7veKSLj9QC+xMn6JzL2N8U2Re+Mnm0ZmngpQJ+6UvGUHlIS7LDZs78JL6muWEMVklss3DQhBc9u+03bQvDM/7pJjKmm69/iRzUR6hEC4ojTAzqbRE//EvKDxIwWdol4eyw8y+KPrfZR3EnJUXN87rO+GY7bN9j0kThkz+MUUA29G7QJrwMTZGK7TPp7i72Nlt67QGbh3zI41NgTEIfF+r0Pp0iTQwDixZSAUqAHvBcncydwiV9rQsn276JpdY4eeoqw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0c6307-92ee-4e85-af3b-08d87f958fb7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 01:12:41.3289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iwsx0e8EdIMdZKE8aHYYr6mxjEX8+SRV9ANYD4Pr74rtIF/e2iZBMBkjFzu3Ccy4okZhuwLE+9sEMQV+wGQwcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5001
Received-SPF: none client-ip=40.107.94.55; envelope-from=Michael.Roth@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 20:12:53
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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


