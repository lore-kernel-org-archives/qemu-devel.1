Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89633C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:06:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 470B920756
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CX57/snS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470B920756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbPMw-0001hC-BB
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 10:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbPLw-0008Lt-0h
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:05:48 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:37226)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbPLu-0001nS-O6
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:05:47 -0400
Received: by mail-ed1-x544.google.com with SMTP id l25so3187035edj.4
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 07:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UeeEkoEdpVqBre5kbf2Z3iGxDOkRZkflMSZw9nUZHA0=;
 b=CX57/snSsRC+YCnc4Wm2N6rdthktOl5UNJv6i/0jLSWSf/BGXt+JqN+Qc37XKVo35U
 gZSCVxiPf334fxDMS3bc293fwQyL5D69AYd/0i+D1VpXWMe7AAS/xUSrTgZLoYM1Sn7u
 EuICP4yKqpp2ji3PRQ3vjZvCJVOMgFpGk2s+f+2LIgX+Xh2PLFzDlCN46bDhqIzEKvmI
 kOVi32a2YGv92iSXA2azpoynaVJBIG3i6L5p4gozY0Y1wcLn4sLas0hdrOcTqik55smh
 LG9miTda51rA4hFH4bQFWyXCXRQvN2IY733uEQGiewcUA2lFOqonnBDKySyX9fbefPCt
 jYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UeeEkoEdpVqBre5kbf2Z3iGxDOkRZkflMSZw9nUZHA0=;
 b=jLkps2DSJniZ7SME3ZgbFZwM7s+kaDH/70er0K7a/p5ystmObDTLPLbGDjoPJWi1wU
 +GIYV88LzMcRGKXmVANh0NfaXdGPTLpWZlEFH94BzjtcC1G6VwVz7JlbhF+kMe93C5b6
 9SsCxQjNn341Ejsf9gteEnxGDZ2O2AO1PECDw7h1Pr4s4KEFAxvPdejLwDfagbgMDqez
 Z6AtSvroUHQk/QMnfHIuSE4YtbPqA81UjqoOrsXN5biWDYx7Vb7Myu2l47hgJ4QR4mit
 V2U0GEn6nU29GlfxdYstI8fMB8pRe5jHS3I+lZ//zwnjv4LhMxr8maWANOadI0CSGdHK
 0B0Q==
X-Gm-Message-State: AOAM531urxhCpYvsVrMI4Q0Quxc1R5p548zfNuD9W5UBDu37RpY1eTn4
 UmB1GHOiQYZj4+aEF/pegkDUxA==
X-Google-Smtp-Source: ABdhPJzu8DQ8pQoXWTmPWQ2NMX699PEfLqgwCT1F9cgBHnT6no9rYZ+LUOCMA0j1bL4GXE0YZKaYcg==
X-Received: by 2002:a50:870c:: with SMTP id i12mr3723574edb.258.1589983544813; 
 Wed, 20 May 2020 07:05:44 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e18sm1978935ejr.2.2020.05.20.07.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 07:05:42 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 680E31FF8C;
 Wed, 20 May 2020 15:05:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 02/15] tests/vm: pass --genisoimage to basevm script
Date: Wed, 20 May 2020 15:05:28 +0100
Message-Id: <20200520140541.30256-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200520140541.30256-1-alex.bennee@linaro.org>
References: <20200520140541.30256-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x544.google.com
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we have an alternative to genisoimage we really need to tell the
script about it as well so it can use it. It will still default to
genisoimage in case it is run outside our build machinery.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/vm/Makefile.include |  1 +
 tests/vm/basevm.py        | 16 ++++++++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 1bf9693d195..74ab522c55d 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -56,6 +56,7 @@ $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
 	$(call quiet-command, \
 		$(PYTHON) $< \
 		$(if $(V)$(DEBUG), --debug) \
+		$(if $(GENISOIMAGE),--genisoimage $(GENISOIMAGE)) \
 		--image "$@" \
 		--force \
 		--build-image $@, \
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 756ccf7acae..a2d4054d72b 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -61,8 +61,9 @@ class BaseVM(object):
     # 4 is arbitrary, but greater than 2,
     # since we found we need to wait more than twice as long.
     tcg_ssh_timeout_multiplier = 4
-    def __init__(self, debug=False, vcpus=None):
+    def __init__(self, debug=False, vcpus=None, genisoimage=None):
         self._guest = None
+        self._genisoimage = genisoimage
         self._tmpdir = os.path.realpath(tempfile.mkdtemp(prefix="vm-test-",
                                                          suffix=".tmp",
                                                          dir="."))
@@ -381,12 +382,12 @@ class BaseVM(object):
             udata.writelines(["apt:\n",
                               "  proxy: %s" % proxy])
         udata.close()
-        subprocess.check_call(["genisoimage", "-output", "cloud-init.iso",
+        subprocess.check_call([self._genisoimage, "-output", "cloud-init.iso",
                                "-volid", "cidata", "-joliet", "-rock",
                                "user-data", "meta-data"],
-                               cwd=cidir,
-                               stdin=self._devnull, stdout=self._stdout,
-                               stderr=self._stdout)
+                              cwd=cidir,
+                              stdin=self._devnull, stdout=self._stdout,
+                              stderr=self._stdout)
 
         return os.path.join(cidir, "cloud-init.iso")
 
@@ -424,6 +425,8 @@ def parse_args(vmcls):
                       help="Interactively run command")
     parser.add_option("--snapshot", "-s", action="store_true",
                       help="run tests with a snapshot")
+    parser.add_option("--genisoimage", default="genisoimage",
+                      help="iso imaging tool")
     parser.disable_interspersed_args()
     return parser.parse_args()
 
@@ -435,7 +438,8 @@ def main(vmcls):
             return 1
         logging.basicConfig(level=(logging.DEBUG if args.debug
                                    else logging.WARN))
-        vm = vmcls(debug=args.debug, vcpus=args.jobs)
+        vm = vmcls(debug=args.debug, vcpus=args.jobs,
+                   genisoimage=args.genisoimage)
         if args.build_image:
             if os.path.exists(args.image) and not args.force:
                 sys.stderr.writelines(["Image file exists: %s\n" % args.image,
-- 
2.20.1


