Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BADC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:07:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3846920781
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hydnMo+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3846920781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo63p-0001yb-Dx
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 10:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jo61M-0004uO-6D
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:05:00 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:44986)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jo61I-0003V5-QY
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:04:59 -0400
Received: by mail-wr1-x434.google.com with SMTP id b6so2392890wrs.11
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 07:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yfaWvkBHiSQ15nCnLOaiCfwwNxNyBgCuiCJ/EYYdU+8=;
 b=hydnMo+0y0ZC++K80GMn9ZR6OJ1W8xU5OuMxzDiD6fkNE4XFTiP+DhjJhjPi/L3vzn
 tr0Da1AbSDCTb2QGgrhxRtrZEgyn2GLBPf9oBommnvINOYKrZ9czErJhLXCqHxI/KT+L
 6rIKpXsLC1u5kb7p+LmojWs01r2ACvKYVY03CgFE+kqJ+b1eoVatEumrjVrrGMNxSCn0
 8ECEllraXFAatAy7UlcOyQCJ42l4jdC8/r9SfGlWhQNq775m3HIAB97DGLTRqfAObTE5
 gdCST3z1AihIUzxucqDZW8IGYu3cLawcNpz0EGxda3CStDjJjtfahlOsE40b1rtsVQcx
 nrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yfaWvkBHiSQ15nCnLOaiCfwwNxNyBgCuiCJ/EYYdU+8=;
 b=jBIuDX2TJEBkOrNxqi8vYr+VuVrwVioNkjfhvO3zsN0w9s7BwPZNZ1APRIrYj8Ubhz
 Nt+SsHMDivs3CEwzMwEMXITXgZdW+2ZoOXTQ25EynINbN+1f+0McQZtv0sZRsaRLUybU
 GQ6OoDOL+sI0W9LXHXetOV5tk5I/Z12llt5ryMWIRtU2vt3x3/JO92qa2bYAOOMkhjZR
 Novaa3PWRENwAgif/rn496wp3arFBaoPn972KFzrrQTAb2SN5F0bhu/Y2nS9Q56zY2C9
 6LsqDXiSJ1baYJIAVFuP109syzaBNIGdhHEoehSXObSaIvwhCHsnRKsPCzZuICDGky0j
 s66A==
X-Gm-Message-State: AOAM531XZWIPmzpjZ5ZTREINPgXzZPaRLNeM+Nvlh1kawXnp91g9ihhP
 W77xtJuyC3kKrWKAPAa5COJF5g==
X-Google-Smtp-Source: ABdhPJwQ1xYXA8S0TyyvNEBygrsxP5ZhTifUHtQtQvq/+fZsM4XtDbvFe1Plp4YZ29A8ilqAfZ9a2A==
X-Received: by 2002:adf:8067:: with SMTP id 94mr29864433wrk.427.1593007495439; 
 Wed, 24 Jun 2020 07:04:55 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y25sm8232106wma.19.2020.06.24.07.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 07:04:51 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C30CE1FF92;
 Wed, 24 Jun 2020 15:04:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 06/25] tests/vm: Add common Ubuntu python module
Date: Wed, 24 Jun 2020 15:04:27 +0100
Message-Id: <20200624140446.15380-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200624140446.15380-1-alex.bennee@linaro.org>
References: <20200624140446.15380-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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


