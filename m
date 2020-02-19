Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6BBC34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:51:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A3302464E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ciKTGZ4Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3302464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4SZo-0003vo-DD
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 11:51:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42028)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1j4SOM-0003KU-A0
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:40:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1j4SOK-00088R-Ry
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:40:06 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:38153)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1j4SOK-000876-Lo
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:40:04 -0500
Received: by mail-pg1-x534.google.com with SMTP id d6so365064pgn.5
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 08:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=BQyiXXZMIOFZUP1qaPFL0Wmx1PB9lf9yghpcYgHV7To=;
 b=ciKTGZ4Q8GDYZbdxsLSo0G1nzkLy0TzfmU2+ZlrNU3KMIC6fhqV0ISpu7hMIci0H1t
 CPnWz/bNpmckN613SPebD0GNY1EEfm6Vn/VcDMeyQ5slRKTIVTqHk9Gxr9Goc6GbeLSn
 9phoZUoLY84yEjthWFCncSHCMdaCnI1paVh3+Hzm9ShkOt2GSPCm0SieCCDPyvo0GkRi
 xZtDGRrHvszXaPWFn1oQ2xxW6nE4tQSl4JtWCh05WybWh8oVoQXR0cbAKZRKR+w3esUR
 uXrZLBUiDSZnxBmWS7ljb/5F5bvnhYkBi6sz06DUo3rN0bR3RWkNqdkp1pORXE3f0QNw
 P9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=BQyiXXZMIOFZUP1qaPFL0Wmx1PB9lf9yghpcYgHV7To=;
 b=lc9h7ivNm/JyZN0zp1h3Vp6vIea/FF+dbdXIzdHRv++FezSEf9gmw/tUnRbg5VHSJS
 WS4aB9FHnHgXsZfD/7uLkMakxIpeR5UbPLtFC2eB8ABLgBIn9dapN3oEEo9t4PCrlB00
 ZJ/rHdshfewHP4wfLFA3q8GQ4JfW0gcxOQkpiaDmk0Z0bjP5F6nBfuK8R7+MgQe0VHG3
 OwTJ84IIwA6Tu28gYP2V/7k/a3mBHqt236ImTboYuIGE4LYxNXvGs6KBlrvZpbiio5vi
 bVU2Dx29PoTeWrY+/P1EeJ0fHDpodZ/dfN2ou0r87nRJ7YeQmreI0+ME3KcqwyFTBqI2
 p4Vw==
X-Gm-Message-State: APjAAAWf/k81gRJg3bfEsmcW+U8PH0jp/A/VEG58lVIEv2Um7vDii0te
 RKBQjrvPEhWqFBwe1UoiBAc2rG8Doag=
X-Google-Smtp-Source: APXvYqwmqvacRdSBjzWzSGFY8B6wU1o9ViJi1fLpjefEc+Tr4L/8w5UfIOX8zIGiNCH3VKrKLk8zig==
X-Received: by 2002:aa7:82c9:: with SMTP id f9mr28096221pfn.168.1582130403244; 
 Wed, 19 Feb 2020 08:40:03 -0800 (PST)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:3cc2:5eb7:e248:ad23])
 by smtp.gmail.com with ESMTPSA id a69sm112362pfa.129.2020.02.19.08.40.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 08:40:02 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/14] tests/vm: Add ability to select QEMU from current
 build.
Date: Wed, 19 Feb 2020 11:35:33 -0500
Message-Id: <20200219163537.22098-11-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219163537.22098-1-robert.foley@linaro.org>
References: <20200219163537.22098-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::534
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

Added a new special variable QEMU_LOCAL=1, which
will indicate to take the QEMU binary from the current
build.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 tests/vm/Makefile.include |  4 ++++
 tests/vm/basevm.py        | 29 ++++++++++++++++++++++++-----
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index d1444c99f5..7557c154a1 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -35,6 +35,7 @@ vm-help vm-test:
 	@echo "    BOOT_CONSOLE=1        	 - Show the console output at boot time. "
 	@echo "    LOG_CONSOLE=1        	 - Log console to file in: ~/.cache/qemu-vm "
 	@echo "    V=1				 - Enable verbose ouput on host and guest commands"
+	@echo "    QEMU_LOCAL=1                 - Use QEMU binary local to this build."
 	@echo "    QEMU=/path/to/qemu		 - Change path to QEMU binary"
 	@echo "    QEMU_IMG=/path/to/qemu-img	 - Change path to qemu-img tool"
 	@echo "    QEMU_CONFIG=/path/conf.yml   - Change path to VM configuration .yml file."
@@ -54,6 +55,7 @@ $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
 		$(if $(V)$(DEBUG), --debug) \
 		$(if $(LOG_CONSOLE),--log-console) \
 		$(if $(BOOT_CONSOLE),--boot-console) \
+		--build-path $(BUILD_DIR)\
 		--image "$@" \
 		--force \
 		--build-image $@, \
@@ -70,6 +72,7 @@ vm-build-%: $(IMAGES_DIR)/%.img
 		$(if $(V),--verbose) \
 		$(if $(LOG_CONSOLE),--log-console) \
 		$(if $(BOOT_CONSOLE),--boot-console) \
+		--build-path $(BUILD_DIR)\
 		--image "$<" \
 		$(if $(BUILD_TARGET),--build-target $(BUILD_TARGET)) \
 		--snapshot \
@@ -92,6 +95,7 @@ vm-boot-ssh-%: $(IMAGES_DIR)/%.img
 		$(if $(J),--jobs $(J)) \
 		$(if $(LOG_CONSOLE),--log-console) \
 		$(if $(BOOT_CONSOLE),--boot-console) \
+		--build-path $(BUILD_DIR)\
 		--image "$<" \
 		--interactive \
 		false, \
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index dc94d1988e..a30a641a4a 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -89,9 +89,9 @@ class BaseVM(object):
     # since we found we need to wait more than twice as long.
     tcg_ssh_timeout_multiplier = 4
     def __init__(self, debug=False, vcpus=None, config=None,
-                 log_console=False,
-                 boot_console=None):
+                 log_console=False, boot_console=False, build_path=None):
         self._guest = None
+        self._build_path = build_path
         self._boot_console = boot_console
         # Allow input config to override defaults.
         self._config = DEFAULT_CONFIG.copy()
@@ -273,8 +273,8 @@ class BaseVM(object):
         args += self._data_args + extra_args + self._config['extra_args']
         args += ["-device", "VGA"]
         logging.debug("QEMU args: %s", " ".join(args))
-        qemu_bin = os.environ.get("QEMU", "qemu-system-" + self.arch)
-        guest = QEMUMachine(binary=qemu_bin, args=args,
+        qemu_path = get_qemu_path(self.arch, self._build_path)
+        guest = QEMUMachine(binary=qemu_path, args=args,
                             console_log=self._console_log_path)
         guest.set_machine(self._config['machine'])
         guest.set_console()
@@ -479,6 +479,22 @@ class BaseVM(object):
                                stderr=self._stdout)
         return os.path.join(cidir, "cloud-init.iso")
 
+def get_qemu_path(arch, build_path=None):
+    """Fetch the path to the qemu binary."""
+    qemu_local = os.environ.get("QEMU_LOCAL", 0)
+    # If QEMU environment variable set, it takes precedence
+    if "QEMU" in os.environ:
+        qemu_path = os.environ["QEMU"]
+    elif qemu_local:
+        if not build_path:
+            raise Exception("--build-path option required with QEMU_LOCAL")
+        qemu_path = os.path.join(build_path, arch + "-softmmu")
+        qemu_path = os.path.join(qemu_path, "qemu-system-" + arch)
+    else:
+        # Default is to use system path for qemu.
+        qemu_path = "qemu-system-" + arch
+    return qemu_path
+
 def parse_config(config, args):
     """ Parse yaml config and populate our config structure.
         The yaml config allows the user to override the
@@ -543,6 +559,8 @@ def parse_args(vmcls):
                            "See config_example.yaml for example.")
     parser.add_option("--boot-console", action="store_true",
                       help="Show console during boot. ")
+    parser.add_option("--build-path", default=None,
+                      help="Path of build directory. ")
     parser.disable_interspersed_args()
     return parser.parse_args()
 
@@ -559,7 +577,8 @@ def main(vmcls, config=None):
                                    else logging.WARN))
         vm = vmcls(debug=args.debug, vcpus=args.jobs, config=config,
                    log_console=args.log_console,
-                   boot_console=args.boot_console)
+                   boot_console=args.boot_console,
+                   build_path=args.build_path)
         if args.build_image:
             if os.path.exists(args.image) and not args.force:
                 sys.stderr.writelines(["Image file exists: %s\n" % args.image,
-- 
2.17.1


