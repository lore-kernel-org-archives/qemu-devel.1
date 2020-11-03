Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D235CC00A89
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 01:16:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EBB722243
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 01:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MmSodb/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EBB722243
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZkva-0007sY-87
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 20:16:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZks8-0006NJ-S2
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 20:12:29 -0500
Received: from mail-mw2nam10on2058.outbound.protection.outlook.com
 ([40.107.94.58]:64832 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZks4-0005WU-V5
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 20:12:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiCAxiFEZAB2uFF4RkxXCAkwXtOzWVeexyHuKVl9S76eguuXcUU45tTpegdIDlcFhaBXyJOXHRyi+2+cp4UoMx6CWzmLr0KOcNYCFyXd55hZSMyqPk4REf2CvjmsJjzQvIwIFPW/j+6zsavhJkXLFLHQfJvjVEfflPbCcDrp04vRc94C7v49WvpeHR8EypKSw+mtDSOY3lgYwzkHcdQDtfg4BV1MrykTg8+cECuTPzDIz0xH2CfstSwMcDVZLNHUq8hWe4lZ/IYsci9egHcumtBbnQO9GUtFl2auNRKivoqw8a8drhVFXWdQw6P5HX30VXMhoOtVu1zQFLL/v00Isg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOKzbp4eQTrLJKMVG7F12JqubO9M4LB6ia5BxwcGHCI=;
 b=SGtGLvMZCtQOspGfg4aGFVgSjb0jLK7lVU8xUn2Wcsb75OncjrKQeeaYKycxoJZ7/BzITZnbH1P0NfevaZSA8RT8AogvYLAo+3Jxd8Kqw2EuEYxWxGOMtkn9FMhKK0GGzxL2muZmI1EPp579nScoH+TrUn80MlQl5Q3Q8Hgz/fQem/iJbzmHRTo7txH/IDnp2NRqAM+IZpqKyHbDBSytp+ZzuKwSYCO/lvjRM7EXTRUoDmrsTzGuV5cjnbSLUDKGQs0CUJoQWKzco0t5wYor5sGGQI/u/5ONPIvFgvESrPKhRuYunW3ggZ+BEjVlVKxTs8BPW2kQLKKqBaJ2TM+QzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOKzbp4eQTrLJKMVG7F12JqubO9M4LB6ia5BxwcGHCI=;
 b=MmSodb/pZVBPOZR1brtJDnLta0qgGEFWPvnMH/SPLBcPKu+ABULuluMQRwkowuAcKW+sgPzZJIXwMFbcKIZoma/V8rFaGIzwtMa10ZM39ZNEPHJ+j/zAX/qRB+aL06DkbsHbWfZWGIg6crfSFzI3KItovAddtC6EgcJh7/wCHJ8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB5001.namprd12.prod.outlook.com (2603:10b6:610:61::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 3 Nov
 2020 01:11:53 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 01:11:53 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 10/12] qga: add *reset argument to ssh-add-authorized-keys
Date: Mon,  2 Nov 2020 19:11:32 -0600
Message-Id: <20201103011134.887744-11-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103011134.887744-1-michael.roth@amd.com>
References: <20201103011134.887744-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SN2PR01CA0020.prod.exchangelabs.com (2603:10b6:804:2::30)
 To CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by
 SN2PR01CA0020.prod.exchangelabs.com (2603:10b6:804:2::30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 3 Nov 2020 01:11:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8f21812d-aa13-4073-dd25-08d87f95730a
X-MS-TrafficTypeDiagnostic: CH2PR12MB5001:
X-Microsoft-Antispam-PRVS: <CH2PR12MB5001231E84E3EF8CE3C4F3DF95110@CH2PR12MB5001.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YAvtu5e0+7UL7fDHS2UAnMsqvruismmtQSzkzVHQzXr+8OshdY1z6bJfjeGvrriqJ8+exzmkGDTWqYo5bdtW/ujdFwAE8LY+bQacRWeqqTWLjuvET4kyTRPFi5kwjyguZvQ6j1IWUrlS9LPBCNSPxEJZmv+Yfph19uknmE/Ht+x7cUcyFD6+9aN/KawSmMKBAugZ5zrs2+MLNZW4fEJOZK+kCnAGchrwmAblIxoemLdzVSbTJZpe6gSMBFLqZSgVr6JyNzjb8jhAJkTt5hsSYDWGYXof7o6dhWCH+7f8tkxSZW1aNaLbEEiJiOEqm6EdalE0meVjz9QciQ5zHojqBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(26005)(44832011)(66556008)(66476007)(66946007)(8936002)(86362001)(6486002)(6666004)(83380400001)(4326008)(36756003)(2906002)(8676002)(5660300002)(52116002)(478600001)(186003)(316002)(6916009)(1076003)(16526019)(2616005)(956004)(6496006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 6ps5593vQrTf4VJJrTdDukqM5lj6Vwj+L4jHVx27LVFqCEffi4tHmL/UtgfhVRmp81Kb7sCVw6ve7cOBLy6+beaCrE2gkF4ihHIJtCxguOiCry+EKpZMO5nCywVTphvW3+dKXrxGo648IRffQnVfE6lXleQPvcd0SDKbiO4oh2tqnnJfaduRJI1Gjp2SAocOLUp+iPGM6SgT93pAb0VbnaXUcwfp5jKgt1aW72oWS2W/Wvbn8eZbiwrI3wczxM2SouPTkzq5XGrD/epv7W5iavwnPvkxxjYJuMST1W6yaN2fq9R+5Gyv2fEgXP/ozpcYSOh7tZZcpBtyawTvfJW74lDCG2eyXnmEJ5LeiXwugLXNK+E7+AHmNKqTwlW9Ow0NeXh9/yvWoX3giiCHI9f+KNj+WKxkJgeSPbwKFB5ZtlosapfZXzZ2/8zT+SLESXU3tgTh1EXNCz0T8HHt3jtIxhQWrD7Mm2UNv/yGbt/+P+d8fNMZv8PXDZdeyVRqoa28tiO4NeqY3Tek03vwCTfZaUVYAuJ8P3j1qXUHh4g7ausdFpHJPoWTcCFpGU3hbNPY11trzMVVo2s63HxbdR6apMYbJ8JjkcM17sX2WHiJFeCh9UDcA0eeVMGlIgEJXJ1R7GDKX0ykO8GymiNZAebpfQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f21812d-aa13-4073-dd25-08d87f95730a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 01:11:53.2012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8dZK36NbVpLolqY8ZKnBcHzqo28roUtpTca7Vmg3tshG8PbEpSr/UH7KYgVVMMqdfP+S4QAHLXoEaV21edwpQ==
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

I prefer 'reset' over 'clear', since 'clear' and keys may have some
other relations or meaning.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 qga/commands-posix-ssh.c | 53 ++++++++++++++++++++++++++++++++++++----
 qga/qapi-schema.json     |  3 ++-
 2 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
index a7bc9a1c24..f974bc4b64 100644
--- a/qga/commands-posix-ssh.c
+++ b/qga/commands-posix-ssh.c
@@ -168,6 +168,7 @@ read_authkeys(const char *path, Error **errp)
 
 void
 qmp_guest_ssh_add_authorized_keys(const char *username, strList *keys,
+                                  bool has_reset, bool reset,
                                   Error **errp)
 {
     g_autofree struct passwd *p = NULL;
@@ -178,6 +179,7 @@ qmp_guest_ssh_add_authorized_keys(const char *username, strList *keys,
     size_t nkeys, nauthkeys;
 
     ERRP_GUARD();
+    reset = has_reset && reset;
 
     if (!check_openssh_pub_keys(keys, &nkeys, errp)) {
         return;
@@ -191,7 +193,9 @@ qmp_guest_ssh_add_authorized_keys(const char *username, strList *keys,
     ssh_path = g_build_filename(p->pw_dir, ".ssh", NULL);
     authkeys_path = g_build_filename(ssh_path, "authorized_keys", NULL);
 
-    authkeys = read_authkeys(authkeys_path, NULL);
+    if (!reset) {
+        authkeys = read_authkeys(authkeys_path, NULL);
+    }
     if (authkeys == NULL) {
         if (!g_file_test(ssh_path, G_FILE_TEST_IS_DIR) &&
             !mkdir_for_user(ssh_path, p, 0700, errp)) {
@@ -318,7 +322,7 @@ test_invalid_user(void)
 {
     Error *err = NULL;
 
-    qmp_guest_ssh_add_authorized_keys("", NULL, &err);
+    qmp_guest_ssh_add_authorized_keys("", NULL, FALSE, FALSE, &err);
     error_free_or_abort(&err);
 
     qmp_guest_ssh_remove_authorized_keys("", NULL, &err);
@@ -333,7 +337,8 @@ test_invalid_key(void)
     };
     Error *err = NULL;
 
-    qmp_guest_ssh_add_authorized_keys(g_get_user_name(), &key, &err);
+    qmp_guest_ssh_add_authorized_keys(g_get_user_name(), &key,
+                                      FALSE, FALSE, &err);
     error_free_or_abort(&err);
 
     qmp_guest_ssh_remove_authorized_keys(g_get_user_name(), &key, &err);
@@ -346,13 +351,17 @@ test_add_keys(void)
     Error *err = NULL;
 
     qmp_guest_ssh_add_authorized_keys(g_get_user_name(),
-                                      (strList *)&test_key2, &err);
+                                      (strList *)&test_key2,
+                                      FALSE, FALSE,
+                                      &err);
     g_assert_null(err);
 
     test_authorized_keys_equal("algo key2 comments");
 
     qmp_guest_ssh_add_authorized_keys(g_get_user_name(),
-                                      (strList *)&test_key1_2, &err);
+                                      (strList *)&test_key1_2,
+                                      FALSE, FALSE,
+                                      &err);
     g_assert_null(err);
 
     /*  key2 came first, and should'nt be duplicated */
@@ -360,6 +369,39 @@ test_add_keys(void)
                                "algo key1 comments");
 }
 
+static void
+test_add_reset_keys(void)
+{
+    Error *err = NULL;
+
+    qmp_guest_ssh_add_authorized_keys(g_get_user_name(),
+                                      (strList *)&test_key1_2,
+                                      FALSE, FALSE,
+                                      &err);
+    g_assert_null(err);
+
+    /* reset with key2 only */
+    test_authorized_keys_equal("algo key1 comments\n"
+                               "algo key2 comments");
+
+    qmp_guest_ssh_add_authorized_keys(g_get_user_name(),
+                                      (strList *)&test_key2,
+                                      TRUE, TRUE,
+                                      &err);
+    g_assert_null(err);
+
+    test_authorized_keys_equal("algo key2 comments");
+
+    /* empty should clear file */
+    qmp_guest_ssh_add_authorized_keys(g_get_user_name(),
+                                      (strList *)NULL,
+                                      TRUE, TRUE,
+                                      &err);
+    g_assert_null(err);
+
+    test_authorized_keys_equal("");
+}
+
 static void
 test_remove_keys(void)
 {
@@ -393,6 +435,7 @@ int main(int argc, char *argv[])
     g_test_add_func("/qga/ssh/invalid_user", test_invalid_user);
     g_test_add_func("/qga/ssh/invalid_key", test_invalid_key);
     g_test_add_func("/qga/ssh/add_keys", test_add_keys);
+    g_test_add_func("/qga/ssh/add_reset_keys", test_add_reset_keys);
     g_test_add_func("/qga/ssh/remove_keys", test_remove_keys);
 
     return g_test_run();
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index a2727ed86b..4ddea898fa 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1352,6 +1352,7 @@
 #
 # @username: the user account to add the authorized keys
 # @keys: the public keys to add (in OpenSSH/sshd(8) authorized_keys format)
+# @reset: ignore the existing content, set it with the given keys only
 #
 # Append public keys to user .ssh/authorized_keys on Unix systems (not
 # implemented for other systems).
@@ -1361,7 +1362,7 @@
 # Since: 5.2
 ##
 { 'command': 'guest-ssh-add-authorized-keys',
-  'data': { 'username': 'str', 'keys': ['str'] },
+  'data': { 'username': 'str', 'keys': ['str'], '*reset': 'bool' },
   'if': 'defined(CONFIG_POSIX)' }
 
 ##
-- 
2.25.1


