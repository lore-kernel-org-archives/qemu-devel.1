Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85799C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:33:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA5025750
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GhP6pyvg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA5025750
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50831 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWIMv-0007t4-Hd
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 06:33:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWIFF-0001Ed-Pi
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:25:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWIFD-0000Ha-C9
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:25:13 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51755)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWIFC-0000Af-TB
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:25:11 -0400
Received: by mail-wm1-x343.google.com with SMTP id f10so3617872wmb.1
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 03:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=2471IffjmNwT1ZIHN+LiHQt5WCW20wr0QmjXYo3CRl8=;
	b=GhP6pyvgxpZHNbcmuwIEZapIcPwTGrWK0KZLjWSykCKgyPcPg2c1rfpruDvYzZsjt6
	MMzu1U5NZa7LdAGOfNQm5KJDcjnzTbl+hFh7iHD+eNMY4yboMipXfdtjtMTRYtoEX/Uh
	bZYiSPwFsYtuFGSVQHMAJdiKdAhTowkASDpUA8uFlqTUsKeq1UNMnfZZt9sKD1XAYamM
	q79zSr5dkeLTSPI0b7H6Td1KqyX5TdHLXbpoHPGLaPIlSQp0UMUSAUhUA7dJdykWM9vU
	xxj+Wp4WmedLwGahsLBEu9vQ4VEP6F66xvC0fiKsBvXGNzTGB1W9JK214ORoHdSUnkWi
	q8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=2471IffjmNwT1ZIHN+LiHQt5WCW20wr0QmjXYo3CRl8=;
	b=GjjV/JBiFVLYKaUGDxIgM6J+2DT8peDzDzDVvyOlm5E5PNLvWwCSlj1drtfRbHKGMy
	gEkVda7RX3t1rNdsNjeeGC64FEWLjyiNImAoQvNnVd5uWoZy9UP6FqH9ETN7EPKgV2Ls
	mPxrCDWir/v2tnecQeGaBzgFOHOnfMoe2Ns5H7dkJp8Qj2bYLewiDTahgZr2Pwl9410Z
	c/9EQaj0YRirDovy2TjtyznlijRFrCBjl+yXgxb/+ueS2L5tedmDcIUzEw9D+sOrc8h+
	LpqumTf6Ji232szEdEh4zZcrEo5j6El96nUy7sveH0S1b6GLCalGdHetgIGakUfJP43u
	m/RA==
X-Gm-Message-State: APjAAAWwV5nMlnu94cqZUbwBO05aGZbPA781E+GMIhm/r+hDjVnv5YUb
	ZT4PDWlRlCXUrk2DBqpN5sJNNJUfy2k=
X-Google-Smtp-Source: APXvYqyW9Iqbs65U6v8JWEmqsWuxobq7L/pVtQOWf2xVlngb/kvOEdicMkKa5lrXYcSjWE8k45uxOw==
X-Received: by 2002:a05:600c:1101:: with SMTP id
	b1mr1855856wma.154.1559211907916; 
	Thu, 30 May 2019 03:25:07 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id w2sm1744827wru.16.2019.05.30.03.25.02
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 30 May 2019 03:25:04 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id C4FBF1FFAA;
	Thu, 30 May 2019 11:16:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 30 May 2019 11:15:58 +0100
Message-Id: <20190530101603.22254-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190530101603.22254-1-alex.bennee@linaro.org>
References: <20190530101603.22254-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v1 21/26] tests/vm: serial console support
 helpers
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Thomas Huth <thuth@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Add a bunch of helpers to talk to the guest using the
serial console.

Also drop the hard-coded -serial parameter for the vm
so QEMUMachine.set_console() actually works.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190520124716.30472-10-kraxel@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/basevm.py | 85 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 3 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index f27178f3c7c..8894267f078 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -2,10 +2,11 @@
 #
 # VM testing base class
 #
-# Copyright 2017 Red Hat Inc.
+# Copyright 2017-2019 Red Hat Inc.
 #
 # Authors:
 #  Fam Zheng <famz@redhat.com>
+#  Gerd Hoffmann <kraxel@redhat.com>
 #
 # This code is licensed under the GPL version 2 or later.  See
 # the COPYING file in the top-level directory.
@@ -13,7 +14,9 @@
 
 from __future__ import print_function
 import os
+import re
 import sys
+import socket
 import logging
 import time
 import datetime
@@ -79,8 +82,7 @@ class BaseVM(object):
             "-cpu", "max",
             "-netdev", "user,id=vnet,hostfwd=:127.0.0.1:0-:22",
             "-device", "virtio-net-pci,netdev=vnet",
-            "-vnc", "127.0.0.1:0,to=20",
-            "-serial", "file:%s" % os.path.join(self._tmpdir, "serial.out")]
+            "-vnc", "127.0.0.1:0,to=20"]
         if vcpus and vcpus > 1:
             self._args += ["-smp", "%d" % vcpus]
         if kvm_available(self.arch):
@@ -162,6 +164,8 @@ class BaseVM(object):
         logging.debug("QEMU args: %s", " ".join(args))
         qemu_bin = os.environ.get("QEMU", "qemu-system-" + self.arch)
         guest = QEMUMachine(binary=qemu_bin, args=args)
+        guest.set_machine('pc')
+        guest.set_console()
         try:
             guest.launch()
         except:
@@ -184,6 +188,81 @@ class BaseVM(object):
             raise Exception("Cannot find ssh port from 'info usernet':\n%s" % \
                             usernet_info)
 
+    def console_init(self, timeout = 120):
+        vm = self._guest
+        vm.console_socket.settimeout(timeout)
+
+    def console_log(self, text):
+        for line in re.split("[\r\n]", text):
+            # filter out terminal escape sequences
+            line = re.sub("\x1b\[[0-9;?]*[a-zA-Z]", "", line)
+            line = re.sub("\x1b\([0-9;?]*[a-zA-Z]", "", line)
+            # replace unprintable chars
+            line = re.sub("\x1b", "<esc>", line)
+            line = re.sub("[\x00-\x1f]", ".", line)
+            if line == "":
+                continue
+            # log console line
+            sys.stderr.write("con recv: %s\n" % line)
+
+    def console_wait(self, expect):
+        vm = self._guest
+        output = ""
+        while True:
+            try:
+                chars = vm.console_socket.recv(1024)
+            except socket.timeout:
+                sys.stderr.write("console: *** read timeout ***\n")
+                sys.stderr.write("console: waiting for: '%s'\n" % expect)
+                sys.stderr.write("console: line buffer:\n")
+                sys.stderr.write("\n")
+                self.console_log(output.rstrip())
+                sys.stderr.write("\n")
+                raise
+            output += chars.decode("latin1")
+            if expect in output:
+                break
+            if "\r" in output or "\n" in output:
+                lines = re.split("[\r\n]", output)
+                output = lines.pop()
+                if self.debug:
+                    self.console_log("\n".join(lines))
+        if self.debug:
+            self.console_log(output)
+
+    def console_send(self, command):
+        vm = self._guest
+        if self.debug:
+            logline = re.sub("\n", "<enter>", command)
+            logline = re.sub("[\x00-\x1f]", ".", logline)
+            sys.stderr.write("con send: %s\n" % logline)
+        for char in list(command):
+            vm.console_socket.send(char.encode("utf-8"))
+            time.sleep(0.01)
+
+    def console_wait_send(self, wait, command):
+        self.console_wait(wait)
+        self.console_send(command)
+
+    def console_ssh_init(self, prompt, user, pw):
+        sshkey_cmd = "echo '%s' > .ssh/authorized_keys\n" % SSH_PUB_KEY.rstrip()
+        self.console_wait_send("login:",    "%s\n" % user)
+        self.console_wait_send("Password:", "%s\n" % pw)
+        self.console_wait_send(prompt,      "mkdir .ssh\n")
+        self.console_wait_send(prompt,      sshkey_cmd)
+        self.console_wait_send(prompt,      "chmod 755 .ssh\n")
+        self.console_wait_send(prompt,      "chmod 644 .ssh/authorized_keys\n")
+
+    def console_sshd_config(self, prompt):
+        self.console_wait(prompt)
+        self.console_send("echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config\n")
+        for var in self.envvars:
+            self.console_wait(prompt)
+            self.console_send("echo 'AcceptEnv %s' >> /etc/ssh/sshd_config\n" % var)
+
+    def print_step(self, text):
+        sys.stderr.write("### %s ...\n" % text)
+
     def wait_ssh(self, seconds=300):
         starttime = datetime.datetime.now()
         endtime = starttime + datetime.timedelta(seconds=seconds)
-- 
2.20.1


