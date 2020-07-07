Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0891CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:16:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3878206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qdRpy8KB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3878206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jshqM-0001Qj-Rv
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshjA-0004lO-5Y
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:09:16 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54936)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshj7-00045I-68
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:09:15 -0400
Received: by mail-wm1-x344.google.com with SMTP id o8so42101474wmh.4
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 00:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wXN1VAPLVX42DG/MXYUsKGX14V7wDDkXJy0egf9Mkr4=;
 b=qdRpy8KBobvBXvxk1HsQN2NFBeJYQabgfqImXreh2XCZK2rYB2OaJ4FFb2qMnbm4Vw
 xDa+Uw0ZATSvm5Doa9uO8axekWToYljAdLWkggA4+F1IGY0pFkZuJYa2OBhSj7XM2fkQ
 74v9NDo563dx6goMyhHSJC+Y5ScSlzAcq6+D5aN5bOj1shVlx7a00IDEz87vkdg0Enox
 VEDMgRTggECUIMTc69+gVdk9Z7HslF8LX0LyfIdNzO8RlOai5GS2Kzb42LofcLnX45K4
 AkmSQn3fv3MkkW299BMuR3+D90pnT4aV+QK/aL7rhajNVBmTfVgLiOF4FC65JiLGGk+1
 Rqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wXN1VAPLVX42DG/MXYUsKGX14V7wDDkXJy0egf9Mkr4=;
 b=cL4JCVaY8UuhkS7ra5GmpdSRDi4zR6Sy7UXVWPkCuoIwkh1SzKi2afuHx9fCWKMEZu
 32qLQHzF3D0uvczSjFA+MtFjBgDqCp5AdVWrrtJG3+zrEGwbPtjsrJ7Ko8SPv1DkxOEU
 CcMfOdChVoqzIAP2T8LPNkr9lnBOIWqD+yGGGphQvbV2Y9KCVAxiTQFyLuXUJzaDCGuU
 W6n0Dm5GxvFNQZ1xcgtt/YDuRMYeF3WMXoufz8lBdGU6fnuw1zKWXLpsmiKCJzkEEuDN
 3gVHVUdmmFeS0ZD3oTOBFB0/LZiiJbv29+yLVH4YJaz69U114AskKUG2QU5sucNGSMOM
 0QQg==
X-Gm-Message-State: AOAM532e9gEOoFzAHcDCSVCNIa57vIBKoQhZPjqRCya4enuGbv5UkC1i
 JsrJ2J+8ntg6x/nzLepTeT93RJSkYTE=
X-Google-Smtp-Source: ABdhPJztcvK337zPC3CNJHeblT65AgH6x4heVhKhx/SE6aNsGMGY5I4Xcgik244NntsM9e0oJsuSlw==
X-Received: by 2002:a1c:6805:: with SMTP id d5mr2571159wmc.19.1594105751682;
 Tue, 07 Jul 2020 00:09:11 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g3sm18597491wrb.59.2020.07.07.00.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 00:09:05 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 625F11FF98;
 Tue,  7 Jul 2020 08:08:59 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 09/41] tests/vm: change scripts to use self._config
Date: Tue,  7 Jul 2020 08:08:26 +0100
Message-Id: <20200707070858.6622-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200707070858.6622-1-alex.bennee@linaro.org>
References: <20200707070858.6622-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Robert Foley <robert.foley@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Foley <robert.foley@linaro.org>

This change converts existing scripts to using for example self.ROOT_PASS,
to self._config['root_pass'].
We made similar changes for GUEST_USER, and GUEST_PASS.
This allows us also to remove the change in basevm.py,
which adds __getattr__ for backwards compatibility.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200601211421.1277-8-robert.foley@linaro.org>
Message-Id: <20200701135652.1366-12-alex.bennee@linaro.org>

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 5fd66f6b26a1..f716798b405e 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -183,13 +183,6 @@ class BaseVM(object):
         self.console_init(timeout=timeout)
         self.console_wait(wait_string)
 
-    def __getattr__(self, name):
-        # Support direct access to config by key.
-        # for example, access self._config['cpu'] by self.cpu
-        if name.lower() in self._config.keys():
-            return self._config[name.lower()]
-        return object.__getattribute__(self, name)
-
     def _download_with_cache(self, url, sha256sum=None, sha512sum=None):
         def check_sha256sum(fname):
             if not sha256sum:
@@ -239,13 +232,13 @@ class BaseVM(object):
         return r
 
     def ssh(self, *cmd):
-        return self._ssh_do(self.GUEST_USER, cmd, False)
+        return self._ssh_do(self._config["guest_user"], cmd, False)
 
     def ssh_root(self, *cmd):
         return self._ssh_do("root", cmd, False)
 
     def ssh_check(self, *cmd):
-        self._ssh_do(self.GUEST_USER, cmd, True)
+        self._ssh_do(self._config["guest_user"], cmd, True)
 
     def ssh_root_check(self, *cmd):
         self._ssh_do("root", cmd, True)
diff --git a/tests/vm/fedora b/tests/vm/fedora
index a9195670f4bd..b2b478fdbcac 100755
--- a/tests/vm/fedora
+++ b/tests/vm/fedora
@@ -108,20 +108,20 @@ class FedoraVM(basevm.BaseVM):
 
         self.console_wait_send("7) [!] Root password",     "7\n")
         self.console_wait("Password:")
-        self.console_send("%s\n" % self.ROOT_PASS)
+        self.console_send("%s\n" % self._config["root_pass"])
         self.console_wait("Password (confirm):")
-        self.console_send("%s\n" % self.ROOT_PASS)
+        self.console_send("%s\n" % self._config["root_pass"])
 
         self.console_wait_send("8) [ ] User creation",     "8\n")
         self.console_wait_send("1) [ ] Create user",       "1\n")
         self.console_wait_send("3) User name",             "3\n")
-        self.console_wait_send("ENTER:", "%s\n" % self.GUEST_USER)
+        self.console_wait_send("ENTER:", "%s\n" % self._config["guest_user"])
         self.console_wait_send("4) [ ] Use password",      "4\n")
         self.console_wait_send("5) Password",              "5\n")
         self.console_wait("Password:")
-        self.console_send("%s\n" % self.GUEST_PASS)
+        self.console_send("%s\n" % self._config["guest_pass"])
         self.console_wait("Password (confirm):")
-        self.console_send("%s\n" % self.GUEST_PASS)
+        self.console_send("%s\n" % self._config["guest_pass"])
         self.console_wait_send("7) Groups",                "c\n")
 
         while True:
@@ -139,7 +139,7 @@ class FedoraVM(basevm.BaseVM):
             if good:
                 break
             time.sleep(10)
-            self.console_send("r\n" % self.GUEST_PASS)
+            self.console_send("r\n" % self._config["guest_pass"])
 
         self.console_wait_send("'b' to begin install",     "b\n")
 
@@ -150,12 +150,13 @@ class FedoraVM(basevm.BaseVM):
 
         # setup qemu user
         prompt = " ~]$"
-        self.console_ssh_init(prompt, self.GUEST_USER, self.GUEST_PASS)
+        self.console_ssh_init(prompt, self._config["guest_user"],
+                                      self._config["guest_pass"])
         self.console_wait_send(prompt, "exit\n")
 
         # setup root user
         prompt = " ~]#"
-        self.console_ssh_init(prompt, "root", self.ROOT_PASS)
+        self.console_ssh_init(prompt, "root", self._config["root_pass"])
         self.console_sshd_config(prompt)
 
         # setup virtio-blk #1 (tarfile)
diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index f87db2b126e6..29252fa4a64a 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -113,9 +113,9 @@ class FreeBSDVM(basevm.BaseVM):
 
         # post-install configuration
         self.console_wait("New Password:")
-        self.console_send("%s\n" % self.ROOT_PASS)
+        self.console_send("%s\n" % self._config["root_pass"])
         self.console_wait("Retype New Password:")
-        self.console_send("%s\n" % self.ROOT_PASS)
+        self.console_send("%s\n" % self._config["root_pass"])
 
         self.console_wait_send("Network Configuration", "\n")
         self.console_wait_send("IPv4",                  "y")
@@ -134,9 +134,9 @@ class FreeBSDVM(basevm.BaseVM):
         # qemu user
         self.console_wait_send("Add User Accounts", "y")
         self.console_wait("Username")
-        self.console_send("%s\n" % self.GUEST_USER)
+        self.console_send("%s\n" % self._config["guest_user"])
         self.console_wait("Full name")
-        self.console_send("%s\n" % self.GUEST_USER)
+        self.console_send("%s\n" % self._config["guest_user"])
         self.console_wait_send("Uid",                   "\n")
         self.console_wait_send("Login group",           "\n")
         self.console_wait_send("Login group",           "\n")
@@ -148,9 +148,9 @@ class FreeBSDVM(basevm.BaseVM):
         self.console_wait_send("Use an empty password", "\n")
         self.console_wait_send("Use a random password", "\n")
         self.console_wait("Enter password:")
-        self.console_send("%s\n" % self.GUEST_PASS)
+        self.console_send("%s\n" % self._config["guest_pass"])
         self.console_wait("Enter password again:")
-        self.console_send("%s\n" % self.GUEST_PASS)
+        self.console_send("%s\n" % self._config["guest_pass"])
         self.console_wait_send("Lock out",              "\n")
         self.console_wait_send("OK",                    "yes\n")
         self.console_wait_send("Add another user",      "no\n")
@@ -164,12 +164,12 @@ class FreeBSDVM(basevm.BaseVM):
 
         # setup qemu user
         prompt = "$"
-        self.console_ssh_init(prompt, self.GUEST_USER, self.GUEST_PASS)
+        self.console_ssh_init(prompt, self._config["guest_user"], self._config["guest_pass"])
         self.console_wait_send(prompt, "exit\n")
 
         # setup root user
         prompt = "root@freebsd:~ #"
-        self.console_ssh_init(prompt, "root", self.ROOT_PASS)
+        self.console_ssh_init(prompt, "root", self._config["root_pass"])
         self.console_sshd_config(prompt)
 
         # setup serial console
diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index cdac502dad86..dc0e45c1d45a 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -120,24 +120,24 @@ class NetBSDVM(basevm.BaseVM):
         self.console_wait_send("d: Change root password",  "d\n")
         self.console_wait_send("a: Yes",                   "a\n")
         self.console_wait("New password:")
-        self.console_send("%s\n" % self.ROOT_PASS)
+        self.console_send("%s\n" % self._config["root_pass"])
         self.console_wait("New password:")
-        self.console_send("%s\n" % self.ROOT_PASS)
+        self.console_send("%s\n" % self._config["root_pass"])
         self.console_wait("Retype new password:")
-        self.console_send("%s\n" % self.ROOT_PASS)
+        self.console_send("%s\n" % self._config["root_pass"])
 
         self.console_wait_send("o: Add a user",            "o\n")
         self.console_wait("username")
-        self.console_send("%s\n" % self.GUEST_USER)
+        self.console_send("%s\n" % self._config["guest_pass"])
         self.console_wait("to group wheel")
         self.console_wait_send("a: Yes",                   "a\n")
         self.console_wait_send("a: /bin/sh",               "a\n")
         self.console_wait("New password:")
-        self.console_send("%s\n" % self.GUEST_PASS)
+        self.console_send("%s\n" % self._config["guest_pass"])
         self.console_wait("New password:")
-        self.console_send("%s\n" % self.GUEST_PASS)
+        self.console_send("%s\n" % self._config["guest_pass"])
         self.console_wait("Retype new password:")
-        self.console_send("%s\n" % self.GUEST_PASS)
+        self.console_send("%s\n" % self._config["guest_pass"])
 
         self.console_wait_send("a: Configure network",     "a\n")
         self.console_wait_send("a: vioif0",                "a\n")
@@ -170,12 +170,13 @@ class NetBSDVM(basevm.BaseVM):
 
         # setup qemu user
         prompt = "localhost$"
-        self.console_ssh_init(prompt, self.GUEST_USER, self.GUEST_PASS)
+        self.console_ssh_init(prompt, self._config["guest_user"],
+                                      self._config["guest_pass"])
         self.console_wait_send(prompt, "exit\n")
 
         # setup root user
         prompt = "localhost#"
-        self.console_ssh_init(prompt, "root", self.ROOT_PASS)
+        self.console_ssh_init(prompt, "root", self._config["root_pass"])
         self.console_sshd_config(prompt)
 
         # setup virtio-blk #1 (tarfile)
diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 13e7f9a6d56f..dfe633e45325 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -98,9 +98,9 @@ class OpenBSDVM(basevm.BaseVM):
         self.console_wait_send("Which network interface", "done\n")
         self.console_wait_send("DNS domain name",         "localnet\n")
         self.console_wait("Password for root account")
-        self.console_send("%s\n" % self.ROOT_PASS)
+        self.console_send("%s\n" % self._config["root_pass"])
         self.console_wait("Password for root account")
-        self.console_send("%s\n" % self.ROOT_PASS)
+        self.console_send("%s\n" % self._config["root_pass"])
         self.console_wait_send("Start sshd(8)",           "yes\n")
         self.console_wait_send("X Window System",         "\n")
         self.console_wait_send("xenodm",                  "\n")
@@ -108,13 +108,13 @@ class OpenBSDVM(basevm.BaseVM):
         self.console_wait_send("Which speed",             "\n")
 
         self.console_wait("Setup a user")
-        self.console_send("%s\n" % self.GUEST_USER)
+        self.console_send("%s\n" % self._config["guest_user"])
         self.console_wait("Full name")
-        self.console_send("%s\n" % self.GUEST_USER)
+        self.console_send("%s\n" % self._config["guest_user"])
         self.console_wait("Password")
-        self.console_send("%s\n" % self.GUEST_PASS)
+        self.console_send("%s\n" % self._config["guest_pass"])
         self.console_wait("Password")
-        self.console_send("%s\n" % self.GUEST_PASS)
+        self.console_send("%s\n" % self._config["guest_pass"])
 
         self.console_wait_send("Allow root ssh login",    "yes\n")
         self.console_wait_send("timezone",                "UTC\n")
@@ -135,12 +135,13 @@ class OpenBSDVM(basevm.BaseVM):
 
         # setup qemu user
         prompt = "$"
-        self.console_ssh_init(prompt, self.GUEST_USER, self.GUEST_PASS)
+        self.console_ssh_init(prompt, self._config["guest_user"],
+                                      self._config["guest_pass"])
         self.console_wait_send(prompt, "exit\n")
 
         # setup root user
         prompt = "openbsd#"
-        self.console_ssh_init(prompt, "root", self.ROOT_PASS)
+        self.console_ssh_init(prompt, "root", self._config["root_pass"])
         self.console_sshd_config(prompt)
 
         # setup virtio-blk #1 (tarfile)
-- 
2.20.1


