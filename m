Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1D4C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:56:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0DD0207CB
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vhsRSyNv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0DD0207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdxTu-00041J-Q5
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 10:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdxSR-0001jP-1P
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:55:03 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40550)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdxSP-00086W-Mb
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:55:02 -0400
Received: by mail-wm1-x341.google.com with SMTP id r15so3312028wmh.5
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 07:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B5wSVizEtzyurTRIZ6Q2GLQ/Teo1CaqJnSNxTo1S1og=;
 b=vhsRSyNvXDVa+nwXEqr4NNxNQAfwb+uFFbXCPOWYE9z+2V70OBW1ph0PA7iaSbpZlM
 fQdFG800zXWb/gNxt49lN2D8JLjd/rp4L+vwPHRDhBwsvcCycyQQJR0XohPylSszzSnE
 XCvLqAd8LK5iFj66FNlMeron7f85lby6Ow3+mfPob38J9fgJKLHMxjIhOec724Iru8lx
 dZKTwTOVFxAsafkMS79/ZDLuAxl4T6i0CL/XmJAdSF1UVH7LmOkoyzqcx5hiAdZQncxV
 04Zks0t7Z+QAs1BFtKJN2bBoBLhl51tZLJ8yM1BgtqV3BY51I/kkcgjPJdFdm5W9gK5a
 6vTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B5wSVizEtzyurTRIZ6Q2GLQ/Teo1CaqJnSNxTo1S1og=;
 b=ntFxH/GUD1f2UlKMM2w0ywePFDiw6p2WVj8HyTY9zeSL+gh2IdmiEHS55alJt6+6c7
 z52UoEpKLX01UR8pr3kbUH12ELBxAe7BiMy4Z6cyBtp0TUicVuep9ymFf68PuGUbCXx7
 Y3RMYSLHAt6RPBOxOQv6dTOQGwJ2u7J8hYqGA9Sk9EljRXd40QBOnb+kEiWUrhS7m4kf
 WDRkC+hRvkHN7rKc6hkwzLR+O11GMPizWtJdpq/kTlFbja2NYHy0nNOvya7/sCE816m+
 esqlp+QmuQ1j4ZXUwRQFMJw8eEuJe1yWfVbIXFBcsg8oHrZyeHaribbU+Lp/dToq833A
 svyw==
X-Gm-Message-State: AOAM533SebqRirjwU2GuvFlLdBiQa+GUoqmCSHX93POr1N7M7SWyr20K
 7WyPK6/5aLWvySy5gy9AKtrCbA==
X-Google-Smtp-Source: ABdhPJzQXbwzYL+X/nsczMEDX1vfafI6Qq4oik1ALAHIpfFLwls9QoMz0/JJXMfoNBWNv4fM1VXIWw==
X-Received: by 2002:a1c:9e8a:: with SMTP id h132mr4660651wme.32.1590591300136; 
 Wed, 27 May 2020 07:55:00 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q5sm3243635wmq.36.2020.05.27.07.54.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 07:54:58 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3CCDE1FF8C;
 Wed, 27 May 2020 15:54:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 02/12] tests/vm: pass --genisoimage to basevm script
Date: Wed, 27 May 2020 15:54:45 +0100
Message-Id: <20200527145455.2550-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200527145455.2550-1-alex.bennee@linaro.org>
References: <20200527145455.2550-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Robert Foley <robert.foley@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we have an alternative to genisoimage we really need to tell the
script about it as well so it can use it. It will still default to
genisoimage in case it is run outside our build machinery.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
Message-Id: <20200519132259.405-3-robert.foley@linaro.org>

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


