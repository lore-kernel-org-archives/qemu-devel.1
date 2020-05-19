Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701B7C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 13:31:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B2E220671
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 13:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EVXA9Ivx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B2E220671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb2Lb-0005Jq-Aw
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 09:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jb2Gr-0005AG-0z
 for qemu-devel@nongnu.org; Tue, 19 May 2020 09:27:01 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c]:40350)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jb2Gp-0008ME-U1
 for qemu-devel@nongnu.org; Tue, 19 May 2020 09:27:00 -0400
Received: by mail-qt1-x82c.google.com with SMTP id c24so11058798qtw.7
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 06:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=4sMxAz28g5gcYIqvgKVS64F3VofSYZDUiJ7JASBbeAA=;
 b=EVXA9Ivx+mjrJ7iazp6AqhDKOQ8Pbum+IMrJfzwDdXiCnGBV1ayGY/umU1BZ+p1nfB
 sr6KZ+4ovo/QS07909yV0dghOrfn9FAxSooUEEwdtANFh/GdZ7Itnmk7Wy7WwODvosvC
 O3K3MFTt45XpG31je+mPyWmu8vSVRd7cgg07gKxUqp5acLsXJA3sasIrl/Ag5zbp648r
 yDUtajEtQ0LGruaLtpHPIS0ZnqeJp/RKGHgmaQagkacjAShnQKMlnqt+26qRTo0PMeLN
 fUQLEKmQY/2bi9/+WfIYAI1JppWpIjDpDvj0A3Trd9a2dEsJCElNwAYNJdNs2SV9nPNF
 0cig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=4sMxAz28g5gcYIqvgKVS64F3VofSYZDUiJ7JASBbeAA=;
 b=s3GKxQtMlWEXon5K79p5Lw2t1Kxr1yAxNTgCDChix1UzuVoP7HyV0JLZtEf7mrNDBW
 XGkPDhXAcyiITvs+eRlRHk+XDQS+I5sIYU2voaaWFW1b+aWzJSajrM2jWXNqgpqBqwzS
 wkxKISiwFjtxOY0Ujhvc5oTArWTwd+BdXpOyc/Ay0JhClpWKMRAmWjn4P3a6xlR86ihJ
 dKzNnF/wIZDhPRsYaUDe40asuNEjvJk8+cxDzSez3EJT9iu0UAR8BxdPp/wYGDVZSV+n
 Dxf3ekEMJklz7AFx4LEpUwUnAzIaIJyQacEZQPfZv9rYLNGUv5XgCrmBuPKSD34fi/fd
 4T2w==
X-Gm-Message-State: AOAM530N2cA+a63KI4hNBYyOilwkz+eUK5VYhF2ulHOiCOLcWQQDpyww
 /V8lqL6b4ziQnSML7C3BkUR/c2GA37bC6Q==
X-Google-Smtp-Source: ABdhPJwQDzn+XtBcn+fyO4jJed95gdr4AA2tGqXx/o9AcXv+KMMqFvcbHoNSNSnwATjToJdYEL3wvQ==
X-Received: by 2002:ac8:345a:: with SMTP id v26mr22122355qtb.253.1589894818620; 
 Tue, 19 May 2020 06:26:58 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:dd6a:8c63:cd9d:ad15])
 by smtp.gmail.com with ESMTPSA id d74sm3482136qke.100.2020.05.19.06.26.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 06:26:57 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 07/12] tests/vm: Add ability to select QEMU from current
 build.
Date: Tue, 19 May 2020 09:22:54 -0400
Message-Id: <20200519132259.405-8-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519132259.405-1-robert.foley@linaro.org>
References: <20200519132259.405-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x82c.google.com
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
 tests/vm/basevm.py        | 25 ++++++++++++++++++++++---
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index e22c391a2a..83a33b1044 100644
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
@@ -63,6 +64,7 @@ $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
 		$(PYTHON) $< \
 		$(if $(V)$(DEBUG), --debug) \
 		$(if $(GENISOIMAGE),--genisoimage $(GENISOIMAGE)) \
+		--build-path $(BUILD_DIR)\
 		--image "$@" \
 		--force \
 		--build-image $@, \
@@ -77,6 +79,7 @@ vm-build-%: $(IMAGES_DIR)/%.img
 		$(if $(DEBUG), --interactive) \
 		$(if $(J),--jobs $(J)) \
 		$(if $(V),--verbose) \
+		--build-path $(BUILD_DIR)\
 		--image "$<" \
 		$(if $(BUILD_TARGET),--build-target $(BUILD_TARGET)) \
 		--snapshot \
@@ -98,6 +101,7 @@ vm-boot-ssh-%: $(IMAGES_DIR)/%.img
 		$(PYTHON) $(SRC_PATH)/tests/vm/$* \
 		$(if $(J),--jobs $(J)) \
 		$(if $(V)$(DEBUG), --debug) \
+		--build-path $(BUILD_DIR)\
 		--image "$<" \
 		--interactive \
 		false, \
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 0bc1bad839..d717b967ca 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -89,6 +89,7 @@ class BaseVM(object):
     def __init__(self, args, config=None):
         self._guest = None
         self._genisoimage = args.genisoimage
+        self._build_path = args.build_path
         # Allow input config to override defaults.
         self._config = DEFAULT_CONFIG.copy()
         if config != None:
@@ -273,15 +274,15 @@ class BaseVM(object):
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
@@ -480,6 +481,22 @@ class BaseVM(object):
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
@@ -554,6 +571,8 @@ def parse_args(vmcls):
     parser.add_option("--config", "-c", default=None,
                       help="Provide config yaml for configuration. "\
                            "See config_example.yaml for example.")
+    parser.add_option("--build-path", default=None,
+                      help="Path of build directory. ")
     parser.disable_interspersed_args()
     return parser.parse_args()
 
-- 
2.17.1


