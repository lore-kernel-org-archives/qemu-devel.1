Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79BFC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 11:03:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DA1721479
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 11:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA1721479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41182 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP3JF-000629-P8
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 07:03:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hP33A-0008Sq-Vp
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:46:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hP339-0004F4-D4
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:46:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hP339-0004Dj-5P
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:46:47 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6B3768830A;
	Fri, 10 May 2019 10:46:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1C80557A1;
	Fri, 10 May 2019 10:46:41 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id C73AA9DB6; Fri, 10 May 2019 12:46:33 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 12:46:32 +0200
Message-Id: <20190510104633.9428-13-kraxel@redhat.com>
In-Reply-To: <20190510104633.9428-1-kraxel@redhat.com>
References: <20190510104633.9428-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Fri, 10 May 2019 10:46:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 12/13] tests/vm: fedora autoinstall,
 using serial console
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
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Kamil Rytarowski <kamil@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Download the install iso and prepare the image locally.  Install to
disk, using the serial console.  Create qemu user, configure ssh login.
Install packages needed for qemu builds.

Yes, we have docker images for fedora.  But for trouble-shooting it
might be helpful to have a vm too.  When vm builds fail you can use
it to figure whenever the vm setup or the guest os is the problem.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 tests/vm/basevm.py        |   9 +-
 tests/vm/Makefile.include |   3 +-
 tests/vm/fedora           | 187 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 197 insertions(+), 2 deletions(-)
 create mode 100755 tests/vm/fedora

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index c4f67ee4c065..9cec3af7cc7e 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -204,7 +204,7 @@ class BaseVM(object):
             # log console line
             sys.stderr.write("con recv: %s\n" % line)
 
-    def console_wait(self, expect):
+    def console_wait(self, expect, expectalt = None):
         vm = self._guest
         output = ""
         while True:
@@ -213,6 +213,8 @@ class BaseVM(object):
             except socket.timeout:
                 sys.stderr.write("console: *** read timeout ***\n")
                 sys.stderr.write("console: waiting for: '%s'\n" % expect)
+                if not expectalt is None:
+                    sys.stderr.write("console: waiting for: '%s' (alt)\n" % expectalt)
                 sys.stderr.write("console: line buffer:\n")
                 sys.stderr.write("\n")
                 self.console_log(output.rstrip())
@@ -221,6 +223,8 @@ class BaseVM(object):
             output += chars
             if expect in output:
                 break
+            if not expectalt is None and expectalt in output:
+                break
             if "\r" in output or "\n" in output:
                 lines = re.split("[\r\n]", output)
                 output = lines.pop()
@@ -228,6 +232,9 @@ class BaseVM(object):
                     self.console_log("\n".join(lines))
         if self.debug:
             self.console_log(output)
+        if not expectalt is None and expectalt in output:
+            return False
+        return True
 
     def console_send(self, command):
         vm = self._guest
diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 8714b5947958..6e24ee786910 100644
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
diff --git a/tests/vm/fedora b/tests/vm/fedora
new file mode 100755
index 000000000000..c5621d083221
--- /dev/null
+++ b/tests/vm/fedora
@@ -0,0 +1,187 @@
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
2.18.1


