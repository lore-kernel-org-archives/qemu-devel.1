Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7969FC31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 19:53:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E6FB20B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 19:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cKsvZfdC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6FB20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41484 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdgeP-00081P-Cc
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 15:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53989)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hdgRg-0006BE-Gv
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:40:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hdgRc-0000BM-Sf
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:40:36 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39577)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hdgRc-00009C-K2
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:40:32 -0400
Received: by mail-wm1-x343.google.com with SMTP id z23so697948wma.4
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2019 12:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oDQCgUljExCFYtLLEJJpwccg9/K7BchyPzoArUB8z3c=;
 b=cKsvZfdCdGbDgxILtJOdXnLM8qVBC/JxJINBFxUByZRvsCBiFiuL5oKdUGcH0SyNUD
 nfFty59Xl+QfF1+Ih/9nIc0yCwk1JufbypLVNtmLJ7rcUzJbxeVLjYyro3+5Ity8bO/Y
 SoT9rnJZ/O/Lf3Ofeja1f+7iMFYY+u1ARPj3c58iszx3O8JqjE27LdznGYFFR1L6F4gm
 z6axjLq6N8Z7Nn0VGCuqYePKWnqXDWzX7A64+IGX2kNcFzV+i2NPE/uDC0Q5s4KjSQDP
 kwu6Vliq5ZlwU1mNjSaijn9Pjf7ubwLPBgUf/cvszpHQsfR/fG8sEe5f+Pkhh/RlILx9
 dRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oDQCgUljExCFYtLLEJJpwccg9/K7BchyPzoArUB8z3c=;
 b=SjErezmqtLc7Bd5sgVcWQvJ3BBSrbATRgUEf7s0lm/5TJxNAoi0YbIOznTo0FGjJ7s
 baIaYCW2K25LE9V9UuJWa23yrGOfVFxL1VYonxyb7AWFcr/BjQ+22HPdfUp72QevPGj1
 sm6a6GZKRv4091FBylD0+gpEEGNdXSTq014/6+Tl3Xg9V6ZfMfjDFCEu1ovhI3FkeByc
 /pFpc07F4YNsoIv2kKLGGex2KOp2GqCgYPV60+tLzrqVDGvxFMhcA9JC5Pb738NtmGTF
 zp0ETQ3DTfMDkBFQ5/aQknwpw1o3WYHGAaBybC1qWyV+qCMBnV6XPnHPIy5UNHs2zJDn
 Xkgg==
X-Gm-Message-State: APjAAAUnqI+/1viUdh5jWiK5L1H6mYIHmiznITOD7NPkRpAq3vM5O4lL
 5jW6fkpuHMG/T/X1jwpl3ect3w==
X-Google-Smtp-Source: APXvYqz/5v65wwXArGB+upmifIXUdDgbAQBmYkRo80UpR1ZWJE2Cd1vMl6fiR1iIHYiH2Toxpld1tg==
X-Received: by 2002:a1c:35c2:: with SMTP id c185mr9505604wma.58.1560973230281; 
 Wed, 19 Jun 2019 12:40:30 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id c6sm3754300wma.25.2019.06.19.12.40.25
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 19 Jun 2019 12:40:27 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 98ABA1FF9D;
 Wed, 19 Jun 2019 20:40:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 20:40:18 +0100
Message-Id: <20190619194021.8240-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190619194021.8240-1-alex.bennee@linaro.org>
References: <20190619194021.8240-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH  v1 14/17] tests/vm: fedora autoinstall,
 using serial console
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Download the install iso and prepare the image locally.  Install to
disk, using the serial console.  Create qemu user, configure ssh login.
Install packages needed for qemu builds.

Yes, we have docker images for fedora.  But for trouble-shooting it
might be helpful to have a vm too.  When vm builds fail you can use
it to figure whenever the vm setup or the guest os is the problem.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190617043858.8290-11-kraxel@redhat.com>
---
 tests/vm/Makefile.include |   3 +-
 tests/vm/basevm.py        |   9 +-
 tests/vm/fedora           | 189 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 199 insertions(+), 2 deletions(-)
 create mode 100755 tests/vm/fedora

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index a61c236b8e..809b80e2e5 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -2,7 +2,7 @@
 
 .PHONY: vm-build-all vm-clean-all
 
-IMAGES := ubuntu.i386 freebsd netbsd openbsd centos
+IMAGES := ubuntu.i386 freebsd netbsd openbsd centos fedora
 IMAGES_DIR := $(HOME)/.cache/qemu-vm/images
 IMAGE_FILES := $(patsubst %, $(IMAGES_DIR)/%.img, $(IMAGES))
 
@@ -16,6 +16,7 @@ vm-test:
 	@echo "  vm-build-netbsd                 - Build QEMU in NetBSD VM"
 	@echo "  vm-build-openbsd                - Build QEMU in OpenBSD VM"
 	@echo "  vm-build-centos                 - Build QEMU in CentOS VM, with Docker"
+	@echo "  vm-build-fedora                 - Build QEMU in Fedora VM"
 	@echo ""
 	@echo "  vm-build-all                    - Build QEMU in all VMs"
 	@echo "  vm-clean-all                    - Clean up VM images"
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 592a344773..3d717da498 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -206,7 +206,7 @@ class BaseVM(object):
             # log console line
             sys.stderr.write("con recv: %s\n" % line)
 
-    def console_wait(self, expect):
+    def console_wait(self, expect, expectalt = None):
         vm = self._guest
         output = ""
         while True:
@@ -215,6 +215,8 @@ class BaseVM(object):
             except socket.timeout:
                 sys.stderr.write("console: *** read timeout ***\n")
                 sys.stderr.write("console: waiting for: '%s'\n" % expect)
+                if not expectalt is None:
+                    sys.stderr.write("console: waiting for: '%s' (alt)\n" % expectalt)
                 sys.stderr.write("console: line buffer:\n")
                 sys.stderr.write("\n")
                 self.console_log(output.rstrip())
@@ -223,6 +225,8 @@ class BaseVM(object):
             output += chars.decode("latin1")
             if expect in output:
                 break
+            if not expectalt is None and expectalt in output:
+                break
             if "\r" in output or "\n" in output:
                 lines = re.split("[\r\n]", output)
                 output = lines.pop()
@@ -230,6 +234,9 @@ class BaseVM(object):
                     self.console_log("\n".join(lines))
         if self.debug:
             self.console_log(output)
+        if not expectalt is None and expectalt in output:
+            return False
+        return True
 
     def console_send(self, command):
         vm = self._guest
diff --git a/tests/vm/fedora b/tests/vm/fedora
new file mode 100755
index 0000000000..e8fa5bf0d2
--- /dev/null
+++ b/tests/vm/fedora
@@ -0,0 +1,189 @@
+#!/usr/bin/env python
+#
+# Fedora VM image
+#
+# Copyright 2019 Red Hat Inc.
+#
+# Authors:
+#  Gerd Hoffmann <kraxel@redhat.com>
+#
+# This code is licensed under the GPL version 2 or later.  See
+# the COPYING file in the top-level directory.
+#
+
+import os
+import re
+import sys
+import time
+import socket
+import subprocess
+import basevm
+
+class FedoraVM(basevm.BaseVM):
+    name = "fedora"
+    arch = "x86_64"
+
+    base = "http://dl.fedoraproject.org/pub/fedora/linux/releases/30/"
+    link = base + "Server/x86_64/iso/Fedora-Server-netinst-x86_64-30-1.2.iso"
+    repo = base + "Server/x86_64/os/"
+    full = base + "Everything/x86_64/os/"
+    csum = "5e4eac4566d8c572bfb3bcf54b7d6c82006ec3c6c882a2c9235c6d3494d7b100"
+    size = "20G"
+    pkgs = [
+        # tools
+        'git-core',
+        'flex', 'bison',
+        'gcc', 'binutils', 'make',
+
+        # perl
+        'perl-Test-Harness',
+
+        # libs: usb
+        '"pkgconfig(libusb-1.0)"',
+        '"pkgconfig(libusbredirparser-0.5)"',
+
+        # libs: crypto
+        '"pkgconfig(gnutls)"',
+
+        # libs: ui
+        '"pkgconfig(sdl2)"',
+        '"pkgconfig(gtk+-3.0)"',
+        '"pkgconfig(ncursesw)"',
+
+        # libs: audio
+        '"pkgconfig(libpulse)"',
+        '"pkgconfig(alsa)"',
+    ]
+
+    BUILD_SCRIPT = """
+        set -e;
+        rm -rf /home/qemu/qemu-test.*
+        cd $(mktemp -d /home/qemu/qemu-test.XXXXXX);
+        mkdir src build; cd src;
+        tar -xf /dev/vdb;
+        cd ../build
+        ../src/configure --python=python3 {configure_opts};
+        gmake --output-sync -j{jobs} {target} {verbose};
+    """
+
+    def build_image(self, img):
+        self.print_step("Downloading install iso")
+        cimg = self._download_with_cache(self.link, sha256sum=self.csum)
+        img_tmp = img + ".tmp"
+        iso = img + ".install.iso"
+
+        self.print_step("Preparing iso and disk image")
+        subprocess.check_call(["cp", "-f", cimg, iso])
+        subprocess.check_call(["qemu-img", "create", "-f", "qcow2",
+                               img_tmp, self.size])
+
+        self.print_step("Booting installer")
+        self.boot(img_tmp, extra_args = [
+            "-bios", "pc-bios/bios-256k.bin",
+            "-machine", "graphics=off",
+            "-cdrom", iso
+        ])
+        self.console_init(300)
+        self.console_wait("installation process.")
+        time.sleep(0.3)
+        self.console_send("\t")
+        time.sleep(0.3)
+        self.console_send(" console=ttyS0")
+        proxy = os.environ.get("http_proxy")
+        if not proxy is None:
+            self.console_send(" proxy=%s" % proxy)
+            self.console_send(" inst.proxy=%s" % proxy)
+        self.console_send(" inst.repo=%s" % self.repo)
+        self.console_send("\n")
+
+        self.console_wait_send("2) Use text mode",         "2\n")
+
+        self.console_wait_send("5) [!] Installation Dest", "5\n")
+        self.console_wait_send("1) [x]",                   "c\n")
+        self.console_wait_send("2) [ ] Use All Space",     "2\n")
+        self.console_wait_send("2) [x] Use All Space",     "c\n")
+        self.console_wait_send("1) [ ] Standard Part",     "1\n")
+        self.console_wait_send("1) [x] Standard Part",     "c\n")
+
+        self.console_wait_send("7) [!] Root password",     "7\n")
+        self.console_wait("Password:")
+        self.console_send("%s\n" % self.ROOT_PASS)
+        self.console_wait("Password (confirm):")
+        self.console_send("%s\n" % self.ROOT_PASS)
+
+        self.console_wait_send("8) [ ] User creation",     "8\n")
+        self.console_wait_send("1) [ ] Create user",       "1\n")
+        self.console_wait_send("3) User name",             "3\n")
+        self.console_wait_send("ENTER:", "%s\n" % self.GUEST_USER)
+        self.console_wait_send("4) [ ] Use password",      "4\n")
+        self.console_wait_send("5) Password",              "5\n")
+        self.console_wait("Password:")
+        self.console_send("%s\n" % self.GUEST_PASS)
+        self.console_wait("Password (confirm):")
+        self.console_send("%s\n" % self.GUEST_PASS)
+        self.console_wait_send("7) Groups",                "c\n")
+
+        while True:
+            good = self.console_wait("3) [x] Installation",
+                                     "3) [!] Installation")
+            self.console_send("r\n")
+            if good:
+                break
+            time.sleep(10)
+
+        while True:
+            good = self.console_wait("4) [x] Software",
+                                     "4) [!] Software")
+            self.console_send("r\n")
+            if good:
+                break
+            time.sleep(10)
+            self.console_send("r\n" % self.GUEST_PASS)
+
+        self.console_wait_send("'b' to begin install",     "b\n")
+
+        self.print_step("Installation started now, this will take a while")
+
+        self.console_wait_send("Installation complete",    "\n")
+        self.print_step("Installation finished, rebooting")
+
+        # setup qemu user
+        prompt = " ~]$"
+        self.console_ssh_init(prompt, self.GUEST_USER, self.GUEST_PASS)
+        self.console_wait_send(prompt, "exit\n")
+
+        # setup root user
+        prompt = " ~]#"
+        self.console_ssh_init(prompt, "root", self.ROOT_PASS)
+        self.console_sshd_config(prompt)
+
+        # setup virtio-blk #1 (tarfile)
+        self.console_wait(prompt)
+        self.console_send("echo 'KERNEL==\"vdb\" MODE=\"666\"' >> %s\n" %
+                          "/etc/udev/rules.d/99-qemu.rules")
+
+        self.print_step("Configuration finished, rebooting")
+        self.console_wait_send(prompt, "reboot\n")
+        self.console_wait("login:")
+        self.wait_ssh()
+
+        self.print_step("Installing packages")
+        self.ssh_root_check("rm -vf /etc/yum.repos.d/fedora*.repo\n")
+        self.ssh_root_check("echo '[fedora]' >> /etc/yum.repos.d/qemu.repo\n")
+        self.ssh_root_check("echo 'baseurl=%s' >> /etc/yum.repos.d/qemu.repo\n" % self.full)
+        self.ssh_root_check("echo 'gpgcheck=0' >> /etc/yum.repos.d/qemu.repo\n")
+        self.ssh_root_check("dnf install -y %s\n" % " ".join(self.pkgs))
+
+        # shutdown
+        self.ssh_root(self.poweroff)
+        self.console_wait("sleep state S5")
+        self.wait()
+
+        if os.path.exists(img):
+            os.remove(img)
+        os.rename(img_tmp, img)
+        os.remove(iso)
+        self.print_step("All done")
+
+if __name__ == "__main__":
+    sys.exit(basevm.main(FedoraVM))
-- 
2.20.1


