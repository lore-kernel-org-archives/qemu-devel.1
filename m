Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09BEC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:31:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EBF820727
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KNaJlWa9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EBF820727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZeAo-00082z-TN
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 13:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZe8T-0003da-Hb
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:28:37 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51421)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZe8S-00016h-JM
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:28:37 -0400
Received: by mail-wm1-x344.google.com with SMTP id f134so3105251wmf.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 10:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oAW6sgDCW3rYyrQQOtrgET+T55ELTqidNtOcxJc+4ts=;
 b=KNaJlWa9a6GnBklC4PpfVmmUjSoXkRASJWRMaupy20+GdkDDtDnC8ybwV9Pn1BsizB
 APR22yy4FshshFCpV6Tctl/vt1UfA7iDM2Wv0n7m9IvBm0SIvIVdov9gOacb5UKbKEfK
 jS+Jq5+8HoqPGSjUsvsUaA1cjCj6HTolEgoWBeqjiLkGkEVsCs4VJoq/IJNRT8q25Dzp
 kn/YD2UF3TEDbsGX34pnrLAw6RBf61oD+3M8jzLqNEYx50pVjFNgl9Mdn+4BtLsEI4qW
 5musrPLiu2TXnBcXnXek7LV/SS9Ww/i/wSo+iUO6m+YivLj/OWNfyjxcEJDciUt724K5
 Fz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oAW6sgDCW3rYyrQQOtrgET+T55ELTqidNtOcxJc+4ts=;
 b=sUJrZz8xOoURhs2dtaO/aEon6NHeLL1rVIBD9s7+/M73UPPk35Zdve9zn9RJwb4PFr
 L0atcbZ8W7Orkn8d8mg2zTTyuqTo/TvmIwMm4wDe052eQa/gLK71XAss/AH2Qb2A1I8F
 LkezTBuhkz/E11TIwZiffVVBDRn7NpXyDCUQF6Lzb/MVFzx3xM/mZcDGgseDHxHsIlTj
 R4VwD6DljcQxD4Wwi3IML4WxJl2HYyyMT5m33t86ZWBlqPaT25d38gssv1xLUzLmdJqk
 KKXm0UNLtGunWXLVtvIUBi2+LCnPgUhIJPQrvuP8EyWZE4/AbD+eax3T0VwmCCPPRG77
 A6mg==
X-Gm-Message-State: AOAM532vJbCrmWEc+NwyUQfAALW4n26/zvpAWAA9LJtKlpkI5XXm4EUF
 UcL3X18hG1hKGtnkuFBuj7oZjQ==
X-Google-Smtp-Source: ABdhPJwlwl+yaIIPe6mzsSmv8As/CCF/BtKiwYx/SmQ/9zAwDCjz8vxt2Mdyqy50mwi/k1jQDLHW0g==
X-Received: by 2002:a1c:6142:: with SMTP id v63mr4858146wmb.61.1589563715184; 
 Fri, 15 May 2020 10:28:35 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w9sm5372491wrc.27.2020.05.15.10.28.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 10:28:31 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 613731FF8C;
 Fri, 15 May 2020 18:28:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 2/2] tests/vm: pass --genisoimage to basevm script
Date: Fri, 15 May 2020 18:28:31 +0100
Message-Id: <20200515172831.8439-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515172831.8439-1-alex.bennee@linaro.org>
References: <20200515172831.8439-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 robert.foley@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we have an alternative to genisoimage we really need to tell the
script about it as well so it can use it. It will still default to
genisoimage in case it is run outside our build machinery.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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


