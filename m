Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1420BC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:30:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3D1F24677
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nhgeH7hj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D1F24677
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBjeA-0002Bu-RC
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 14:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44089)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jBjbC-00059Z-9t
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:27:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jBjbA-0002K5-Lt
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:27:26 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:44072)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jBjbA-0002JD-Ed
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:27:24 -0400
Received: by mail-pl1-x636.google.com with SMTP id d9so5759982plo.11
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 11:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=HLPZo5Mpt6bAz3JUox4H09RNNnYNOYLGWSUwOHKTkfk=;
 b=nhgeH7hj8awtNO+dk6hC1fkavg9rbHK1wpaPCQhW2FL/smqdrTFVcqWRocUHagJ1av
 i397EiICMzUzw2J3sXj+BBEOgumxWeiYf0Jc55F9TFica2R/BOcM7aEXroD5lCSn2USs
 741XYX+/vRh7ryHaXx/VwSMoNTD/L0z8ErILfOH70OXGcqnV9jE2cIStAbaFrwBqHA4q
 Ia2fZStMilfYF9lADhwWFSbHNYXosyv05+khX3Qg27FLNaYtLKMiCvV7Hc39e9w7IgPd
 tnXFGP7Kkl8yQBUyHrH1YDLemkBqiRwEV3Pn/mjVYLzk0AAMX57gFGhGAn7Rv2+cvb2l
 1Ngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=HLPZo5Mpt6bAz3JUox4H09RNNnYNOYLGWSUwOHKTkfk=;
 b=VmAYD+H5ViUcbq9dW+kESFrez/B7QRNs9i/zyAPYk70EGCQeiIAZjy9KhJ747bVfD7
 E36zeg+M5sovLcrRARil9EZf45c2AMYqPtsNL+2uaW9GrAkYy+gQBoAsefXqCdTnrD1d
 F6pYBR+aRsUW/TTwxhiPyIMi7yB+frPhJpqNNPqBzXY8onaACaBSTxYXR6i40dkio3RP
 YFQ5gT1UQeC8dX54gAICfEVqrEMPpxuK3XT9ie4sEJn7H1mtCziD7LeeHeCLSBD8/o1I
 GesVX98SquiRT2Sr5g6T0yXzbrSYimg7TXGqI4cOfOTolRKSLyZdAsajfpGcoRNCoojH
 sufQ==
X-Gm-Message-State: ANhLgQ0np3yZXkZj2PjiJjOBecoyl3s6l4WlVVcop3Ihf212If8OgXKN
 Mse1xytLRk9w8RZkZHlOA71hDt+1qkc=
X-Google-Smtp-Source: ADFU+vuHCrkcA4IkavGjjpe/fqbzJGDrqNrlJdq4ophD0EAXR0Oo2rnpM8xFMu9X4m/DeOlBunFpoA==
X-Received: by 2002:a17:90a:8c8a:: with SMTP id
 b10mr3081593pjo.51.1583864843050; 
 Tue, 10 Mar 2020 11:27:23 -0700 (PDT)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id p1sm8730692pfq.114.2020.03.10.11.27.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 11:27:22 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/10] tests/vm: Add ability to select QEMU from current
 build.
Date: Tue, 10 Mar 2020 14:25:31 -0400
Message-Id: <20200310182536.11137-6-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310182536.11137-1-robert.foley@linaro.org>
References: <20200310182536.11137-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::636
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
 tests/vm/basevm.py        | 28 ++++++++++++++++++++++++----
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 8879fdd185..9986e4ae9a 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -42,6 +42,7 @@ endif
 	@echo "    DEBUG=1              	 - Enable verbose output on host and interactive debugging"
 	@echo "    BOOT_CONSOLE=1        	 - Show the console output at boot time. "
 	@echo "    V=1				 - Enable verbose ouput on host and guest commands"
+	@echo "    QEMU_LOCAL=1                 - Use QEMU binary local to this build."
 	@echo "    QEMU=/path/to/qemu		 - Change path to QEMU binary"
 	@echo "    QEMU_IMG=/path/to/qemu-img	 - Change path to qemu-img tool"
 ifeq ($(PYTHON_YAML),yes)
@@ -75,6 +76,7 @@ $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
 		$(PYTHON) $< \
 		$(if $(V)$(DEBUG), --debug) \
 		$(if $(BOOT_CONSOLE),--boot-console) \
+		--build-path $(BUILD_DIR)\
 		--image "$@" \
 		--force \
 		--build-image $@, \
@@ -91,6 +93,7 @@ vm-build-%: $(IMAGES_DIR)/%.img
 		$(if $(J),--jobs $(J)) \
 		$(if $(V),--verbose) \
 		$(if $(BOOT_CONSOLE),--boot-console) \
+		--build-path $(BUILD_DIR)\
 		--image "$<" \
 		$(if $(BUILD_TARGET),--build-target $(BUILD_TARGET)) \
 		--snapshot \
@@ -114,6 +117,7 @@ vm-boot-ssh-%: $(IMAGES_DIR)/%.img
 		$(PYTHON) $(SRC_PATH)/tests/vm/$* \
 		$(if $(J),--jobs $(J)) \
 		$(if $(BOOT_CONSOLE),--boot-console) \
+		--build-path $(BUILD_DIR)\
 		--image "$<" \
 		--interactive \
 		false, \
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index aab3d98edf..3562a33ffa 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -86,8 +86,9 @@ class BaseVM(object):
     # since we found we need to wait more than twice as long.
     tcg_ssh_timeout_multiplier = 4
     def __init__(self, debug=False, vcpus=None, config=None,
-                 boot_console=None):
+                 boot_console=False, build_path=None):
         self._guest = None
+        self._build_path = build_path
         self._boot_console = boot_console
         # Allow input config to override defaults.
         self._config = DEFAULT_CONFIG.copy()
@@ -264,8 +265,8 @@ class BaseVM(object):
         args += self._data_args + extra_args + self._config['extra_args']
         args += ["-device", "VGA"]
         logging.debug("QEMU args: %s", " ".join(args))
-        qemu_bin = os.environ.get("QEMU", "qemu-system-" + self.arch)
-        guest = QEMUMachine(binary=qemu_bin, args=args)
+        qemu_path = get_qemu_path(self.arch, self._build_path)
+        guest = QEMUMachine(binary=qemu_path, args=args)
         guest.set_machine(self._config['machine'])
         guest.set_console()
         try:
@@ -465,6 +466,22 @@ class BaseVM(object):
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
@@ -539,6 +556,8 @@ def parse_args(vmcls):
                            "See config_example.yaml for example.")
     parser.add_option("--boot-console", action="store_true",
                       help="Show console during boot. ")
+    parser.add_option("--build-path", default=None,
+                      help="Path of build directory. ")
     parser.disable_interspersed_args()
     return parser.parse_args()
 
@@ -554,7 +573,8 @@ def main(vmcls, config=None):
         logging.basicConfig(level=(logging.DEBUG if args.debug
                                    else logging.WARN))
         vm = vmcls(debug=args.debug, vcpus=args.jobs, config=config,
-                   boot_console=args.boot_console)
+                   boot_console=args.boot_console,
+                   build_path=args.build_path)
         if args.build_image:
             if os.path.exists(args.image) and not args.force:
                 sys.stderr.writelines(["Image file exists: %s\n" % args.image,
-- 
2.17.1


