Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C32C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 20:55:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7DA8208B8
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 20:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="krGLgW9B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7DA8208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jem2n-0007wF-UN
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 16:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jelqt-0006JL-Uu
 for qemu-devel@nongnu.org; Fri, 29 May 2020 16:43:39 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:36402)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jelqs-00011M-M4
 for qemu-devel@nongnu.org; Fri, 29 May 2020 16:43:39 -0400
Received: by mail-pf1-x444.google.com with SMTP id e11so415620pfn.3
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 13:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DrW0NEIM6Nr/spQYP7ZRVxUxdagYdkLudwFL6LhCVeQ=;
 b=krGLgW9Bv/jNAHbmsogW/QBUQ25aEcnRPTeY7vU2y1wfYiiqwl8neJAN2AT31GimCO
 mFw5k8Jz4VofYl3pZJgaWx14tn/FnnSkPrD1VmIUi+pGRixDI3BqCzxErWCjbLtLnxnJ
 HA883LNK43VpETpY9s2hY4NPWTB1Rm+q8q2Z0CDOxSKYeAriZZkwcUruRuAJIeu+6qDs
 TtCtU4g1l3m4Z3gPHQj/Annw1sRSGcTiddqw5W7T8Tv6HgVsASuDMhCraIEZEGfK2XqV
 5zMxB95rVCEMC1zzgEdDOF1siLm+9HzeHbtNePv7Wr037OXQBzSyZklDPMXFeMc/mAcM
 k7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DrW0NEIM6Nr/spQYP7ZRVxUxdagYdkLudwFL6LhCVeQ=;
 b=j4fcwugBYtTaYwz+GR6BxxuGXxLT/agei0xU4R0SJ4e9Z0kr/fwr5FOyUYGn05wsOu
 6t0tHE5F1i7xAPPtODCB1TeWgSjSzdFHdC4xqG/EQIgM09qm2N+Pp0GLFUothykUfNEF
 9KHy/03OWcvEbJuu8w9T2e4BXgVTYHJhNIC/1IK+HgQp8823kOwqGv9SX6i7snBfm77W
 rdmWkoos6qBcJopfD4viN+f60ToBR7PfhB26e3F6400MBRM5A6hmyvuhCASb5bIxEf9m
 c/FmSXRJbo++LBzANsIKSgSkyLoiigzVa6ffCleH6QxPUjQvIaAhBEYfELsfBfuhpt2S
 Lp4A==
X-Gm-Message-State: AOAM532ter76XXoI5FbqwQZWoWT9xNyAmsbt9onR7iSmkFEF6UIH+Fog
 4Z3U1tU7083DMlgY3kWICFCMOGrAKKSCEA==
X-Google-Smtp-Source: ABdhPJyhaL9l1L/NweuKLGCLQri2yXGlLoiWBVGuo4bLjzg01Zzhn6UxQMN8/nU10HWDUSVmlzkXxQ==
X-Received: by 2002:a62:543:: with SMTP id 64mr10179475pff.271.1590785016902; 
 Fri, 29 May 2020 13:43:36 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:75ac:d268:da04:dde4])
 by smtp.gmail.com with ESMTPSA id t12sm282839pjf.3.2020.05.29.13.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 13:43:36 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 12/12] tests/vm: Add workaround to consume console
Date: Fri, 29 May 2020 16:34:58 -0400
Message-Id: <20200529203458.1038-13-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200529203458.1038-1-robert.foley@linaro.org>
References: <20200529203458.1038-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=robert.foley@linaro.org; helo=mail-pf1-x444.google.com
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

This adds support to basevm.py so that we always
drain the console chars.  This makes use of
support added in an earlier commit that allows
QEMUMachine to use the ConsoleSocket.

This is a workaround we found was needed since
there is a known issue where QEMU will hang waiting
for console characters to be consumed.

We also added the option of logging the console to a file.
LOG_CONSOLE=1 will now log the output to a file.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/Makefile.include |  4 ++++
 tests/vm/basevm.py        | 17 +++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 8cccfaf95d..ad35c6e7a1 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -49,6 +49,7 @@ endif
 	@echo '    EXTRA_CONFIGURE_OPTS="..."'
 	@echo "    J=[0..9]*            	 - Override the -jN parameter for make commands"
 	@echo "    DEBUG=1              	 - Enable verbose output on host and interactive debugging"
+	@echo "    LOG_CONSOLE=1        	 - Log console to file in: ~/.cache/qemu-vm "
 	@echo "    V=1				 - Enable verbose ouput on host and guest commands"
 	@echo "    QEMU_LOCAL=1                 - Use QEMU binary local to this build."
 	@echo "    QEMU=/path/to/qemu		 - Change path to QEMU binary"
@@ -75,6 +76,7 @@ $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
 		$(if $(GENISOIMAGE),--genisoimage $(GENISOIMAGE)) \
 		$(if $(QEMU_LOCAL),--build-path $(BUILD_DIR)) \
 		$(if $(EFI_AARCH64),--efi-aarch64 $(EFI_AARCH64)) \
+		$(if $(LOG_CONSOLE),--log-console) \
 		--image "$@" \
 		--force \
 		--build-image $@, \
@@ -91,6 +93,7 @@ vm-build-%: $(IMAGES_DIR)/%.img
 		$(if $(V),--verbose) \
 		$(if $(QEMU_LOCAL),--build-path $(BUILD_DIR)) \
 		$(if $(EFI_AARCH64),--efi-aarch64 $(EFI_AARCH64)) \
+		$(if $(LOG_CONSOLE),--log-console) \
 		--image "$<" \
 		$(if $(BUILD_TARGET),--build-target $(BUILD_TARGET)) \
 		--snapshot \
@@ -114,6 +117,7 @@ vm-boot-ssh-%: $(IMAGES_DIR)/%.img
 		$(if $(V)$(DEBUG), --debug) \
 		$(if $(QEMU_LOCAL),--build-path $(BUILD_DIR)) \
 		$(if $(EFI_AARCH64),--efi-aarch64 $(EFI_AARCH64)) \
+		$(if $(LOG_CONSOLE),--log-console) \
 		--image "$<" \
 		--interactive \
 		false, \
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index b9d828423b..64dbe64326 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -117,6 +117,11 @@ class BaseVM(object):
              "w").write(self._config['ssh_pub_key'])
 
         self.debug = args.debug
+        self._console_log_path = None
+        if args.log_console:
+                self._console_log_path = \
+                         os.path.join(os.path.expanduser("~/.cache/qemu-vm"),
+                                      "{}.install.log".format(self.name))
         self._stderr = sys.stderr
         self._devnull = open(os.devnull, "w")
         if self.debug:
@@ -271,7 +276,9 @@ class BaseVM(object):
         args += self._data_args + extra_args + self._config['extra_args']
         logging.debug("QEMU args: %s", " ".join(args))
         qemu_path = get_qemu_path(self.arch, self._build_path)
-        guest = QEMUMachine(binary=qemu_path, args=args)
+        guest = QEMUMachine(binary=qemu_path, args=args,
+                            console_log=self._console_log_path,
+                            drain_console=True)
         guest.set_machine(self._config['machine'])
         guest.set_console()
         try:
@@ -285,6 +292,8 @@ class BaseVM(object):
             raise
         atexit.register(self.shutdown)
         self._guest = guest
+        # Init console so we can start consuming the chars.
+        self.console_init()
         usernet_info = guest.qmp("human-monitor-command",
                                  command_line="info usernet")
         self.ssh_port = None
@@ -296,7 +305,9 @@ class BaseVM(object):
             raise Exception("Cannot find ssh port from 'info usernet':\n%s" % \
                             usernet_info)
 
-    def console_init(self, timeout = 120):
+    def console_init(self, timeout = None):
+        if timeout == None:
+            timeout = self.socket_timeout
         vm = self._guest
         vm.console_socket.settimeout(timeout)
         self.console_raw_path = os.path.join(vm._temp_dir,
@@ -578,6 +589,8 @@ def parse_args(vmcls):
     parser.add_option("--efi-aarch64",
                       default="/usr/share/qemu-efi-aarch64/QEMU_EFI.fd",
                       help="Path to efi image for aarch64 VMs.")
+    parser.add_option("--log-console", action="store_true",
+                      help="Log console to file.")
     parser.disable_interspersed_args()
     return parser.parse_args()
 
-- 
2.17.1


