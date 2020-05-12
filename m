Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05BACA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 19:37:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7378320731
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 19:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lNCGE9uJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7378320731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYaic-00064X-Ga
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 15:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jYaem-0000La-6M
 for qemu-devel@nongnu.org; Tue, 12 May 2020 15:33:36 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:35151)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jYaek-0001r5-Fu
 for qemu-devel@nongnu.org; Tue, 12 May 2020 15:33:35 -0400
Received: by mail-qk1-x744.google.com with SMTP id f13so14322791qkh.2
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 12:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=gSaM358UHMm/zfpDXaif/Gr0958wC6l/oGYNTNtJTnA=;
 b=lNCGE9uJt3+H8wgGwYXd3UtUtu/SEZkokAzjo54QXLBfK8I/TgyiMBsjs5drEXRjft
 ZC88xh+dg7KGr+UF8PSm18PGBaRUg9/ufUQ581XSnSLdhc9+3NsFFDL/DWmzmTeX2/yS
 YYWsl1r5oq9k3x77SXUf2c8anKpWeWjthszE5nb/5+ju4EXAtZvjipYzBTrNUHM6j6X7
 8VXXiuF6I1pxoK5wROdBYe/4zVfeUbdEZZdJ1/tu+ErBVNz/5+SkR7hSDtPRXWq6NxDe
 1kStjZ1t7DW7yx2bYP15wGPqR8oGw6zyxyY0WtGR1A1tINfo217/j7gt72UYUMYfNfiZ
 xP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=gSaM358UHMm/zfpDXaif/Gr0958wC6l/oGYNTNtJTnA=;
 b=fqZfBNgkY2XW1BL6CD+jTJZ5VKc7BdGRU6gF2T3oGV+FcLfwp6JksGhawtZUZVvSWZ
 HGkUjrO8aClzmoRVy2oicpeeuwYnsNPIV1zvDNvMnzsrDyV23BRo/zCQ8RLPp5MKMPyf
 7FAPst/LdZZyEB5aC7vccfJLSJuDcMKVy9R+7KH2CINm4WCBvJK86KNpaekzaRYhhPP1
 RODix0XCZSkEVN604hGGqaIk7BmabMMhsLEUJOGgSqSO4dnMahrCSseGz+PAUBfNX2Aw
 dt2DRf/qcT+Guup4VZC6V/tcgmTTfK9QBe/F3iPLeyEfLISqqx7V8DQ7APWm7Rn6HlO0
 BgzQ==
X-Gm-Message-State: AGi0PuaoB8DOPHw/dZiB5ZYsxj7UFb+OaPHxnEynjypXP1Kr649ElhPT
 Jcmen4Qj36y7mZVvYVzBe9Ftkozt1k7Ewg==
X-Google-Smtp-Source: APiQypIFyWdZ7Eslx9K7cRbApKEFiehlwChXuKMlRWJ6UCTBmgEXgBChym/VvW+9ip0VUZ3PIna8cQ==
X-Received: by 2002:a37:a603:: with SMTP id p3mr21814549qke.133.1589312013104; 
 Tue, 12 May 2020 12:33:33 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:d31:9f53:b3eb:9b53])
 by smtp.gmail.com with ESMTPSA id j45sm2100998qtk.14.2020.05.12.12.33.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 12:33:32 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 4/9] tests/vm: Add ability to select QEMU from current
 build.
Date: Tue, 12 May 2020 15:33:35 -0400
Message-Id: <20200512193340.265-5-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512193340.265-1-robert.foley@linaro.org>
References: <20200512193340.265-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::744;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x744.google.com
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
Cc: philmd@redhat.com, alex.bennee@linaro.org, robert.foley@linaro.org,
 peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Added a new special variable QEMU_LOCAL=1, which
will indicate to take the QEMU binary from the current
build.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
---
 tests/vm/Makefile.include |  4 ++++
 tests/vm/basevm.py        | 31 ++++++++++++++++++++++++++-----
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 4e041103b7..99c06832ac 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -41,6 +41,7 @@ endif
 	@echo "    J=[0..9]*            	 - Override the -jN parameter for make commands"
 	@echo "    DEBUG=1              	 - Enable verbose output on host and interactive debugging"
 	@echo "    V=1				 - Enable verbose ouput on host and guest commands"
+	@echo "    QEMU_LOCAL=1                 - Use QEMU binary local to this build."
 	@echo "    QEMU=/path/to/qemu		 - Change path to QEMU binary"
 	@echo "    QEMU_IMG=/path/to/qemu-img	 - Change path to qemu-img tool"
 ifeq ($(PYTHON_YAML),yes)
@@ -62,6 +63,7 @@ $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
 	$(call quiet-command, \
 		$(PYTHON) $< \
 		$(if $(V)$(DEBUG), --debug) \
+		--build-path $(BUILD_DIR)\
 		--image "$@" \
 		--force \
 		--build-image $@, \
@@ -76,6 +78,7 @@ vm-build-%: $(IMAGES_DIR)/%.img
 		$(if $(DEBUG), --interactive) \
 		$(if $(J),--jobs $(J)) \
 		$(if $(V),--verbose) \
+		--build-path $(BUILD_DIR)\
 		--image "$<" \
 		$(if $(BUILD_TARGET),--build-target $(BUILD_TARGET)) \
 		--snapshot \
@@ -97,6 +100,7 @@ vm-boot-ssh-%: $(IMAGES_DIR)/%.img
 		$(PYTHON) $(SRC_PATH)/tests/vm/$* \
 		$(if $(J),--jobs $(J)) \
 		$(if $(V)$(DEBUG), --debug) \
+		--build-path $(BUILD_DIR)\
 		--image "$<" \
 		--interactive \
 		false, \
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 97f8ac4218..1cb104c402 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -86,8 +86,10 @@ class BaseVM(object):
     # 4 is arbitrary, but greater than 2,
     # since we found we need to wait more than twice as long.
     tcg_ssh_timeout_multiplier = 4
-    def __init__(self, debug=False, vcpus=None, config=None):
+    def __init__(self, debug=False, vcpus=None, config=None,
+                 build_path=None):
         self._guest = None
+        self._build_path = build_path
         # Allow input config to override defaults.
         self._config = DEFAULT_CONFIG.copy()
         if config != None:
@@ -272,15 +274,15 @@ class BaseVM(object):
         args = self._args + boot_params.split(' ')
         args += self._data_args + extra_args + self._config['extra_args']
         logging.debug("QEMU args: %s", " ".join(args))
-        qemu_bin = os.environ.get("QEMU", "qemu-system-" + self.arch)
-        guest = QEMUMachine(binary=qemu_bin, args=args)
+        qemu_path = get_qemu_path(self.arch, self._build_path)
+        guest = QEMUMachine(binary=qemu_path, args=args)
         guest.set_machine(self._config['machine'])
         guest.set_console()
         try:
             guest.launch()
         except:
             logging.error("Failed to launch QEMU, command line:")
-            logging.error(" ".join([qemu_bin] + args))
+            logging.error(" ".join([qemu_path] + args))
             logging.error("Log:")
             logging.error(guest.get_log())
             logging.error("QEMU version >= 2.10 is required")
@@ -479,6 +481,22 @@ class BaseVM(object):
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
@@ -551,6 +569,8 @@ def parse_args(vmcls):
     parser.add_option("--config", "-c", default=None,
                       help="Provide config yaml for configuration. "\
                            "See config_example.yaml for example.")
+    parser.add_option("--build-path", default=None,
+                      help="Path of build directory. ")
     parser.disable_interspersed_args()
     return parser.parse_args()
 
@@ -565,7 +585,8 @@ def main(vmcls, config=None):
         config = parse_config(config, args)
         logging.basicConfig(level=(logging.DEBUG if args.debug
                                    else logging.WARN))
-        vm = vmcls(debug=args.debug, vcpus=args.jobs, config=config)
+        vm = vmcls(debug=args.debug, vcpus=args.jobs, config=config,
+                   build_path=args.build_path)
         if args.build_image:
             if os.path.exists(args.image) and not args.force:
                 sys.stderr.writelines(["Image file exists: %s\n" % args.image,
-- 
2.17.1


