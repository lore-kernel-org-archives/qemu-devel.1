Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA542C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 07:50:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C42E20738
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 07:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="B1bC+jC9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C42E20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXJkl-0005XG-6t
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 03:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kXIA0-0004eZ-UG
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 02:08:44 -0400
Received: from mail-eopbgr750081.outbound.protection.outlook.com
 ([40.107.75.81]:32774 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kXI9y-0001H2-GH
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 02:08:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ij+nHyuih3J2lY3q88sORRjamEXmqOfJUJ8ZZmLVsjbhMELB6bA7a7Sc1KVq/ZHSdeHIubh8Hiv/uMz1gKW2ayR+bs9rBNoVLse60OqG+YAyY6RnaixsgVGU/0K2S4pmIayZG/xD3FQRUOFezLc+GWCqJBHh6xYRB01rf68guTjJ+jyhQx0vCBjHOSM909hsVsV0rx3oKKj5Jq4LyxsXtcW5QSAQ9+HLVg9YGy1+RK2RJVTijVEQhUMrPumfchpzWsLvsdkQaB2ZpQ82tj2kNlBOm+Vln5u7h+PNd5jyXgs3hAHtyXMXXbEV0MQC9U5fyqj5KtzjvXYnOIKWCdHd9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/DRVT7YUTTFAMmhTauvLeP9m7sc/3uDPVn0BMDPTTY=;
 b=kf3RA0XQyj2xHW8QPmmyAILEvRzc0vYrqrO6Jlpe/5V2U2AsbjBbtSJm91I31/Vwp1E5rslTtlGpKLLCOYSHOz4V3Ec5gGg6pW5S/KIw5lkXsxB5MwLZgvhfaZtFmxnzJIoZ5nFw6pNnnxThaAQUZEUznn6COG/g349VjaRymYHd5v+hm1UD7xcmLAyuOCCSzdbGrXtx6sYLrhOBOINj8G0/nw0UxMiNtSsm6M9QpQWVKEV+GFv2dKRN9mfS+2ewfdrVW+6X0WJe5P2fKtnNRRF8CifJhsumHNV/URTo5HE6rwd4O9IJW/+6lCdMsJxy6L1VP7pxXbC0qeI/zleqwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/DRVT7YUTTFAMmhTauvLeP9m7sc/3uDPVn0BMDPTTY=;
 b=B1bC+jC98I+ki2aKFrI8c1YmJXZ639uz5apQxTPkA7GkzNL0FSEh34ydhZuqds8nYFDNZF4KoWUrswP/O57iOnm42j3P1hVl5sX7yvbtd25ocxQ8SEEfEpQLayM+aaq7tisvakMlkYMJw/vjN322hu0+YwV20Tyw9wh58ULDRX4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB5004.namprd12.prod.outlook.com (2603:10b6:610:62::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 05:53:36 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.018; Tue, 27 Oct 2020
 05:53:35 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/12] qga: add ssh-{add,remove}-authorized-keys
Date: Tue, 27 Oct 2020 00:53:14 -0500
Message-Id: <20201027055317.351868-10-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027055317.351868-1-michael.roth@amd.com>
References: <20201027055317.351868-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [76.251.165.188]
X-ClientProxiedBy: SA9PR11CA0005.namprd11.prod.outlook.com
 (2603:10b6:806:6e::10) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (76.251.165.188) by
 SA9PR11CA0005.namprd11.prod.outlook.com (2603:10b6:806:6e::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 05:53:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 551f857a-b53e-47fc-099a-08d87a3ca4a7
X-MS-TrafficTypeDiagnostic: CH2PR12MB5004:
X-Microsoft-Antispam-PRVS: <CH2PR12MB50042893E882658FD8859F9B95160@CH2PR12MB5004.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h1Wn4NEDbPnsknR90gS9eIQKEQ/3D8vT5OYLeloPXI1y37LLlWGtooLH3tCG4tp/FfbSEYE3VwW9pj5d4f433V6JHj5wM3WhzRscSI9eEO+MgzoCLAUdQ4S/oGMR/q8FYyt3/1hiYfHdsG4msam45pgXDQG0eNJlA1Mo5cVe2boYG1R4tl4UkMXbxcb0EgNBEPksJEUacUldMM+TC1pDkQfQ+rcOtymht4z6ENKrXWdM70CWZTLT6ZgFsI+t8R5TYj6RnaL/Xrd2C94H7UOAqG8IvcqF8l4Q7ZvNCg3+LlstEdkp9RJyZf1MHc/dZTz5LpgECLmpmMqyc6Yug6j2PO6SlK1EaJazUC81wIPan65ATvw18TnnB7+sw0mbW21IZB4OyCcHp6ykTWyKwj/X2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(54906003)(316002)(956004)(2616005)(1076003)(8936002)(6496006)(5660300002)(30864003)(86362001)(52116002)(66556008)(2906002)(6666004)(6916009)(478600001)(66476007)(26005)(66946007)(16526019)(8676002)(186003)(6486002)(4326008)(44832011)(83380400001)(966005)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 8s6ZvbSNjkGFvwxVMpbkzIocucGNVWwx8/8CqWHtSTel9kw9/RUAreZNNyoapr9dVpFQsLiaEqgnSUixCFSX6o8YNfV8G3igIzO8DqzZIfqrIfjH7Xt2s9VK07wH6oGplqC6ebAXjx8zct+e13/NwAPaICWV/Sw4KeQuDFMskY5lncpzBPXAjYI65dk66CUxTayxijdQDPXmJMEyQKE4xWVLEBWjOV67k/IfmzghVvXTEfJ06hyCkT0Mxbhv4IOsR+KJ+rgrGUokHLtTqTjeIiDqZpqD7lyuJaMeI4S+GReYpKdr5c9VWZ07Zt4c+Dx0gIDZ4vlSocnOgR8eiX5bPQbl9b6H0Hx7smKDpPEpdnCYxHG29xM7A2b10VmkSBSyOshYUpHKCwMAf/rS+FboWhQx3xCj01u3IiOCRKRklwYufV+UOSyLLzT4GyLuVqBJs8nCPhfS9Oz4VPFGFUUQM86clm4chNdTDbLUfyH+Ju3H6mtvRboMIcRfFNsVjqT/WDCSMZle+E0C+BDCs/9TOgok6N+PeaMPJ3Mgt0AZEObnuQoC0WUEnZZPz9966AFSOWAe3VOIxFMljiVz0ybttnPEPYiFh6EJ1bdvxYpvrPw76BYr1Ar4LvEQMeoQpt/D/8vGJw1sJsleFcuwYQprAA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 551f857a-b53e-47fc-099a-08d87a3ca4a7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 05:53:35.9220 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OllPmvV81/sYNNJxuq/p0BHffSuj/ESAIQZmvExqHp9XzFHBMDdq0BPClGlGkkSIo5mwL2SxuOONu+P/OPnG5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5004
Received-SPF: none client-ip=40.107.75.81; envelope-from=Michael.Roth@amd.com;
 helo=NAM02-BL2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 02:08:40
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 27 Oct 2020 03:46:57 -0400
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
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Add new commands to add and remove SSH public keys from
~/.ssh/authorized_keys.

I took a different approach for testing, including the unit tests right
with the code. I wanted to overwrite the function to get the user
details, I couldn't easily do that over QMP. Furthermore, I prefer
having unit tests very close to the code, and unit files that are domain
specific (commands-posix is too crowded already). FWIW, that
coding/testing style is Rust-style (where tests can or should even be
part of the documentation!).

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=1885332

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michal Privoznik <mprivozn@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
*squashed in fix-ups for setting file ownership and use of QAPI
 conditionals for CONFIG_POSIX instead of stub definitions
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 qga/commands-posix-ssh.c | 407 +++++++++++++++++++++++++++++++++++++++
 qga/meson.build          |  20 +-
 qga/qapi-schema.json     |  35 ++++
 3 files changed, 461 insertions(+), 1 deletion(-)
 create mode 100644 qga/commands-posix-ssh.c

diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
new file mode 100644
index 0000000000..a7bc9a1c24
--- /dev/null
+++ b/qga/commands-posix-ssh.c
@@ -0,0 +1,407 @@
+ /*
+  * This work is licensed under the terms of the GNU GPL, version 2 or later.
+  * See the COPYING file in the top-level directory.
+  */
+#include "qemu/osdep.h"
+
+#include <glib-unix.h>
+#include <glib/gstdio.h>
+#include <locale.h>
+#include <pwd.h>
+
+#include "qapi/error.h"
+#include "qga-qapi-commands.h"
+
+#ifdef QGA_BUILD_UNIT_TEST
+static struct passwd *
+test_get_passwd_entry(const gchar *user_name, GError **error)
+{
+    struct passwd *p;
+    int ret;
+
+    if (!user_name || g_strcmp0(user_name, g_get_user_name())) {
+        g_set_error(error, G_UNIX_ERROR, 0, "Invalid user name");
+        return NULL;
+    }
+
+    p = g_new0(struct passwd, 1);
+    p->pw_dir = (char *)g_get_home_dir();
+    p->pw_uid = geteuid();
+    p->pw_gid = getegid();
+
+    ret = g_mkdir_with_parents(p->pw_dir, 0700);
+    g_assert_cmpint(ret, ==, 0);
+
+    return p;
+}
+
+#define g_unix_get_passwd_entry_qemu(username, err) \
+   test_get_passwd_entry(username, err)
+#endif
+
+static struct passwd *
+get_passwd_entry(const char *username, Error **errp)
+{
+    g_autoptr(GError) err = NULL;
+    struct passwd *p;
+
+    ERRP_GUARD();
+
+    p = g_unix_get_passwd_entry_qemu(username, &err);
+    if (p == NULL) {
+        error_setg(errp, "failed to lookup user '%s': %s",
+                   username, err->message);
+        return NULL;
+    }
+
+    return p;
+}
+
+static bool
+mkdir_for_user(const char *path, const struct passwd *p,
+               mode_t mode, Error **errp)
+{
+    ERRP_GUARD();
+
+    if (g_mkdir(path, mode) == -1) {
+        error_setg(errp, "failed to create directory '%s': %s",
+                   path, g_strerror(errno));
+        return false;
+    }
+
+    if (chown(path, p->pw_uid, p->pw_gid) == -1) {
+        error_setg(errp, "failed to set ownership of directory '%s': %s",
+                   path, g_strerror(errno));
+        return false;
+    }
+
+    if (chmod(path, mode) == -1) {
+        error_setg(errp, "failed to set permissions of directory '%s': %s",
+                   path, g_strerror(errno));
+        return false;
+    }
+
+    return true;
+}
+
+static bool
+check_openssh_pub_key(const char *key, Error **errp)
+{
+    ERRP_GUARD();
+
+    /* simple sanity-check, we may want more? */
+    if (!key || key[0] == '#' || strchr(key, '\n')) {
+        error_setg(errp, "invalid OpenSSH public key: '%s'", key);
+        return false;
+    }
+
+    return true;
+}
+
+static bool
+check_openssh_pub_keys(strList *keys, size_t *nkeys, Error **errp)
+{
+    size_t n = 0;
+    strList *k;
+
+    ERRP_GUARD();
+
+    for (k = keys; k != NULL; k = k->next) {
+        if (!check_openssh_pub_key(k->value, errp)) {
+            return false;
+        }
+        n++;
+    }
+
+    if (nkeys) {
+        *nkeys = n;
+    }
+    return true;
+}
+
+static bool
+write_authkeys(const char *path, const GStrv keys,
+               const struct passwd *p, Error **errp)
+{
+    g_autofree char *contents = NULL;
+    g_autoptr(GError) err = NULL;
+
+    ERRP_GUARD();
+
+    contents = g_strjoinv("\n", keys);
+    if (!g_file_set_contents(path, contents, -1, &err)) {
+        error_setg(errp, "failed to write to '%s': %s", path, err->message);
+        return false;
+    }
+
+    if (chown(path, p->pw_uid, p->pw_gid) == -1) {
+        error_setg(errp, "failed to set ownership of directory '%s': %s",
+                   path, g_strerror(errno));
+        return false;
+    }
+
+    if (chmod(path, 0600) == -1) {
+        error_setg(errp, "failed to set permissions of '%s': %s",
+                   path, g_strerror(errno));
+        return false;
+    }
+
+    return true;
+}
+
+static GStrv
+read_authkeys(const char *path, Error **errp)
+{
+    g_autoptr(GError) err = NULL;
+    g_autofree char *contents = NULL;
+
+    ERRP_GUARD();
+
+    if (!g_file_get_contents(path, &contents, NULL, &err)) {
+        error_setg(errp, "failed to read '%s': %s", path, err->message);
+        return NULL;
+    }
+
+    return g_strsplit(contents, "\n", -1);
+
+}
+
+void
+qmp_guest_ssh_add_authorized_keys(const char *username, strList *keys,
+                                  Error **errp)
+{
+    g_autofree struct passwd *p = NULL;
+    g_autofree char *ssh_path = NULL;
+    g_autofree char *authkeys_path = NULL;
+    g_auto(GStrv) authkeys = NULL;
+    strList *k;
+    size_t nkeys, nauthkeys;
+
+    ERRP_GUARD();
+
+    if (!check_openssh_pub_keys(keys, &nkeys, errp)) {
+        return;
+    }
+
+    p = get_passwd_entry(username, errp);
+    if (p == NULL) {
+        return;
+    }
+
+    ssh_path = g_build_filename(p->pw_dir, ".ssh", NULL);
+    authkeys_path = g_build_filename(ssh_path, "authorized_keys", NULL);
+
+    authkeys = read_authkeys(authkeys_path, NULL);
+    if (authkeys == NULL) {
+        if (!g_file_test(ssh_path, G_FILE_TEST_IS_DIR) &&
+            !mkdir_for_user(ssh_path, p, 0700, errp)) {
+            return;
+        }
+    }
+
+    nauthkeys = authkeys ? g_strv_length(authkeys) : 0;
+    authkeys = g_realloc_n(authkeys, nauthkeys + nkeys + 1, sizeof(char *));
+    memset(authkeys + nauthkeys, 0, (nkeys + 1) * sizeof(char *));
+
+    for (k = keys; k != NULL; k = k->next) {
+        if (g_strv_contains((const gchar * const *)authkeys, k->value)) {
+            continue;
+        }
+        authkeys[nauthkeys++] = g_strdup(k->value);
+    }
+
+    write_authkeys(authkeys_path, authkeys, p, errp);
+}
+
+void
+qmp_guest_ssh_remove_authorized_keys(const char *username, strList *keys,
+                                     Error **errp)
+{
+    g_autofree struct passwd *p = NULL;
+    g_autofree char *authkeys_path = NULL;
+    g_autofree GStrv new_keys = NULL; /* do not own the strings */
+    g_auto(GStrv) authkeys = NULL;
+    GStrv a;
+    size_t nkeys = 0;
+
+    ERRP_GUARD();
+
+    if (!check_openssh_pub_keys(keys, NULL, errp)) {
+        return;
+    }
+
+    p = get_passwd_entry(username, errp);
+    if (p == NULL) {
+        return;
+    }
+
+    authkeys_path = g_build_filename(p->pw_dir, ".ssh",
+                                     "authorized_keys", NULL);
+    if (!g_file_test(authkeys_path, G_FILE_TEST_EXISTS)) {
+        return;
+    }
+    authkeys = read_authkeys(authkeys_path, errp);
+    if (authkeys == NULL) {
+        return;
+    }
+
+    new_keys = g_new0(char *, g_strv_length(authkeys) + 1);
+    for (a = authkeys; *a != NULL; a++) {
+        strList *k;
+
+        for (k = keys; k != NULL; k = k->next) {
+            if (g_str_equal(k->value, *a)) {
+                break;
+            }
+        }
+        if (k != NULL) {
+            continue;
+        }
+
+        new_keys[nkeys++] = *a;
+    }
+
+    write_authkeys(authkeys_path, new_keys, p, errp);
+}
+
+
+#ifdef QGA_BUILD_UNIT_TEST
+#if GLIB_CHECK_VERSION(2, 60, 0)
+static const strList test_key2 = {
+    .value = (char *)"algo key2 comments"
+};
+
+static const strList test_key1_2 = {
+    .value = (char *)"algo key1 comments",
+    .next = (strList *)&test_key2,
+};
+
+static char *
+test_get_authorized_keys_path(void)
+{
+    return g_build_filename(g_get_home_dir(), ".ssh", "authorized_keys", NULL);
+}
+
+static void
+test_authorized_keys_set(const char *contents)
+{
+    g_autoptr(GError) err = NULL;
+    g_autofree char *path = NULL;
+    int ret;
+
+    path = g_build_filename(g_get_home_dir(), ".ssh", NULL);
+    ret = g_mkdir_with_parents(path, 0700);
+    g_assert_cmpint(ret, ==, 0);
+    g_free(path);
+
+    path = test_get_authorized_keys_path();
+    g_file_set_contents(path, contents, -1, &err);
+    g_assert_no_error(err);
+}
+
+static void
+test_authorized_keys_equal(const char *expected)
+{
+    g_autoptr(GError) err = NULL;
+    g_autofree char *path = NULL;
+    g_autofree char *contents = NULL;
+
+    path = test_get_authorized_keys_path();
+    g_file_get_contents(path, &contents, NULL, &err);
+    g_assert_no_error(err);
+
+    g_assert_cmpstr(contents, ==, expected);
+}
+
+static void
+test_invalid_user(void)
+{
+    Error *err = NULL;
+
+    qmp_guest_ssh_add_authorized_keys("", NULL, &err);
+    error_free_or_abort(&err);
+
+    qmp_guest_ssh_remove_authorized_keys("", NULL, &err);
+    error_free_or_abort(&err);
+}
+
+static void
+test_invalid_key(void)
+{
+    strList key = {
+        .value = (char *)"not a valid\nkey"
+    };
+    Error *err = NULL;
+
+    qmp_guest_ssh_add_authorized_keys(g_get_user_name(), &key, &err);
+    error_free_or_abort(&err);
+
+    qmp_guest_ssh_remove_authorized_keys(g_get_user_name(), &key, &err);
+    error_free_or_abort(&err);
+}
+
+static void
+test_add_keys(void)
+{
+    Error *err = NULL;
+
+    qmp_guest_ssh_add_authorized_keys(g_get_user_name(),
+                                      (strList *)&test_key2, &err);
+    g_assert_null(err);
+
+    test_authorized_keys_equal("algo key2 comments");
+
+    qmp_guest_ssh_add_authorized_keys(g_get_user_name(),
+                                      (strList *)&test_key1_2, &err);
+    g_assert_null(err);
+
+    /*  key2 came first, and should'nt be duplicated */
+    test_authorized_keys_equal("algo key2 comments\n"
+                               "algo key1 comments");
+}
+
+static void
+test_remove_keys(void)
+{
+    Error *err = NULL;
+    static const char *authkeys =
+        "algo key1 comments\n"
+        /* originally duplicated */
+        "algo key1 comments\n"
+        "# a commented line\n"
+        "algo some-key another\n";
+
+    test_authorized_keys_set(authkeys);
+    qmp_guest_ssh_remove_authorized_keys(g_get_user_name(),
+                                         (strList *)&test_key2, &err);
+    g_assert_null(err);
+    test_authorized_keys_equal(authkeys);
+
+    qmp_guest_ssh_remove_authorized_keys(g_get_user_name(),
+                                         (strList *)&test_key1_2, &err);
+    g_assert_null(err);
+    test_authorized_keys_equal("# a commented line\n"
+                               "algo some-key another\n");
+}
+
+int main(int argc, char *argv[])
+{
+    setlocale(LC_ALL, "");
+
+    g_test_init(&argc, &argv, G_TEST_OPTION_ISOLATE_DIRS, NULL);
+
+    g_test_add_func("/qga/ssh/invalid_user", test_invalid_user);
+    g_test_add_func("/qga/ssh/invalid_key", test_invalid_key);
+    g_test_add_func("/qga/ssh/add_keys", test_add_keys);
+    g_test_add_func("/qga/ssh/remove_keys", test_remove_keys);
+
+    return g_test_run();
+}
+#else
+int main(int argc, char *argv[])
+{
+    g_test_message("test skipped, needs glib >= 2.60");
+    return 0;
+}
+#endif /* GLIB_2_60 */
+#endif /* BUILD_UNIT_TEST */
diff --git a/qga/meson.build b/qga/meson.build
index cd08bd953a..6315bb357e 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -35,7 +35,9 @@ qga_ss.add(files(
 ))
 qga_ss.add(when: 'CONFIG_POSIX', if_true: files(
   'channel-posix.c',
-  'commands-posix.c'))
+  'commands-posix.c',
+  'commands-posix-ssh.c',
+))
 qga_ss.add(when: 'CONFIG_WIN32', if_true: files(
   'channel-win32.c',
   'commands-win32.c',
@@ -87,3 +89,19 @@ else
 endif
 
 alias_target('qemu-ga', all_qga)
+
+test_env = environment()
+test_env.set('G_TEST_SRCDIR', meson.current_source_dir())
+test_env.set('G_TEST_BUILDDIR', meson.current_build_dir())
+
+if 'CONFIG_POSIX' in config_host
+  qga_ssh_test = executable('qga-ssh-test',
+                            files('commands-posix-ssh.c'),
+                            dependencies: [qemuutil],
+                            c_args: ['-DQGA_BUILD_UNIT_TEST'])
+
+  test('qga-ssh-test',
+       qga_ssh_test,
+       env: test_env,
+       suite: ['unit', 'qga'])
+endif
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index e123a000be..a2727ed86b 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1346,3 +1346,38 @@
 ##
 { 'command': 'guest-get-devices',
   'returns': ['GuestDeviceInfo'] }
+
+##
+# @guest-ssh-add-authorized-keys:
+#
+# @username: the user account to add the authorized keys
+# @keys: the public keys to add (in OpenSSH/sshd(8) authorized_keys format)
+#
+# Append public keys to user .ssh/authorized_keys on Unix systems (not
+# implemented for other systems).
+#
+# Returns: Nothing on success.
+#
+# Since: 5.2
+##
+{ 'command': 'guest-ssh-add-authorized-keys',
+  'data': { 'username': 'str', 'keys': ['str'] },
+  'if': 'defined(CONFIG_POSIX)' }
+
+##
+# @guest-ssh-remove-authorized-keys:
+#
+# @username: the user account to remove the authorized keys
+# @keys: the public keys to remove (in OpenSSH/sshd(8) authorized_keys format)
+#
+# Remove public keys from the user .ssh/authorized_keys on Unix systems (not
+# implemented for other systems). It's not an error if the key is already
+# missing.
+#
+# Returns: Nothing on success.
+#
+# Since: 5.2
+##
+{ 'command': 'guest-ssh-remove-authorized-keys',
+  'data': { 'username': 'str', 'keys': ['str'] },
+  'if': 'defined(CONFIG_POSIX)' }
-- 
2.25.1


