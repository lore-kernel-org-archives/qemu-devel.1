Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27D2C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 11:06:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6543E21479
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 11:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6543E21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41247 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP3Mg-0000mI-Kh
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 07:06:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hP336-0008MP-59
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:46:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hP334-00045X-6S
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:46:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hP333-00044G-UQ
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:46:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 345DF3DDBE;
	Fri, 10 May 2019 10:46:41 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8463A1001DE7;
	Fri, 10 May 2019 10:46:40 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id BBB889DB5; Fri, 10 May 2019 12:46:33 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 12:46:31 +0200
Message-Id: <20190510104633.9428-12-kraxel@redhat.com>
In-Reply-To: <20190510104633.9428-1-kraxel@redhat.com>
References: <20190510104633.9428-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Fri, 10 May 2019 10:46:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 11/13] tests/vm: netbsd autoinstall,
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

Instead of fetching the prebuilt image from patchew download the install
iso and prepare the image locally.  Install to disk, using the serial
console.  Create qemu user, configure ssh login.  Install packages
needed for qemu builds.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 tests/vm/netbsd | 187 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 177 insertions(+), 10 deletions(-)

diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index 4c6624ea5ed5..6dbfc1b0fbe3 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -2,10 +2,11 @@
 #
 # NetBSD VM image
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
@@ -13,32 +14,198 @@
 
 import os
 import sys
+import time
 import subprocess
 import basevm
 
 class NetBSDVM(basevm.BaseVM):
     name = "netbsd"
     arch = "x86_64"
+
+    link = "https://cdn.netbsd.org/pub/NetBSD/NetBSD-8.0/images/NetBSD-8.0-amd64.iso"
+    size = "20G"
+    pkgs = [
+        # tools
+        "git-base",
+        "pkgconf",
+        "xz",
+        "python37",
+
+        # gnu tools
+        "bash",
+        "gmake",
+        "gsed",
+        "flex", "bison",
+
+        # libs: crypto
+        "gnutls",
+
+        # libs: images
+        "jpeg",
+        "png",
+
+	# libs: ui
+        "SDL2",
+        "gtk3+",
+        "libxkbcommon",
+    ]
+
     BUILD_SCRIPT = """
         set -e;
-        rm -rf /var/tmp/qemu-test.*
-        cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
+        rm -rf /home/qemu/qemu-test.*
+        cd $(mktemp -d /home/qemu/qemu-test.XXXXXX);
+        mkdir src build; cd src;
         tar -xf /dev/rld1a;
-        ./configure --python=python2.7 {configure_opts};
+        cd ../build
+        ../src/configure --python=python3.7 --disable-opengl {configure_opts};
         gmake --output-sync -j{jobs} {target} {verbose};
     """
+    poweroff = "/sbin/poweroff"
 
     def build_image(self, img):
-        cimg = self._download_with_cache("http://download.patchew.org/netbsd-7.1-amd64.img.xz",
-                                         sha256sum='b633d565b0eac3d02015cd0c81440bd8a7a8df8512615ac1ee05d318be015732')
-        img_tmp_xz = img + ".tmp.xz"
+        cimg = self._download_with_cache(self.link)
         img_tmp = img + ".tmp"
-        sys.stderr.write("Extracting the image...\n")
-        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
-        subprocess.check_call(["xz", "-dvf", img_tmp_xz])
+        iso = img + ".install.iso"
+
+        self.print_step("Preparing iso and disk image")
+        subprocess.check_call(["cp", "-f", cimg, iso])
+        subprocess.check_call(["qemu-img", "create", "-f", "qcow2",
+                               img_tmp, self.size])
+
+        self.print_step("Booting installer")
+        self.boot(img_tmp, extra_args = [
+            "-device", "VGA",
+            "-machine", "graphics=off",
+            "-cdrom", iso
+        ])
+        self.console_init()
+        self.console_wait("Primary Bootstrap")
+
+        # serial console boot menu output doesn't work for some
+        # reason, so we have to fly blind ...
+        for char in list("5consdev com0\n"):
+            time.sleep(0.2)
+            self.console_send(char)
+            self.console_wait("")
+        self.console_wait_send("> ", "boot\n")
+
+        self.console_wait_send("Terminal type",            "xterm\n")
+        self.console_wait_send("a: Installation messages", "a\n")
+        self.console_wait_send("b: US-English",            "b\n")
+        self.console_wait_send("a: Install NetBSD",        "a\n")
+        self.console_wait("Shall we continue?")
+        self.console_wait_send("b: Yes",                   "b\n")
+
+        self.console_wait_send("a: ld0",                   "a\n")
+        self.console_wait_send("a: This is the correct",   "a\n")
+        self.console_wait_send("b: Use the entire disk",   "b\n")
+        self.console_wait("NetBSD bootcode")
+        self.console_wait_send("a: Yes",                   "a\n")
+        self.console_wait_send("b: Use existing part",     "b\n")
+        self.console_wait_send("x: Partition sizes ok",    "x\n")
+        self.console_wait_send("for your NetBSD disk",     "\n")
+        self.console_wait("Shall we continue?")
+        self.console_wait_send("b: Yes",                   "b\n")
+
+        self.console_wait_send("b: Use serial port com0",  "b\n")
+        self.console_wait_send("f: Set serial baud rate",  "f\n")
+        self.console_wait_send("a: 9600",                  "a\n")
+        self.console_wait_send("x: Exit",                  "x\n")
+
+        self.console_wait_send("a: Full installation",     "a\n")
+        self.console_wait_send("a: CD-ROM",                "a\n")
+
+        self.print_step("Installation started now, this will take a while")
+        self.console_wait_send("Hit enter to continue",    "\n")
+
+        self.console_wait_send("d: Change root password",  "d\n")
+        self.console_wait_send("a: Yes",                   "a\n")
+        self.console_wait("New password:")
+        self.console_send("%s\n" % self.ROOT_PASS)
+        self.console_wait("New password:")
+        self.console_send("%s\n" % self.ROOT_PASS)
+        self.console_wait("Retype new password:")
+        self.console_send("%s\n" % self.ROOT_PASS)
+
+        self.console_wait_send("o: Add a user",            "o\n")
+        self.console_wait("username")
+        self.console_send("%s\n" % self.GUEST_USER)
+        self.console_wait("to group wheel")
+        self.console_wait_send("a: Yes",                   "a\n")
+        self.console_wait_send("a: /bin/sh",               "a\n")
+        self.console_wait("New password:")
+        self.console_send("%s\n" % self.GUEST_PASS)
+        self.console_wait("New password:")
+        self.console_send("%s\n" % self.GUEST_PASS)
+        self.console_wait("Retype new password:")
+        self.console_send("%s\n" % self.GUEST_PASS)
+
+        self.console_wait_send("a: Configure network",     "a\n")
+        self.console_wait_send("a: vioif0",                "a\n")
+        self.console_wait_send("Network media type",       "\n")
+        self.console_wait("autoconfiguration")
+        self.console_wait_send("a: Yes",                   "a\n")
+        self.console_wait_send("DNS domain",               "localnet\n")
+        self.console_wait("Are they OK?")
+        self.console_wait_send("a: Yes",                   "a\n")
+        self.console_wait("installed in /etc")
+        self.console_wait_send("a: Yes",                   "a\n")
+
+        self.console_wait_send("e: Enable install",        "e\n")
+        proxy = os.environ.get("http_proxy")
+        if not proxy is None:
+            self.console_wait_send("f: Proxy",             "f\n")
+            self.console_wait("Proxy")
+            self.console_send("%s\n" % proxy)
+        self.console_wait_send("x: Install pkgin",         "x\n")
+        self.console_init(1200)
+        self.console_wait_send("Hit enter to continue", "\n")
+        self.console_init()
+
+        self.console_wait_send("g: Enable sshd",           "g\n")
+        self.console_wait_send("x: Finished conf",         "x\n")
+        self.console_wait_send("Hit enter to continue",    "\n")
+
+        self.print_step("Installation finished, rebooting")
+        self.console_wait_send("d: Reboot the computer",   "d\n")
+
+        # setup qemu user
+        prompt = "localhost$"
+        self.console_ssh_init(prompt, self.GUEST_USER, self.GUEST_PASS)
+        self.console_wait_send(prompt, "exit\n")
+
+        # setup root user
+        prompt = "localhost#"
+        self.console_ssh_init(prompt, "root", self.ROOT_PASS)
+        self.console_sshd_config(prompt)
+
+        # setup virtio-blk #1 (tarfile)
+        self.console_wait(prompt)
+        self.console_send("echo 'chmod 666 /dev/rld1a' >> /etc/rc.local\n")
+
+        # turn off mprotect (conflicts with tcg)
+        self.console_wait(prompt)
+        self.console_send("echo security.pax.mprotect.enabled=0 >> /etc/sysctl.conf\n")
+
+        self.print_step("Configuration finished, rebooting")
+        self.console_wait_send(prompt, "reboot\n")
+        self.console_wait("login:")
+        self.wait_ssh()
+
+        self.print_step("Installing packages")
+        self.ssh_root_check("pkgin update\n")
+        self.ssh_root_check("pkgin -y install %s\n" % " ".join(self.pkgs))
+
+        # shutdown
+        self.ssh_root(self.poweroff)
+        self.console_wait("entering state S5")
+        self.wait()
+
         if os.path.exists(img):
             os.remove(img)
         os.rename(img_tmp, img)
+        os.remove(iso)
+        self.print_step("All done")
 
 if __name__ == "__main__":
     sys.exit(basevm.main(NetBSDVM))
-- 
2.18.1


