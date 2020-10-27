Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC1AC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 07:50:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79A1521D24
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 07:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AaOmG6/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A1521D24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXJkb-0005Cq-BC
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 03:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kXHvf-0007CH-NC
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:53:55 -0400
Received: from mail-bn7nam10on2050.outbound.protection.outlook.com
 ([40.107.92.50]:55041 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kXHve-000447-0l
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:53:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETPnDkcE+61d7eljE4gwzVqF6HCRGg0grV6//ARpu5SvYakXJdWl4oQAj0LXRG2ofjXlRiT8exbPGvhhjFYEaadcePBhjCEzOvWz7rG/xcHz5czM2q+oSuBryoOsKpWsxuXHcFqtkmFsM8hT5TvgPvj82NTAVpZzPdvXt7rslQvflGZaokVLc0AMORopwnQHQgGDCSoIdTna/VRBxCkRBQqOZ919o603xEDalunvnO0YidSXQDRkFx4zuLVk17kMbUeFZgDLMeH4aKtqjWS4OQaBotiGot0uxjHE2XxdQS6cRRavFaADCndTr7oY/fQhzTYJH/kRZDFwKzByRjKWKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vOCkIJkfN5Na4rMWYOwTpob84gyCO2id/T+cDNGFi8=;
 b=R4ti2aErHnAiMvg3QzD1HfrdzKIMpTvDPAUbTWtXFEj2tysXkDH9EwJQQZ2NMNFxU5KcGfc9hUYFAdzW7I1vpfqvEUtJwITF3Akta7/W8OE9XxL95ioDNhWceyCTWDtPzG82eMnHsPKBKbqvu1pA6rbf5ZS0B5jykgfgTyWJHsqFBJd6aBLywnYzbLonyKtdZbGt//QA3lVupxeuckCIrDuwl4z3aPDyjxAdo74Kxi7AJgShRfJ5m2j5ricifilTDn0VFupBN3GW0GCSlV5hk739QExrzxu6bPd7NlEG9Emj1HXMy+pgQ6566mDBsBnbGbGLYaNQuhPw5puoCz2Ihw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vOCkIJkfN5Na4rMWYOwTpob84gyCO2id/T+cDNGFi8=;
 b=AaOmG6/9IUi4cXkvt1SnfrETiAYlnEIMFOV+mTs2qlcMYOxddI8obU0csbWzJ/4grVQqj04rM86cQ0sKjcY0yUwyzuXzXYOxB/0+NBELxXXqa1UpRpZkRz8dBync8WjmQqwTNSA5v9XWQTikFknRZMPXD+EYfvy7WFTz2Mhkv8A=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB5004.namprd12.prod.outlook.com (2603:10b6:610:62::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 05:53:42 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.018; Tue, 27 Oct 2020
 05:53:42 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/12] qga: add ssh-get-authorized-keys
Date: Tue, 27 Oct 2020 00:53:17 -0500
Message-Id: <20201027055317.351868-13-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027055317.351868-1-michael.roth@amd.com>
References: <20201027055317.351868-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [76.251.165.188]
X-ClientProxiedBy: SN4PR0501CA0028.namprd05.prod.outlook.com
 (2603:10b6:803:40::41) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (76.251.165.188) by
 SN4PR0501CA0028.namprd05.prod.outlook.com (2603:10b6:803:40::41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.9 via Frontend
 Transport; Tue, 27 Oct 2020 05:53:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 65ab5166-2486-433c-5eec-08d87a3ca8ab
X-MS-TrafficTypeDiagnostic: CH2PR12MB5004:
X-Microsoft-Antispam-PRVS: <CH2PR12MB50041EB16FFE1B24A3B3AD7C95160@CH2PR12MB5004.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DfppJNxBhU8Yq8q8nuJsYRmck6ylK5CaKpy+dxPoKft/VQeyqRP4Qvs1RC9G91av+CEwvCrvv4RrKEydAXi9TeLGhDo8rvhDI3A+hieQbRiTLhAxExAlW4aqEZGH8OEVDmWJ9o+FUgSV5EAYzi1Y841cdigYjXimG0r1V0etbStc7r+94/3uzorehpPfLsQLX7dVU0ZL9Uk80BFqAzzf9CRR1gqOSUBkKYzGrH04qsbvnMsPN1zCnb9Gf6Nvs/6QARj6S+kUWURN9VgBv1hdeJUnrRDfx0fj9CW8E7IIz03zt7vx/QeqP5rjgMoDaEzK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(316002)(956004)(2616005)(1076003)(8936002)(6496006)(5660300002)(86362001)(52116002)(66556008)(2906002)(6666004)(6916009)(478600001)(66476007)(26005)(66946007)(16526019)(8676002)(186003)(6486002)(4326008)(44832011)(83380400001)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: orMGfsyf70ogANhIwsQSfR7GTwCBjKN7HLCdEA2S0YhblMN4nrN1udgarYgJqmbX4jxQ+ZPT2J0V3UAZ+1LIK4Ojko5Ntfrp3bvNoakiL4dz98vN/B7K5kd2CqiN6gSwdIGF630bOB3rx64pgsjz/0sFSK9yCKcp1Un4tLDWgKgN6ly2WWHx4s/dc2qfByF3trJoc3p8Af/AalSKvc4n6fAEJAxDqu/la8f1wp4Uw1ox5jdjFQdzAbhjWxZ0WP6Kfvcq4L9o7yl0gL02zSDtT7qeHEJKqeRizPZQxRyJDPvmhBS4VDlkQzqci16yOt5vyukfgyQsAuVeQEEuO/pXjJqeRh8NGBgLRdrPqwB0nzq4Nz+qqrAV5QHUMW6tlqfqi9LwZQ4OsoWiBM7KlXHjD6URLh0QBlu5bHOvxEM0NRJF6CAE8EO87UjGSdUta+jYxYpDbtlVrE0Lfg3GHSkg0qPllrILLnAFruGsWuJZGyVHjckd1bEkXc3Q+i1Ag+LjYIxGWvzohtM2b7a+6zH00rpuP2ZSOZI4l64bTKG7uY4KPdiEAljDneai9eqzTTLme56u71rqlKA41gRu4eUcIWfmMU0y81LmzRBvVSgfvITPztNawR8LpcDMWnh8xC8kjqBlKg7Ii2hsp9qXKzGeXw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ab5166-2486-433c-5eec-08d87a3ca8ab
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 05:53:42.1644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FwPH/SzKMObwaqw7CdmwP76JNsbL4YV2/ygErFZ4xySnMIrtshe0X5eeNry46tEAIkXyIrUwu0uMUYqOSUsq3w==
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
X-Mailman-Approved-At: Tue, 27 Oct 2020 03:46:40 -0400
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
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 qga/commands-posix-ssh.c | 66 ++++++++++++++++++++++++++++++++++++++++
 qga/meson.build          | 11 +++++--
 qga/qapi-schema.json     | 31 +++++++++++++++++++
 3 files changed, 106 insertions(+), 2 deletions(-)

diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
index f974bc4b64..4d75cb0113 100644
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
+    return g_steal_pointer (&ret);
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
+    g_assert_null(err);
+
+    for (len = 0, k = ret->keys; k != NULL; k = k->next) {
+        g_assert(g_str_has_prefix(k->value, "algo "));
+        len++;
+    }
+
+    g_assert_cmpint(len, ==, 2);
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
index 8340892139..80e7487f32 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -90,8 +90,15 @@ test_env.set('G_TEST_SRCDIR', meson.current_source_dir())
 test_env.set('G_TEST_BUILDDIR', meson.current_build_dir())
 
 if 'CONFIG_POSIX' in config_host
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


