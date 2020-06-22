Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDA2C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:34:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A0EF20720
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SEir2Ahm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A0EF20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnNWZ-0000ET-JB
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 10:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnNUg-0006vn-8p
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:32:18 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:33186)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnNUd-0005eu-Sw
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:32:17 -0400
Received: by mail-wr1-x42e.google.com with SMTP id l11so16942929wru.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 07:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yfaWvkBHiSQ15nCnLOaiCfwwNxNyBgCuiCJ/EYYdU+8=;
 b=SEir2Ahmo7Nd8yYiRd1WY5NTq6XP8EapsZxIfXHKNxxTIH4rVqBKKe+lqTPduXe/aB
 GJcuInCEAuGbIuxTUT5opCJYtM+gLX5EzbvZ8dpV0amp1aqGid/NT5xzD+8Fi59HZDkl
 c5fa6gQZQN4HdR9t8Tz7XpvW/wq6BNV2pN31BrmEq9fza7BZJb/C6lPG75LI1ZAJWzzM
 nOJV0oRsV/VCsqlpFyGN0aajuwrE7TYZGhkA3ejQUr7FRCRBArZuzScFX+ZqU/Ah8pft
 IRvEffzjCrM/aezdP+1Qjw7FXfCr3Sc2LeLgESQSEi+kVp4yA5b666OgwJQbR703zD3C
 ejEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yfaWvkBHiSQ15nCnLOaiCfwwNxNyBgCuiCJ/EYYdU+8=;
 b=DZdTIXg/HadSrWOkXeK4N+8BpYNumUfbXvvdDtkhq4EonSx4oTgxc3dzbgohVjDIfG
 3qnQtTgAfUaf4xbI9o/Xshond5zCVTjBgnbtQxpLgXSmTgL7D9NatCJm/x3Js3sHL+bL
 ohxH2q9vSGQj5gToSqpJdUIJgdI7fXcLqXvTb7cQYVaI419iQDjOeZuu65lpSFmnFw5C
 8irrZjIbk1gvr2Z3bkzZgbXiOS+DMY6Hq7ZiK9YufIWN9+ul1qfsGo/MeUcWzQrOccrJ
 PM/XlPiXNFba955y8miMxwarHGgPuXcWszDsH7j4LTlClpu9q6MMub9VBLs+Jq2zHHdF
 55Eg==
X-Gm-Message-State: AOAM533zpFlqyadootKqoMGUF7QcNFUYeeXyQsg4i/0tQeVoV6bGpQOP
 XvPBmQJQVTD3BbxO03NKAXUXISI4y20=
X-Google-Smtp-Source: ABdhPJwYHQcPL2toOToigrRr178+6cFvpKM8wpnjdasMqS4n/aHvaayMXVt+USBCSt+ed5hBivo+sw==
X-Received: by 2002:a5d:4687:: with SMTP id u7mr4093252wrq.357.1592836334123; 
 Mon, 22 Jun 2020 07:32:14 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v20sm18654864wrb.51.2020.06.22.07.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 07:32:10 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3BDB11FF91;
 Mon, 22 Jun 2020 15:32:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 05/18] tests/vm: Add common Ubuntu python module
Date: Mon, 22 Jun 2020 15:31:51 +0100
Message-Id: <20200622143204.12921-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200622143204.12921-1-alex.bennee@linaro.org>
References: <20200622143204.12921-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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
Cc: fam@euphon.net, berrange@redhat.com, Robert Foley <robert.foley@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Foley <robert.foley@linaro.org>

Add a common Ubuntu python module and make use of
it with the ubuntu.i386 script.
This is preparation for adding an Ubuntu script
ubuntu.aarch64.  Splitting out the common
logic such as build_image() will reduce duplication.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200601211421.1277-5-robert.foley@linaro.org>
---
 tests/vm/ubuntu.i386 | 46 +++++++++------------------------
 tests/vm/ubuntuvm.py | 60 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 34 deletions(-)
 create mode 100644 tests/vm/ubuntuvm.py

diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
index 24527cc78c7..5ce72610a6c 100755
--- a/tests/vm/ubuntu.i386
+++ b/tests/vm/ubuntu.i386
@@ -11,15 +11,22 @@
 # the COPYING file in the top-level directory.
 #
 
-import os
 import sys
-import subprocess
 import basevm
-import time
+import ubuntuvm
 
-class UbuntuX86VM(basevm.BaseVM):
+DEFAULT_CONFIG = {
+    'install_cmds' : "apt-get update,"\
+                     "apt-get build-dep -y qemu,"\
+                     "apt-get install -y libfdt-dev language-pack-en",
+}
+
+class UbuntuX86VM(ubuntuvm.UbuntuVM):
     name = "ubuntu.i386"
     arch = "i386"
+    image_link="https://cloud-images.ubuntu.com/releases/bionic/"\
+               "release-20191114/ubuntu-18.04-server-cloudimg-i386.img"
+    image_sha256="28969840626d1ea80bb249c08eef1a4533e8904aa51a327b40f37ac4b4ff04ef"
     BUILD_SCRIPT = """
         set -e;
         cd $(mktemp -d);
@@ -29,34 +36,5 @@ class UbuntuX86VM(basevm.BaseVM):
         make --output-sync {target} -j{jobs} {verbose};
     """
 
-    def build_image(self, img):
-        cimg = self._download_with_cache(
-            "https://cloud-images.ubuntu.com/releases/bionic/release-20191114/ubuntu-18.04-server-cloudimg-i386.img",
-            sha256sum="28969840626d1ea80bb249c08eef1a4533e8904aa51a327b40f37ac4b4ff04ef")
-        img_tmp = img + ".tmp"
-        subprocess.check_call(["cp", "-f", cimg, img_tmp])
-        self.exec_qemu_img("resize", img_tmp, "50G")
-        self.boot(img_tmp, extra_args = [
-            "-device", "VGA",
-            "-cdrom", self.gen_cloud_init_iso()
-        ])
-        self.wait_ssh()
-        self.ssh_root_check("touch /etc/cloud/cloud-init.disabled")
-        self.ssh_root_check("apt-get update")
-        self.ssh_root_check("apt-get install -y cloud-initramfs-growroot")
-        # Don't check the status in case the guest hang up too quickly
-        self.ssh_root("sync && reboot")
-        time.sleep(5)
-        self.wait_ssh()
-        # The previous update sometimes doesn't survive a reboot, so do it again
-        self.ssh_root_check("sed -ie s/^#\ deb-src/deb-src/g /etc/apt/sources.list")
-        self.ssh_root_check("apt-get update")
-        self.ssh_root_check("apt-get build-dep -y qemu")
-        self.ssh_root_check("apt-get install -y libfdt-dev language-pack-en")
-        self.ssh_root("poweroff")
-        self.wait()
-        os.rename(img_tmp, img)
-        return 0
-
 if __name__ == "__main__":
-    sys.exit(basevm.main(UbuntuX86VM))
+    sys.exit(basevm.main(UbuntuX86VM, DEFAULT_CONFIG))
diff --git a/tests/vm/ubuntuvm.py b/tests/vm/ubuntuvm.py
new file mode 100644
index 00000000000..6689ad87aa8
--- /dev/null
+++ b/tests/vm/ubuntuvm.py
@@ -0,0 +1,60 @@
+#!/usr/bin/env python3
+#
+# Ubuntu VM testing library
+#
+# Copyright 2017 Red Hat Inc.
+# Copyright 2020 Linaro
+#
+# Authors:
+#  Robert Foley <robert.foley@linaro.org>
+#  Originally based on ubuntu.i386 Fam Zheng <famz@redhat.com>
+#
+# This code is licensed under the GPL version 2 or later.  See
+# the COPYING file in the top-level directory.
+
+import os
+import subprocess
+import basevm
+
+class UbuntuVM(basevm.BaseVM):
+
+    def __init__(self, args, config=None):
+        self.login_prompt = "ubuntu-{}-guest login:".format(self.arch)
+        basevm.BaseVM.__init__(self, args, config)
+
+    def build_image(self, img):
+        """Build an Ubuntu VM image.  The child class will
+           define the install_cmds to init the VM."""
+        os_img = self._download_with_cache(self.image_link,
+                                           sha256sum=self.image_sha256)
+        img_tmp = img + ".tmp"
+        subprocess.check_call(["cp", "-f", os_img, img_tmp])
+        self.exec_qemu_img("resize", img_tmp, "+50G")
+        ci_img = self.gen_cloud_init_iso()
+
+        self.boot(img_tmp, extra_args = [ "-device", "VGA", "-cdrom", ci_img, ])
+
+        # First command we issue is fix for slow ssh login.
+        self.wait_ssh(wait_root=True,
+                      cmd="chmod -x /etc/update-motd.d/*")
+        # Wait for cloud init to finish
+        self.wait_ssh(wait_root=True,
+                      cmd="ls /var/lib/cloud/instance/boot-finished")
+        self.ssh_root("touch /etc/cloud/cloud-init.disabled")
+        # Disable auto upgrades.
+        # We want to keep the VM system state stable.
+        self.ssh_root('sed -ie \'s/"1"/"0"/g\' '\
+                      '/etc/apt/apt.conf.d/20auto-upgrades')
+        self.ssh_root("sed -ie s/^#\ deb-src/deb-src/g /etc/apt/sources.list")
+
+        # If the user chooses not to do the install phase,
+        # then we will jump right to the graceful shutdown
+        if self._config['install_cmds'] != "":
+            # Issue the install commands.
+            # This can be overriden by the user in the config .yml.
+            install_cmds = self._config['install_cmds'].split(',')
+            for cmd in install_cmds:
+                self.ssh_root(cmd)
+        self.graceful_shutdown()
+        os.rename(img_tmp, img)
+        return 0
-- 
2.20.1


