Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48731C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:32:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D655208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NOhbJSeY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D655208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBjfb-0003es-9l
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 14:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44038)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jBjb9-00054w-W5
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:27:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jBjb8-0002HJ-MI
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:27:23 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:36398)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jBjb8-0002Eg-Fr
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:27:22 -0400
Received: by mail-pg1-x543.google.com with SMTP id c7so958957pgw.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 11:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=WeELFgz4oE5nux7AxNZv/xikqWNx8/F92UvlX1CD9Nw=;
 b=NOhbJSeYycDhZ/5wHfxLKcS+XSyAFakB3Mq8DYYWVQ1g90/zHsQFn6xHsl2ma5jk15
 B5Rm7GrgzcZZ7Xfu+4pWrVsWSeHdLaY1GkkxqiK4s7FK4NUMssyzY9Ear+lDgtAvzk/p
 kVUGY0XocfTx+IMWLuTeQcLOazOTNr33H0h1IHN1kQbLfmm2pvsla+0vBPKKBpfDriIn
 DGMY6gI8OsBViv5tFEqqRkvz+smF+CIsZP1bsbm+HrEMWBcBUCfdVd4Nt7P7IqFZvb4M
 xUljSBuwkekMAWieggxGCxuI0089sYFEaBAtj64VbLMSWvfdIzPbnaiC2qsDb/Pp6mk3
 +N3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=WeELFgz4oE5nux7AxNZv/xikqWNx8/F92UvlX1CD9Nw=;
 b=Mv7KGYmypoD3YxgKf5MqKfEUTlHWcqC8fTUsZX3J8wTLnTUpaalBtidlTCl6W+kuIX
 C+Et0spH/oFOvenj5TLerRkU/9WOUNAq5/2ssAgrWNl2JHFvltu4Ih05/auea36XuT58
 9pR5FWIpjtXfEBxl4PLIYDqyi06ke7h8QURJNtT9WyS4zLGTD7EFAU79aB1Br5l64E+L
 zVHDoMstGPwLSRgYXcT1CQMOEI2Hjm8R4csvV0RclgUq3PKANsck17kKC+xxP219NYHr
 dZBZ5fUl+gVQlHaMITAorICihXcNFETHUfbdgXBbPRI8ft9kXgn3phrg9scKAhUMd4UK
 4F9A==
X-Gm-Message-State: ANhLgQ3u/XWNgaW7ViuAigMNWGMCSBWiC3ridEuWSJ91NEbTr4PTo9C0
 TJnj1oqpNRMGxBB3F/5mTLfxUlLqIrQ=
X-Google-Smtp-Source: ADFU+vsMdyoFvm6TAaoAN4gMxkCDSQr1U6SJkGA/alRrvvdFdYaxqlg9WWvbwmJy/3YeIGYdCG/SOA==
X-Received: by 2002:a62:8144:: with SMTP id t65mr14872364pfd.188.1583864841164; 
 Tue, 10 Mar 2020 11:27:21 -0700 (PDT)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id p1sm8730692pfq.114.2020.03.10.11.27.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 11:27:20 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/10] tests/vm: add --boot-console switch
Date: Tue, 10 Mar 2020 14:25:30 -0400
Message-Id: <20200310182536.11137-5-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310182536.11137-1-robert.foley@linaro.org>
References: <20200310182536.11137-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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

Added ability to view console during boot via
--boot-console switch to basevm.py.  This helps debug issues that occur
during the boot sequence.
Also added a new special variable to vm-build:
BOOT_CONSOLE=1 will cause this new --boot-console switch to be set.
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 tests/vm/Makefile.include |  4 ++++
 tests/vm/basevm.py        | 11 +++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 9916e6d050..8879fdd185 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -40,6 +40,7 @@ endif
 	@echo '    EXTRA_CONFIGURE_OPTS="..."'
 	@echo "    J=[0..9]*            	 - Override the -jN parameter for make commands"
 	@echo "    DEBUG=1              	 - Enable verbose output on host and interactive debugging"
+	@echo "    BOOT_CONSOLE=1        	 - Show the console output at boot time. "
 	@echo "    V=1				 - Enable verbose ouput on host and guest commands"
 	@echo "    QEMU=/path/to/qemu		 - Change path to QEMU binary"
 	@echo "    QEMU_IMG=/path/to/qemu-img	 - Change path to qemu-img tool"
@@ -73,6 +74,7 @@ $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
 	$(call quiet-command, \
 		$(PYTHON) $< \
 		$(if $(V)$(DEBUG), --debug) \
+		$(if $(BOOT_CONSOLE),--boot-console) \
 		--image "$@" \
 		--force \
 		--build-image $@, \
@@ -88,6 +90,7 @@ vm-build-%: $(IMAGES_DIR)/%.img
 		$(if $(DEBUG), --interactive) \
 		$(if $(J),--jobs $(J)) \
 		$(if $(V),--verbose) \
+		$(if $(BOOT_CONSOLE),--boot-console) \
 		--image "$<" \
 		$(if $(BUILD_TARGET),--build-target $(BUILD_TARGET)) \
 		--snapshot \
@@ -110,6 +113,7 @@ vm-boot-ssh-%: $(IMAGES_DIR)/%.img
 	$(call quiet-command, \
 		$(PYTHON) $(SRC_PATH)/tests/vm/$* \
 		$(if $(J),--jobs $(J)) \
+		$(if $(BOOT_CONSOLE),--boot-console) \
 		--image "$<" \
 		--interactive \
 		false, \
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index dd545d3d1d..aab3d98edf 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -85,8 +85,10 @@ class BaseVM(object):
     # 4 is arbitrary, but greater than 2,
     # since we found we need to wait more than twice as long.
     tcg_ssh_timeout_multiplier = 4
-    def __init__(self, debug=False, vcpus=None, config=None):
+    def __init__(self, debug=False, vcpus=None, config=None,
+                 boot_console=None):
         self._guest = None
+        self._boot_console = boot_console
         # Allow input config to override defaults.
         self._config = DEFAULT_CONFIG.copy()
         if config != None:
@@ -535,6 +537,8 @@ def parse_args(vmcls):
     parser.add_option("--config", "-c", default=None,
                       help="Provide config yaml for configuration. "\
                            "See config_example.yaml for example.")
+    parser.add_option("--boot-console", action="store_true",
+                      help="Show console during boot. ")
     parser.disable_interspersed_args()
     return parser.parse_args()
 
@@ -549,7 +553,8 @@ def main(vmcls, config=None):
         config = parse_config(config, args)
         logging.basicConfig(level=(logging.DEBUG if args.debug
                                    else logging.WARN))
-        vm = vmcls(debug=args.debug, vcpus=args.jobs, config=config)
+        vm = vmcls(debug=args.debug, vcpus=args.jobs, config=config,
+                   boot_console=args.boot_console)
         if args.build_image:
             if os.path.exists(args.image) and not args.force:
                 sys.stderr.writelines(["Image file exists: %s\n" % args.image,
@@ -569,6 +574,8 @@ def main(vmcls, config=None):
         if args.snapshot:
             img += ",snapshot=on"
         vm.boot(img)
+        if vm._boot_console:
+            vm.wait_boot()
         vm.wait_ssh()
     except Exception as e:
         if isinstance(e, SystemExit) and e.code == 0:
-- 
2.17.1


