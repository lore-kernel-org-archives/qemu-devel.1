Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D347C4742C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 01:26:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 238DC2063A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 01:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZztAKNAr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238DC2063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZl5T-0006wz-PS
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 20:26:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZksT-0006Vx-QV
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 20:12:49 -0500
Received: from mail-mw2nam10on2058.outbound.protection.outlook.com
 ([40.107.94.58]:64832 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZksR-0005WU-JE
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 20:12:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJ6dXhOGvh+oogKpK8YFGk5hL2h+UvNS9x+x9QWEk40GOIB8mJ2TMBBmNBP5Z3KjSSEzpK/sqikGOc3ve0lTx6LKXSP8dTCQkYkMcNggLwNjYT7U3BEIq8UNKLzq0VSu6YYAGZXh0LAxupxVzIUSWpFPWuanXKfG4ZIpEJ4sngCOMgzt4rGrI0HUOe97tbiV8cLzol63Q1fXIqg9CYK58PNBn009RP+/L4dF7H2KiPRWVdEkkzSTECi4mueFDBte3OaejWUzNtnGBfulAv26dsy0lIsbm9z0EPvk6UUgE8DVh72xNxe36cejWcgKJcejV1koi5p3bqkAXOgFfdDXkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppi/Xh995pP+WTM9r/wbc0QZQ9H8XIWE/UmcUBhTc9c=;
 b=MG7rW2bEKwWme1gfVxoBG2aaW16Ccs/u7k+nysfZoO86+adIdbDREsU+5F95kUjoxWUncgD8q90H8rfmWFOvqzfX73E3pYalGJDxvnqyke0S94L/dnx0pK2ZpmleZWca3UJKidyFZLwTxQS4dYTuBSZxbvXU9/+IgvbiCaazYEpPSxjLvnvJ6d0q4N1GVuNkhsuo5xB8/4/yUasmZXZSIexyOc2TAV4uEQO2mP2k/5IxHi/QYuE/Yj1vSTaCNsqCivII5x+gatYvQFxEIdMieoaugJMd0fZNqEwAkocevAnkWOaobZMbxhlsIpFJmhSSs1PdJss60SBbJc6KvK3Euw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppi/Xh995pP+WTM9r/wbc0QZQ9H8XIWE/UmcUBhTc9c=;
 b=ZztAKNAr9H6qVbFijIXZFGnAzzGbVF3cBYDU5UQJm0AgUYyy7F4FPs+E1QVpk/T24LeSIHG/icxUoKg5j8sBVC2UOZCSh4bpt+0hLl9u/DnSBpYA085CjS8MUjTJB66YY6Zo+TiT8WxdGvq5absQjoZR1kEmMLBizxdDCuv4wjk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB5001.namprd12.prod.outlook.com (2603:10b6:610:61::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 3 Nov
 2020 01:12:18 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 01:12:18 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 12/12] qga: add ssh-get-authorized-keys
Date: Mon,  2 Nov 2020 19:11:34 -0600
Message-Id: <20201103011134.887744-13-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103011134.887744-1-michael.roth@amd.com>
References: <20201103011134.887744-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SA9PR13CA0229.namprd13.prod.outlook.com
 (2603:10b6:806:25::24) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by
 SA9PR13CA0229.namprd13.prod.outlook.com (2603:10b6:806:25::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.10 via Frontend Transport; Tue, 3 Nov 2020 01:12:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e3a6afe0-db66-495a-da51-08d87f9581f5
X-MS-TrafficTypeDiagnostic: CH2PR12MB5001:
X-Microsoft-Antispam-PRVS: <CH2PR12MB5001CAD9EC47974B00F6685A95110@CH2PR12MB5001.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dzDSbDgZay7/mRfS8odVpLsKxVyPdbnoCrsE4SChY0NScCwa934SNMvaiGIiFhH/uXLRj2x/hXp/rAmlY5O0pXpv8A91mVCfAv6N4L12WWad5fjWKYxLhNY5QfUsKpgpHF/VFBjSj3DKNLgp6caPS6HOHFkUkF3Z4qkmIKKMt/q8I/JDlbof1YfH6y7jfCMgFIs+wyU1yN9MQfXHmSvcu+wTX3gakWBgBgMPF0WlO5j26AUjim548A9LBxoWLWrIq8dpq6Nd25hkhVY46uZUMUvfjz5w9Upd+HGV2KoskhbThMDt2gw2NtZPiQCqRXza5OPEjy6dbWUpkBAKUDCWUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(26005)(44832011)(66556008)(66476007)(66946007)(8936002)(86362001)(6486002)(6666004)(83380400001)(4326008)(36756003)(2906002)(8676002)(5660300002)(52116002)(478600001)(186003)(316002)(6916009)(1076003)(16526019)(2616005)(956004)(6496006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 8qJZlrXOCaxueqdHKxlI/Dkawqf8DVRP5EbmI3ImH4x1dvCOwxJznxfS0nU6fl+TzJU51S6ay+KY8ijso0mnQoicuIci1WKEg1sE7FkJ/zHqcvRcNT/li5hzioEEIAv3rv2rpvWigfmcTZC0yaJO0b7/5amTc2xkzWg3Xca4YkxQ35t1cLP8wVgCkvv8hG6KUfXoZtC7jkkr1I0BGtujHhNpbmvs3wPoxpmpq46cQzflIkUsaOzX/5jVh2kpiunybj+RqWgadx81IEb64UrAlFkFin4HcTZLAbxhCOczvwepFfPFByp+bwbYqqi1Ge6sOIzgTlBfFYVNzz2fuhuLFgC4Q+OQK9YYJ5t+d6b6VDl/I42Yq3xDHfDxwpvd2D2xgiiWm03CFSyUbyYmqsRyzlffSCXyp+XbFdKVxp5R4Yi/0CfNXqEg6I+NxhxEPzan567jofrdc6AozMt2pbutpSi5n3xC1DWcyC5haw2qStPCn8QHOrOsBKfP2PzI+hyLWNfAs8372gcjQfUeyZumVbfpTB8ANkohuDHOoKlBayBSD4zEhufqfDxixJqB/+NuzLqrSj6sETmTLMNoViX7hSaSL1wOQyuATXgVdDCthAkrNzj5HDUyVCzLzWe6gN0Eo/9TRYpUrD7DUekqLghJog==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a6afe0-db66-495a-da51-08d87f9581f5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 01:12:18.1765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R/P/rb3Ag2RT3iuov4gWh/UH3JR1k6yJW/RImsufSi9yn+VYWMjTm+wpFultMS4dgKVCJ66OXA9ZHaqGxVyk1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5001
Received-SPF: none client-ip=40.107.94.58; envelope-from=Michael.Roth@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 20:12:23
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


