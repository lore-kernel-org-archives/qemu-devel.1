Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1A5C48BE8
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 14:01:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3993A208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 14:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n7L6nSdY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3993A208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51420 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfPX1-000675-FM
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 10:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41590)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hfPGJ-0006jE-9z
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:44:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hfPGG-0007fQ-BS
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:43:58 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:37795)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hfPGE-0007Te-Dp
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:43:54 -0400
Received: by mail-wm1-x32f.google.com with SMTP id f17so13455974wme.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 06:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uy+t0RIuw/tzOoTJEZrmneCaAg6fEiVS+nMeJyBAP3k=;
 b=n7L6nSdYpkNsaNLeVCkJZbgX2kxUGZi3y+GUNDnBySKiSFheCTg+XbRgvVzDqnIAc3
 xI4O4HWe431FqGD4fHwECSF97kcbg3dY6wjk7+pyHD0ZJuGDkfE3OBpdXsisPNQC6vj+
 a4LoJfQPm3K2sHzAY097CBiVHlO5n3LT4iigUWsPaN212/slZ8tNG2SUHjFoMx8wPyej
 MZfoGeoM4ljaehTJhARrCyCmqTZIpRdYkn1rLIv+heONEGFlsQWg1F2TluDHEIdnL/NU
 ZtoUv2N71Kz46Ou+ei3zlLV6f8f6snZzXMI12HejHwHCIryP2IXT6GeYYrjsFN7+CMEi
 a0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uy+t0RIuw/tzOoTJEZrmneCaAg6fEiVS+nMeJyBAP3k=;
 b=UcONvuvZ9abDTlKHI2iw/B+UZVjDittD9rQd7+/jFi925Y/docotuwG+TaYSqwsx86
 kpYvCCBxdo7C/M1YjgnSQVzscIUBtIjgLIpX0+lJerY0nq2Fhu3xaZYV5dj6J9fuh4c9
 d51nBDElCg9eRjBh1aXiTHR6x3ld3zvDtSRx1vCQoEb0OdMCy6e86ZRNG2ETumQ5SxL+
 61uvTyMpIVY9G0gcug8ESertKuPwvCwo5SWZNpzqablczlza8gQ9MXkkioVGNszoEOAv
 gSLn9v9IjoSrxiopaUpb4U/LtK6X5thUes7InmsEul3BGZDuztFi8X6hw6F8lQkbR2LR
 vP6g==
X-Gm-Message-State: APjAAAVB9ZGpRx2cnedzuocty7MlAnU5dMB1fxLv42I49Y2RUaAOCa5B
 uR/9j0CrZLcXtO+7rqpJp9+DCw==
X-Google-Smtp-Source: APXvYqxRC8zMw1upwti8Y8vWt9odXsZJ0E/rFYA1NdjXTv2JTYTiulwWoGW8heA1rhxOdgBIVKVmAQ==
X-Received: by 2002:a1c:c255:: with SMTP id s82mr16863185wmf.6.1561383827350; 
 Mon, 24 Jun 2019 06:43:47 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id v15sm9612712wrt.25.2019.06.24.06.43.41
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 06:43:42 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 86B4E1FF87;
 Mon, 24 Jun 2019 14:43:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon, 24 Jun 2019 14:43:30 +0100
Message-Id: <20190624134337.10532-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624134337.10532-1-alex.bennee@linaro.org>
References: <20190624134337.10532-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
Subject: [Qemu-devel] [PULL 12/19] tests/vm: freebsd autoinstall,
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Instead of fetching the prebuilt image from patchew download the install
iso and prepare the image locally.  Install to disk, using the serial
console.  Create qemu user, configure ssh login.  Install packages
needed for qemu builds.

Note that freebsd package downloads are delivered as non-cachable
content, so I had to configure squid with "ignore-no-store
ignore-private ignore-reload" for pkgmir.geo.freebsd.org to make the
caching actually work.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190617043858.8290-9-kraxel@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index 091be1a065..2a19461a90 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -2,41 +2,203 @@
 #
 # FreeBSD VM image
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
 #
 
 import os
+import re
 import sys
+import time
+import socket
 import subprocess
 import basevm
 
 class FreeBSDVM(basevm.BaseVM):
     name = "freebsd"
     arch = "x86_64"
+
+    link = "https://download.freebsd.org/ftp/releases/ISO-IMAGES/12.0/FreeBSD-12.0-RELEASE-amd64-disc1.iso.xz"
+    csum = "1d40015bea89d05b8bd13e2ed80c40b522a9ec1abd8e7c8b80954fb485fb99db"
+    size = "20G"
+    pkgs = [
+        # build tools
+        "git",
+        "pkgconf",
+        "bzip2",
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
+        "jpeg-turbo",
+        "png",
+
+        # libs: ui
+        "sdl2",
+        "gtk3",
+        "libxkbcommon",
+
+        # libs: opengl
+        "libepoxy",
+        "mesa-libs",
+    ]
+
     BUILD_SCRIPT = """
         set -e;
-        rm -rf /var/tmp/qemu-test.*
-        cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
+        rm -rf /home/qemu/qemu-test.*
+        cd $(mktemp -d /home/qemu/qemu-test.XXXXXX);
+        mkdir src build; cd src;
         tar -xf /dev/vtbd1;
-        ./configure {configure_opts};
+        cd ../build
+        ../src/configure --python=python3.6 {configure_opts};
         gmake --output-sync -j{jobs} {target} {verbose};
     """
 
+    def console_boot_serial(self):
+        self.console_wait_send("Autoboot", "3")
+        self.console_wait_send("OK", "set console=comconsole\n")
+        self.console_wait_send("OK", "boot\n")
+
     def build_image(self, img):
-        cimg = self._download_with_cache("http://download.patchew.org/freebsd-11.1-amd64.img.xz",
-                sha256sum='adcb771549b37bc63826c501f05121a206ed3d9f55f49145908f7e1432d65891')
-        img_tmp_xz = img + ".tmp.xz"
+        self.print_step("Downloading install iso")
+        cimg = self._download_with_cache(self.link, sha256sum=self.csum)
         img_tmp = img + ".tmp"
-        sys.stderr.write("Extracting the image...\n")
-        subprocess.check_call(["ln", "-f", cimg, img_tmp_xz])
-        subprocess.check_call(["xz", "--keep", "-dvf", img_tmp_xz])
+        iso = img + ".install.iso"
+        iso_xz = iso + ".xz"
+
+        self.print_step("Preparing iso and disk image")
+        subprocess.check_call(["cp", "-f", cimg, iso_xz])
+        subprocess.check_call(["xz", "-dvf", iso_xz])
+        subprocess.check_call(["qemu-img", "create", "-f", "qcow2",
+                               img_tmp, self.size])
+
+        self.print_step("Booting installer")
+        self.boot(img_tmp, extra_args = [
+            "-bios", "pc-bios/bios-256k.bin",
+            "-machine", "graphics=off",
+            "-cdrom", iso
+        ])
+        self.console_init()
+        self.console_boot_serial()
+        self.console_wait_send("Console type",          "xterm\n")
+
+        # pre-install configuration
+        self.console_wait_send("Welcome",               "\n")
+        self.console_wait_send("Keymap Selection",      "\n")
+        self.console_wait_send("Set Hostname",          "freebsd\n")
+        self.console_wait_send("Distribution Select",   "\n")
+        self.console_wait_send("Partitioning",          "\n")
+        self.console_wait_send("Partition",             "\n")
+        self.console_wait_send("Scheme",                "\n")
+        self.console_wait_send("Editor",                "f")
+        self.console_wait_send("Confirmation",          "c")
+
+        self.print_step("Installation started now, this will take a while")
+
+        # post-install configuration
+        self.console_wait("New Password:")
+        self.console_send("%s\n" % self.ROOT_PASS)
+        self.console_wait("Retype New Password:")
+        self.console_send("%s\n" % self.ROOT_PASS)
+
+        self.console_wait_send("Network Configuration", "\n")
+        self.console_wait_send("IPv4",                  "y")
+        self.console_wait_send("DHCP",                  "y")
+        self.console_wait_send("IPv6",                  "n")
+        self.console_wait_send("Resolver",              "\n")
+
+        self.console_wait_send("Time Zone Selector",    "a\n")
+        self.console_wait_send("Confirmation",          "y")
+        self.console_wait_send("Time & Date",           "\n")
+        self.console_wait_send("Time & Date",           "\n")
+
+        self.console_wait_send("System Configuration",  "\n")
+        self.console_wait_send("System Hardening",      "\n")
+
+        # qemu user
+        self.console_wait_send("Add User Accounts", "y")
+        self.console_wait("Username")
+        self.console_send("%s\n" % self.GUEST_USER)
+        self.console_wait("Full name")
+        self.console_send("%s\n" % self.GUEST_USER)
+        self.console_wait_send("Uid",                   "\n")
+        self.console_wait_send("Login group",           "\n")
+        self.console_wait_send("Login group",           "\n")
+        self.console_wait_send("Login class",           "\n")
+        self.console_wait_send("Shell",                 "\n")
+        self.console_wait_send("Home directory",        "\n")
+        self.console_wait_send("Home directory perm",   "\n")
+        self.console_wait_send("Use password",          "\n")
+        self.console_wait_send("Use an empty password", "\n")
+        self.console_wait_send("Use a random password", "\n")
+        self.console_wait("Enter password:")
+        self.console_send("%s\n" % self.GUEST_PASS)
+        self.console_wait("Enter password again:")
+        self.console_send("%s\n" % self.GUEST_PASS)
+        self.console_wait_send("Lock out",              "\n")
+        self.console_wait_send("OK",                    "yes\n")
+        self.console_wait_send("Add another user",      "no\n")
+
+        self.console_wait_send("Final Configuration",   "\n")
+        self.console_wait_send("Manual Configuration",  "\n")
+        self.console_wait_send("Complete",              "\n")
+
+        self.print_step("Installation finished, rebooting")
+        self.console_boot_serial()
+
+        # setup qemu user
+        prompt = "$"
+        self.console_ssh_init(prompt, self.GUEST_USER, self.GUEST_PASS)
+        self.console_wait_send(prompt, "exit\n")
+
+        # setup root user
+        prompt = "root@freebsd:~ #"
+        self.console_ssh_init(prompt, "root", self.ROOT_PASS)
+        self.console_sshd_config(prompt)
+
+        # setup serial console
+        self.console_wait(prompt)
+        self.console_send("echo 'console=comconsole' >> /boot/loader.conf\n")
+
+        # setup boot delay
+        self.console_wait(prompt)
+        self.console_send("echo 'autoboot_delay=1' >> /boot/loader.conf\n")
+
+        # setup virtio-blk #1 (tarfile)
+        self.console_wait(prompt)
+        self.console_send("echo 'chmod 666 /dev/vtbd1' >> /etc/rc.local\n")
+
+        self.print_step("Configuration finished, rebooting")
+        self.console_wait_send(prompt, "reboot\n")
+        self.console_wait("login:")
+        self.wait_ssh()
+
+        self.print_step("Installing packages")
+        self.ssh_root_check("pkg install -y %s\n" % " ".join(self.pkgs))
+
+        # shutdown
+        self.ssh_root(self.poweroff)
+        self.console_wait("Uptime:")
+        self.wait()
+
+        if os.path.exists(img):
+            os.remove(img)
         os.rename(img_tmp, img)
+        os.remove(iso)
+        self.print_step("All done")
 
 if __name__ == "__main__":
     sys.exit(basevm.main(FreeBSDVM))
-- 
2.20.1


