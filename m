Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AA5C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 21:17:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2853A2073B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 21:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nTCZ3cDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2853A2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfro5-0003Q7-73
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 17:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jfrmc-0001gs-6F
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 17:15:46 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e]:36910)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jfrma-0006Uk-IN
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 17:15:45 -0400
Received: by mail-pj1-x102e.google.com with SMTP id m2so393108pjv.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 14:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Q/9EozNKYD40zwO3wznbuGp/VFv5YOYvdDEqeJtY87o=;
 b=nTCZ3cDojUKpzGYrA/97u8SKRFuPC+5YL/wvci4nUtq1jp1Rl5/rTBkLBFrHHu6BUM
 sNcCzMIy/8D+qilah4sLeLgj5k6jY4p/vOidsOnV9UYC128xr/I1VKesvAu5IxsjCVEc
 c4sJE5GhD3YNmh0wAdLtq+RvJZBruxowBlm8o4GIyD/RhkiDD1eUg8C1zhXKjg0K/HbN
 u5rFwQOw9sOyRlnlo/uJrMEg08LMIsJyE1+SHdGoA2P04l/XzAI6dp6FMbRjFZXnNqrX
 Kue1CPc0fXj+LL17mDQFQ59ETZ1jxxh9wDhFOy7HdBy5FjDrhoxBxZxTk/wDbYH4+l7u
 8dOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Q/9EozNKYD40zwO3wznbuGp/VFv5YOYvdDEqeJtY87o=;
 b=m3BwKxIIjJGnEze2XHGQpNCOJ54IMHNyC2Cmx5CcdvpAPr1386huPf9ErcsmrVNLuI
 lnNUyLpAHwVcXEOUXkdDijTvjtInKP45vPONHCy06dPWUUAuDZO3sg4H2O7dDdf11GZS
 Oc9UUa1jX9OjnuTFmMVSZXwQWacWIh3KdZ7nm+EMjuchtjdrtb0L+W8lyGL4P/nUSRgy
 cIbSoZyiwEgJhqMyXLwOpSPUaB7YmuVgmxMRwXwVdGm51D3bFKKKvN0qKo9hWH9bNlPi
 c3cZKPVjTLvHam5Ap96XMhCsbvp1pvT5+m6QKOowtYr4N3bpPwnTrCS88a+CGLoimjbP
 Fp2w==
X-Gm-Message-State: AOAM532bo5UY+9Sa6ZSrHkjci+AbBz5PkIHWoxLhiCgqffgShXo55zPs
 ygVSi4/xol0tzE688XRhqLEIPYjTZDsGhA==
X-Google-Smtp-Source: ABdhPJz1eeEjPO5FuAwYHQ2WaA7OmSuoWDUC+3a+zCvSm6cenRthvUILvgN63dEMpqNCmb6MoXWZ1g==
X-Received: by 2002:a17:90a:bb81:: with SMTP id
 v1mr1350720pjr.168.1591046139440; 
 Mon, 01 Jun 2020 14:15:39 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:85d8:9a30:f0f7:b100])
 by smtp.gmail.com with ESMTPSA id j24sm330131pga.51.2020.06.01.14.15.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 14:15:38 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 5/9] tests/vm: Added a new script for ubuntu.aarch64.
Date: Mon,  1 Jun 2020 17:14:17 -0400
Message-Id: <20200601211421.1277-6-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601211421.1277-1-robert.foley@linaro.org>
References: <20200601211421.1277-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=robert.foley@linaro.org; helo=mail-pj1-x102e.google.com
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

ubuntu.aarch64 provides a script to create an Ubuntu 18.04 VM.
Another new file is also added aarch64vm.py, which is a module with
common methods used by aarch64 VMs, such as how to create the
flash images.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
---
 configure                 |  20 +++++++
 tests/vm/Makefile.include |  11 ++++
 tests/vm/aarch64vm.py     | 106 ++++++++++++++++++++++++++++++++++++++
 tests/vm/basevm.py        |  12 +++++
 tests/vm/ubuntu.aarch64   |  68 ++++++++++++++++++++++++
 5 files changed, 217 insertions(+)
 create mode 100644 tests/vm/aarch64vm.py
 create mode 100755 tests/vm/ubuntu.aarch64

diff --git a/configure b/configure
index b645470a63..0f2c1472db 100755
--- a/configure
+++ b/configure
@@ -411,6 +411,7 @@ prefix="/usr/local"
 mandir="\${prefix}/share/man"
 datadir="\${prefix}/share"
 firmwarepath="\${prefix}/share/qemu-firmware"
+efi_aarch64=""
 qemu_docdir="\${prefix}/share/doc/qemu"
 bindir="\${prefix}/bin"
 libdir="\${prefix}/lib"
@@ -1099,6 +1100,8 @@ for opt do
   ;;
   --firmwarepath=*) firmwarepath="$optarg"
   ;;
+  --efi-aarch64=*) efi_aarch64="$optarg"
+  ;;
   --host=*|--build=*|\
   --disable-dependency-tracking|\
   --sbindir=*|--sharedstatedir=*|\
@@ -1753,6 +1756,7 @@ Advanced options (experts only):
   --sysconfdir=PATH        install config in PATH$confsuffix
   --localstatedir=PATH     install local state in PATH (set at runtime on win32)
   --firmwarepath=PATH      search PATH for firmware files
+  --efi-aarch64=PATH       PATH of efi file to use for aarch64 VMs.
   --with-confsuffix=SUFFIX suffix for QEMU data inside datadir/libdir/sysconfdir [$confsuffix]
   --with-pkgversion=VERS   use specified string as sub-version of the package
   --enable-debug           enable common debug build options
@@ -3548,6 +3552,20 @@ EOF
   fi
 fi
 
+############################################
+# efi-aarch64 probe
+# Check for efi files needed by aarch64 VMs.
+# By default we will use the efi included with QEMU.
+# Allow user to override the path for efi also.
+if ! test -f "$efi_aarch64"; then
+  if test -f $source_path/pc-bios/edk2-aarch64-code.fd.bz2; then
+    # valid after build
+    efi_aarch64=$PWD/pc-bios/edk2-aarch64-code.fd
+  else
+    efi_aarch64=""
+  fi
+fi
+
 ##########################################
 # libcap-ng library probe
 if test "$cap_ng" != "no" ; then
@@ -6604,6 +6622,7 @@ if test "$docs" != "no"; then
     echo "sphinx-build      $sphinx_build"
 fi
 echo "genisoimage       $genisoimage"
+echo "efi_aarch64       $efi_aarch64"
 echo "python_yaml       $python_yaml"
 echo "slirp support     $slirp $(echo_version $slirp $slirp_version)"
 if test "$slirp" != "no" ; then
@@ -7667,6 +7686,7 @@ echo "PYTHON=$python" >> $config_host_mak
 echo "SPHINX_BUILD=$sphinx_build" >> $config_host_mak
 echo "SPHINX_WERROR=$sphinx_werror" >> $config_host_mak
 echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
+echo "EFI_AARCH64=$efi_aarch64" >> $config_host_mak
 echo "PYTHON_YAML=$python_yaml" >> $config_host_mak
 echo "CC=$cc" >> $config_host_mak
 if $iasl -h > /dev/null 2>&1; then
diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index f6c3892bb2..4fa292765d 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -5,6 +5,9 @@
 IMAGES := freebsd netbsd openbsd centos fedora
 ifneq ($(GENISOIMAGE),)
 IMAGES += ubuntu.i386 centos
+ifneq ($(EFI_AARCH64),)
+IMAGES += ubuntu.aarch64
+endif
 endif
 
 IMAGES_DIR := $(HOME)/.cache/qemu-vm/images
@@ -23,6 +26,11 @@ vm-help vm-test:
 ifneq ($(GENISOIMAGE),)
 	@echo "  vm-build-centos                 - Build QEMU in CentOS VM, with Docker"
 	@echo "  vm-build-ubuntu.i386            - Build QEMU in ubuntu i386 VM"
+ifneq ($(EFI_AARCH64),)
+	@echo "  vm-build-ubuntu.aarch64         - Build QEMU in ubuntu aarch64 VM"
+else
+	@echo "  (to build centos/ubuntu aarch64 images use configure --efi-aarch64)"
+endif
 else
 	@echo "  (install genisoimage to build centos/ubuntu images)"
 endif
@@ -65,6 +73,7 @@ $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
 		$(if $(V)$(DEBUG), --debug) \
 		$(if $(GENISOIMAGE),--genisoimage $(GENISOIMAGE)) \
 		$(if $(QEMU_LOCAL),--build-path $(BUILD_DIR)) \
+		$(if $(EFI_AARCH64),--efi-aarch64 $(EFI_AARCH64)) \
 		--image "$@" \
 		--force \
 		--build-image $@, \
@@ -80,6 +89,7 @@ vm-build-%: $(IMAGES_DIR)/%.img
 		$(if $(J),--jobs $(J)) \
 		$(if $(V),--verbose) \
 		$(if $(QEMU_LOCAL),--build-path $(BUILD_DIR)) \
+		$(if $(EFI_AARCH64),--efi-aarch64 $(EFI_AARCH64)) \
 		--image "$<" \
 		$(if $(BUILD_TARGET),--build-target $(BUILD_TARGET)) \
 		--snapshot \
@@ -102,6 +112,7 @@ vm-boot-ssh-%: $(IMAGES_DIR)/%.img
 		$(if $(J),--jobs $(J)) \
 		$(if $(V)$(DEBUG), --debug) \
 		$(if $(QEMU_LOCAL),--build-path $(BUILD_DIR)) \
+		$(if $(EFI_AARCH64),--efi-aarch64 $(EFI_AARCH64)) \
 		--image "$<" \
 		--interactive \
 		false, \
diff --git a/tests/vm/aarch64vm.py b/tests/vm/aarch64vm.py
new file mode 100644
index 0000000000..bb04cb19c9
--- /dev/null
+++ b/tests/vm/aarch64vm.py
@@ -0,0 +1,106 @@
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
+def create_flash_images(flash_dir="./", efi_img=""):
+    """Creates the appropriate pflash files
+       for an aarch64 VM."""
+    flash0_path = get_flash_path(flash_dir, "flash0")
+    flash1_path = get_flash_path(flash_dir, "flash1")
+    fd_null = open(os.devnull, 'w')
+    subprocess.check_call(["dd", "if=/dev/zero", "of={}".format(flash0_path),
+                           "bs=1M", "count=64"],
+                           stdout=fd_null, stderr=subprocess.STDOUT)
+    # A reliable way to get the QEMU EFI image is via an installed package or
+    # via the bios included with qemu.
+    if not os.path.exists(efi_img):
+        sys.stderr.write("*** efi argument is invalid ({})\n".format(efi_img))
+        sys.stderr.write("*** please check --efi-aarch64 argument or "\
+                         "install qemu-efi-aarch64 package\n")
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
index fa56fbbb4b..5fd66f6b26 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -92,6 +92,7 @@ class BaseVM(object):
         self._guest = None
         self._genisoimage = args.genisoimage
         self._build_path = args.build_path
+        self._efi_aarch64 = args.efi_aarch64
         # Allow input config to override defaults.
         self._config = DEFAULT_CONFIG.copy()
         if config != None:
@@ -496,6 +497,14 @@ def get_qemu_path(arch, build_path=None):
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
@@ -573,6 +582,9 @@ def parse_args(vmcls):
     parser.add_option("--config", "-c", default=None,
                       help="Provide config yaml for configuration. "\
                            "See config_example.yaml for example.")
+    parser.add_option("--efi-aarch64",
+                      default="/usr/share/qemu-efi-aarch64/QEMU_EFI.fd",
+                      help="Path to efi image for aarch64 VMs.")
     parser.disable_interspersed_args()
     return parser.parse_args()
 
diff --git a/tests/vm/ubuntu.aarch64 b/tests/vm/ubuntu.aarch64
new file mode 100755
index 0000000000..6f903c029c
--- /dev/null
+++ b/tests/vm/ubuntu.aarch64
@@ -0,0 +1,68 @@
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
+import sys
+import basevm
+import aarch64vm
+import ubuntuvm
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
+class UbuntuAarch64VM(ubuntuvm.UbuntuVM):
+    name = "ubuntu.aarch64"
+    arch = "aarch64"
+    image_name = "ubuntu-18.04-server-cloudimg-arm64.img"
+    image_link = "https://cloud-images.ubuntu.com/releases/18.04/release/" + image_name
+    image_sha256="0fdcba761965735a8a903d8b88df8e47f156f48715c00508e4315c506d7d3cb1"
+    BUILD_SCRIPT = """
+        set -e;
+        cd $(mktemp -d);
+        sudo chmod a+r /dev/vdb;
+        tar --checkpoint=.10 -xf /dev/vdb;
+        ./configure {configure_opts};
+        make --output-sync {target} -j{jobs} {verbose};
+    """
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
+
+        # We have overridden boot() since aarch64 has additional parameters.
+        # Call down to the base class method.
+        super(UbuntuAarch64VM, self).boot(img, extra_args=extra_args)
+
+if __name__ == "__main__":
+    defaults = aarch64vm.get_config_defaults(UbuntuAarch64VM, DEFAULT_CONFIG)
+    sys.exit(basevm.main(UbuntuAarch64VM, defaults))
-- 
2.17.1


