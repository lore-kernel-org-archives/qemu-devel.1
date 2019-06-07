Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FB7C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:34:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 505122080C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kvkb8v3n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 505122080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48068 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZCCp-0008MX-1U
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 06:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45061)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZB54-0008IM-2e
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZB52-0005vn-5x
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:38 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:35367)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZB51-0005ud-Th
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:36 -0400
Received: by mail-wm1-x330.google.com with SMTP id c6so1192313wml.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+eu+J+AReHOJ91tEV+4Y0qnnta+u3KP6te0Wm8mtIjs=;
 b=kvkb8v3n1wMTsnt8/p2c2ie+j35xWYiKp5s+i4TltGuiugslWamLojffr9Av5iHs5y
 HbpweHyAPQu4LkKM0wgG1FOmcBglebJp3xDvLGuzjRLS5lYyB/QHT9LEFvHebVA1KzR+
 QDHh8rJmXPAHv1Bz4r+YDk5IlLzi3IJ9hQCSbOMlFRyeg1+fsAG1mDgn9A5sxAQKKhKt
 m5Wl3VQx3nlyMrcxhOpqbs3+M4a7mATLvr4yL6x6HYbtxgn844uNk5M2SrkwSqBR6O3N
 a1gfCI9V/PpW3gbLPiIodsWQGuizkIX+aBBJp5HO78As6Z4hzU0OcgmCPuCEgLmmRlow
 qpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+eu+J+AReHOJ91tEV+4Y0qnnta+u3KP6te0Wm8mtIjs=;
 b=BDLkqQx6EcqdF51L31Vy6vv7+gs0bFSZRQRHkIjnAZUMC1hjo5xAjV3f1UiKePC8Ix
 X74rs/Vm6RC1EGvfvAt0EczrDetsha9icaApfu+1D/v8zqiOSjVBk8MrexNqHrYV8s8m
 bDxrzC/Ei0dvHjxZVHoxpTH+A62gNjkVhUarcXUlGvsk8RebmC0mgXoQJPz3Kt+PmhTZ
 l6HarZBnoqRj7a4icwRNjiMyxQdhiNzFpfI2VaaB2TFX3SJQF8AC3j3QQZ+/SYY5Oos1
 bOhidRxVXYXyFu4jTU6gym5HTPJoN3IvEIAqfdcLkm1BfS/D9rk4VXJnE02RFHKMA3hq
 UDYQ==
X-Gm-Message-State: APjAAAX8RoNa6OWYIzHB+eKRc8l7DWMXnweb0uE8BoJFpnGcssIdf8p2
 7MTchC95FfwLfRX5Vz52qz5yig==
X-Google-Smtp-Source: APXvYqwMEr/UQDNSyU/f0CJDcX5QETknyuqfBWwqDDmTAcu4PJdMTt2TgCAWHTaxBDmSxZG0+HGwbw==
X-Received: by 2002:a1c:480a:: with SMTP id v10mr2899790wma.120.1559899354889; 
 Fri, 07 Jun 2019 02:22:34 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id y133sm2528618wmg.5.2019.06.07.02.22.28
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:22:30 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AA4AB1FFA9;
 Fri,  7 Jun 2019 10:05:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:20 +0100
Message-Id: <20190607090552.12434-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
Subject: [Qemu-devel] [PULL 21/52] tests/vm: openbsd autoinstall,
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
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brad Smith <brad@comstyle.com>
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
Message-Id: <20190520124716.30472-11-kraxel@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 2105c01a26..c5f0a15218 100755
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
@@ -13,34 +14,165 @@
 
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
         if os.path.exists(img):
             os.remove(img)
         os.rename(img_tmp, img)
+        os.remove(iso)
+        self.print_step("All done")
 
 if __name__ == "__main__":
     sys.exit(basevm.main(OpenBSDVM))
-- 
2.20.1


