Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3E3C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 21:20:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE60A206E2
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 21:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ony0QKlr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE60A206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfrqt-0006g8-53
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 17:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jfrma-0001f1-Uw
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 17:15:45 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033]:35558)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jfrmW-0006UT-0C
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 17:15:44 -0400
Received: by mail-pj1-x1033.google.com with SMTP id 5so398293pjd.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 14:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HwMKTDzpXMlV2BZpE6DudYiQmM2uC/mqcK0kAaGHKdQ=;
 b=ony0QKlrCLJXY88jQns6O2Vl0DyCYhQ11cD8iapYiyDIgXSj9PZRvYsspYuOsAbq01
 Ost8FPqAH0eAxWN+YQLiuXfEMwWZEyiH3WFLwF+2OWcgs74owP3c74HK2MGFvZ6Zkav2
 w233bafL533Jys3NeGPVlBhDZM2t1DXTLyrlQ281JyODwAM2w9zPpp6+N4Nb41Ix1kQi
 j8gibL60nOBhHoBWx3bcGmlj/UI8Jkw+omYb1FpN6iCM9LrKcFDCcd8ZRUmDlv0WjKV0
 dfen2/mYmJxw2iBe9Kx3dOXhenpJOZxF23QdNJNWZslVbIrQVGaIPRgXWcLYvpEKdacQ
 TJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HwMKTDzpXMlV2BZpE6DudYiQmM2uC/mqcK0kAaGHKdQ=;
 b=mywbzGDenS1xNY5tvvgbybu1Rxn65EnbjOJmgm8a8XUYZXloZPguNvzO912ClysrOV
 V+O3GV3tipmqIh2OblC0uTOsNMHasqJc9QVXNuzD3plb9aWDK+RDFXeGg3DfwBBODYqk
 kTlB/Y6t3m7P2gtxwkuALIAJpq2DT9LbUpSMG0jkgFzISOVuGz9qXLu167hbwOFv7f6H
 /kGdXXJtyHciOtjMuH8aSu5Cp967NMCh/ikA+zH4/q4IwSwZ4IgYeC/g6CBBkHvO8qLk
 cWXhql+uh4KcAh66Ahmov2SYXf4xtwZPOTrHGZ6asTTvFOneExJtlcd+9pPu/4vCEdVg
 lqCw==
X-Gm-Message-State: AOAM531c9+6P77SeW2gw2PYuQWPVOBe3SbU0AeoxHBwhz/VQ1rdxMYmL
 BSKGjQiGyJNrgi6Sk84QscSMzfN7E+/8Ig==
X-Google-Smtp-Source: ABdhPJxJ4MFXIn8fes9SXmuJmh0TPAmGQKP0FDKqmgZJO21JP2n7Tj0hbsQsB45ipZCFRqskl5Zwmg==
X-Received: by 2002:a17:902:8d83:: with SMTP id
 v3mr5120072plo.27.1591046137158; 
 Mon, 01 Jun 2020 14:15:37 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:85d8:9a30:f0f7:b100])
 by smtp.gmail.com with ESMTPSA id j24sm330131pga.51.2020.06.01.14.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 14:15:36 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 4/9] tests/vm: Add common Ubuntu python module
Date: Mon,  1 Jun 2020 17:14:16 -0400
Message-Id: <20200601211421.1277-5-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601211421.1277-1-robert.foley@linaro.org>
References: <20200601211421.1277-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=robert.foley@linaro.org; helo=mail-pj1-x1033.google.com
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

Add a common Ubuntu python module and make use of
it with the ubuntu.i386 script.
This is preparation for adding an Ubuntu script
ubuntu.aarch64.  Splitting out the common
logic such as build_image() will reduce duplication.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/vm/ubuntu.i386 | 46 +++++++++------------------------
 tests/vm/ubuntuvm.py | 60 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 34 deletions(-)
 create mode 100644 tests/vm/ubuntuvm.py

diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
index 1570775335..c699eaf8d7 100755
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
+                     "apt-get install -y libfdt-dev flex bison language-pack-en",
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
-        self.ssh_root_check("apt-get install -y libfdt-dev flex bison language-pack-en")
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
index 0000000000..6689ad87aa
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
2.17.1


