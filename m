Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B25C4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:24:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4306D20873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Je608rte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4306D20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUBzH-000414-F5
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45448)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jUBda-0000by-2I
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:03:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jUBaH-0003Uq-89
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:02:09 -0400
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735]:46641)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jUBaG-0003Qa-Oz
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:58:44 -0400
Received: by mail-qk1-x735.google.com with SMTP id g74so6165533qke.13
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 08:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=TYO4Zx0Loe04L+x6lPxnHdIAL0X0Jk82WXdBB7mYsRE=;
 b=Je608rteJbKCi888tRaQgduw62n5oWEaHMkAHHu7H496LSlwQBZU0zZLyN4CoeZY/9
 Jq6Sl8Ej222UwXT4GsrNfy4xKwHubCHZy+9vtfOY1HgIETYrQ051+nF2iNdU6ox58HvL
 tcK4bb4BR+ulC1mW1JstFjXDUk1hM2GE5rCiDQdGRxuL22G3dgu2Soj0e2rUZD9s6E0x
 PBQFOyxQcIHPK9A4Cp6zCqrntLu0U+clK32LQ3sxb8lhzDDkRXJah8I5uXF0qAMvZgl1
 9QdpAPfhqlV421PBaLqkX7ijs0mnH0vCyT31S/xxCqmY/JKVnrVQzA20g2sXsFkwVzg6
 fRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=TYO4Zx0Loe04L+x6lPxnHdIAL0X0Jk82WXdBB7mYsRE=;
 b=XGcZJStXDdliimEH9Tn8TFkfrC/PW0MhjTpBdD+EhlViMR8jJs8pSVo9X0GIBPey36
 ORu+Jc87w96pgWBMb9G9FMCwrLGUFhwMWQvrlw5KahElAbBO4zNUmQkIA4K6s3bMBsmZ
 yMhg+tAmBysGha35UEli6xlE2BjHc/D8hIYkR7AJAI012Um6UaSXM9zH8EBhUGaYWMSW
 xA65bs82TMjAZ20wX8zTAFYf4kDBOhAam/dcfLej23G7odf6/3mCLYm74+IhwdsKbJHv
 u9OGpBcd5GGlXj+bhHfUQ0ELkvVXqdbvDpPDlirpg0hKiP0ywcbifDCxpB5mCyX1ZQRJ
 jSpQ==
X-Gm-Message-State: AGi0PubXyCSM8swIDO7cS8eeJiySfejuA1rZ6ENJsEIBZl6t8/ea4akP
 yYi5iFTp0G0Cl7MBjNEFOKJDg4ezm8abaw==
X-Google-Smtp-Source: APiQypJJtJPZxKEQptuYHAnU5OIqe8+R1F9PDhtp16+zWP/vJLf9ATUBgy3yDkZieCCSuu8tm1yLEQ==
X-Received: by 2002:a37:66d8:: with SMTP id a207mr4087875qkc.127.1588262323073; 
 Thu, 30 Apr 2020 08:58:43 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:7489:3328:3806:7c3])
 by smtp.gmail.com with ESMTPSA id v16sm305254qkf.80.2020.04.30.08.58.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 08:58:42 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 6/9] tests/vm: Added a new script for ubuntu.aarch64.
Date: Thu, 30 Apr 2020 11:57:15 -0400
Message-Id: <20200430155718.212-7-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430155718.212-1-robert.foley@linaro.org>
References: <20200430155718.212-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::735;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x735.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::735
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
Cc: philmd@redhat.com, alex.bennee@linaro.org, robert.foley@linaro.org,
 peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ubuntu.aarch64 provides a script to create an Ubuntu 20.04 VM.
Another new file is also added aarch64vm.py, which is a module with
common methods used by aarch64 VMs, such as how to create the
flash images.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
---
 configure                 |  16 ++++++
 tests/vm/Makefile.include |   8 +++
 tests/vm/aarch64vm.py     | 105 ++++++++++++++++++++++++++++++++++
 tests/vm/basevm.py        |   8 +++
 tests/vm/ubuntu.aarch64   | 117 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 254 insertions(+)
 create mode 100644 tests/vm/aarch64vm.py
 create mode 100755 tests/vm/ubuntu.aarch64

diff --git a/configure b/configure
index eec6615b81..00102f2bf0 100755
--- a/configure
+++ b/configure
@@ -950,6 +950,20 @@ do
     fi
 done
 
+# Check for files needed by aarch64 VMs.
+# Allow user to override the path for efi also.
+qemu_efi_aarch64=
+for fd in $QEMU_EFI_PATH /usr/share/qemu-efi-aarch64/QEMU_EFI.fd
+do
+    if has $fd
+    then
+        if [ -f  $fd ]; then
+            qemu_efi_aarch64=$fd
+        fi
+        break
+    fi
+done
+
 # Check for existence of python3 yaml, needed to
 # import yaml config files into vm-build.
 python_yaml="no"
@@ -6588,6 +6602,7 @@ if test "$docs" != "no"; then
     echo "sphinx-build      $sphinx_build"
 fi
 echo "genisoimage       $genisoimage"
+echo "qemu_efi_aarch64  $qemu_efi_aarch64"
 echo "python_yaml       $python_yaml"
 echo "slirp support     $slirp $(echo_version $slirp $slirp_version)"
 if test "$slirp" != "no" ; then
@@ -7650,6 +7665,7 @@ echo "PYTHON=$python" >> $config_host_mak
 echo "SPHINX_BUILD=$sphinx_build" >> $config_host_mak
 echo "SPHINX_WERROR=$sphinx_werror" >> $config_host_mak
 echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
+echo "QEMU_EFI_AARCH64=$qemu_efi_aarch64" >> $config_host_mak
 echo "PYTHON_YAML=$python_yaml" >> $config_host_mak
 echo "CC=$cc" >> $config_host_mak
 if $iasl -h > /dev/null 2>&1; then
diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 667705a91a..9934008bfa 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -5,6 +5,9 @@
 IMAGES := freebsd netbsd openbsd centos fedora
 ifneq ($(GENISOIMAGE),)
 IMAGES += ubuntu.i386 centos
+ifneq ($(QEMU_EFI_AARCH64),)
+IMAGES += ubuntu.aarch64
+endif
 endif
 
 IMAGES_DIR := $(HOME)/.cache/qemu-vm/images
@@ -23,6 +26,11 @@ vm-help vm-test:
 ifneq ($(GENISOIMAGE),)
 	@echo "  vm-build-centos                 - Build QEMU in CentOS VM, with Docker"
 	@echo "  vm-build-ubuntu.i386            - Build QEMU in ubuntu i386 VM"
+ifneq ($(QEMU_EFI_AARCH64),)
+	@echo "  vm-build-ubuntu.aarch64         - Build QEMU in ubuntu aarch64 VM"
+else
+	@echo "  (install qemu-efi-aarch64 to build centos/ubuntu aarch64 images.)"
+endif
 else
 	@echo "  (install genisoimage to build centos/ubuntu images)"
 endif
diff --git a/tests/vm/aarch64vm.py b/tests/vm/aarch64vm.py
new file mode 100644
index 0000000000..3a9807cd43
--- /dev/null
+++ b/tests/vm/aarch64vm.py
@@ -0,0 +1,105 @@
+#!/usr/bin/env python3
+#
+# VM testing aarch64 library
+#
+# Copyright 2020 Linaro
+#
+# Authors:
+#  Robert Foley <robert.foley@linaro.org>
+#
+# This code is licensed under the GPL version 2 or later.  See
+# the COPYING file in the top-level directory.
+#
+import os
+import sys
+import subprocess
+import basevm
+from qemu.accel import kvm_available
+
+# This is the config needed for current version of QEMU.
+# This works for both kvm and tcg.
+CURRENT_CONFIG = {
+    'cpu'          : "max",
+    'machine'      : "virt,gic-version=max",
+}
+
+# The minimum minor version of QEMU we will support with aarch64 VMs is 3.
+# QEMU versions less than 3 have various issues running these VMs.
+QEMU_AARCH64_MIN_VERSION = 3
+
+# The DEFAULT_CONFIG will default to a version of
+# parameters that works for backwards compatibility.
+DEFAULT_CONFIG = {'kvm' : {'cpu'          : "host",
+                           'machine'      : "virt,gic-version=host"},
+                  'tcg' : {'cpu'          : "cortex-a57",
+                           'machine'      : "virt"},
+}
+
+def get_config_defaults(vmcls, default_config):
+    """Fetch the configuration defaults for this VM,
+       taking into consideration the defaults for
+       aarch64 first, followed by the defaults for this VM."""
+    config = default_config
+    config.update(aarch_get_config_defaults(vmcls))
+    return config
+
+def aarch_get_config_defaults(vmcls):
+    """Set the defaults for current version of QEMU."""
+    config = CURRENT_CONFIG
+    args, argv = basevm.parse_args(vmcls)
+    qemu_path = basevm.get_qemu_path(vmcls.arch, args.build_path)
+    qemu_version = basevm.get_qemu_version(qemu_path)
+    if qemu_version < QEMU_AARCH64_MIN_VERSION:
+        error = "\nThis major version of QEMU {} is to old for aarch64 VMs.\n"\
+                "The major version must be at least {}.\n"\
+                "To continue with the current build of QEMU, "\
+                "please restart with QEMU_LOCAL=1 .\n"
+        print(error.format(qemu_version, QEMU_AARCH64_MIN_VERSION))
+        exit(1)
+    if qemu_version == QEMU_AARCH64_MIN_VERSION:
+        # We have an older version of QEMU,
+        # set the config values for backwards compatibility.
+        if kvm_available('aarch64'):
+            config.update(DEFAULT_CONFIG['kvm'])
+        else:
+            config.update(DEFAULT_CONFIG['tcg'])
+    return config
+
+def create_flash_images(flash_dir="./"):
+    """Creates the appropriate pflash files
+       for an aarch64 VM."""
+    flash0_path = get_flash_path(flash_dir, "flash0")
+    flash1_path = get_flash_path(flash_dir, "flash1")
+    fd_null = open(os.devnull, 'w')
+    subprocess.check_call(["dd", "if=/dev/zero", "of={}".format(flash0_path),
+                           "bs=1M", "count=64"],
+                           stdout=fd_null, stderr=subprocess.STDOUT)
+    # A reliable way to get the QEMU EFI image is via an installed package.
+    efi_img = "/usr/share/qemu-efi-aarch64/QEMU_EFI.fd"
+    if not os.path.exists(efi_img):
+        sys.stderr.write("*** {} is missing\n".format(efi_img))
+        sys.stderr.write("*** please install qemu-efi-aarch64 package\n")
+        exit(3)
+    subprocess.check_call(["dd", "if={}".format(efi_img),
+                           "of={}".format(flash0_path),
+                           "conv=notrunc"],
+                           stdout=fd_null, stderr=subprocess.STDOUT)
+    subprocess.check_call(["dd", "if=/dev/zero",
+                           "of={}".format(flash1_path),
+                           "bs=1M", "count=64"],
+                           stdout=fd_null, stderr=subprocess.STDOUT)
+    fd_null.close()
+
+def get_pflash_args(flash_dir="./"):
+    """Returns a string that can be used to
+       boot qemu using the appropriate pflash files
+       for aarch64."""
+    flash0_path = get_flash_path(flash_dir, "flash0")
+    flash1_path = get_flash_path(flash_dir, "flash1")
+    pflash_args_str = "-drive file={},format=raw,if=pflash "\
+                      "-drive file={},format=raw,if=pflash"
+    pflash_args = pflash_args_str.format(flash0_path, flash1_path)
+    return pflash_args.split(" ")
+
+def get_flash_path(flash_dir, name):
+    return os.path.join(flash_dir, "{}.img".format(name))
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 9f06f84974..dddd4711ff 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -498,6 +498,14 @@ def get_qemu_path(arch, build_path=None):
         qemu_path = "qemu-system-" + arch
     return qemu_path
 
+def get_qemu_version(qemu_path):
+    """Get the version number from the current QEMU,
+       and return the major number."""
+    output = subprocess.check_output([qemu_path, '--version'])
+    version_line = output.decode("utf-8")
+    version_num = re.split(' |\(', version_line)[3].split('.')[0]
+    return int(version_num)
+
 def parse_config(config, args):
     """ Parse yaml config and populate our config structure.
         The yaml config allows the user to override the
diff --git a/tests/vm/ubuntu.aarch64 b/tests/vm/ubuntu.aarch64
new file mode 100755
index 0000000000..40bf1110e8
--- /dev/null
+++ b/tests/vm/ubuntu.aarch64
@@ -0,0 +1,117 @@
+#!/usr/bin/env python3
+#
+# Ubuntu aarch64 image
+#
+# Copyright 2020 Linaro
+#
+# Authors:
+#  Robert Foley <robert.foley@linaro.org>
+#  Originally based on ubuntu.i386 Fam Zheng <famz@redhat.com>
+#
+# This code is licensed under the GPL version 2 or later.  See
+# the COPYING file in the top-level directory.
+#
+
+import os
+import sys
+import subprocess
+import basevm
+from qemu.accel import kvm_available
+import time
+import aarch64vm
+
+DEFAULT_CONFIG = {
+    'cpu'          : "cortex-a57",
+    'machine'      : "virt,gic-version=3",
+    'install_cmds' : "apt-get update,"\
+                     "apt-get build-dep -y --arch-only qemu,"\
+                     "apt-get install -y libfdt-dev flex bison pkg-config",
+    # We increase beyond the default time since during boot
+    # it can take some time (many seconds) to log into the VM
+    # especially using softmmu.
+    'ssh_timeout'  : 60,
+}
+
+class UbuntuAarch64VM(basevm.BaseVM):
+    name = "ubuntu.aarch64"
+    arch = "aarch64"
+    image_name = "ubuntu-20.04-server-cloudimg-arm64.img"
+    image_link = "https://cloud-images.ubuntu.com/releases/20.04/release/" + image_name
+    login_prompt = "ubuntu-aarch64-guest login:"
+    BUILD_SCRIPT = """
+        set -e;
+        cd $(mktemp -d);
+        sudo chmod a+r /dev/vdb;
+        tar --checkpoint=.10 -xf /dev/vdb;
+        ./configure {configure_opts};
+        make --output-sync {target} -j{jobs} {verbose};
+    """
+    def boot(self, img, extra_args=None):
+        aarch64vm.create_flash_images(self._tmpdir)
+        default_args = aarch64vm.get_pflash_args(self._tmpdir)
+        if extra_args:
+            extra_args.extend(default_args)
+        else:
+            extra_args = default_args
+        # We always add these performance tweaks
+        # because without them, we boot so slowly that we
+        # can time out finding the boot efi device.
+        if '-smp' not in extra_args and \
+           '-smp' not in self._config['extra_args'] and \
+           '-smp' not in self._args:
+            # Only add if not already there to give caller option to change it.
+            extra_args.extend(["-smp", "8"])
+
+        # We have overridden boot() since aarch64 has additional parameters.
+        # Call down to the base class method.
+        super(UbuntuAarch64VM, self).boot(img, extra_args=extra_args)
+
+    def build_image(self, img):
+        os_img = self._download_with_cache(self.image_link)
+        img_tmp = img + ".tmp"
+        subprocess.check_call(["cp", "-f", os_img, img_tmp])
+        subprocess.check_call(["qemu-img", "resize", img_tmp, "+50G"])
+        ci_img = self.gen_cloud_init_iso()
+
+        self.boot(img_tmp, extra_args = ["-cdrom", ci_img])
+        if self._boot_console:
+            self.wait_boot()
+        # First command we issue is fix for slow ssh login.
+        self.wait_ssh(wait_root=True,
+                      cmd="chmod -x /etc/update-motd.d/*")
+        # Wait for cloud init to finish
+        self.wait_ssh(wait_root=True,
+                      cmd="ls /var/lib/cloud/instance/boot-finished")
+        self.ssh_root("touch /etc/cloud/cloud-init.disabled")
+        # Disable auto upgrades.
+        # We want to keep the VM system state stable.
+        self.ssh_root('sed -ie \'s/"1"/"0"/g\' /etc/apt/apt.conf.d/20auto-upgrades')
+        # If the user chooses *not* to do the second phase,
+        # then we will jump right to the graceful shutdown
+        if self._config['install_cmds'] != "":
+            self.ssh_root("sync")
+            # Shutdown and then boot it again.
+            # Allows us to know for sure it is booting (not shutting down)
+            # before we call wait_ssh().
+            self.graceful_shutdown()
+            self.boot(img_tmp)
+            if self._boot_console:
+                self.wait_boot()
+            self.wait_ssh(wait_root=True)
+            self.wait_ssh(wait_root=True, cmd="locale")
+            # The previous update sometimes doesn't survive a reboot, so do it again
+            self.ssh_root("sed -ie s/^#\ deb-src/deb-src/g /etc/apt/sources.list")
+
+            # Issue the install commands.
+            # This can be overriden by the user in the config .yml.
+            install_cmds = self._config['install_cmds'].split(',')
+            for cmd in install_cmds:
+                self.ssh_root(cmd)
+        self.graceful_shutdown()
+        self.wait()
+        os.rename(img_tmp, img)
+        return 0
+
+if __name__ == "__main__":
+    defaults = aarch64vm.get_config_defaults(UbuntuAarch64VM, DEFAULT_CONFIG)
+    sys.exit(basevm.main(UbuntuAarch64VM, defaults))
-- 
2.17.1


