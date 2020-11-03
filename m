Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF56C388F2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:46:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96A8122265
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hhBxzV5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A8122265
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZmLT-00028x-30
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 21:46:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZmJi-0000lj-RE
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:45:04 -0500
Received: from mail-mw2nam12on2072.outbound.protection.outlook.com
 ([40.107.244.72]:13281 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZmJe-0007gm-JN
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:45:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMbUVNsCGpqEes33ra/77K+ziYkWLvRgf8Laos1sqmzvf7/Ox1h+FVELRcTl0cdTLEhSuNfoD+2xV/jTMjAyiBUqFtcabouC8sApwfF/GsSNhZZWLA5ZmVlVQ/ANEn7+sb0N+lh13gyFiriOObeQNdx8a0ap7UGjDnxmacQ/2h/CWCJ5HWP/stZdm0rnKp5MvgZgt/ukm9qoR5bdQx1Tigk5kRO2BexXFBWGJZbZnMztzk/irHtKxlKKq7AsBpUH/JB6K7my83oilvYxweY6OCKEfDtsON3iHXd5BpPIvuAcPrwg/Og4WoDCUg/XDszJO7JrZn/OQryGB9zwn6zj9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5GkDq94uNC2fCpdfnTJMWf7SXZ9FCqm11p5oNx7M6M=;
 b=VcsmxKowUQDHwyADpL1UAbxaNcfbZ2XDxP++5pxBet3/QgY2cin8U8XefBH9Kkk2yp9LvMQkGJO70L8+pR6zhl0WH2Jsth8b0pKZEPmTFFY5b2xbBg3jYDHwJBNhxq/Fnp7lGbWNrOoIyzGVOzqCXMDdP+tS0S5VXipTqdLkXsiul4jzafGhgPTouUEgGrZAxjRsKEp5NhOOkcAFzJng0akHaFdY2uKpe3yNgP+a64Cu1TZLdk1pFpCMjjMpJm5jzaNbg5zRMWYSFcvi6PKMOWR5+XCkSdirvgolk1ukp/L6K2Jh/05xKbs5BhaAUeWZgPkP4SRwzlOsWjAE56os1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5GkDq94uNC2fCpdfnTJMWf7SXZ9FCqm11p5oNx7M6M=;
 b=hhBxzV5PR8IdvwCQCQXkxzOeUUhvULu7JUiguPb2v7ZPgndXX0wQLjWvThjYdWVJOK5M8/6nIPtNpMoVmP7TrXcSLkl07BPKH2bOMqahNysvN3J790uHjKFOfzE831dtWtt/pcXbmNSyI8ute2+u7pIm3ZZYPupGpzgkeE8eRyk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB4311.namprd12.prod.outlook.com (2603:10b6:610:a8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 3 Nov
 2020 02:44:42 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 02:44:42 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 12/12] qga: add ssh-get-authorized-keys
Date: Mon,  2 Nov 2020 20:43:44 -0600
Message-Id: <20201103024343.894221-13-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103024343.894221-1-michael.roth@amd.com>
References: <20201103024343.894221-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: DM5PR18CA0086.namprd18.prod.outlook.com (2603:10b6:3:3::24)
 To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by
 DM5PR18CA0086.namprd18.prod.outlook.com (2603:10b6:3:3::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 3 Nov 2020 02:44:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2dd2499f-711f-4fe6-e9cf-08d87fa26a7e
X-MS-TrafficTypeDiagnostic: CH2PR12MB4311:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4311766BF5F53395AE1C746895110@CH2PR12MB4311.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tCCb8NBq5Jzm7E9ghUCypE4Ou2ey9udXbZsGmhIHFs7pxzuH5DC3TBe4nxWUn7pL+CAi3N54yHPVQIrBI6VKNYJeSpkePOVWeEP97DM9sBk980A/eLil31EE5xTxYaq8D5L2bh3MlOBlhymnXRyspwtjxsY0d+1WEEmLp4m9EbgSDyOI9Nst7bI0rUyP8zultaHNdcTQLX2N8At/K/9DD+j3W1Pe2zfMrBZ7/vhw2jlaBuZ3rLrRWKmhoVs2v5QZzDcI8M2A3o0C7V3JFaANrJKJF/WcSefnoOCg49bRcSNrGT5IHJVOiV/v8+jzia87HXD6YmE2H4t9hn902WcPIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(16526019)(186003)(5660300002)(8936002)(6916009)(8676002)(36756003)(478600001)(86362001)(26005)(66556008)(956004)(66946007)(6496006)(2616005)(6486002)(52116002)(66476007)(4326008)(1076003)(83380400001)(44832011)(316002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: xz9MM3n20Zi2SeOWnx4TZJ0C9kgyBoZgBGc82pczkwgNBaSRiIVzXAtBNWRP1RCvdvwaIDOI7xDJPS+dmVR7fEgGIkvy7PDz+WfTgTYCKsILOu2nzgTzTYVzxD6iITmYI/grk5OvPgQ9ALEMLdgcl2E/nW/dskasuNy3dTunr1xf4+fesPH6RdPGTVOgfGFBH93VlzX7rpaOuRjRRgvGL+G75EGGXlAAM808ied7DpU2QxughPeSgqwYNq/+yEFvmASP8+8HZmXGoT/TkrOfgMJvBawcjnX0+ueH1vihCE4IJuzpemvz+o07DPTpTSLJiPd9XdUxGQKq2MAp+3Tmbh7SxzZzzsPkyidW2LpueymwYyB+FtneYAR7Lc+IDNU4yDRHFvurBiZF8xTW4u1s/GZSXLxWi1gXx1xlJV4U6OT+Vj2JSXFBDtIlA6dXYVawtzvOh3AQdcyafTs3CdxczpcZdKRQycuvHIUkqnReFSFpb+cXiKUem07Ab/haHEXkZxjgben30VcT+o/8fZ/7Be5PilUrroUgWVDu6Q+MB35RWmDl7j3lWqfDQNq2WC2jPWkbjTO9TIr15m8oO6Ll5GSOW/qE50/8/aYeDShcpRgNHVfs/Wx6AhYmyzv2ME3Um2JuzvA+4L7KTVVTyPZp3Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd2499f-711f-4fe6-e9cf-08d87fa26a7e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 02:44:42.3048 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: te8IbQ/H8qBTrXrSe9ggaT4bkLAbFCQBx6l4HXtD4LFq53e75iVv8zKmv+YIYZYfkM23bb95d7KdHS1LiecC5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4311
Received-SPF: none client-ip=40.107.244.72; envelope-from=Michael.Roth@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 21:44:34
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
*fix-up merge conflicts due to qga-ssh-test being disabled in earlier
 patch due to G_TEST_OPTION_ISOLATE_DIRS triggering build-oss-fuzz
 leak detector.
*fix up style and disallowed g_assert* usage reported by checkpatch
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 qga/commands-posix-ssh.c | 66 ++++++++++++++++++++++++++++++++++++++++
 qga/meson.build          | 11 +++++--
 qga/qapi-schema.json     | 31 +++++++++++++++++++
 3 files changed, 106 insertions(+), 2 deletions(-)

diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
index 362c9e8816..749167e82d 100644
--- a/qga/commands-posix-ssh.c
+++ b/qga/commands-posix-ssh.c
@@ -268,6 +268,46 @@ qmp_guest_ssh_remove_authorized_keys(const char *username, strList *keys,
     write_authkeys(authkeys_path, new_keys, p, errp);
 }
 
+GuestAuthorizedKeys *
+qmp_guest_ssh_get_authorized_keys(const char *username, Error **errp)
+{
+    g_autofree struct passwd *p = NULL;
+    g_autofree char *authkeys_path = NULL;
+    g_auto(GStrv) authkeys = NULL;
+    g_autoptr(GuestAuthorizedKeys) ret = NULL;
+    int i;
+
+    ERRP_GUARD();
+
+    p = get_passwd_entry(username, errp);
+    if (p == NULL) {
+        return NULL;
+    }
+
+    authkeys_path = g_build_filename(p->pw_dir, ".ssh",
+                                     "authorized_keys", NULL);
+    authkeys = read_authkeys(authkeys_path, errp);
+    if (authkeys == NULL) {
+        return NULL;
+    }
+
+    ret = g_new0(GuestAuthorizedKeys, 1);
+    for (i = 0; authkeys[i] != NULL; i++) {
+        strList *new;
+
+        g_strstrip(authkeys[i]);
+        if (!authkeys[i][0] || authkeys[i][0] == '#') {
+            continue;
+        }
+
+        new = g_new0(strList, 1);
+        new->value = g_strdup(authkeys[i]);
+        new->next = ret->keys;
+        ret->keys = new;
+    }
+
+    return g_steal_pointer(&ret);
+}
 
 #ifdef QGA_BUILD_UNIT_TEST
 #if GLIB_CHECK_VERSION(2, 60, 0)
@@ -426,6 +466,31 @@ test_remove_keys(void)
                                "algo some-key another\n");
 }
 
+static void
+test_get_keys(void)
+{
+    Error *err = NULL;
+    static const char *authkeys =
+        "algo key1 comments\n"
+        "# a commented line\n"
+        "algo some-key another\n";
+    g_autoptr(GuestAuthorizedKeys) ret = NULL;
+    strList *k;
+    size_t len = 0;
+
+    test_authorized_keys_set(authkeys);
+
+    ret = qmp_guest_ssh_get_authorized_keys(g_get_user_name(), &err);
+    g_assert(err == NULL);
+
+    for (len = 0, k = ret->keys; k != NULL; k = k->next) {
+        g_assert(g_str_has_prefix(k->value, "algo "));
+        len++;
+    }
+
+    g_assert(len == 2);
+}
+
 int main(int argc, char *argv[])
 {
     setlocale(LC_ALL, "");
@@ -437,6 +502,7 @@ int main(int argc, char *argv[])
     g_test_add_func("/qga/ssh/add_keys", test_add_keys);
     g_test_add_func("/qga/ssh/add_reset_keys", test_add_reset_keys);
     g_test_add_func("/qga/ssh/remove_keys", test_remove_keys);
+    g_test_add_func("/qga/ssh/get_keys", test_get_keys);
 
     return g_test_run();
 }
diff --git a/qga/meson.build b/qga/meson.build
index 4cb3b3f259..53ba6de5f8 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -95,8 +95,15 @@ test_env.set('G_TEST_BUILDDIR', meson.current_build_dir())
 # issue is identified/fix
 #if 'CONFIG_POSIX' in config_host
 if false
-  qga_ssh_test = executable('qga-ssh-test',
-                            files('commands-posix-ssh.c'),
+  srcs = [files('commands-posix-ssh.c')]
+  i = 0
+  foreach output: qga_qapi_outputs
+    if output.startswith('qga-qapi-types') or output.startswith('qga-qapi-visit')
+      srcs += qga_qapi_files[i]
+    endif
+    i = i + 1
+  endforeach
+  qga_ssh_test = executable('qga-ssh-test', srcs,
                             dependencies: [qemuutil],
                             c_args: ['-DQGA_BUILD_UNIT_TEST'])
 
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 4ddea898fa..6ca85f995f 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1347,6 +1347,37 @@
 { 'command': 'guest-get-devices',
   'returns': ['GuestDeviceInfo'] }
 
+##
+# @GuestAuthorizedKeys:
+#
+# @keys: public keys (in OpenSSH/sshd(8) authorized_keys format)
+#
+# Since: 5.2
+##
+{ 'struct': 'GuestAuthorizedKeys',
+  'data': {
+      'keys': ['str']
+  },
+  'if': 'defined(CONFIG_POSIX)' }
+
+
+##
+# @guest-ssh-get-authorized-keys:
+#
+# @username: the user account to add the authorized keys
+#
+# Return the public keys from user .ssh/authorized_keys on Unix systems (not
+# implemented for other systems).
+#
+# Returns: @GuestAuthorizedKeys
+#
+# Since: 5.2
+##
+{ 'command': 'guest-ssh-get-authorized-keys',
+  'data': { 'username': 'str' },
+  'returns': 'GuestAuthorizedKeys',
+  'if': 'defined(CONFIG_POSIX)' }
+
 ##
 # @guest-ssh-add-authorized-keys:
 #
-- 
2.25.1


