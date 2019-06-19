Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC35C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 19:57:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F4AB20B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 19:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CyTVKeqh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F4AB20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41512 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdght-0003Ns-9w
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 15:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56002)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hdgYu-0003vp-Ci
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:48:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hdgYn-00068A-Eb
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:47:59 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:38003)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hdgYk-0005cI-Sn
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:47:55 -0400
Received: by mail-wr1-x436.google.com with SMTP id d18so512176wrs.5
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2019 12:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3soHcxEWb8Oo7T3dyQPwcUMo7qCQ9tsZ0YvPTKHGaVI=;
 b=CyTVKeqhbbV4p2Rf4mMdXfImygY3yvfvHBDCn1MWTpivITX3Q/ITsjB74nMpx0gzz0
 cjg5AAy/Vk03gq9Sr8S2UvxrJYOhmP3degDIi6Cvcb3vGVfWtJDlbefxZ/YAxRmkeYVQ
 JpPVVkdJz4Nf6JhE68eH895ICPmiKtUU3++iHtNV98UXAiJrMMOADt8rkfikgDmUe8Ow
 /drTn+MNjsj24gVmxY2mqA+4zPriEPCIcMai/jlxepeJQCkQy5UvCrb6bQkxoJBSPiYq
 dheTWmAXQMOTt/6ZuW6kt7/J/GCkP/wxkvL9uP26pE6Y4cSMw5RD+gdz/Acthwi+3Ifb
 O2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3soHcxEWb8Oo7T3dyQPwcUMo7qCQ9tsZ0YvPTKHGaVI=;
 b=pnMTgypGL4Mq9gQntBiJOxI0cTjHZhuTTThCtFKWJN/PGHU034X4JU31/SVrZB2QRN
 PoBYyIuU7vtMNheur8LRvWkQhXFYDNhpIpa5/l3uYOm47tXwSVTe9wKai+5MKGuaNvl1
 UFWSV+vO69vpniD7fMn6rwPzL4GuY9q7uVV+L7FhzK7DHzMyJb/a3a4l92H2u08oq5rI
 ntTUuGmrEYYQksUwveKRRqJ4vwfuZd8r0NsNk+4jx5s1rW6hCIRLnLnhPtGnZk+Ny9AI
 wnBFBcqRKE7TXB0pJUk+IiaFZp0Jcsg4SdIR0L3KwydB4sajvMLliadfet6kokcsfBA0
 tSkg==
X-Gm-Message-State: APjAAAV2ge/GFzPmrLeOk9zbmyS4Yyoa928LHDkN92IwyOqBhm7PsR9H
 kRYAOcUu52Z5Q1XPjmnYExXcQg==
X-Google-Smtp-Source: APXvYqz7tqJCIvCqChug9LYAO57isP5JJSX9Gbz9l/r5jHdnByRjAwb8lqIhHpyKRHEwy6xmmqenGg==
X-Received: by 2002:adf:9dcc:: with SMTP id q12mr19243243wre.6.1560973641075; 
 Wed, 19 Jun 2019 12:47:21 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id 11sm2929838wmd.23.2019.06.19.12.47.18
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 19 Jun 2019 12:47:18 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5A0791FF9B;
 Wed, 19 Jun 2019 20:40:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 20:40:15 +0100
Message-Id: <20190619194021.8240-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190619194021.8240-1-alex.bennee@linaro.org>
References: <20190619194021.8240-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
Subject: [Qemu-devel] [PATCH  v1 11/17] tests/vm: openbsd autoinstall,
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Instead of fetching the prebuilt image from patchew download the install
iso and prepare the image locally.  Install to disk, using the serial
console.  Create qemu user, configure ssh login.  Install packages
needed for qemu builds.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190617043858.8290-8-kraxel@redhat.com>
[AJB: added tags]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/openbsd | 161 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 148 insertions(+), 13 deletions(-)

diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 28c7d25e29..b92c39f89a 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -2,10 +2,11 @@
 #
 # OpenBSD VM image
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
@@ -13,32 +14,166 @@
 
 import os
 import sys
+import socket
 import subprocess
 import basevm
 
 class OpenBSDVM(basevm.BaseVM):
     name = "openbsd"
     arch = "x86_64"
+
+    link = "https://cdn.openbsd.org/pub/OpenBSD/6.5/amd64/install65.iso"
+    csum = "38d1f8cadd502f1c27bf05c5abde6cc505dd28f3f34f8a941048ff9a54f9f608"
+    size = "20G"
+    pkgs = [
+        # tools
+        "git",
+        "pkgconf",
+        "bzip2", "xz",
+
+        # gnu tools
+        "bash",
+        "gmake",
+        "gsed",
+        "bison",
+
+        # libs: usb
+        "libusb1",
+
+        # libs: crypto
+        "gnutls",
+
+        # libs: images
+        "jpeg",
+        "png",
+
+	# libs: ui
+        "sdl2",
+        "gtk+3",
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
         tar -xf /dev/rsd1c;
-        ./configure --cc=x86_64-unknown-openbsd6.1-gcc-4.9.4 --python=python2.7 {configure_opts};
-        gmake --output-sync -j{jobs} {verbose};
-        # XXX: "gmake check" seems to always hang or fail
-        #gmake --output-sync -j{jobs} check {verbose};
+        cd ../build
+        ../src/configure --cc=cc --python=python3 {configure_opts};
+        gmake --output-sync -j{jobs} {target} {verbose};
     """
+    poweroff = "halt -p"
 
     def build_image(self, img):
-        cimg = self._download_with_cache("http://download.patchew.org/openbsd-6.1-amd64.img.xz",
-                sha256sum='8c6cedc483e602cfee5e04f0406c64eb99138495e8ca580bc0293bcf0640c1bf')
-        img_tmp_xz = img + ".tmp.xz"
+        self.print_step("Downloading install iso")
+        cimg = self._download_with_cache(self.link, sha256sum=self.csum)
         img_tmp = img + ".tmp"
-        sys.stderr.write("Extracting the image...\n")
-        subprocess.check_call(["ln", "-f", cimg, img_tmp_xz])
-        subprocess.check_call(["xz", "--keep", "-dvf", img_tmp_xz])
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
+        self.console_init()
+        self.console_wait_send("boot>", "set tty com0\n")
+        self.console_wait_send("boot>", "\n")
+
+        # pre-install configuration
+        self.console_wait_send("(I)nstall",               "i\n")
+        self.console_wait_send("Terminal type",           "xterm\n")
+        self.console_wait_send("System hostname",         "openbsd\n")
+        self.console_wait_send("Which network interface", "vio0\n")
+        self.console_wait_send("IPv4 address",            "dhcp\n")
+        self.console_wait_send("IPv6 address",            "none\n")
+        self.console_wait_send("Which network interface", "done\n")
+        self.console_wait_send("DNS domain name",         "localnet\n")
+        self.console_wait("Password for root account")
+        self.console_send("%s\n" % self.ROOT_PASS)
+        self.console_wait("Password for root account")
+        self.console_send("%s\n" % self.ROOT_PASS)
+        self.console_wait_send("Start sshd(8)",           "yes\n")
+        self.console_wait_send("X Window System",         "\n")
+        self.console_wait_send("xenodm",                  "\n")
+        self.console_wait_send("console to com0",         "\n")
+        self.console_wait_send("Which speed",             "\n")
+
+        self.console_wait("Setup a user")
+        self.console_send("%s\n" % self.GUEST_USER)
+        self.console_wait("Full name")
+        self.console_send("%s\n" % self.GUEST_USER)
+        self.console_wait("Password")
+        self.console_send("%s\n" % self.GUEST_PASS)
+        self.console_wait("Password")
+        self.console_send("%s\n" % self.GUEST_PASS)
+
+        self.console_wait_send("Allow root ssh login",    "yes\n")
+        self.console_wait_send("timezone",                "UTC\n")
+        self.console_wait_send("root disk",               "\n")
+        self.console_wait_send("(W)hole disk",            "\n")
+        self.console_wait_send("(A)uto layout",           "\n")
+        self.console_wait_send("Location of sets",        "cd0\n")
+        self.console_wait_send("Pathname to the sets",    "\n")
+        self.console_wait_send("Set name(s)",             "\n")
+        self.console_wait_send("without verification",    "yes\n")
+
+        self.print_step("Installation started now, this will take a while")
+        self.console_wait_send("Location of sets",        "done\n")
+
+        self.console_wait("successfully completed")
+        self.print_step("Installation finished, rebooting")
+        self.console_wait_send("(R)eboot",                "reboot\n")
+
+        # setup qemu user
+        prompt = "$"
+        self.console_ssh_init(prompt, self.GUEST_USER, self.GUEST_PASS)
+        self.console_wait_send(prompt, "exit\n")
+
+        # setup root user
+        prompt = "openbsd#"
+        self.console_ssh_init(prompt, "root", self.ROOT_PASS)
+        self.console_sshd_config(prompt)
+
+        # setup virtio-blk #1 (tarfile)
+        self.console_wait(prompt)
+        self.console_send("echo 'chmod 666 /dev/rsd1c' >> /etc/rc.local\n")
+
+        # enable w+x for /home
+        self.console_wait(prompt)
+        self.console_send("sed -i -e '/home/s/rw,/rw,wxallowed,/' /etc/fstab\n")
+
+        # tweak datasize limit
+        self.console_wait(prompt)
+        self.console_send("sed -i -e 's/\\(datasize[^=]*\\)=[^:]*/\\1=infinity/' /etc/login.conf\n")
+
+        # use http (be proxy cache friendly)
+        self.console_wait(prompt)
+        self.console_send("sed -i -e 's/https/http/' /etc/installurl\n")
+
+        self.print_step("Configuration finished, rebooting")
+        self.console_wait_send(prompt, "reboot\n")
+        self.console_wait("login:")
+        self.wait_ssh()
+
+        self.print_step("Installing packages")
+        self.ssh_root_check("pkg_add %s\n" % " ".join(self.pkgs))
+
+        # shutdown
+        self.ssh_root(self.poweroff)
+        self.wait()
+
+        if os.path.exists(img):
+            os.remove(img)
         os.rename(img_tmp, img)
+        os.remove(iso)
+        self.print_step("All done")
 
 if __name__ == "__main__":
     sys.exit(basevm.main(OpenBSDVM))
-- 
2.20.1


