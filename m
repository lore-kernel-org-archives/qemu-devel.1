Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3706C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 21:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AC28206E2
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 21:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uSnH68VZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC28206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfruQ-0002jD-O6
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 17:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jfrmh-0001on-Qm
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 17:15:51 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029]:52940)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jfrmg-0006Xi-Ic
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 17:15:51 -0400
Received: by mail-pj1-x1029.google.com with SMTP id k2so360656pjs.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 14:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=53ps36Avs107IZ6YEiMw8dg6Bvd26MfJW/oDFJqcYuk=;
 b=uSnH68VZ5GXsME3JosnNOSDbykvfqS7B5VT4q0GlJ4QIL+1Dx/tE1c7hTmoMrY2LBO
 gLFHoy4Q7GdV+4VWA4xWDLpHETnXuyCY+8f4DWKylZloHZmBb+KBbaVVukemqzrFBoBd
 T69KdDuo6/jlKgDODBWDQmzRTZ26KZt5DnkzGvNZPqYUpCUBSvj0DhbF96xJNT3rnbah
 SjZrDECkI/hczVB5MVIR/fv+lJWZK9gPKgPwe5WOCtuTvN9OA9brBfvxoW00NDsX9P5T
 S79c41dpZk9WCKqhe5gpvvDxKfpHp5+hmdcaOU6bGxAsoxwaN4qJurYgKStb+V+Wl+Xu
 WRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=53ps36Avs107IZ6YEiMw8dg6Bvd26MfJW/oDFJqcYuk=;
 b=SauspRN6RN4OpaZ+6a8yUjgkRK5PxG71uYyZciP1v+WG3B0G2Co34muQ3CuOdZBiFC
 rzhnQgZeZ0aDU55/DFzfBP+8nk5vJ0poOPDaBe7ogIdkHYpH0LNq1wblrh1B/B/3A0Q3
 Im6XyjGf+vt23Re00zqjtVDBFHQtd3b9w9cT0ZMPCU8WzwN0NPSSuNMI+W5Dtl2w7Y8/
 oZxSsOtPOxs4N3BumwSejTgXFU1rCSAQfmDlJPxtF1MjKdXLMNp0epNs99o7PRkugZzn
 /YCT2I93/vCjqjvs9kMqwQ6SUUWnDto1T9CsZi4tGQ6kHrGi8z/95yj+0NIpl2IiKOXa
 nUpw==
X-Gm-Message-State: AOAM530MNuj5xp7xnF+GA27JnPgBrKnBlBIPghbkn6qHMXP2kT6947Sw
 2K2aVXDlcZZpw9D+7bOSORvy4Z5Z7mVLRg==
X-Google-Smtp-Source: ABdhPJwFHfSXxz0JxOaPY0D5ezu3sPJdxzv/A1WQwOCE9csc224fZd8gHl4J0Ei72nlf5I1bwUcKyg==
X-Received: by 2002:a17:902:558f:: with SMTP id
 g15mr8242998pli.174.1591046148875; 
 Mon, 01 Jun 2020 14:15:48 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:85d8:9a30:f0f7:b100])
 by smtp.gmail.com with ESMTPSA id j24sm330131pga.51.2020.06.01.14.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 14:15:48 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 9/9] tests/vm: Add workaround to consume console
Date: Mon,  1 Jun 2020 17:14:21 -0400
Message-Id: <20200601211421.1277-10-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601211421.1277-1-robert.foley@linaro.org>
References: <20200601211421.1277-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=robert.foley@linaro.org; helo=mail-pj1-x1029.google.com
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
 tests/vm/basevm.py        | 21 +++++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 39f918a430..f21948c46a 100644
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
index f716798b40..04d083409a 100644
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
@@ -271,7 +276,13 @@ class BaseVM(object):
         args += self._data_args + extra_args + self._config['extra_args']
         logging.debug("QEMU args: %s", " ".join(args))
         qemu_path = get_qemu_path(self.arch, self._build_path)
-        guest = QEMUMachine(binary=qemu_path, args=args)
+
+        # Since console_log_path is only set when the user provides the
+        # log_console option, we will set drain_console=True so the
+        # console is always drained.
+        guest = QEMUMachine(binary=qemu_path, args=args,
+                            console_log=self._console_log_path,
+                            drain_console=True)
         guest.set_machine(self._config['machine'])
         guest.set_console()
         try:
@@ -285,6 +296,8 @@ class BaseVM(object):
             raise
         atexit.register(self.shutdown)
         self._guest = guest
+        # Init console so we can start consuming the chars.
+        self.console_init()
         usernet_info = guest.qmp("human-monitor-command",
                                  command_line="info usernet")
         self.ssh_port = None
@@ -296,7 +309,9 @@ class BaseVM(object):
             raise Exception("Cannot find ssh port from 'info usernet':\n%s" % \
                             usernet_info)
 
-    def console_init(self, timeout = 120):
+    def console_init(self, timeout = None):
+        if timeout == None:
+            timeout = self.socket_timeout
         vm = self._guest
         vm.console_socket.settimeout(timeout)
         self.console_raw_path = os.path.join(vm._temp_dir,
@@ -578,6 +593,8 @@ def parse_args(vmcls):
     parser.add_option("--efi-aarch64",
                       default="/usr/share/qemu-efi-aarch64/QEMU_EFI.fd",
                       help="Path to efi image for aarch64 VMs.")
+    parser.add_option("--log-console", action="store_true",
+                      help="Log console to file.")
     parser.disable_interspersed_args()
     return parser.parse_args()
 
-- 
2.17.1


