Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E677C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 07:48:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 789D220738
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 07:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PlgReS2a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 789D220738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXJiE-0001jQ-8P
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 03:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kXHva-00073q-Iq
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:53:50 -0400
Received: from mail-bn7nam10on2050.outbound.protection.outlook.com
 ([40.107.92.50]:55041 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kXHvY-000447-Bj
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:53:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h69hcZw2aYmqePSHtoGTYNgbBD0j2jo7VLI/dE3uZYgXyn7xMzPO7dmBy9XjBfa2+JtKHOCRg0ZzXbmPPqPA0pKMRluqjNSxEDGxvUxO+gY1sz85jK5tVUTgGjkWCZ0QFUnycscMTLuta7mNDLhCjN1Y5iJD0lObzUjZZ6tWUf+GKuIzUgO17Nl7lbOyODF5dHznyqkY3Dff2fL1v6p7T5mA+LFvDMqaoJspDBV8q/xm7LmHE2OrE3C1Gdu9qa8FPln9SRhEnf5+UZWNkos94LcfdWsa3kJWK6yk7gh7JReByBVXfG63VOzeipfEMps++1pEQMkz4yDSO4UlY0+WtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOKzbp4eQTrLJKMVG7F12JqubO9M4LB6ia5BxwcGHCI=;
 b=PfaJ/wabXgF1mdm2K15QnaKJbXP5SUfKILqplZxVpuovhdy+fXGgcQxSQtyg+8cgBtgPUlIKS4D2Sd0V3uy8j7gt5VwpOzoLe/WTFbWNYqg0R3veHNg0gPlOHVZhnaaJuA8GBYeZhxhz4WLwU0dkdm02xXYmkspgq3jFvbSD5AksoTaWsgs1JM10+RMc8LpbVmyaLPg1dgr6qrpGOWLoHL7dxqM0I89UTOY3RuUqEAccVcCfLSADFJzGlv7vE6AUrTEcIneDKsf0CID/8/HauLNxCgOC7eMQfDyl8xv2QWODzA4qODGR8kXRxiTEoLIJuabgzhGKExM+PJ8wdRJxBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOKzbp4eQTrLJKMVG7F12JqubO9M4LB6ia5BxwcGHCI=;
 b=PlgReS2aQHP49gSQm/j5hgDPXsdqiWqvlRFbMx79TFa0ldTgAesZkSWt42dL7PV9HME/TFY4I1S5SBFCopYQPXAT8nXNIqgS9gUbXg1IAQaxIoLslzyxERDtlC/cV07tTWHc1LhB3igkPsDFXpDpyN+uJD4g9mVTyz6a1TBS+jQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB5004.namprd12.prod.outlook.com (2603:10b6:610:62::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 05:53:37 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.018; Tue, 27 Oct 2020
 05:53:37 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/12] qga: add *reset argument to ssh-add-authorized-keys
Date: Tue, 27 Oct 2020 00:53:15 -0500
Message-Id: <20201027055317.351868-11-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027055317.351868-1-michael.roth@amd.com>
References: <20201027055317.351868-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [76.251.165.188]
X-ClientProxiedBy: DM6PR07CA0046.namprd07.prod.outlook.com
 (2603:10b6:5:74::23) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (76.251.165.188) by
 DM6PR07CA0046.namprd07.prod.outlook.com (2603:10b6:5:74::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 05:53:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ce921660-1728-4fcb-5756-08d87a3ca5d0
X-MS-TrafficTypeDiagnostic: CH2PR12MB5004:
X-Microsoft-Antispam-PRVS: <CH2PR12MB5004119FA12A07C94B729EC995160@CH2PR12MB5004.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /64xbMdXNuIwq1kF8bDuMeZpKA2hMImdquK6UaPqMVCQ8u0g2hYZyblcvWOjKR5LuaxsYyPT67GzEYkc8Bo45JvzGmW2LJ3w411ssrI4+6mM3zE4Hq2jrQz64Yvj6WEqECHdjPDRiAGPYvOUB4EV/aSAdNrdRLmiD46dh/o+IMlawsc2XXv432rQPdBmqOWrLKy4t2WRlvoot16CVMGuxUgvWssNcFYPg8PPhGDqzLqyK1CNR72cinV8HO5EazR1x7vICa9T9UbhvpjtyRkMvLftvaxw8QY4PcCofuDyvz/5iTBVFHoDFYOI1pH1DBTBHt6SgeL/V7qnKYQM5tzxnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(316002)(956004)(2616005)(1076003)(8936002)(6496006)(5660300002)(86362001)(52116002)(66556008)(2906002)(6666004)(6916009)(478600001)(66476007)(26005)(66946007)(16526019)(8676002)(186003)(6486002)(4326008)(44832011)(83380400001)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: qnV72S493Sslp0HLmyW0LgbbjqJnBl9uvhQiA0MEHuhQIW3QpL+rijCzf2NXUfbqXN/HMQXwvBzrUBOh5ECJ/3lhEdpY3ZI35CPsk+E/6kMGd6GoDrug1PmPnqjm+UJDqnahbZwN/HDPK89Mpem4gGpXdSVaEltEk6KZBP0IaRUmA9quArSzhQKR1/L/BMUv/IrCxYo3Ds+gkue3+CwyrnoTeI470J4/pDM/wa6oltZviEY09svbIH2cZvI3AlER/HQyvwdDYKKjAoYGa5C0R5GotWm3E4cCzog6SIyPENbfYvjitAaqbITFJB4ENmrPhKcUq14GN8ZmobBeU1Mt3jVVV9msp55K8oCl8ubDbc8EI7Ng+XGMKTPFHfRgH8fCkXBPaKepvtfJTf1IbBcx+tWJ4idQAo5ETnBfC6XCj/YK4UPgFY7HRKj+X9zTdvw6eZwjvwXeNMtYzchygHY8a+b5X+qLsC3C/OZE20x004JAw+CRn8kOsy+S8IdcqgpToWaIA4ufBmofaja+XtkGf3HbJrdg1Xve0zWXxCKWrIAnCfuOKHQPCkWATec2M4UCLDh4g2924betSbBAOrmKwd+sVznvHjC0IdPApxmyKWlf+YmZel4iHeSlWliZESZFUPNBwQkm2sIlZd+9BXSXww==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce921660-1728-4fcb-5756-08d87a3ca5d0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 05:53:37.3636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rDMPKNX4lz6wQGrBhyPybNZaf/tpQGvYEQZl5XSIYS9g+FEhHRyhLHQ+aHLl3mEhs5KnqQG2pVFh4QOq7Iob5Q==
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
X-Mailman-Approved-At: Tue, 27 Oct 2020 03:46:19 -0400
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


