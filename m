Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB7BC433E1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 21:20:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 072F4206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 21:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SdoRmx7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 072F4206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfrqv-0006gT-8T
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 17:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jfrmf-0001iX-5G
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 17:15:49 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:45886)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jfrmb-0006VW-Un
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 17:15:48 -0400
Received: by mail-pl1-x641.google.com with SMTP id y11so425234plt.12
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 14:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Av/aSukKm7E4C/n6bTL1XFaPSywJZc2wrn7KulrdpIo=;
 b=SdoRmx7/1Zf7wkYSxfNYYTjuS10MSuXIwYRlrNYdeo01xcrk8m+My6qOYNAGE2Mv8O
 FeqGA8pwoDtcDXxFXrG5w96eduEG5/sbtsm3tAlp+i15B9tjdg9SPWCR9PyRHoCFOTZj
 vftgVxCzhPZpBY8AAErUlttjrM9fVQ3c2vfXwf/eL+A7TuH4HbqtBrh3i4tfg1KF/wih
 C8PrQCXuUSVahUr4iNuZ7RIfYPvqT4WUUaeTfY+D9UWNz+eB5V0Ew8POSdMpXQ01hUUg
 GIu/0X5ooIih7q76gj9y9LFI/DaO7o64R8M2Iq1noc0HdwKLBv+YAV8Gz4lJdg3TqAiI
 FFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Av/aSukKm7E4C/n6bTL1XFaPSywJZc2wrn7KulrdpIo=;
 b=iwt1fImigPWfmkihKrmxXxeufeM8Y+YikW4Da1duNYuI9r1PNHd+cy+wlGtgWYBNv2
 qCTU618R4fEkqvXId2a5dBoU6DUb/UBeVxeHTMEhGkHeZe0DI9xwzOem/ETmoG8fDnhs
 2+qHgnMaffR5/yJpXP/Md0+Qjkutc+3d6ekSuHjXZI+/rEOJdAJ/dXsnFjfAt7Ccmupz
 mXSeBlgx60No+VhBmQ5ej5efiBOkx+bD+8+eiveY7kUUowcieMbZv6iJboxk63zlfhcR
 bhC7WNKmf5uiZppgrEbtjvKjbNeCYMVn8EprRZ4rO9ASzryvokEcA0rlbuLfe8IlpMAe
 e2+w==
X-Gm-Message-State: AOAM530VqHyDOqL6T6WwIKz1zMv64dQdTEj5lAKMWDfI6b8GBCKu29eT
 UUTKlSSYPxXotRChMZ3oxFyzTnxVnbr/sA==
X-Google-Smtp-Source: ABdhPJwATpFa0U6g8jCsp5DV8qWffo05tjc7LglJwQ1DuGpvC/TegoSlVfu9HkHVgAb5mJYIoaCnfw==
X-Received: by 2002:a17:90b:23c8:: with SMTP id
 md8mr1554127pjb.72.1591046144071; 
 Mon, 01 Jun 2020 14:15:44 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:85d8:9a30:f0f7:b100])
 by smtp.gmail.com with ESMTPSA id j24sm330131pga.51.2020.06.01.14.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 14:15:43 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 7/9] tests/vm: change scripts to use self._config
Date: Mon,  1 Jun 2020 17:14:19 -0400
Message-Id: <20200601211421.1277-8-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601211421.1277-1-robert.foley@linaro.org>
References: <20200601211421.1277-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=robert.foley@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, philmd@redhat.com, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This change converts existing scripts to using for example self.ROOT_PASS,
to self._config['root_pass'].
We made similar changes for GUEST_USER, and GUEST_PASS.
This allows us also to remove the change in basevm.py,
which adds __getattr__ for backwards compatibility.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
---
 tests/vm/basevm.py | 11 ++---------
 tests/vm/fedora    | 17 +++++++++--------
 tests/vm/freebsd   | 16 ++++++++--------
 tests/vm/netbsd    | 19 ++++++++++---------
 tests/vm/openbsd   | 17 +++++++++--------
 5 files changed, 38 insertions(+), 42 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 5fd66f6b26..f716798b40 100644
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
index bd9c6cf295..f536a92678 100755
--- a/tests/vm/fedora
+++ b/tests/vm/fedora
@@ -109,20 +109,20 @@ class FedoraVM(basevm.BaseVM):
 
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
@@ -140,7 +140,7 @@ class FedoraVM(basevm.BaseVM):
             if good:
                 break
             time.sleep(10)
-            self.console_send("r\n" % self.GUEST_PASS)
+            self.console_send("r\n" % self._config["guest_pass"])
 
         self.console_wait_send("'b' to begin install",     "b\n")
 
@@ -151,12 +151,13 @@ class FedoraVM(basevm.BaseVM):
 
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
index 298967fe9c..898393b58d 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -114,9 +114,9 @@ class FreeBSDVM(basevm.BaseVM):
 
         # post-install configuration
         self.console_wait("New Password:")
-        self.console_send("%s\n" % self.ROOT_PASS)
+        self.console_send("%s\n" % self._config["root_pass"])
         self.console_wait("Retype New Password:")
-        self.console_send("%s\n" % self.ROOT_PASS)
+        self.console_send("%s\n" % self._config["root_pass"])
 
         self.console_wait_send("Network Configuration", "\n")
         self.console_wait_send("IPv4",                  "y")
@@ -135,9 +135,9 @@ class FreeBSDVM(basevm.BaseVM):
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
@@ -149,9 +149,9 @@ class FreeBSDVM(basevm.BaseVM):
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
@@ -165,12 +165,12 @@ class FreeBSDVM(basevm.BaseVM):
 
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
index b10c9d429d..7e54fe8322 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -121,24 +121,24 @@ class NetBSDVM(basevm.BaseVM):
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
@@ -171,12 +171,13 @@ class NetBSDVM(basevm.BaseVM):
 
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
index 0b705f4945..04a532c763 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -99,9 +99,9 @@ class OpenBSDVM(basevm.BaseVM):
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
@@ -109,13 +109,13 @@ class OpenBSDVM(basevm.BaseVM):
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
@@ -136,12 +136,13 @@ class OpenBSDVM(basevm.BaseVM):
 
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
2.17.1


