Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4D7C00A89
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 03:01:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87FB92076E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 03:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="r7I1wuVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87FB92076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZmZx-0004uD-7q
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 22:01:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZmK7-0001Du-I4
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:45:29 -0500
Received: from mail-mw2nam12on2045.outbound.protection.outlook.com
 ([40.107.244.45]:27233 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZmK3-0007wP-Qa
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:45:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YoWWW6H7YI2OrGcfLiYqqm/9HuITH+SSRcVTLgBAP2zL7stG5BzM/Uuo25qE1eY/nqAFCbQNRuQuR1sBjGBy9wuzs6fMr/vclIUz+CReOObwlFb9UiNfyg+1BY3btPL4dZczjgqsIGm9lpkRrWQt8iiYumn2Dq4YIm9qIxL7JnIlVNY4V72Jmflq/089CMg0BA3XObE+etUdkL37hczFlZXGg+H2uI703PQRvcxpIB29NmTCqpQx+HgWtYuUkuhl7XqffYcMWPlA1Xiz54bfeV8nHh4os4oigBgTDlEa5Awwn9TaFzPabayUHhFSFi1bq/cJg5aA6Hppso+sA6/aow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrZ5Ns3AxSK0gLKZmlixk1pPSvByMj+wnurEMMS6lcQ=;
 b=YwEyahlntwR+KmuHROUzmdAzt+oejYs2e5Ir3DILe60rARkmOMyAuaYOEIipUcFeU8OQvx1C8bUoGbZY4g/Sv575BNOxLckzTPVq24iWc412ggnHJkSHhhhh7alc1JDA/howIokO/JXfOKSWbEBamAdZ3tx8G1H5MCgdmJdkufDOhUXvfhN9doYhNgcixWcbiwXWS1Sdj9yI1w/rnNGl1YwDf53Jw1DlEIbfSNAdwd3vbPKVaiGvv/Y3lnm63vSfs9zpF5g8soIaioiRQF3UT/e3AsIbjloUlzhNMV/XjFnnudm4R7MoiYJ1iX8Xgnfmj7DDXL2/W49H5oyfd7lOmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrZ5Ns3AxSK0gLKZmlixk1pPSvByMj+wnurEMMS6lcQ=;
 b=r7I1wuVlWFZhfiIi85BvA+Zs4irdRJX1ZftSh7BqsLEe4pppR7SPAX4BwHhwqEr4DCDaeBeNr/oqw6H6U0Zx/XbU9TsAmG6rlNyd/HO8u1McxbPdjlkpKH+E/DwpxBKmzMjhprZ4LAEo9jnkOqmzs+6grQXSquvpFBywZCS7vME=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB4311.namprd12.prod.outlook.com (2603:10b6:610:a8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 3 Nov
 2020 02:45:21 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 02:45:21 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 08/12] glib-compat: add g_unix_get_passwd_entry_qemu()
Date: Mon,  2 Nov 2020 20:43:40 -0600
Message-Id: <20201103024343.894221-9-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103024343.894221-1-michael.roth@amd.com>
References: <20201103024343.894221-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SA0PR11CA0119.namprd11.prod.outlook.com
 (2603:10b6:806:d1::34) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by
 SA0PR11CA0119.namprd11.prod.outlook.com (2603:10b6:806:d1::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.19 via Frontend Transport; Tue, 3 Nov 2020 02:45:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d460bf25-7a48-401e-de4b-08d87fa281dd
X-MS-TrafficTypeDiagnostic: CH2PR12MB4311:
X-Microsoft-Antispam-PRVS: <CH2PR12MB43117DD85B5BF22D6A1697A995110@CH2PR12MB4311.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GgldmuxzBE/5gW246KJrLy7SZ5ZqGOzjZzzch1vaP+93EqeoYn0sTTJMg9kK/AYFD11UzLMgghdchoUT7ILndrjSXKSseREs1X8yiXZs/vBgfZYAyvf+fVF2WwOMwriQWZO1r9YQw4ivFs4j22oqaT+Pvnx0JreRZd7YWL0uY580j1NW9UMO4uTzt6cGg2ygVagEsfC7TyiuJeT6wbuVumumkzjUysdMGBdFi3uy1c3QmInMrMO9mQ0ERBhzd6TjDYYsHDxav3uEs4Af7LzzDyM9X11PYcapfd87lN9hQE3gIk9YkWSdUWlrY4FHa7IU2YW1Zu4kMgynf7nUvvQ8tA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(16526019)(186003)(5660300002)(8936002)(6916009)(8676002)(36756003)(478600001)(86362001)(26005)(66556008)(956004)(66946007)(6666004)(6496006)(2616005)(6486002)(52116002)(66476007)(4326008)(1076003)(83380400001)(54906003)(44832011)(316002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ++g3rbD3J5H4W+p/1t+eJgnVCse2rVJu96adaj7kmBrBV6hlZScW1b0kQdA+GEgQDP7Ul5kSVUAUPyEoobu+i7GS/Q3IVZcjElINKOI1kaogIYxttelXWcPPeXqvgLfhUTlHGsFooNJOnZdvAQ50ZYmcp7mKbm+Z7VuIovQgn9c5uz/GXhPt3H98yPslVy/0Y/Hg3wtAGHov3LW6ZgABlrX4qhumWx0cVn9nxKvc6ZMOUtH9TmJyPtS7eYaeFKyz3yM0dIiVWVVhI3sXA4dLMMQQ5CMf9oO7PuWSW2BmU1IKjjA2Fsfw+zLtenwHrcIM81G9d5cEJraZRlB507r3shpghya2HzIE8koMRBuiRMOhoVaLdKo6qagrckgeCQVSrn/gOqv1qncaoGrRgYmT4qbmaV+bajQO1iz9XpJ1KLvRk/+sQGeS7wm/QEil4FHbGolYCwk5GaAYsqRO8FetU0NTI6CnBjbXG5DUhkdTXwfNGpKCnkyWUDTKIvaH8N4JP9gQ+QikrZJ6YBLzdlRXi4gwa+ML2KXIJtYzB7H6KY6emtKn+/nJiK0XJrh6/NNq5hE4KycYUzdJtiavZob7lvFUnpeFNvUiMwcakbyf1kftCYa2tOvdgi5OavoqAk2MiyA3enhKtOPT1e7JyBC/+Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d460bf25-7a48-401e-de4b-08d87fa281dd
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 02:45:21.4271 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/Kf6WSaBIYdTXI1p2xWosdgJ8anpqK+lAYivzLMbDppJgmrC2LffcGyvCAMW7+jOWA2+/PZW2DCQy8p34U1Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4311
Received-SPF: none client-ip=40.107.244.45; envelope-from=Michael.Roth@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 21:45:22
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
*fix checkpatch warnings about newlines before/after block comments
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 include/glib-compat.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/glib-compat.h b/include/glib-compat.h
index 0b0ec76299..695a96f7ea 100644
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
@@ -72,6 +77,29 @@
 gint g_poll_fixed(GPollFD *fds, guint nfds, gint timeout);
 #endif
 
+#if defined(G_OS_UNIX)
+/*
+ * Note: The fallback implementation is not MT-safe, and it returns a copy of
+ * the libc passwd (must be g_free() after use) but not the content. Because of
+ * these important differences the caller must be aware of, it's not #define for
+ * GLib API substitution.
+ */
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


