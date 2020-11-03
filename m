Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A19C388F2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:49:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 543F222275
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3ywXb6oJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 543F222275
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZmOB-0004dp-7c
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 21:49:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZmJQ-0000g4-JC
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:44:46 -0500
Received: from mail-mw2nam12on2072.outbound.protection.outlook.com
 ([40.107.244.72]:13281 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZmJM-0007gm-Gm
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:44:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1z29ZAvtYTGCX3Fy0nMO7tH8yBdHdLUVP0KBX2zFmwodSapf7IQzG9twyOUDtg8oJI79EGQuiBpf/RiA+l9J+kJjVNTh0xNmslo/xcuAjRRqLMbZUUhUrmkp7fIeSINdsRKDsR6oaLaUZ9GYafkmpCFMrmtFLGspbwsPtUqXsXdo8zufa+jCPv66XSaLZXzNrYhigvB9fAZYPZ562gpVrB1eW595dLvRb811VY2Wlym9GDsFAjf56lBSq2lAO/RNHmdkHJmwhoTvgsJFQJrMyW98dLnAFxItLVK8bS6L25P5p37t4EgzsKXUn1hdQsha0865EnMguFFWiOrDQauIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tseNb57wpljKm04dFzmL/UoCYpD6m83klH8rkwG1M3w=;
 b=lhLekTF0+lyAxB5sgK92yrsMVTGbJx/V8dYrOazuucc0P9MLdqlR+TstIZFNVU2T3G3QJJLL9byUjnBCvjhc+4Z9mCFkAkTU4dVc3BqPN3eHSyw3Kfg6qRvbGuHvNJ2NV407Q5CUfufymCuq5073mePhSV4BIqDU1x4+7gZ/AG8MI4VVRGiZ4jPvDp/OmdeNm8tmNnj/EsNl3clEnB+CcV6l7YQcsYSksMmHUUjnu7xfO/VKfJxiFtgR+BrY5Klrixs9qwl0Vb2JilYbRONSBAJTp1Ww/NpcXsQ9I1dT0hZxeHSP0CGKX0bi0I6SIe3J//z3PV6wppvys6HYRUZsfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tseNb57wpljKm04dFzmL/UoCYpD6m83klH8rkwG1M3w=;
 b=3ywXb6oJrMQ/6u+yeTkApqYFyLfuHYBetC10ZXrknD/rqf8pS6v4uQaWIxcKmEKn+Y/QzxoMj6wzPqzeR5rDLBtQER6AnE1pgqS1Gsl3yJOVMd8ADOzT+L1HrQ2B6fas/aG6eMezjdPuWV6o1U4gx8huiUPX860cJHigPB0zyrc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB4311.namprd12.prod.outlook.com (2603:10b6:610:a8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 3 Nov
 2020 02:44:34 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 02:44:34 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 10/12] qga: add *reset argument to ssh-add-authorized-keys
Date: Mon,  2 Nov 2020 20:43:42 -0600
Message-Id: <20201103024343.894221-11-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103024343.894221-1-michael.roth@amd.com>
References: <20201103024343.894221-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: DM6PR02CA0110.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::12) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by
 DM6PR02CA0110.namprd02.prod.outlook.com (2603:10b6:5:1b4::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 3 Nov 2020 02:44:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0535de6f-acad-4045-6f15-08d87fa265ce
X-MS-TrafficTypeDiagnostic: CH2PR12MB4311:
X-Microsoft-Antispam-PRVS: <CH2PR12MB43117A3947DD328D943404E495110@CH2PR12MB4311.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gTFGFfOEbtuMFfi8aQmTRiSv14fMo1YAwalkMAf6gnxLy1I43ExgAAifTUBueJ6USrzyqFIMLnNnLqzW3fuAhz3GB5XCItSYbzF0q5aEWBwWPOI1/RJwSQab00PMIbPW+YD+s4MPZ08u1MjQcD3uyzegwnzm9uY735DwsGfVa989Sb5+FaN51JtxjgShh54zU07NZlS6G9QunQNNay7v3aoaUzIBqdtEec7OrK7Cw9MEnQOezYl/om4Z19njFlOupqmGWRuQrBvVwFxAqjnUdfbVKzeSWbwNdOezr0Bcwgv6pX7ux7FhAaTjNMAuHO6Bw+sOP+oe89vH+8whGMAq0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(16526019)(186003)(5660300002)(8936002)(6916009)(8676002)(36756003)(478600001)(86362001)(26005)(66556008)(956004)(66946007)(6666004)(6496006)(2616005)(6486002)(52116002)(66476007)(4326008)(1076003)(83380400001)(44832011)(316002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 0Yqi+vBZ2sAlWK5okk11HiXimhc+mHkuA2QxRTRIUpqPlE1SnxU3GiGhtjLqnwk9dapA8gHouQC3STUQ4+fIPyNlkZxpahvDrS+9nxHKQ3mC6f3w+bg31NC1FJ5bYYyozeM7Q24nZ8t2PLDcifBHPbpLSQRudnp5uNar7EnD14GHbq7IFa8DaRdOwUL4xKXMnBdLw2sGzW3D0DaGf30NLKyhifRk8THDc2IdMwgqUfeosn7wnHfShYWbqSWQukqfzw9TF9rNSJr9vjsyvVIy/Pb7V11t4D0UHTmYhiqNrtY8zfBCdIAxduZbNjtXk1qjSkJ2zzl535a1Di6uwqxOUMsr86NkzdxII/7QMTs6BD2D/ZpyqFoMvFNvWueYbbZN8tmJNZ4KWy/cDjE8VC+TzrKULuBXqMy7EpyNxwbSkICiqXcHR0KRNwOTknfpYrSYQCJGYw04FRqGgaCADgPxuRxfnaVetLUMSSulndxIPGPDVnWcqEkHQp2ZwqSueLmMCNDPTn0EUFD9oXcu9oHAS7eQZfbyA0nIwF1OUERcTNWTB7RlPR9q0gvFUSAz8yxC3hl/CqDnS4AlMDGaY5uQedzJQCMBiCrqc1ipy2uMfLiLXO/2mH3ZmCC0uX/pdiEQp6rb4X9AZzfuzJqMpwa2TQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0535de6f-acad-4045-6f15-08d87fa265ce
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 02:44:34.4184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3STnbTPYIbZtp7C44ytKe9cxOVhiAxzZzWplGH8W911cvus1qdoXmAyhnFDpzbPTtAyhOSz0w0Oz9w0yY1ViDg==
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

I prefer 'reset' over 'clear', since 'clear' and keys may have some
other relations or meaning.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
*fix disallowed g_assert* usage reported by checkpatch
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 qga/commands-posix-ssh.c | 53 ++++++++++++++++++++++++++++++++++++----
 qga/qapi-schema.json     |  3 ++-
 2 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
index f74d89679c..362c9e8816 100644
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
     g_assert(err == NULL);
 
     test_authorized_keys_equal("algo key2 comments");
 
     qmp_guest_ssh_add_authorized_keys(g_get_user_name(),
-                                      (strList *)&test_key1_2, &err);
+                                      (strList *)&test_key1_2,
+                                      FALSE, FALSE,
+                                      &err);
     g_assert(err == NULL);
 
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
+    g_assert(err == NULL);
+
+    /* reset with key2 only */
+    test_authorized_keys_equal("algo key1 comments\n"
+                               "algo key2 comments");
+
+    qmp_guest_ssh_add_authorized_keys(g_get_user_name(),
+                                      (strList *)&test_key2,
+                                      TRUE, TRUE,
+                                      &err);
+    g_assert(err == NULL);
+
+    test_authorized_keys_equal("algo key2 comments");
+
+    /* empty should clear file */
+    qmp_guest_ssh_add_authorized_keys(g_get_user_name(),
+                                      (strList *)NULL,
+                                      TRUE, TRUE,
+                                      &err);
+    g_assert(err == NULL);
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


