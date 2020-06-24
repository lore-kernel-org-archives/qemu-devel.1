Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D54C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:07:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 942CF20781
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MUJxn1sx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 942CF20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo63n-0001vK-Pi
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 10:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jo61Q-00051J-Hz
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:05:04 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:47049)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jo61N-0003Vu-9C
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:05:04 -0400
Received: by mail-wr1-x42c.google.com with SMTP id r12so2376922wrj.13
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 07:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kdMIZtPe+aZda1/mXQW7aQb8KseTM0tT+oUaOxEz8I4=;
 b=MUJxn1sxXRAp4DhnvYyDZocNypsJUbI6Pp0bBQ4PYprWSSCQiUpWnpUclj80cUKLwp
 TjzCO0nh88sMGCxQ4+QHsgXMT+xkABjJkf+cVaqKpQEOw4H0KsjE+Bt5upJ7DpCkuD/G
 IwQb7u4TthDjDOPygwgyYE8zoWmhHHEQtG1HWrp5lH0pcMkU/Ek2aBf66lvc4eiGcN+4
 ChOnEfv1wSe0Hrs8/awuS8KCaO7B0mzqwpAlkh3XyfgUOPq2ERrbAe5AIlqG89HRQieX
 2E55R2GFsvuhOXOzUPGb0IIsDQsMkzTIMtZvQq4IID6MzQPcKQQ4ZvHyZQs/yfmX3TKG
 8ljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kdMIZtPe+aZda1/mXQW7aQb8KseTM0tT+oUaOxEz8I4=;
 b=QhPKVTclEaObuCw+O9Q+m4DwxZycINSKfDbtiyGKhTKKZZTV6IijxkDmXwmUt8mSAh
 ULir88rJHPmntm/ut2BV5ygP7imHlUQqPR3UBtKEQcbycJUM2GDqVrPghujoW6Pzw7YJ
 gsjzleO82gMC6ZsXwgAOL9x64XMGSTEBJOrts3wis9ExTHhWC/kCoHsudN43FyD5VmLR
 bkEbOCzI2lNl+Qb48bH1nVdlVvcoun7NEX7oVYsaZNMOwQB5Ceiv+NMNIhEqC9EXzRpD
 uAqVuFPbJRXw34GUR0VCjtSHqgjBdTN+BsmbzwXvLlf8lXx5+Juf93ypbcraj2GYM29V
 NIow==
X-Gm-Message-State: AOAM533D54isK9lasU6Kg8o1dYilCTzx2RUUC1NZfJ8uUA2fDFWe9Zzn
 HTfRkgod2F5PuvsxSbTlvCYzdQ==
X-Google-Smtp-Source: ABdhPJw7xJnqqpSQfZh5S9ZO1IZBMchobJRB8wC8vF4rn6QAE5h+XDM1G7IDFOYSGIP5k8Y906sojw==
X-Received: by 2002:a5d:4603:: with SMTP id t3mr4807959wrq.38.1593007499536;
 Wed, 24 Jun 2020 07:04:59 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z1sm13677635wrh.14.2020.06.24.07.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 07:04:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 04B301FF96;
 Wed, 24 Jun 2020 15:04:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 08/25] tests/vm: Added a new script for centos.aarch64.
Date: Wed, 24 Jun 2020 15:04:29 +0100
Message-Id: <20200624140446.15380-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200624140446.15380-1-alex.bennee@linaro.org>
References: <20200624140446.15380-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 Peter Puhov <peter.puhov@linaro.org>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Foley <robert.foley@linaro.org>

centos.aarch64 creates a CentOS 8 image.
Also added a new kickstart script used to build the centos.aarch64 image.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200601211421.1277-7-robert.foley@linaro.org>
---
 tests/vm/Makefile.include    |   3 +-
 tests/vm/centos-8-aarch64.ks |  51 ++++++++
 tests/vm/centos.aarch64      | 227 +++++++++++++++++++++++++++++++++++
 3 files changed, 280 insertions(+), 1 deletion(-)
 create mode 100644 tests/vm/centos-8-aarch64.ks
 create mode 100755 tests/vm/centos.aarch64

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 4fa292765d5..39f918a430a 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -6,7 +6,7 @@ IMAGES := freebsd netbsd openbsd centos fedora
 ifneq ($(GENISOIMAGE),)
 IMAGES += ubuntu.i386 centos
 ifneq ($(EFI_AARCH64),)
-IMAGES += ubuntu.aarch64
+IMAGES += ubuntu.aarch64 centos.aarch64
 endif
 endif
 
@@ -28,6 +28,7 @@ ifneq ($(GENISOIMAGE),)
 	@echo "  vm-build-ubuntu.i386            - Build QEMU in ubuntu i386 VM"
 ifneq ($(EFI_AARCH64),)
 	@echo "  vm-build-ubuntu.aarch64         - Build QEMU in ubuntu aarch64 VM"
+	@echo "  vm-build-centos.aarch64         - Build QEMU in CentOS aarch64 VM"
 else
 	@echo "  (to build centos/ubuntu aarch64 images use configure --efi-aarch64)"
 endif
diff --git a/tests/vm/centos-8-aarch64.ks b/tests/vm/centos-8-aarch64.ks
new file mode 100644
index 00000000000..fd6ebe4d49e
--- /dev/null
+++ b/tests/vm/centos-8-aarch64.ks
@@ -0,0 +1,51 @@
+# CentOS aarch64 image kickstart file.
+# This file is used by the CentOS installer to
+# script the generation of the image.
+#
+# Copyright 2020 Linaro
+#
+ignoredisk --only-use=vda
+# System bootloader configuration
+bootloader --append=" crashkernel=auto" --location=mbr --boot-drive=vda
+autopart --type=plain
+# Partition clearing information
+clearpart --linux --initlabel --drives=vda
+# Use text mode install
+text
+repo --name="AppStream" --baseurl=file:///run/install/repo/AppStream
+# Use CDROM installation media
+cdrom
+# Keyboard layouts
+keyboard --vckeymap=us --xlayouts=''
+# System language
+lang en_US.UTF-8
+
+# Network information
+network  --bootproto=dhcp --device=enp0s1 --onboot=off --ipv6=auto --no-activate
+network  --hostname=localhost.localdomain
+# Run the Setup Agent on first boot
+firstboot --enable
+# Do not configure the X Window System
+skipx
+# System services
+services --enabled="chronyd"
+# System timezone
+timezone America/New_York --isUtc
+
+# Shutdown after installation is complete.
+shutdown
+
+%packages
+@^server-product-environment
+kexec-tools
+
+%end
+
+%addon com_redhat_kdump --enable --reserve-mb='auto'
+
+%end
+%anaconda
+pwpolicy root --minlen=6 --minquality=1 --notstrict --nochanges --notempty
+pwpolicy user --minlen=6 --minquality=1 --notstrict --nochanges --emptyok
+pwpolicy luks --minlen=6 --minquality=1 --notstrict --nochanges --notempty
+%end
diff --git a/tests/vm/centos.aarch64 b/tests/vm/centos.aarch64
new file mode 100755
index 00000000000..d5232ecdb8c
--- /dev/null
+++ b/tests/vm/centos.aarch64
@@ -0,0 +1,227 @@
+#!/usr/bin/env python3
+#
+# Centos aarch64 image
+#
+# Copyright 2020 Linaro
+#
+# Authors:
+#  Robert Foley <robert.foley@linaro.org>
+#  Originally based on ubuntu.aarch64
+#
+# This code is licensed under the GPL version 2 or later.  See
+# the COPYING file in the top-level directory.
+#
+
+import os
+import sys
+import subprocess
+import basevm
+import time
+import traceback
+import aarch64vm
+
+DEFAULT_CONFIG = {
+    'cpu'          : "max",
+    'machine'      : "virt,gic-version=max",
+    'install_cmds' : "yum install -y make git python3 gcc gcc-c++ flex bison, "\
+        "yum install -y glib2-devel pixman-devel zlib-devel, "\
+        "yum install -y perl-Test-Harness, "\
+        "alternatives --set python /usr/bin/python3, "\
+        "sudo dnf config-manager "\
+        "--add-repo=https://download.docker.com/linux/centos/docker-ce.repo,"\
+        "sudo dnf install --nobest -y docker-ce.aarch64,"\
+        "systemctl enable docker",
+    # We increase beyond the default time since during boot
+    # it can take some time (many seconds) to log into the VM.
+    'ssh_timeout'  : 60,
+}
+
+class CentosAarch64VM(basevm.BaseVM):
+    name = "centos.aarch64"
+    arch = "aarch64"
+    login_prompt = "localhost login:"
+    prompt = '[root@localhost ~]#'
+    image_name = "CentOS-8-aarch64-1905-dvd1.iso"
+    image_link = "http://mirrors.usc.edu/pub/linux/distributions/centos/8.0.1905/isos/aarch64/"
+    image_link += image_name
+    BUILD_SCRIPT = """
+        set -e;
+        cd $(mktemp -d);
+        sudo chmod a+r /dev/vdb;
+        tar --checkpoint=.10 -xf /dev/vdb;
+        ./configure {configure_opts};
+        make --output-sync {target} -j{jobs} {verbose};
+    """
+    def set_key_perm(self):
+        """Set permissions properly on certain files to allow
+           ssh access."""
+        self.console_wait_send(self.prompt,
+                               "/usr/sbin/restorecon -R -v /root/.ssh\n")
+        self.console_wait_send(self.prompt,
+                "/usr/sbin/restorecon -R -v "\
+                "/home/{}/.ssh\n".format(self._config["guest_user"]))
+
+    def create_kickstart(self):
+        """Generate the kickstart file used to generate the centos image."""
+        # Start with the template for the kickstart.
+        ks_file = "../tests/vm/centos-8-aarch64.ks"
+        subprocess.check_call("cp {} ./ks.cfg".format(ks_file), shell=True)
+        # Append the ssh keys to the kickstart file
+        # as the post processing phase of installation.
+        with open("ks.cfg", "a") as f:
+            # Add in the root pw and guest user.
+            rootpw = "rootpw --plaintext {}\n"
+            f.write(rootpw.format(self._config["root_pass"]))
+            add_user = "user --groups=wheel --name={} "\
+                       "--password={} --plaintext\n"
+            f.write(add_user.format(self._config["guest_user"],
+                                    self._config["guest_pass"]))
+            # Add the ssh keys.
+            f.write("%post --log=/root/ks-post.log\n")
+            f.write("mkdir -p /root/.ssh\n")
+            addkey = 'echo "{}" >> /root/.ssh/authorized_keys\n'
+            addkey_cmd = addkey.format(self._config["ssh_pub_key"])
+            f.write(addkey_cmd)
+            f.write('mkdir -p /home/{}/.ssh\n'.format(self._config["guest_user"]))
+            addkey = 'echo "{}" >> /home/{}/.ssh/authorized_keys\n'
+            addkey_cmd = addkey.format(self._config["ssh_pub_key"],
+                                       self._config["guest_user"])
+            f.write(addkey_cmd)
+            f.write("%end\n")
+        # Take our kickstart file and create an .iso from it.
+        # The .iso will be provided to qemu as we boot
+        # from the install dvd.
+        # Anaconda will recognize the label "OEMDRV" and will
+        # start the automated installation.
+        gen_iso_img = 'genisoimage -output ks.iso -volid "OEMDRV" ks.cfg'
+        subprocess.check_call(gen_iso_img, shell=True)
+
+    def wait_for_shutdown(self):
+        """We wait for qemu to shutdown the VM and exit.
+           While this happens we display the console view
+           for easier debugging."""
+        # The image creation is essentially done,
+        # so whether or not the wait is successful we want to
+        # wait for qemu to exit (the self.wait()) before we return.
+        try:
+            self.console_wait("reboot: Power down")
+        except Exception as e:
+            sys.stderr.write("Exception hit\n")
+            if isinstance(e, SystemExit) and e.code == 0:
+                return 0
+            traceback.print_exc()
+        finally:
+            self.wait()
+
+    def build_base_image(self, dest_img):
+        """Run through the centos installer to create
+           a base image with name dest_img."""
+        # We create the temp image, and only rename
+        # to destination when we are done.
+        img = dest_img + ".tmp"
+        # Create an empty image.
+        # We will provide this as the install destination.
+        qemu_img_create = "qemu-img create {} 50G".format(img)
+        subprocess.check_call(qemu_img_create, shell=True)
+
+        # Create our kickstart file to be fed to the installer.
+        self.create_kickstart()
+        # Boot the install dvd with the params as our ks.iso
+        os_img = self._download_with_cache(self.image_link)
+        dvd_iso = "centos-8-dvd.iso"
+        subprocess.check_call(["cp", "-f", os_img, dvd_iso])
+        extra_args = "-cdrom ks.iso"
+        extra_args += " -drive file={},if=none,id=drive1,cache=writeback"
+        extra_args += " -device virtio-blk,drive=drive1,bootindex=1"
+        extra_args = extra_args.format(dvd_iso).split(" ")
+        self.boot(img, extra_args=extra_args)
+        self.console_wait_send("change the selection", "\n")
+        # We seem to need to hit esc (chr(27)) twice to abort the
+        # media check, which takes a long time.
+        # Waiting a bit seems to be more reliable before hitting esc.
+        self.console_wait("Checking")
+        time.sleep(5)
+        self.console_wait_send("Checking", chr(27))
+        time.sleep(5)
+        self.console_wait_send("Checking", chr(27))
+        print("Found Checking")
+        # Give sufficient time for the installer to create the image.
+        self.console_init(timeout=7200)
+        self.wait_for_shutdown()
+        os.rename(img, dest_img)
+        print("Done with base image build: {}".format(dest_img))
+
+    def check_create_base_img(self, img_base, img_dest):
+        """Create a base image using the installer.
+           We will use the base image if it exists.
+           This helps cut down on install time in case we
+           need to restart image creation,
+           since the base image creation can take a long time."""
+        if not os.path.exists(img_base):
+            print("Generate new base image: {}".format(img_base))
+            self.build_base_image(img_base);
+        else:
+            print("Use existing base image: {}".format(img_base))
+        # Save a copy of the base image and copy it to dest.
+        # which we will use going forward.
+        subprocess.check_call(["cp", img_base, img_dest])
+
+    def boot(self, img, extra_args=None):
+        aarch64vm.create_flash_images(self._tmpdir, self._efi_aarch64)
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
+        # We have overridden boot() since aarch64 has additional parameters.
+        # Call down to the base class method.
+        super(CentosAarch64VM, self).boot(img, extra_args=extra_args)
+
+    def build_image(self, img):
+        img_tmp = img + ".tmp"
+        self.check_create_base_img(img + ".base", img_tmp)
+
+        # Boot the new image for the first time to finish installation.
+        self.boot(img_tmp)
+        self.console_init()
+        self.console_wait_send(self.login_prompt, "root\n")
+        self.console_wait_send("Password:",
+                               "{}\n".format(self._config["root_pass"]))
+
+        self.set_key_perm()
+        self.console_wait_send(self.prompt, "rpm -q centos-release\n")
+        enable_adapter = "sed -i 's/ONBOOT=no/ONBOOT=yes/g'" \
+                         " /etc/sysconfig/network-scripts/ifcfg-enp0s1\n"
+        self.console_wait_send(self.prompt, enable_adapter)
+        self.console_wait_send(self.prompt, "ifup enp0s1\n")
+        self.console_wait_send(self.prompt,
+                               'echo "qemu  ALL=(ALL) NOPASSWD:ALL" | '\
+                               'sudo tee /etc/sudoers.d/qemu\n')
+        self.console_wait(self.prompt)
+
+        # Rest of the commands we issue through ssh.
+        self.wait_ssh(wait_root=True)
+
+        # If the user chooses *not* to do the second phase,
+        # then we will jump right to the graceful shutdown
+        if self._config['install_cmds'] != "":
+            install_cmds = self._config['install_cmds'].split(',')
+            for cmd in install_cmds:
+                self.ssh_root(cmd)
+        self.ssh_root("poweroff")
+        self.wait_for_shutdown()
+        os.rename(img_tmp, img)
+        print("image creation complete: {}".format(img))
+        return 0
+
+if __name__ == "__main__":
+    defaults = aarch64vm.get_config_defaults(CentosAarch64VM, DEFAULT_CONFIG)
+    sys.exit(basevm.main(CentosAarch64VM, defaults))
-- 
2.20.1


