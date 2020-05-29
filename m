Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C72C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 20:47:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E20A207BC
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 20:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mymBIW2m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E20A207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jelur-0004G2-AY
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 16:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jelqf-0005rn-Dg
 for qemu-devel@nongnu.org; Fri, 29 May 2020 16:43:25 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:33764)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jelqe-0000pc-7a
 for qemu-devel@nongnu.org; Fri, 29 May 2020 16:43:25 -0400
Received: by mail-pl1-x62f.google.com with SMTP id t7so1711484plr.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 13:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5VM4/GB0V2/UozGr03LttV9zgjDgk37jEZ21y8bUQhs=;
 b=mymBIW2mfA6EOafEbHSHcS39wUajelqY8+VZ8P2AllsgDOFJagjOK1JWA3g7jhBCCo
 V2YATSdKQYocRyfgVtdlRXKE0ANUyaLmdGeKet+k23LFKaaoU5xW94qyVJtAGUh699eT
 xfxz92+Xr7jfwDItXyk/5ay/KV2kzm52cYldtn0JAmv+kIIHdeUEhvjhwNJINuimEbGi
 r1Zsny2Ccei1Sp9OwsE4hOGoU6KKWErwei8mkZde5Hnhsfj20/FkMfnRjkx/JwNCXp61
 YTvUVuvUrBcUi/st1Mfc/O6cNteZoYc+VtMrX6xetB87jk6jE29DUlWr4Wtyaqd/w+Br
 QsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5VM4/GB0V2/UozGr03LttV9zgjDgk37jEZ21y8bUQhs=;
 b=Esl6DA+pqw+NLjOsAOYQd9JIhdHsve1SqVLjlb+zpCIl+DlfrWdG2/EYT7HnFW9r2d
 qSxqsLjmLJ0j+WcYG7pcpkKGxwqO7XRU0xLcIVqYeHtuA80FFPIfcOHfLlDPV7TPG2z5
 1p/GYl9uj3PpT2QsF6BDjPSZIJdW5nMNyQX4/P5h93X6/09skXJ+sRYSwkBjgXqpU3Bi
 qdKJRSMS8Yai8PXyWzsHBMqXcf0xbJ2s/AfEGV57xJXz9My7CE9Ux6YU5kIFLSz7LWdn
 jhqjebREYvi2BofzIK1ioeONSX/06Im4h7V9X2hDU+DxJ6f4KHwPqWAfKgx8KG7O+Esa
 ZNkg==
X-Gm-Message-State: AOAM532/QUKQMOZSk40HEF3ddHXPk0AGCiK3v6xHpaXN9yrjZeioPVfU
 yFDPizU4CeX90Z5Vf2WI5LLZQaiB2o7qXw==
X-Google-Smtp-Source: ABdhPJxuJCkKPu2i8bWAalZLR4R0NR3HGrc3KvnpUa47U/Q6DSmxjUVbsw4Uscsxwf4HCL7CliaWYw==
X-Received: by 2002:a17:90a:ba18:: with SMTP id
 s24mr11724757pjr.192.1590785002460; 
 Fri, 29 May 2020 13:43:22 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:75ac:d268:da04:dde4])
 by smtp.gmail.com with ESMTPSA id t12sm282839pjf.3.2020.05.29.13.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 13:43:21 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 05/12] tests/vm: Add ability to select QEMU from current
 build.
Date: Fri, 29 May 2020 16:34:51 -0400
Message-Id: <20200529203458.1038-6-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200529203458.1038-1-robert.foley@linaro.org>
References: <20200529203458.1038-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=robert.foley@linaro.org; helo=mail-pl1-x62f.google.com
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

Added a new special variable QEMU_LOCAL=1, which
will indicate to take the QEMU binary from the current
build.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/Makefile.include |  4 ++++
 tests/vm/basevm.py        | 23 ++++++++++++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index e22c391a2a..f6c3892bb2 100644
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
+		$(if $(QEMU_LOCAL),--build-path $(BUILD_DIR)) \
 		--image "$@" \
 		--force \
 		--build-image $@, \
@@ -77,6 +79,7 @@ vm-build-%: $(IMAGES_DIR)/%.img
 		$(if $(DEBUG), --interactive) \
 		$(if $(J),--jobs $(J)) \
 		$(if $(V),--verbose) \
+		$(if $(QEMU_LOCAL),--build-path $(BUILD_DIR)) \
 		--image "$<" \
 		$(if $(BUILD_TARGET),--build-target $(BUILD_TARGET)) \
 		--snapshot \
@@ -98,6 +101,7 @@ vm-boot-ssh-%: $(IMAGES_DIR)/%.img
 		$(PYTHON) $(SRC_PATH)/tests/vm/$* \
 		$(if $(J),--jobs $(J)) \
 		$(if $(V)$(DEBUG), --debug) \
+		$(if $(QEMU_LOCAL),--build-path $(BUILD_DIR)) \
 		--image "$<" \
 		--interactive \
 		false, \
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 7d23ae279b..75a7ac2bd3 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -91,6 +91,7 @@ class BaseVM(object):
     def __init__(self, args, config=None):
         self._guest = None
         self._genisoimage = args.genisoimage
+        self._build_path = args.build_path
         # Allow input config to override defaults.
         self._config = DEFAULT_CONFIG.copy()
         if config != None:
@@ -275,15 +276,15 @@ class BaseVM(object):
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
@@ -482,6 +483,19 @@ class BaseVM(object):
                               stderr=self._stdout)
         return os.path.join(cidir, "cloud-init.iso")
 
+def get_qemu_path(arch, build_path=None):
+    """Fetch the path to the qemu binary."""
+    # If QEMU environment variable set, it takes precedence
+    if "QEMU" in os.environ:
+        qemu_path = os.environ["QEMU"]
+    elif build_path:
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
@@ -556,6 +570,9 @@ def parse_args(vmcls):
     parser.add_option("--config", "-c", default=None,
                       help="Provide config yaml for configuration. "\
                            "See config_example.yaml for example.")
+    parser.add_option("--build-path", default=None,
+                      help="Path of build directory, "\
+                           "for using build tree QEMU binary. ")
     parser.disable_interspersed_args()
     return parser.parse_args()
 
-- 
2.17.1


